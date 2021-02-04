import Foundation

public struct Navigator {
  private let _path: () -> [IdentifiedScreen]
  private let _go: (AnyScreen, ScreenID) -> Void
  private let _goToPath: ([AnyScreen], ScreenID) -> Void
  private let _goBack: (AnyScreen) -> Void
  private let _replace: ([AnyScreen]) -> Void
  private let _dismiss: (ScreenID) -> Void
  private let _dismissSuccessor: (ScreenID) -> Void
  private let _didAppear: (ScreenID) -> Void

  /// Retrieve the current value of the routing path
  /// - Returns: The current routing path
  /// - SeeAlso: Navigator.debug()
  func path() -> [IdentifiedScreen] {
    _path()
  }

  /// Append a screen after a  given screen ID.
  ///
  /// `go(to:, on:)` appends the given screen after the screen associated with the passed screen ID. If you call `go(to:, on:)` for a screen ID that is not associated with the last screen in the current routing path, the routing path after the screen ID is replaced with `[screen]` and therefore cut off.
  ///
  /// ## Example
  /// ```swift
  /// // Curent path [(Content, ID)]
  /// // [(A, 0), (B, 1)]
  /// navigator.go(to: C(), on: 1)
  /// // New path
  /// // [(A, 0), (B, 1)], (C, 2)]
  /// ```
  ///
  /// - Parameters:
  ///   - screen: Destination
  ///   - id: Screen ID used to identify where the destination should be appended
  public func go<S: Screen>(to screen: S, on id: ScreenID) {
    _go(screen.eraseToAnyScreen(), id)
  }


  /// Replace the path  after a given screen ID with the passed path.
  ///
  /// `go(to:, on:)` appends the given path after the screen associated with the passed screen ID. If you call `go(to:, on:)` for a screen ID that is not associated with the last screen in the current routing path, the routing path after the screen ID is replaced with `path` and potentially cut off.
  ///
  /// ## Example
  /// ```swift
  /// // Curent path [(Content, ID)]
  /// // [(A, 0), (B, 1)]
  ///
  /// navigator.go(
  ///  to: [C().eraseToAnyScreen(), D().eraseToAnyScreen()],
  ///  on: 1
  /// )
  ///
  /// // New path
  /// // [(A, 0), (B, 1)], (C, 2), (D, 3)]
  /// ```
  ///
  /// - Parameters:
  ///   - path: New path after `id`
  ///   - id: Screen ID used to identify where the destination should be appended
  public func go(to path: [AnyScreen], on id: ScreenID) {
    _goToPath(path, id)
  }

  /// Go back to the last occurence of the screen instance in the routing path.
  ///
  /// The function appends the given screen after the screen associated with the passed screen ID. If you call `go(to:, on:)` for a screen ID that is not associated with the last screen in the current routing path, the routing path after the screen ID is replaced with `[screen]` and therefore cut off.
  ///
  /// ## Example
  /// ```swift
  /// // Curent path [(Content, ID)]
  /// // [(A, 0), (B, 1), (C, 2)]
  ///
  /// navigator.goBack(to: A())
  ///
  /// // New path
  /// // [(A, 0)]
  /// ```
  /// - Parameters:
  ///   - screen: Destination
  public func goBack<S: Screen>(to screen: S) {
    _goBack(screen.eraseToAnyScreen())
  }

  /// Replace the current routing path with a new routing path.
  ///
  /// **Example**
  /// ```swift
  /// // Curent path [(Content, ID)]
  /// // [(A, 0), (B, 1)]
  ///
  /// navigator.replace(
  ///   path: C().eraseToAnyScreen(), D().eraseToAnyScreen()
  /// )
  ///
  /// // New path
  /// // [(C, 0), (D, 1)]
  /// ```
  ///
  /// - Parameters:
  ///   - path: The new routing path
   */
  public func replace(path: AnyScreen...) {
    _replace(path)
  }

  /// Replace the current routing path with a new routing path.
  ///
  /// `replace(path:)` checks if a prefix  of the new path was already part of the replaced routing path and makes sure to keep the IDs and hasAppeared state intact.
  ///
  /// ## Example
  /// ```swift
  /// // Curent path [(Content, ID)]
  /// // [(A, 0), (B, 1)]
  ///
  /// navigator.replace(
  ///   path: [
  ///     C().eraseToAnyScreen(),
  ///     D().eraseToAnyScreen()
  ///   ]
  /// )
  ///
  /// // New path
  /// // [(C, 0), (D, 1)]
  /// ```
  ///
  /// - Parameters:
  ///   - path: The new routing path
   */
  public func replace(path: [AnyScreen]) {
    _replace(path)
  }

  /// Removes the screen from the routing path.
  ///
  /// `dismiss(id:)` does not care take the screen's presentation style into account and cuts the routing path up to the passed id.
  ///
  /// ## Example
  /// ```swift
  /// // Curent path [(Content, ID)]
  /// // [(A, 0), (B, 1), (C, 2), (D,3)]
  ///
  /// navigator.dismiss(id: 2)
  ///
  /// // New path
  /// // [(A, 0), (B, 1)]
  /// ```
  ///
  /// - Parameters:
  ///   - id: The id identifying the screen that needs to be dismissed
  public func dismiss(id: ScreenID) {
    _dismiss(id)
  }

