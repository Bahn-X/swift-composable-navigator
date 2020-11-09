import ComposableArchitecture
import SwiftUI

public struct Routed: View {
  public struct Next: Identifiable {
    let screenState: IdentifiedScreen
    let content: AnyView

    init<Content: View>(screenState: IdentifiedScreen, content: Content) {
      self.screenState = screenState
      switch screenState.content.presentationStyle {
        case .push, .sheet(allowsPush: false):
          self.content = AnyView(content)
        case .sheet(allowsPush: true):
          self.content = AnyView(
            NavigationView { content }
              .navigationViewStyle(StackNavigationViewStyle())
          )
      }
    }

    public var id: ScreenID { screenState.id }
  }

  @Environment(\.currentScreenID) private var currentID
  private let store: Store<RouterState, RouterAction>
  private let content: AnyView
  private let next: Next?

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
            send: .dismissSuccessor(of: currentID)
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
              send: .dismissSuccessor(of: currentID)
            ),
            label: { EmptyView() }
          )
        )
    }
  }

  private var sheet: Next? {
    next.flatMap { next in
      guard case .sheet = next.screenState.content.presentationStyle else {
        return nil
      }
      return next
    }
  }

  private var push: Next? {
    next.flatMap { next in
      guard case .push = next.screenState.content.presentationStyle else {
        return nil
      }
      return next
    }
  }

  private var pushIsActive: Bool {
    push != nil
  }
}
