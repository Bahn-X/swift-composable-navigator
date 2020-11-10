import Foundation
import ComposableArchitecture
@testable import ComposableRouter
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
  let router: Router

  var home: HomeEnvironment {
    HomeEnvironment(router: router)
  }

  var detail: DetailEnvironment {
    DetailEnvironment(router: router)
  }

  var settings: SettingsEnvironment {
    SettingsEnvironment(router: router)
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

let routerStore = Store<RouterState, RouterAction>(
  initialState: RouterState(
    path: [
      IdentifiedScreen(
        id: .root,
        content: HomeScreen()
      ),
      IdentifiedScreen(
        id: ScreenID(),
        content: DetailScreen(detailID: "0")
      )
    ]
  ),
  reducer: routerReducer,
  environment: RouterEnvironment()
)

func initializeRouter() -> Router {
  var appStore: Store<AppState, AppAction>!

  let appRouter: Router = .root(
    store: routerStore,
    router: .screen( // /home
      store: routerStore,
      parse: { url in
        url.host == "home" ? HomeScreen(): nil
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
          store: routerStore,
          parse: { url in
            guard url.host == "detail" else {
              return nil
            }

            return DetailScreen(detailID: "123")
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
          }
        ),
        .screen( // settings
          store: routerStore,
          parse: { url in
            guard url.host == "settings" else {
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
    environment: AppEnvironment(router: appRouter)
  )

  return appRouter
}

