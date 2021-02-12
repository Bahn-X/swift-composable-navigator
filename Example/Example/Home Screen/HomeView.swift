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
  case settingsButtonTapped
}

struct HomeEnvironment {
  let navigator: Navigator
}

struct HomeView: View {
  @Environment(\.currentScreenID) var currentScreenID
  @Environment(\.currentScreen) var currentScreen
  @Environment(\.navigator) var navigator
  let store: Store<HomeState, HomeAction>

  var body: some View {
    WithViewStore(store) { viewStore in
      List {
        Button(
          action: {
            navigator.go(to: SettingsScreen(), on: currentScreen)
          },
          label: {
            HStack {
              Text("Open Settings")
              Image(systemName: "gear")
                .foregroundColor(.gray)
              Spacer()
            }
          }
        )

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
          action: { viewStore.send(.settingsButtonTapped) },
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
    let settingsStore = appStore.scope(
      state: \.settings,
      action: AppAction.settings
    )

    let buildDetailStore = { (detailID: String) -> Store<DetailState?, DetailAction> in
      appStore.scope(
        state: { state in
          state.details.first(
            where: { $0.id == detailID })
        },
        action: { action in AppAction.detail(id: detailID, action) }
      )
    }

    return PathBuilders.screen( // /home
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
        PathBuilders.if(
          screen: { (screen: DetailScreen) in
            PathBuilders.ifLetStore(
              store: buildDetailStore(screen.detailID),
              then: { store in
                DetailScreen.builder(
                  store: store,
                  settingsStore: settingsStore
                )
              }
            )
          }
        ),
        SettingsScreen.builder(store: settingsStore)
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

  case .settingsButtonTapped:
    return .fireAndForget {
      environment
        .navigator
        .go(to: SettingsScreen(), on: HomeScreen())
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
