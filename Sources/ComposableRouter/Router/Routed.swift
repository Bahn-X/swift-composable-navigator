import ComposableArchitecture
import SwiftUI

public struct Routed: View {
  private struct Successor: Identifiable {
    let first: IdentifiedScreen
    let path: [IdentifiedScreen]

    var id: ScreenID { first.id }
  }

  @Environment(\.currentScreenID) private var currentID
  private let store: Store<RouterState, RouterAction>
  private let content: AnyView
  private let next: (([IdentifiedScreen]) -> Routed?)?

  public init<Content: View>(
    store: Store<RouterState, RouterAction>,
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
          content: { sheet in
            next?(sheet.path)
              .environment(\.parentScreenID, currentID)
              .environment(\.currentScreenID, sheet.id)
          }
        )
        .overlay(
          NavigationLink(
            destination: push(in: viewStore).flatMap { push in
              next?(push.path)
                .environment(\.parentScreenID, currentID)
                .environment(\.currentScreenID, push.id)
            },
            isActive: pushIsActive(in: viewStore),
            label: { EmptyView() }
          )
        )
        .onAppear {
          if !(viewStore.path.first(where: { $0.id == currentID })?.didAppear ?? true) {
            DispatchQueue.main.async {
              viewStore.send(.didAppear(currentID))
            }
          }
        }
    }
    .id(currentID)
  }

  private func pushIsActive(
    in viewStore: ViewStore<RouterState, RouterAction>
  ) -> Binding<Bool> {
    viewStore.binding(
      get: { state -> Bool in
        guard (viewStore.state.screen(with: currentID)?.didAppear ?? false),
              let tail = state.tail(from: currentID)?.dropFirst(),
              let successor = tail.first,
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
    in viewStore: ViewStore<RouterState, RouterAction>
  ) -> Successor? {
    guard let tail = viewStore.state.tail(from: currentID)?.dropFirst(),
          let successor = tail.first,
          case .push = successor.content.presentationStyle
    else {
      return nil
    }

    return Successor(first: successor, path: Array(tail))
  }

  private func sheetBinding(
    in viewStore: ViewStore<RouterState, RouterAction>
  ) -> Binding<Successor?> {
    viewStore.binding(
      get: { state -> Successor? in
        guard let tail = state.tail(from: currentID)?.dropFirst(),
              let successor = tail.first,
              case .sheet = successor.content.presentationStyle
        else {
          return nil
        }

        return Successor(first: successor, path: Array(tail))
      },
      send: .dismissSuccessor(of: currentID)
    )
  }
}
