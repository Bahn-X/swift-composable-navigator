import ComposableRouter
import SwiftUI

@main
struct ExampleApp: App {
  var body: some Scene {
    WindowGroup {
      Root(
        store: routerStore,
        router: appRouter
      )
    }
  }
}
