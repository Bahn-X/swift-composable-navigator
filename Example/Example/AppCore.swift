import Foundation
import ComposableArchitecture
import ComposableRouter
import SwiftUI

struct AppEnvironment {
  let router: Router
}

struct HomeRoute: Route {
  let presentationStyle: ScreenPresentationStyle = .push
}

struct DetailRoute: Route {
  let presentationStyle: ScreenPresentationStyle = .sheet(allowsPush: true)
  
  let detailID: String
}

extension Router {
  static func home(
    coordinator: Store<RouterState, RouterAction>,
    store: Store<Int, Int>
  ) -> Router {
    .route(
      store: coordinator,
      parse: { (url: URL) in
        guard url.host == "home" else { return nil }
        return HomeRoute()
      },
      content: { (route: HomeRoute) in Text("Home") }
    )
  }
  
  static func detail(
    coordinator: Store<RouterState, RouterAction>,
    store: Store<Int, Int>
  ) -> Router {
    .route(
      store: coordinator,
      parse: { _ in DetailRoute(detailID: "123") },
      content: { (route: DetailRoute) in
        Text("Detail: \(route.detailID)")
          .navigationBarTitle(Text("Detail"), displayMode: .inline)
      }
    )
  }
}

let routerStore = Store<RouterState, RouterAction>(
  initialState: RouterState(
    screens: [
      ScreenState(
        id: .init(),
        content: HomeRoute().eraseToAnyRoute()
      ),
      ScreenState(
        id: .init(),
        content: DetailRoute(
          detailID: "123"
        ).eraseToAnyRoute()
      )
    ]
  ),
  reducer: .empty,
  environment: ()
)

let homeStore = Store<Int, Int>(
  initialState: 1,
  reducer: .empty,
  environment: ()
)

let router: Router = .root(
  store: routerStore,
  router:
    .nested(
      store: routerStore,
      parse: { _ in HomeRoute() },
      content: { _ in
        VStack {
          Text("This is the home view")
          Text("More")
        }
      },
      next: .anyOf(
        .detail(
          coordinator: routerStore,
          store: homeStore
        )
      )
    )
)

let appEnvironment = AppEnvironment(router: router)

struct AppEnvironment_Previews: PreviewProvider {
  static var previews: some View {
    Root(
      store: routerStore,
      router: router
    )
  }
}
