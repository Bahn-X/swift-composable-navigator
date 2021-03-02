import ComposableArchitecture
import ComposableDeeplinking
import ComposableNavigator
import SwiftUI

@main
struct ExampleApp: App {
  let appStore: Store<AppState, AppAction>

  let navigator: Navigator
  let dataSource: Navigator.Datasource

  var deeplinkHandler: DeeplinkHandler {
    DeeplinkHandler(
      navigator: navigator,
      parser: DeeplinkParser.exampleApp
    )
  }

  init() {
    dataSource = Navigator.Datasource(
      root: HomeScreen()
    )

    navigator = Navigator(dataSource: dataSource).debug()

    appStore = Store(
      initialState: AppState(
        elements: (0..<10).map(String.init)
      ),
      reducer: appReducer,
      environment: AppEnvironment(navigator: navigator)
    )
  }

  var body: some Scene {
    WindowGroup {
      Root(
        dataSource: dataSource,
        navigator: navigator,
        pathBuilder: HomeScreen.Builder(appStore: appStore)
      )
      .onOpenURL(
        perform: { url in
          guard let deeplink = Deeplink(
            url: url,
            matching: "example"
          )
          else { return }

          deeplinkHandler.handle(deeplink: deeplink)
        }
      )
      .environment(\.treatSheetDismissAsAppearInPresenter, true)
    }
  }
}
