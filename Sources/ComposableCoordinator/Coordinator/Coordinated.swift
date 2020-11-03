import ComposableArchitecture
import SwiftUI

public struct Coordinated: View {
  @Environment(\.parentScreenID) private var parentID
  @Environment(\.currentScreenID) private var currentID

  private let store: Store<CoordinatorState, CoordinatorAction>
  private let content: () -> AnyView
  var buildRoute: (Route) -> Coordinated?
  
  public init<Content: View>(
    store: Store<CoordinatorState, CoordinatorAction>,
    buildRoute: @escaping (Route) -> Coordinated?,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.store = store
    self.buildRoute = buildRoute
    self.content = {
      AnyView(content())
    }
  }

  func screenState(state: CoordinatorState) -> ScreenState? {
    state.screens[currentID]
  }
  
  public var body: some View {
    WithViewStore(store) { viewStore in
      content()
        .id(currentID)
        .sheet(
          item: viewStore.binding(
            get: {
              screenState(state: $0)
                .flatMap { $0.push != nil ? $0: nil }
            },
            send: .sheetDismissed(on: currentID)
          ),
          content: { $0.sheet.map(buildRoute) }
        )
        .overlay(
          NavigationLink(
            destination: screenState(state: viewStore.state)
              .map { $0.push.map(buildRoute) },
            isActive: viewStore.binding(
              get: { screenState(state: $0)?.push != nil },
              send: .pushDismissed(on: currentID)
            ),
            label: { EmptyView() }
          )
      )
    }
  }
}
