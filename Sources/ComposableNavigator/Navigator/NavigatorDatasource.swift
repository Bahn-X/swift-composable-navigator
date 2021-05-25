import Foundation

public extension Navigator {
  /// Observable Object exposing navigation path changes
  class Datasource: ObservableObject {
    @Published public var path: NavigationPathUpdate

    private let screenID: () -> ScreenID

    init(
      navigationPath: NavigationPath,
      screenID: @escaping () -> ScreenID = ScreenID.init
    ) {
      self.path = NavigationPathUpdate(
        previous: [],
        current: navigationPath
      )
      self.screenID = screenID
    }

    func go(to successor: AnyScreen, on id: ScreenID, forceNavigation: Bool) {
      update(
        path: path.current.go(
            to: successor,
            on: id,
            forceNavigation: forceNavigation,
            screenID: screenID
        )
      )
    }

    func go(to newPath: [AnyScreen], on id: ScreenID) {
      guard let index = path.current.firstIndex(where: { $0.id == id }) else {
        return
      }

      let suffix = path
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
        .map { index, element -> NavigationPathElement in
          let oldPathElement: NavigationPathElement? = matchingContentRange.contains(index)
            ? suffix[index]
            : nil

          let id: ScreenID = oldPathElement.map(\.id) ?? screenID()
          let hasAppeared = oldPathElement.map(\.hasAppeared) ?? false
            && (index != matchingContentRange.last || index == path.current.endIndex.advanced(by: -1))

          return .screen(
            IdentifiedScreen(
              id: id,
              content: element,
              hasAppeared: hasAppeared
            )
          )
        }

      update(
        path: Array(path.current.prefix(through: index))
          + appendedPath
      )
    }

    func goBack(to id: ScreenID) {
      guard let index = path.current.firstIndex(where: { $0.id == id }) else {
        return
      }

      update(path: Array(path.current.prefix(through: index)))
    }

    func replace(path: [AnyScreen]) {
      guard !path.isEmpty else {
        return
      }

      let pathPrefix = self.path.current.prefix(path.count)

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
        .map { (index, element) -> NavigationPathElement in
          let oldPathElement: NavigationPathElement? = matchingContentRange.contains(index)
            ? self.path.current[index]
            : nil

          let fallBackID = (index == 0) ? ScreenID.root: self.screenID()
          let id: ScreenID = oldPathElement.map(\.id) ?? fallBackID
          let hasAppeared = oldPathElement.map(\.hasAppeared) ?? false
            && (index != matchingContentRange.last || index == self.path.current.endIndex.advanced(by: -1))

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
      guard id != path.current.first?.id,
            let index = path.current.firstIndex(where: { $0.id == id })
      else { return }

      update(path: Array(path.current.prefix(upTo: index)))
    }

    func dismissSuccessor(of id: ScreenID) {
      guard let index = path.current.firstIndex(where: { $0.id == id }) else {
        return
      }

      update(path: Array(path.current.prefix(through: index)))
    }

    func replaceContent(of id: ScreenID, with newContent: AnyScreen) {
      update(
        path: path.current.map { element in
          guard element.id == id else {
            return element
          }

          return .screen(
            IdentifiedScreen(
              id: element.id,
              content: newContent,
              hasAppeared: element.hasAppeared
            )
          )
        }
      )
    }

    func didAppear(id: ScreenID) {
      update(path: path.current.didAppear(id: id))
    }

    func setActive(id: ScreenID) {
      update(path: path.current.setActive(id: id))
    }

    private func update(path newValue: NavigationPath) {
      guard newValue != path.current else { return }

      path = NavigationPathUpdate(
        previous: path.current,
        current: newValue
      )
    }
  }
}

// MARK: - Screen based navigation
extension Navigator.Datasource {
  private func lastOccurrence(of content: AnyScreen) -> ScreenID? {
    path.current.lastOccurrence(of: content)
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

  func setActive(screen: AnyScreen) {
    guard let id = lastOccurrence(of: screen) else { return }
    setActive(id: id)
  }
}

// MARK: - Convenience Initialisers
public extension Navigator.Datasource {
  convenience init(
    path: [IdentifiedScreen],
    screenID: @escaping () -> ScreenID = ScreenID.init
  ) {
    self.init(
      navigationPath: path.map(NavigationPathElement.screen),
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
