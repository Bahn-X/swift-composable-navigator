import ComposableArchitecture
import SwiftUI

public struct Routed: View {
  private struct Successor: Identifiable {
    let first: IdentifiedScreen
    let path: [IdentifiedScreen]

    var id: ScreenID { first.id }
  }

  @Environment(\.currentScreenID) private var currentID
  private let store: Store<NavigatorState, NavigatorAction>
  private let content: AnyView
  private let next: (([IdentifiedScreen]) -> Routed?)?

  public init<Content: View>(
    store: Store<NavigatorState, NavigatorAction>,
    content: Content,
    next: (([IdentifiedScreen]) -> Routed?)?
  ) {
    self.store = store
    self.content = AnyView(content)
    self.next = next
  }

  public var body: some View {
    WithViewStore(store) { viewStore in
      content
        .sheet(
          item: sheetBinding(in: viewStore),
          content: build(successor:)
        )
        .overlay(
          NavigationLink(
            destination: push(in: viewStore).flatMap(build(successor:)),
            isActive: pushIsActive(in: viewStore),
            label: { EmptyView() }
          )
        )
        .onAppear {
          if !(viewStore.state.screen(with: currentID)?.didAppear ?? true) {
            DispatchQueue.main.async {
              viewStore.send(.didAppear(currentID))
            }
          }
        }
    }
    .id(currentID)
  }

  private func pushIsActive(
    in viewStore: ViewStore<NavigatorState, NavigatorAction>
  ) -> Binding<Bool> {
    viewStore.binding(
      get: { state -> Bool in
        guard (viewStore.state.screen(with: currentID)?.didAppear ?? false),
              let suffix = state.suffix(from: currentID)?.dropFirst(),
              let successor = suffix.first,
              case .push = successor.content.presentationStyle
        else {
          return false
        }

        return true
      },
      send: .dismissSuccessor(of: currentID)
    )
  }

  private func push(
    in viewStore: ViewStore<NavigatorState, NavigatorAction>
  ) -> Successor? {
    guard let suffix = viewStore.state.suffix(from: currentID)?.dropFirst(),
          let successor = suffix.first,
          case .push = successor.content.presentationStyle
    else {
      return nil
    }

    return Successor(first: successor, path: Array(suffix))
  }

  private func sheetBinding(
    in viewStore: ViewStore<NavigatorState, NavigatorAction>
  ) -> Binding<Successor?> {
    viewStore.binding(
      get: { state -> Successor? in
        guard let suffix = state.suffix(from: currentID)?.dropFirst(),
              let successor = suffix.first,
              case .sheet = successor.content.presentationStyle
        else {
          return nil
        }

        return Successor(first: successor, path: Array(suffix))
      },
      send: .dismissSuccessor(of: currentID)
    )
  }

  @ViewBuilder private func build(successor: Successor) -> some View {
    let content = next?(successor.path)
      .environment(\.parentScreenID, currentID)
      .environment(\.currentScreenID, successor.id)

    switch successor.first.content.presentationStyle {
      case .push, .sheet(allowsPush: false):
          content
      case .sheet(allowsPush: true):
        NavigationView { content }
        .navigationViewStyle(StackNavigationViewStyle())
    }
  }
}
