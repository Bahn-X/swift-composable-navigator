import Foundation
import ComposableArchitecture
@testable import ComposableRouter
import SwiftUI

struct AppState: Equatable {
  var home: HomeState { HomeState() }
  var detail: DetailState { DetailState(id: "123") }
  var settings: SettingsState { SettingsState() }
}

enum AppAction: Equatable {
  case home(HomeAction)
  case detail(DetailAction)
  case settings(SettingsAction)
}

struct AppEnvironment {
  let router: Router
}

let appReducer = Reducer<
  AppState,
  AppAction,
  AppEnvironment
>.combine(
  .empty
)

let appStore = Store<AppState, AppAction>(
  initialState: AppState(),
  reducer: .empty,
  environment: ()
)

let routerStore = Store<RouterState, RouterAction>(
  initialState: RouterState(
    path: [
      IdentifiedScreen(id: .root, content: HomeScreen()),
      IdentifiedScreen(id: ScreenID(), content: SettingsScreen())
    ]
  ),
  reducer: routerReducer,
  environment: RouterEnvironment()
)

let appRouter: Router = .root(
  store: routerStore,
  router: .screen( // /home
    store: routerStore,
    parse: { url in
      url.host == "home" ? HomeScreen(): nil
    },
    content: { _ in
      HomeView(
        store: appStore.scope(state: \.home, action: AppAction.home)
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
          DetailView(
            store: appStore.scope(state: \.detail, action: AppAction.detail)
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
