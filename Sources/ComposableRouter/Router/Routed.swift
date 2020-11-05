import ComposableArchitecture
import SwiftUI

public struct Routed: View {
  @Environment(\.parentScreenID) private var parentID
  @Environment(\.currentScreenID) private var currentID
  private let store: Store<RouterState, RouterAction>
  private let content: () -> AnyView
  
  var buildRoute: (AnyRoute) -> Routed?
  
  public init<Content: View>(
    store: Store<RouterState, RouterAction>,
    buildRoute: @escaping (AnyRoute) -> Routed?,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.store = store
    self.buildRoute = buildRoute
    self.content = { AnyView(content()) }
  }
  
  public var body: some View {
    WithViewStore(store) { viewStore in
      content()
        .id(currentID)
        .sheet(
          item: viewStore.binding(
            get: sheet,
            send: .dismissSheet(on: currentID)
          ),
          content: build
        )
        .overlay(
          NavigationLink(
            destination: push(state: viewStore.state).map(build),
            isActive: viewStore.binding(
              get: pushIsActive,
              send: .pop(on: currentID)
            ),
            label: { EmptyView() }
          )
        )
    }
  }

  // MARK: - Helpers
  private func next(
    in state: RouterState
  ) -> ScreenState? {
    state.screens[currentID]
      .flatMap(\.next)
      .flatMap { nextID in state.screens[nextID] }
  }

  private func push(
    state: RouterState
  ) -> ScreenState? {
    next(in: state)
      .flatMap { nextScreen in
        nextScreen.content.presentationStyle == .push ? nextScreen: nil
      }
  }

  private func pushIsActive(
    state: RouterState
  ) -> Bool {
    push(state: state) != nil
  }

  private func sheet(
    state: RouterState
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
    _ coordinated: Routed,
    nextID: ScreenID
  ) -> some View {
    coordinated
      .environment(\.currentScreenID, nextID)
      .environment(\.parentScreenID, currentID)
  }
}