  /// Removes the screen successors from the routing path.
  ///
  /// `dismissSuccessor(of id:)` does not care take the screen's presentation style into account and cuts the routing path after the passed id.
  ///
  /// ## Example
  /// ```swift
  /// // Curent path [(Content, ID)]
  /// // [(A, 0), (B, 1), (C, 2), (D,3)]
  ///
  /// navigator.dismissSuccessor(of id: 2)
  ///
  /// // New path
  /// // [(A, 0), (B, 1), (C, 2)]
  /// ```
  ///
  /// - Parameters:
  ///   - id: The id identifying the screen that needs to be dismissed
  public func dismissSuccessor(of id: ScreenID) {
    _dismissSuccessor(id)
  }


  /// Sets the `hasAppeared` flag to `true` for the passed screen ID.
  ///
  /// Needed for nested deeplinks as SwiftUI is only "ready" to navigate once a screen has appeared.
  ///
  /// - Parameters:
  ///   - id: ScreenID identifying the appeared screen
  func didAppear(id: ScreenID) {
    _didAppear(id)
  }

  public init(
    path: @escaping () -> [IdentifiedScreen],
    go: @escaping (AnyScreen, ScreenID) -> Void,
    goToPath: @escaping ([AnyScreen], ScreenID) -> Void,
    goBack: @escaping (AnyScreen) -> Void,
    replace: @escaping ([AnyScreen]) -> Void,
    dismiss: @escaping (ScreenID) -> Void,
    dismissSuccessor: @escaping (ScreenID) -> Void,
    didAppear: @escaping (ScreenID) -> Void
  ) {
    self._path = path
    self._go = go
    self._goToPath = goToPath
    self._goBack = goBack
    self._replace = replace
    self._dismiss = dismiss
    self._dismissSuccessor = dismissSuccessor
    self._didAppear = didAppear
  }
}

// MARK: - Stub
public extension Navigator {
  static func mock(
    path: @escaping () -> [IdentifiedScreen] = { fatalError("path() unimplemented in stub. Make sure to wrap your application in a Root view or inject Navigator via .environment(\\.navigator, navigator) for testing purposes.") },
    go: @escaping (AnyScreen, ScreenID) -> Void = { _, _ in fatalError("go(to:) unimplemented in stub. Make sure to wrap your application in a Root view or inject Navigator via .environment(\\.navigator, navigator) for testing purposes.") },
    goToPath: @escaping ([AnyScreen], ScreenID) -> Void = { _, _ in fatalError("append(path:, to:) unimplemented in stub. Make sure to wrap your application in a Root view or inject Navigator via .environment(\\.navigator, navigator) for testing purposes.") },
    goBack: @escaping (AnyScreen) -> Void = { _ in fatalError("goBack(to:) unimplemented in stub. Make sure to wrap your application in a Root view or inject Navigator via .environment(\\.navigator, navigator) for testing purposes.") },
    replace: @escaping ([AnyScreen]) -> Void = { _ in fatalError("replace(path:) unimplemented in stub. Make sure to wrap your application in a Root view or inject Navigator via .environment(\\.navigator, navigator) for testing purposes.") },
    dismiss: @escaping (ScreenID) -> Void = { _ in fatalError("dismiss(id:) unimplemented in stub. Make sure to wrap your application in a Root view or inject Navigator via .environment(\\.navigator, navigator) for testing purposes.") },
    dismissSuccessor: @escaping (ScreenID) -> Void = { _ in fatalError("dismissSuccessor(of:) unimplemented in stub. Make sure to wrap your application in a Root view or inject Navigator via .environment(\\.navigator, navigator) for testing purposes.") },
    didAppear: @escaping (ScreenID) -> Void = { _ in fatalError("didAppear(id:) unimplemented in stub. Make sure to wrap your application in a Root view or inject Navigator via .environment(\\.navigator, navigator) for testing purposes.") }
  ) -> Navigator {
    Navigator(
      path: path,
      go: go,
      goToPath: goToPath,
      goBack: goBack,
      replace: replace,
      dismiss: dismiss,
      dismissSuccessor: dismissSuccessor,
      didAppear: didAppear
    )
  }

  static let stub = Navigator.mock()
}

// MARK: - Debug
public extension Navigator {
  /// Enable  logging received function calls and path changes.
  func debug() -> Navigator {
    Navigator(
      path: path,
      go: { (screen, id) in
        _go(screen, id)
        print("Sent go(to: \(screen), on: \(id)).\nNew path:")
        dump(path())
      },
      goToPath: { newPath, id in
        _goToPath(newPath, id)
        print("Sent go(to path: \(newPath), on: \(id)).\nNew path:")
        dump(path())
      },
      goBack: { (predecessor) in
        _goBack(predecessor)
        print("Sent goBack(to: \(predecessor)).\nNew path:")
        dump(path())
      },
      replace: { (newPath) in
        _replace(newPath)
        print("Sent replace(path: \(newPath)).\nNew path:")
        dump(path())
      },
      dismiss: { (id) in
        _dismiss(id)
        print("Sent dismiss(id: \(id)).\nNew path:")
        dump(path())
      },
      dismissSuccessor: { (id) in
        _dismissSuccessor(id)
        print("Sent dismissSuccessor(of: \(id)).\nNew path:")
        dump(path())
      },
      didAppear: { (id) in
        _didAppear(id)
        print("Sent didAppear(id: \(id)).\nNew path:")
        dump(path())
      }
    )
  }
}
