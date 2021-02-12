import Foundation

public extension Navigator {
  /// Observable Object exposing routing path changes
  class Datasource: ObservableObject {
    @Published public var path: [IdentifiedScreen]

    private let screenID: () -> ScreenID

    init(
      path: [IdentifiedScreen],
      screenID: @escaping () -> ScreenID = ScreenID.init
    ) {
      self.path = path
      self.screenID = screenID
    }

    func go(to successor: AnyScreen, on id: ScreenID) {
      guard let index = path.firstIndex(where: { $0.id == id }) else {
        return
      }

      path = path.prefix(through: index) + [
        IdentifiedScreen(
          id: screenID(),
          content: successor,
          hasAppeared: false
        )
      ]
    }

    func go(to newPath: [AnyScreen], on id: ScreenID) {
      guard let index = path.firstIndex(where: { $0.id == id }) else {
        return
      }

      let suffix = path
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
        .map { index, element -> IdentifiedScreen in
          let oldPathElement: IdentifiedScreen? = matchingContentRange.contains(index)
            ? suffix[index]
            : nil

          let id: ScreenID = oldPathElement.map(\.id) ?? screenID()
          let hasAppeared = oldPathElement.map(\.hasAppeared) ?? false
            && (index != matchingContentRange.last || index == path.endIndex.advanced(by: -1))

          return IdentifiedScreen(
            id: id,
            content: element,
            hasAppeared: hasAppeared
          )
        }

      path = Array(path.prefix(through: index)) + appendedPath
    }

    func goBack(to id: ScreenID) {
      guard let index = path.firstIndex(where: { $0.id == id }) else {
        return
      }

      path = Array(path.prefix(through: index))
    }

    func replace(path: [AnyScreen]) {
      guard !path.isEmpty else {
        return
      }

      let pathPrefix = self.path.prefix(path.count)

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
        .map { (index, element) -> IdentifiedScreen in
          let oldPathElement: IdentifiedScreen? = matchingContentRange.contains(index)
            ? self.path[index]
            : nil

          let fallBackID = (index == 0) ? ScreenID.root: self.screenID()
          let id: ScreenID = oldPathElement.map(\.id) ?? fallBackID
          let hasAppeared = oldPathElement.map(\.hasAppeared) ?? false
            && (index != matchingContentRange.last || index == self.path.endIndex.advanced(by: -1))

          return IdentifiedScreen(
            id: id,
            content: element,
            hasAppeared: hasAppeared
          )
        }

      self.path = newPath
    }

    func dismiss(id: ScreenID) {
      guard id != path.first?.id, let index = path.firstIndex(where: { $0.id == id }) else {
        return
      }
      path = Array(path.prefix(upTo: index))
    }

    func dismissSuccessor(of id: ScreenID) -> Void {
      guard let index = path.firstIndex(where: { $0.id == id }) else {
        return
      }

      path = Array(path.prefix(through: index))
    }

    func replaceContent(of id: ScreenID, with newContent: AnyScreen) -> Void {
      guard let index = path.firstIndex(where: { screen in screen.id == id }),
            path[index].content != newContent else {
        return
      }

      path[index] = IdentifiedScreen(
        id: id,
        content: newContent,
        hasAppeared: path[index].hasAppeared
      )
    }

    func replace(screen: AnyScreen, with newContent: AnyScreen) -> Void {
      guard let id = identifiedScreen(for: screen)?.id else {
        return
      }

      replaceContent(of: id, with: newContent)
    }

    func didAppear(id: ScreenID) {
      guard let index = path.firstIndex(where: { $0.id == id }) else {
        return
      }

      path[index] = IdentifiedScreen(
        id: id,
        content: path[index].content,
        hasAppeared: true
      )
    }
  }
}

// MARK: - Screen based navigation
extension Navigator.Datasource {
  private func identifiedScreen(for content: AnyScreen) -> IdentifiedScreen? {
    path.last(where: { $0.content == content })
  }

  func go(to successor: AnyScreen, on parent: AnyScreen) {
    guard let id = identifiedScreen(for: parent)?.id else { return }
    go(to: successor, on: id)
  }

  func go(to newPath: [AnyScreen], on parent: AnyScreen) {
    guard let id = identifiedScreen(for: parent)?.id else { return }
    go(to: newPath, on: id)
  }

  func goBack(to predecessor: AnyScreen) {
    guard let id = identifiedScreen(for: predecessor)?.id else { return }
    goBack(to: id)
  }

  func dismiss(screen: AnyScreen) {
    guard let id = identifiedScreen(for: screen)?.id else { return }
    dismiss(id: id)
  }

  func dismissSuccessor(of screen: AnyScreen) {
    guard let id = identifiedScreen(for: screen)?.id else { return }
    dismissSuccessor(of: id)
  }
}

// MARK: - Convenience Initialisers
public extension Navigator.Datasource {
  /// Initialise a data source given a root screen.
  /// - Parameters:
  ///   - root: The application's root screen
  ///   - screenID: Closure used to initialise `ScreenID`s for new routing path elements
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
  ///   - screenID: Closure used to initialise `ScreenID`s for new routing path elements
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

  /// Initialise a data source given a routing path.
  /// - Parameters:
  ///   - path: The routing path built on Root view appear
  ///   - screenID: Closure used to initialise `ScreenID`s for new routing path elements
  convenience init(
    path: [AnyScreen],
    screenID: @escaping () -> ScreenID = ScreenID.init
  ) {
    let identifiedPath = path.map { element in
      IdentifiedScreen(id: screenID(), content: element, hasAppeared: false)
    }

    self.init(
      path: identifiedPath,
      screenID: screenID
    )
  }
}
