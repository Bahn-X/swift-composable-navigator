import Foundation
import ComposableArchitecture
import ComposableNavigator
import SwiftUI

struct AppState: Equatable {
  var elements: [String]

  var home: HomeState {
    get { HomeState(elements: elements) }
    set { elements = newValue.elements }
  }

  var details: IdentifiedArray<String, DetailState> {
    get {
      IdentifiedArray(
        elements.map(DetailState.init),
        id: \.id
      )
    }
    set {}
  }
  var settings = SettingsState()
}

enum AppAction: Equatable {
  case home(HomeAction)
  case detail(id: String, DetailAction)
  case settings(SettingsAction)
}

struct AppEnvironment {
  let navigator: Navigator

  var home: HomeEnvironment {
    HomeEnvironment(navigator: navigator)
  }

  var detail: DetailEnvironment {
    DetailEnvironment(navigator: navigator)
  }

  var settings: SettingsEnvironment {
    SettingsEnvironment(navigator: navigator)
  }
}

let appReducer = Reducer<
  AppState,
  AppAction,
  AppEnvironment
>.combine(
  homeReducer.pullback(
    state: \.home,
    action: /AppAction.home,
    environment: \.home
  ),
  detailReducer.forEach(
    state: \.details,
    action: /AppAction.detail,
    environment: \.detail
  ),
  settingsReducer.pullback(
    state: \.settings,
    action: /AppAction.settings,
    environment: \.settings
  )
)

let navigatorStore = Store<NavigatorState, NavigatorAction>(
  initialState: NavigatorState(
    path: [
      IdentifiedScreen(
        id: .root,
        content: HomeScreen()
      ),
      IdentifiedScreen(
        id: ScreenID(),
        content: DetailScreen(detailID: "0")
      ),
      IdentifiedScreen(
        id: ScreenID(),
        content: SettingsScreen()
      )
    ]
  ),
  reducer: navigatorReducer,
  environment: NavigatorEnvironment(screenID: ScreenID.init)
)

func initializeNavigator() -> Navigator {
  var appStore: Store<AppState, AppAction>!

  let appRouter: Navigator = .root(
    store: navigatorStore,
    navigator: .screen( // /home
      store: navigatorStore,
      parse: { pathElement in
        pathElement.name == "home" ? HomeScreen(): nil
      },
      content: { _ in
        HomeView(
          store: appStore.scope(
            state: \.home,
            action: AppAction.home
          )
        )
      },
      nesting: .anyOf(
        .screen( // detail?id=123
          store: navigatorStore,
          parse: { pathElement in
            guard pathElement.name == "detail",
                  case .value(let id) = pathElement.arguments?["id"]
            else {
              return nil
            }

            return DetailScreen(detailID: id)
          },
          content: { (screen: DetailScreen) in
            IfLetStore(
              appStore.scope(
                state: { state in
                  state.details.first(where: { $0.id == screen.detailID }) },
                action: { action in AppAction.detail(id: screen.detailID, action)}
              ),
              then: { detailStore in
                DetailView(
                  store: detailStore
                )
              }
            )
          },
          nesting: .screen( // settings
            store: navigatorStore,
            parse: { pathElement in
              guard pathElement.name == "settings" else {
                return nil
              }

              return SettingsScreen()
            },
            content: { (screen: SettingsScreen) in
              SettingsView(store: appStore.scope(state: \.settings, action: AppAction.settings))
            }
          )
        ),
        .screen( // settings
          store: navigatorStore,
          parse: { pathElement in
            guard pathElement.name == "settings" else {
              return nil
            }

            return SettingsScreen()
          },
          content: { (screen: SettingsScreen) in
            SettingsView(store: appStore.scope(state: \.settings, action: AppAction.settings))
          }
        )
      )
    )
  )

  appStore = Store<AppState, AppAction>(
    initialState: AppState(
      elements: (0..<10).map(String.init)
    ),
    reducer: appReducer,
    environment: AppEnvironment(navigator: appRouter)
  )

  return appRouter
}

