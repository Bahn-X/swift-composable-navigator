import SwiftUI

/// Screen container view, taking care of push and sheet bindings.
public struct NavigationNode<Content: View, Successor: View>: View {
  @Environment(\.currentScreenID) var screenID
  @Environment(\.currentScreen) var currentScreen
  @Environment(\.navigator) var navigator
  @Environment(\.treatSheetDismissAsAppearInPresenter) var treatSheetDismissAsAppearInPresenter
  @EnvironmentObject var dataSource: Navigator.Datasource

  private struct Successors: Identifiable, View {
    let successor: IdentifiedScreen
    let body: Successor

    var id: ScreenID { successor.id }
    var presentationStyle: ScreenPresentationStyle { successor.content.presentationStyle }

    init(successor: IdentifiedScreen, content: Successor) {
      self.successor = successor
      self.body = content
    }
  }

  let content: Content
  let onAppear: (Bool) -> Void
  let next: (PathComponentUpdate) -> Successor?

  public init(
    content: Content,
    onAppear: @escaping (Bool) -> Void,
    next: @escaping (PathComponentUpdate) -> Successor?
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
    dataSource.path.current.first(where: { $0.id == screenID })
  }

  private var successors: Successors? {
    let successorUpdate = dataSource.path.successor(of: screenID)
    return next(successorUpdate).flatMap { content in
      successorUpdate.current.flatMap { successor in
        Successors(successor: successor, content: content)
      }
    }
  }

  private var pushIsActive: Binding<Bool> {
    Binding(
      get: {
        guard screen?.hasAppeared ?? false, case .push = successors?.presentationStyle else {
          return false
        }

        return true
      },
      set: { isActive in
        guard !isActive, let successor = successors?.successor, successor.hasAppeared else {
          return
        }
        navigator.dismiss(id: successor.id)
      }
    )
  }

  private var push: Successors? {
    guard case .push = successors?.presentationStyle else {
      return nil
    }

    return successors
  }

  private var sheetBinding: Binding<Successors?> {
    Binding(
      get: { () -> Successors? in
        guard screen?.hasAppeared ?? false, case .some(.sheet) = successors?.presentationStyle else {
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

        guard value == nil, let successor = successors?.successor, successor.hasAppeared else {
          return
        }

        if treatSheetDismissAsAppearInPresenter { onAppear(false) }
        navigator.dismiss(id: successor.id)
      }
    )
  }

  @ViewBuilder private func build(successors: Successors) -> some View {
    let content = successors
      .environment(\.parentScreenID, screenID)
      .environment(\.parentScreen, currentScreen)
      .environment(\.currentScreenID, successors.successor.id)
      .environment(\.currentScreen, successors.successor.content)
      .environment(\.navigator, navigator)
      .environment(\.treatSheetDismissAsAppearInPresenter, treatSheetDismissAsAppearInPresenter)
      .environmentObject(dataSource)

    switch successors.successor.content.presentationStyle {
    case .push, .sheet(allowsPush: false):
      content
    case .sheet(allowsPush: true):
      NavigationView { content }
        .navigationViewStyle(StackNavigationViewStyle())
    }
  }
}
