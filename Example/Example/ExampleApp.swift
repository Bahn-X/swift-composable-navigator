import ComposableNavigator
import SwiftUI

@main
struct ExampleApp: App {
  let appNavigator = initializeNavigator()

  var body: some Scene {
    WindowGroup {
      Root(
        store: navigatorStore,
        navigator: appNavigator
      )
    }
  }
}
