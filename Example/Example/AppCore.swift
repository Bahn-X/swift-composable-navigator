import Foundation
import ComposableArchitecture
@testable import ComposableNavigator
import ComposableNavigatorTCA
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

let dataSource = Navigator.Datasource(
  path: [
    IdentifiedScreen(
      id: .root,
      content: HomeScreen(),
      hasAppeared: false
    ),
    IdentifiedScreen(
      id: ScreenID(),
      content: DetailScreen(detailID: "0"),
      hasAppeared: false
    ),
    IdentifiedScreen(
      id: ScreenID(),
      content: SettingsScreen(),
      hasAppeared: false
    )
  ]
)

func initializeApp() -> some View {
  let appNavigator: Navigator = Navigator(dataSource: dataSource)
  let appStore = Store<AppState, AppAction>(
    initialState: AppState(
      elements: (0..<10).map(String.init)
    ),
    reducer: appReducer,
    environment: AppEnvironment(navigator: appNavigator)
  )

  let pathBuilder = HomeScreen.builder(appStore: appStore)
  return Root(
    dataSource: dataSource,
    pathBuilder: pathBuilder
  )
  .environment(\.treatSheetDismissAsAppearInPresenter, true)
}

