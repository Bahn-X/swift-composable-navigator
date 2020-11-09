import ComposableArchitecture
import ComposableRouter
import SwiftUI

struct HomeState: Equatable {}
enum HomeAction: Equatable {
  case viewAppeared
}
struct HomeEnvironment {
  let router: Router
}

struct HomeView: View {
  let store: Store<HomeState, HomeAction>

  var body: some View {
    WithViewStore(store) { viewStore in
      Text("Home")
        .onAppear {
          viewStore.send(.viewAppeared)
        }
    }
  }
}

struct HomeScreen: Screen {
  let presentationStyle: ScreenPresentationStyle = .push
}

let homeReducer = Reducer<
  HomeState,
  HomeAction,
  HomeEnvironment
> { state, action, environment in
  switch action {
    case .viewAppeared:
      return .fireAndForget {
        environment
          .router
          .route(
            .go(to: DetailScreen(detailID: "123"))
          )
      }

  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView(
      store: Store(
        initialState: .init(),
        reducer: .empty,
        environment: ()
      )
    )
  }
}
