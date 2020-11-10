import ComposableArchitecture
import ComposableRouter
import SwiftUI

struct HomeState: Equatable {
  var elements: [String]
}
enum HomeAction: Equatable {
  case viewAppeared
  case selected(element: String)
  case settingsButtonTapped
}
struct HomeEnvironment {
  let router: Router
}

struct HomeView: View {
  let store: Store<HomeState, HomeAction>

  var body: some View {
    WithViewStore(store) { viewStore in
      List {
        ForEach(
          viewStore.elements,
          id: \.self,
          content: { element in
            Button(
              action: {
                viewStore.send(.selected(element: element))
              },
              label: {
                Text("Element \(element)")
              }
            )
          }
        )
      }
      .onAppear {
        viewStore.send(.viewAppeared)
      }
      .navigationBarItems(
        trailing: Button(
          action: { viewStore.send(.settingsButtonTapped)},
          label: { Image(systemName: "gear") }
        )
      )
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
      return .none
    case .settingsButtonTapped:
      return .fireAndForget {
        environment
          .router
          .route(
            .go(to: SettingsScreen())
          )
      }
    case let .selected(element):
      return .fireAndForget {
        environment
          .router
          .route(
            .go(to: DetailScreen(detailID: element))
          )
      }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      HomeView(
        store: Store(
          initialState: .init(elements: (0..<10).map(String.init)),
          reducer: .empty,
          environment: ()
        )
      )
    }
  }
}
