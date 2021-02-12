import SwiftUI

/// Screen container view, taking care of push and sheet bindings.
public struct Routed<Content: View, Next: View>: View {
  @Environment(\.currentScreenID) var screenID
  @Environment(\.currentScreen) var currentScreen
  @Environment(\.navigator) var navigator
  @Environment(\.treatSheetDismissAsAppearInPresenter) var treatSheetDismissAsAppearInPresenter
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
      .uiKitOnAppear {
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
      set: { isActive in
        guard !isActive, let successor = successors?.first, successor.hasAppeared else {
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
        if let screen = screen, !screen.hasAppeared {
          DispatchQueue.main.async {
            navigator.didAppear(id: screenID)
          }
        }

        guard value == nil, let successor = successors?.first, successor.hasAppeared else {
            return
        }

        if treatSheetDismissAsAppearInPresenter { onAppear(false) }
        navigator.dismiss(id: successor.id)
      }
    )
  }

  @ViewBuilder private func build(successors: Successors) -> some View {
    let content = next?(successors.path)
      .environment(\.parentScreenID, screenID)
      .environment(\.parentScreen, currentScreen)
      .environment(\.currentScreenID, successors.first.id)
      .environment(\.currentScreen, successors.first.content)
      .environment(\.navigator, navigator)
      .environment(\.treatSheetDismissAsAppearInPresenter, treatSheetDismissAsAppearInPresenter)
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
