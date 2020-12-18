import SwiftUI

public struct Routed: View {
  @Environment(\.navigator) var navigator

  private struct Successors: Identifiable {
    let first: IdentifiedScreen
    let path: [IdentifiedScreen]

    init?(path: [IdentifiedScreen]) {
      guard let first = path.first else {
        return nil
      }

      self.first = first
      self.path = path
    }

    var id: ScreenID { first.id }
  }

  private let screen: IdentifiedScreen
  private let successors: [IdentifiedScreen]
  private let content: AnyView
  private let onAppear: (Bool) -> Void
  private let next: (([IdentifiedScreen]) -> Routed?)?

  public init<Content: View>(
    screen: IdentifiedScreen,
    successors: [IdentifiedScreen],
    content: Content,
    onAppear: @escaping (Bool) -> Void,
    next: (([IdentifiedScreen]) -> Routed?)?
  ) {
    self.screen = screen
    self.successors = successors
    self.content = AnyView(content)
    self.onAppear = onAppear
    self.next = next
  }

  public var body: some View {
    content
      .sheet(
        item: sheetBinding,
        content: build(successors:)
      )
      .overlay(
        NavigationLink(
          destination: push.flatMap(build(successors:)),
          isActive: pushIsActive,
          label: { EmptyView() }
        )
      )
      .onAppear {
        self.onAppear(!screen.hasAppeared)

        if !screen.hasAppeared {
          DispatchQueue.main.async {
            navigator.didAppear(id: screen.id)
          }
        }
      }
      .id(screen.id)
  }

  private var pushIsActive: Binding<Bool> {
    Binding(
      get: {
        guard screen.hasAppeared,
              let successor = successors.first,
              case .push = successor.content.presentationStyle,
              next?([successor]) != nil
        else {
          return false
        }

        return true
      },
      set: { _ in
        guard let successor = successors.first else {
            return
        }
        navigator.dismiss(id: successor.id)
      }
    )
  }

  private var push: Successors? {
    guard let successor = successors.first, case .push = successor.content.presentationStyle else {
      return nil
    }

    return Successors(path: successors)
  }

  private var sheetBinding: Binding<Successors?> {
    Binding(
      get: { () -> Successors? in
        guard let successor = successors.first,
              case .sheet = successor.content.presentationStyle,
              next?([successor]) != nil
        else {
          return nil
        }

        return Successors(path: successors)
      },
      set: { value in
        if value == nil { onAppear(false) }

        guard let successor = successors.first else {
            return
        }
        navigator.dismiss(id: successor.id)
      }
    )
  }

  @ViewBuilder private func build(successors: Successors) -> some View {
    let content = next?(successors.path)
      .environment(\.parentScreenID, screen.id)
      .environment(\.currentScreenID, successors.id)
      .environment(\.navigator, navigator)

    switch successors.first.content.presentationStyle {
    case .push, .sheet(allowsPush: false):
      content
    case .sheet(allowsPush: true):
      NavigationView { content }
        .navigationViewStyle(StackNavigationViewStyle())
    }
  }
}
