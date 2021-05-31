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

    func go(to newPath: [AnyScreen], on id: ScreenID) {
      guard let index = navigationTree.current.firstIndex(where: { $0.id == id }) else {
        return
      }

      let suffix = navigationTree
        .current
        .suffix(from: index.advanced(by: 1))
        .prefix(newPath.count)

      let firstNonMatchingContent = zip(suffix.indices, suffix)
        .first(
          where: { (index, element) in
            let newPathIndex = index.advanced(by: -suffix.startIndex)
            return element.content != newPath[newPathIndex]
              || element.content.presentationStyle != newPath[newPathIndex].presentationStyle
          }
        )?.0 ?? suffix.endIndex

      let matchingContentRange = suffix.startIndex..<firstNonMatchingContent
      let suffixRange = suffix.startIndex..<suffix.startIndex.advanced(by: newPath.count)

      let appendedPath = zip(suffixRange, newPath)
        .map { index, element -> ActiveNavigationTreeElement in
          let oldPathElement: ActiveNavigationTreeElement? = matchingContentRange.contains(index)
            ? suffix[index]
            : nil

          let id: ScreenID = oldPathElement.map(\.id) ?? screenID()
          let hasAppeared = oldPathElement.map(\.hasAppeared) ?? false
            && (index != matchingContentRange.last || index == navigationTree.current.endIndex.advanced(by: -1))

          return .screen(
            IdentifiedScreen(
              id: id,
              content: element,
              hasAppeared: hasAppeared
            )
          )
        }

      update(
        path: Array(navigationTree.current.prefix(through: index))
          + appendedPath
      )
    }

    func goBack(to id: ScreenID) {
      dismissSuccessor(of: id)
    }

    func replace(path: [AnyScreen]) {
      guard !path.isEmpty else {
        return
      }

      let pathPrefix = self.navigationTree.current.prefix(path.count)

      let firstNonMatchingContent = pathPrefix
        .enumerated()
        .first(
          where: { (index, element) in
            element.content != path[index]
              || element.content.presentationStyle != path[index].presentationStyle
          }
        )?
        .offset
        ?? pathPrefix.count

      let matchingContentRange = 0..<firstNonMatchingContent

      let newPath = path
        .enumerated()
        .map { (index, element) -> ActiveNavigationTreeElement in
          let oldPathElement: ActiveNavigationTreeElement? = matchingContentRange.contains(index)
            ? self.navigationTree.current[index]
            : nil

          let fallBackID = (index == 0) ? ScreenID.root: self.screenID()
          let id: ScreenID = oldPathElement.map(\.id) ?? fallBackID
          let hasAppeared = oldPathElement.map(\.hasAppeared) ?? false
            && (index != matchingContentRange.last || index == self.navigationTree.current.endIndex.advanced(by: -1))

          return .screen(
            IdentifiedScreen(
              id: id,
              content: element,
              hasAppeared: hasAppeared
            )
          )
        }

      update(path: newPath)
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

  func go(to newPath: [AnyScreen], on parent: AnyScreen) {
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
