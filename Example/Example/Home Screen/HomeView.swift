import ComposableArchitecture
import ComposableNavigator
import SwiftUI

struct HomeState: Equatable {
  var elements: [String]
}
enum HomeAction: Equatable {
  case viewAppeared
  case selected(element: String, on: ScreenID)
  case openSettings(for: String, on: ScreenID)
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
            HStack {
              Button(
                action: {
                  viewStore.send(
                    .selected(element: element, on: currentScreenID)
                  )
                },
                label: {
                  Text("Element \(element)")
                }
              )
              Spacer()
              Image(systemName: "gear")
                .foregroundColor(.gray)
                .onTapGesture {
                  viewStore.send(
                    .openSettings(for: element, on: currentScreenID)
                  )
                }
            }
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

  static func builder(
    appStore: Store<AppState, AppAction>
  ) -> some PathBuilder {
    PathBuilders.screen( // /home
      onAppear: { _ in print("HomeView appeared") },
      content: { (_: HomeScreen) in
        HomeView(
          store: appStore.scope(
            state: \.home,
            action: AppAction.home
          )
        )
      },
      nesting: PathBuilders.anyOf(
        PathBuilders.screen( // detail?id=123
          content: { (screen: DetailScreen) in
            IfLetStore(
              appStore.scope(
                state: { state in
                  state.details.first(where: { $0.id == screen.detailID }) },
                action: { action in AppAction.detail(id: screen.detailID, action) }
              ),
              then: { detailStore in
                DetailView(
                  store: detailStore
                )
              }
            )
          },
          nesting: PathBuilders.screen( // settings
            content: { (screen: SettingsScreen) in
              SettingsView(store: appStore.scope(state: \.settings, action: AppAction.settings))
            }
          )
        ),
        PathBuilders.screen( // settings
          content: { (screen: SettingsScreen) in
            SettingsView(store: appStore.scope(state: \.settings, action: AppAction.settings))
          }
        )
      )
    )
  }
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
          .go(to: SettingsScreen(), on: id)
      }
      
    case let .selected(element, screenID):
      return .fireAndForget {
        environment
          .navigator
          .go(to: DetailScreen(detailID: element), on: screenID)
      }

  case let .openSettings(for: element, on: screenID):
    return .fireAndForget {
      environment
        .navigator
        .go(
          to: [
            DetailScreen(detailID: element).eraseToAnyScreen(),
            SettingsScreen().eraseToAnyScreen()
          ],
          on: screenID
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
