import ComposableRouter
import SwiftUI

@main
struct ExampleApp: App {
  let appRouter = initializeRouter()

  var body: some Scene {
    WindowGroup {
      Root(
        store: routerStore,
        router: appRouter
      )
    }
  }
}
