import ComposableArchitecture
import SwiftUI

public struct Root: View {
  private let store: Store<RouterState, RouterAction>
  private let router: Router

  public init(
    store: Store<RouterState, RouterAction>,
    router: Router
  ) {
    self.store = store
    self.router = router
  }

  public var body: some View {
    WithViewStore(
      store,
      content: { viewStore in
        NavigationView {
          router
            .build(path: viewStore.path)?
            .environment(
              \.currentScreenID,
              viewStore.path.first?.id ?? .root
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
      }
    )
  }
}
