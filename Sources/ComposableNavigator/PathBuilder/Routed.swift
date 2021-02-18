import SwiftUI

/// Screen container view, taking care of push and sheet bindings.
public struct Routed<Content: View, Successor: View>: View {
  @Environment(\.currentScreenID) var screenID
  @Environment(\.currentScreen) var currentScreen
  @Environment(\.navigator) var navigator
  @Environment(\.treatSheetDismissAsAppearInPresenter) var treatSheetDismissAsAppearInPresenter
  @EnvironmentObject var dataSource: Navigator.Datasource

  private struct Successors: Identifiable, View {
    let first: IdentifiedScreen
    let body: Successor

    var id: ScreenID { first.id }
    var presentationStyle: ScreenPresentationStyle { first.content.presentationStyle }

    init?(path: [IdentifiedScreen], content: Successor) {
      guard let first = path.first else {
        return nil
      }

      self.first = first
      self.body = content
    }
  }

  let content: Content
  let onAppear: (Bool) -> Void
  let next: ([IdentifiedScreen]) -> Successor?

  public init(
    content: Content,
    onAppear: @escaping (Bool) -> Void,
    next: @escaping ([IdentifiedScreen]) -> Successor?
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
    guard let screen = self.screen, let index = dataSource.path.firstIndex(of: screen) else {
      return nil
    }

    let suffix = Array(dataSource.path.suffix(from: index + 1))
    return next(suffix).flatMap { content in
      Successors(path: suffix, content: content)
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
        guard !isActive, let successor = successors?.first, successor.hasAppeared else {
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

        guard value == nil, let successor = successors?.first, successor.hasAppeared else {
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
