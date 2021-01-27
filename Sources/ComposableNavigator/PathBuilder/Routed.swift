import SwiftUI

public struct Routed<Content: View, Next: View>: View {
  @Environment(\.currentScreenID) var screenID
  @Environment(\.navigator) var navigator
  @EnvironmentObject var dataSource: Navigator.Datasource

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

  private let content: Content
  private let onAppear: (Bool) -> Void
  private let next: (([IdentifiedScreen]) -> Next?)?

  public init(
    content: Content,
    onAppear: @escaping (Bool) -> Void,
    next: (([IdentifiedScreen]) -> Next?)?
  ) {
    self.content = content
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
        if let screen = self.screen {
          self.onAppear(!screen.hasAppeared)

          if !screen.hasAppeared {
            DispatchQueue.main.async {
              navigator.didAppear(id: screenID)
            }
          }
        }
      }
  }

  private var screen: IdentifiedScreen? {
    dataSource.path.first(where: { $0.id == screenID })
  }

  private var successors: Successors? {
    guard let screen = self.screen,
          let index = dataSource.path.firstIndex(of: screen)
    else {
      return nil
    }

    return Successors(path: Array(dataSource.path.suffix(from: index + 1)))
  }

  private var pushIsActive: Binding<Bool> {
    Binding(
      get: {
        guard screen?.hasAppeared ?? false,
              let successor = successors?.first,
              case .push = successor.content.presentationStyle,
              next?([successor]) != nil
        else {
          return false
        }

        return true
      },
      set: { _ in
        guard let successor = successors?.first else {
            return
        }
        navigator.dismiss(id: successor.id)
      }
    )
  }

  private var push: Successors? {
    guard let successor = successors?.first,
          case .push = successor.content.presentationStyle else {
      return nil
    }

    return successors
  }

  private var sheetBinding: Binding<Successors?> {
    Binding(
      get: { () -> Successors? in
        guard screen?.hasAppeared ?? false,
              let successor = successors?.first,
              case .sheet = successor.content.presentationStyle,
              next?([successor]) != nil
        else {
          return nil
        }

        return successors
      },
      set: { value in
        if value == nil { onAppear(false) }

        guard let successor = successors?.first else {
            return
        }
        navigator.dismiss(id: successor.id)
      }
    )
  }

  @ViewBuilder private func build(successors: Successors) -> some View {
    let content = next?(successors.path)
      .environment(\.parentScreenID, screenID)
      .environment(\.currentScreenID, successors.id)
      .environment(\.navigator, navigator)
      .environmentObject(dataSource)

    switch successors.first.content.presentationStyle {
    case .push, .sheet(allowsPush: false):
      content
    case .sheet(allowsPush: true):
      NavigationView { content }
        .navigationViewStyle(StackNavigationViewStyle())
    }
  }
}
