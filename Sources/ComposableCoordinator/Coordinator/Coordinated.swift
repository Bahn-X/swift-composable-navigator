import ComposableArchitecture
import SwiftUI

public struct Coordinated: View {
  @Environment(\.parentScreenID) private var parentID
  @Environment(\.currentScreenID) private var currentID
  
  private let store: Store<CoordinatorState, CoordinatorAction>
  private let content: (ScreenID) -> AnyView
  var buildRoute: (AnyRoute) -> Coordinated?
  
  public init<Content: View>(
    store: Store<CoordinatorState, CoordinatorAction>,
    buildRoute: @escaping (AnyRoute) -> Coordinated?,
    @ViewBuilder content: @escaping (ScreenID) -> Content
  ) {
    self.store = store
    self.buildRoute = buildRoute
    self.content = { id in AnyView(content(id)) }
  }
  
  public var body: some View {
    WithViewStore(store) { viewStore in
      content(currentID)
        .id(currentID)
        .sheet(
          item: viewStore.binding(
            get: sheet,
            send: .sheetDismissed(on: currentID)
          ),
          content: build
        )
        .overlay(
          NavigationLink(
            destination: push(state: viewStore.state).map(build),
            isActive: viewStore.binding(
              get: pushIsActive,
              send: .pushDismissed(on: currentID)
            ),
            label: { EmptyView() }
          )
        )
    }
  }

  // MARK: - Helpers
  private func next(
    in state: CoordinatorState
  ) -> ScreenState? {
    state.screens[currentID]
      .flatMap(\.next)
      .flatMap { nextID in state.screens[nextID] }
  }

  private func push(
    state: CoordinatorState
  ) -> ScreenState? {
    next(in: state)
      .flatMap { nextScreen in
        nextScreen.content.presentationStyle == .push ? nextScreen: nil
      }
  }

  private func pushIsActive(
    state: CoordinatorState
  ) -> Bool {
    push(state: state) != nil
  }

  private func sheet(
    state: CoordinatorState
  ) -> ScreenState? {
    next(in: state)
      .flatMap { nextScreen in
        nextScreen.content.presentationStyle == .sheet ? nextScreen: nil
      }
  }

  private func build(
    _ nextScreen: ScreenState
  ) -> some View {
    buildRoute(nextScreen.content)
      .map { view in
        enrichNext(view, nextID: nextScreen.id)
      }
  }

  private func enrichNext(
    _ coordinated: Coordinated,
    nextID: ScreenID
  ) -> some View {
    coordinated
      .environment(\.currentScreenID, nextID)
      .environment(\.parentScreenID, currentID)
  }
}
