import Foundation
import ComposableArchitecture
import ComposableNavigator
import ComposableNavigatorTCA
import SwiftUI

struct AppState: Equatable {
  var home: HomeState
  var settings: SettingsState

  init(elements: [String]) {
    home = HomeState(elements: elements, selectedDetail: nil)
    settings = SettingsState()
  }
}

enum AppAction: Equatable {
  case home(HomeAction)
  case detail(DetailAction)
  case settings(SettingsAction)

  case binding(BindingAction<AppState>)
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
  settingsReducer.pullback(
    state: \.settings,
    action: /AppAction.settings,
    environment: \.settings
  )
)
