import Foundation
import ComposableArchitecture
import SwiftUI

struct AppEnvironment {
  let router: Router
}

struct HomeRoute: Route {
  let presentationStyle: ScreenPresentationStyle = .push
}

struct DetailRoute: Route {
  let presentationStyle: ScreenPresentationStyle = .push
  let id: String
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
      content: { (route: HomeRoute) in
        EmptyView()
      }
    )
  }

  static func detail(
    coordinator: Store<RouterState, RouterAction>,
    store: Store<Int, Int>
  ) -> Router {
    .route(
      store: coordinator,
      parse: { _ in DetailRoute(id: "123") },
      content: { (route: DetailRoute) in Text("Home") }
    )
  }
}

let f = {
  let store = Store<RouterState, RouterAction>(
    initialState: RouterState(
      screens: [:]
    ),
    reducer: .empty,
    environment: ()
  )

  let homeStore = Store<Int, Int>(
    initialState: 1,
    reducer: .empty,
    environment: ()
  )

  _ =
    AppEnvironment(
        router: .combine(
        .home(
          coordinator: store,
          store: homeStore
        ),
        .detail(
          coordinator: store,
          store: homeStore
        )
      )
    )
}
