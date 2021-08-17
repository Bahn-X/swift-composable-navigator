import Foundation

public extension Navigator {
  /// Observable Object exposing navigation path changes
  class Datasource: ObservableObject {
    @Published public var navigationTree: NavigationTreeUpdate

    private let screenID: () -> ScreenID

    init(
      navigationTree: ActiveNavigationTree,
      screenID: @escaping () -> ScreenID = ScreenID.init
    ) {
      self.navigationTree = NavigationTreeUpdate(
        previous: [],
        current: navigationTree
      )
      self.screenID = screenID
    }

    func go(to successor: AnyScreen, on id: ScreenID, forceNavigation: Bool) {
      update(
        path: navigationTree.current.go(
            to: successor,
            on: id,
            forceNavigation: forceNavigation,
            screenID: screenID
        )
      )
    }

    func go(to newPath: ActiveNavigationPath, on id: ScreenID) {
      update(
        path: navigationTree.current.go(
          to: newPath,
          on: id,
          forceNavigation: true,
          screenID: screenID
        )
      )
    }

    func goBack(to id: ScreenID) {
      dismissSuccessor(of: id)
    }

    func replace(path: ActiveNavigationPath) {
      guard !path.isEmpty else {
        return
      }

      update(
        path: navigationTree.current.update(
          with: path,
          screenID: screenID
        )
      )
    }

    func dismiss(id: ScreenID) {
      update(path: navigationTree.current.dismiss(id: id))
    }

    func dismissSuccessor(of id: ScreenID) {
      update(path: navigationTree.current.dismissSuccessor(of: id))
    }

    func replaceContent(of id: ScreenID, with newContent: AnyScreen) {
      update(path: navigationTree.current.replaceContent(of: id, with: newContent))
    }

    func didAppear(id: ScreenID) {
      update(path: navigationTree.current.didAppear(id: id))
    }

    func activate(_ activatable: AnyActivatable) {
      update(path: navigationTree.current.activate(activatable))
    }

    public func initializeDefaultContents(for id: ScreenID, contents: [DefaultTabContent]) {
      update(
        path: navigationTree.current.initializeDefaultContents(
          for: id,
          contents: contents,
          initScreenID: screenID
        )
      )
    }

    private func update(path newValue: ActiveNavigationTree) {
      guard newValue != navigationTree.current else { return }

      navigationTree = NavigationTreeUpdate(
        previous: navigationTree.current,
        current: newValue
      )
    }
  }
}

// MARK: - Screen based navigation
extension Navigator.Datasource {
  private func lastOccurrence(of content: AnyScreen) -> ScreenID? {
    navigationTree.current.lastOccurrence(of: content)
  }

  func go(to successor: AnyScreen, on parent: AnyScreen, forceNavigation: Bool) {
    guard let id = lastOccurrence(of: parent) else { return }
    go(to: successor, on: id, forceNavigation: forceNavigation)
  }

  func go(to newPath: ActiveNavigationPath, on parent: AnyScreen) {
    guard let id = lastOccurrence(of: parent) else { return }
    go(to: newPath, on: id)
  }

  func goBack(to predecessor: AnyScreen) {
    guard let id = lastOccurrence(of: predecessor) else { return }
    goBack(to: id)
  }

  func dismiss(screen: AnyScreen) {
    guard let id = lastOccurrence(of: screen) else { return }
    dismiss(id: id)
  }

  func dismissSuccessor(of screen: AnyScreen) {
    guard let id = lastOccurrence(of: screen) else { return }
    dismissSuccessor(of: id)
  }

  func replace(screen: AnyScreen, with newContent: AnyScreen) {
    guard let id = lastOccurrence(of: screen) else { return }
    replaceContent(of: id, with: newContent)
  }
}

// MARK: - Convenience Initialisers
public extension Navigator.Datasource {
  convenience init(
    path: [IdentifiedScreen],
    screenID: @escaping () -> ScreenID = ScreenID.init
  ) {
    self.init(
      navigationTree: path.map(ActiveNavigationTreeElement.screen),
      screenID: screenID
    )
  }

  /// Initialise a data source given a root screen.
  /// - Parameters:
  ///   - root: The application's root screen
  ///   - screenID: Closure used to initialise `ScreenID`s for new navigation path elements
  convenience init<S: Screen>(
    root: S,
    screenID: @escaping () -> ScreenID = ScreenID.init
  ) {
    self.init(
      root: root.eraseToAnyScreen(),
      screenID: screenID
    )
  }

  /// Initialise a data source given a root active navigation path element.
  /// - Parameters:
  ///   - root: The application's root screen
  ///   - screenID: Closure used to initialise `ScreenID`s for new navigation path elements
  convenience init(
    root: ActiveNavigationPathElement,
    screenID: @escaping () -> ScreenID = ScreenID.init
  ) {
    self.init(
      navigationTree: [root].toNavigationTree(screenID: screenID),
      screenID: screenID
    )
  }

  /// Initialise a data source given a root screen.
  /// - Parameters:
  ///   - root: The application's root screen
  ///   - screenID: Closure used to initialise `ScreenID`s for new navigation path elements
  convenience init(
    root: AnyScreen,
    screenID: @escaping () -> ScreenID = ScreenID.init
  ) {
    self.init(
      path: [
        IdentifiedScreen(
          id: .root,
          content: root,
          hasAppeared: false
        )
      ],
      screenID: screenID
    )
  }

  /// Initialise a data source given a navigation path.
  /// - Parameters:
  ///   - path: The navigation path built on Root view appear
  ///   - screenID: Closure used to initialise `ScreenID`s for new navigation path elements
  convenience init(
    screens: [AnyScreen],
    screenID: @escaping () -> ScreenID = ScreenID.init
  ) {
    let identifiedPath = screens.map { element in
      IdentifiedScreen(id: screenID(), content: element, hasAppeared: false)
    }

    self.init(
      path: identifiedPath,
      screenID: screenID
    )
  }
}
