import ComposableArchitecture
import SwiftUI

public struct Root: View {
  private let store: Store<NavigatorState, NavigatorAction>
  private let navigator: Navigator

  public init(
    store: Store<NavigatorState, NavigatorAction>,
    navigator: Navigator
  ) {
    self.store = store
    self.navigator = navigator
  }

  public var body: some View {
    WithViewStore(
      store,
      content: { viewStore in
        NavigationView {
          navigator
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
