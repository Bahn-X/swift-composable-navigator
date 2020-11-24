import ComposableArchitecture
import ComposableNavigator
import SwiftUI

struct HomeState: Equatable {
  var elements: [String]
}
enum HomeAction: Equatable {
  case viewAppeared
  case selected(element: String, on: ScreenID)
  case settingsButtonTapped(ScreenID)
}
struct HomeEnvironment {
  let navigator: Navigator
}

struct HomeView: View {
  @Environment(\.currentScreenID) var currentScreenID
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
                viewStore.send(.selected(element: element, on: currentScreenID))
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
          action: { viewStore.send(.settingsButtonTapped(currentScreenID))},
          label: { Image(systemName: "gear") }
        )
      )
      .navigationBarTitle("Example App")
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
    case let .settingsButtonTapped(id):
      return .fireAndForget {
        environment
          .navigator
          .route(
            .go(to: SettingsScreen(), on: id)
          )
      }
    case let .selected(element, screenID):
      return .fireAndForget {
        environment
          .navigator
          .route(
            .go(to: DetailScreen(detailID: element), on: screenID)
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
