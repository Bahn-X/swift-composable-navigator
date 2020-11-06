import ComposableArchitecture
import SwiftUI

public struct Routed: View {
  public struct Next: Identifiable {
    let screenState: ScreenState
    let content: AnyView

    init<Content: View>(screenState: ScreenState, content: Content) {
      self.screenState = screenState
      self.content = AnyView(content)
    }

    public var id: ScreenID { screenState.id }
  }

  @Environment(\.currentScreenID) private var currentID
  private let store: Store<RouterState, RouterAction>
  private let content: AnyView
  var next: Next?

  public init<Content: View>(
    store: Store<RouterState, RouterAction>,
    content: Content,
    next: Next?
  ) {
    self.store = store
    self.content = AnyView(content)
    self.next = next
  }

  public var body: some View {
    WithViewStore(store) { viewStore in
      content
        .id(currentID)
        .sheet(
          item: viewStore.binding(
            get: { _ in sheet },
            send: .dismissSheet(on: currentID)
          ),
          content: { sheet in
            sheet.content
              .environment(\.parentScreenID, currentID)
              .environment(\.currentScreenID, sheet.id)
          }
        )
        .overlay(
          NavigationLink(
            destination: push.flatMap { push in
              push.content
                .environment(\.parentScreenID, currentID)
                .environment(\.currentScreenID, push.id)
            },
            isActive: viewStore.binding(
              get: { _ in pushIsActive } ,
              send: .pop(on: currentID)
            ),
            label: { EmptyView() }
          )
        )
    }
  }

  private var sheet: Next? {
    next.flatMap { next in
      next.screenState.content.presentationStyle == .sheet ? next: nil
    }
  }

  private var push: Next? {
    next.flatMap { next in
      next.screenState.content.presentationStyle == .push ? next: nil
    }
  }

  private var pushIsActive: Bool {
    push != nil
  }
}
