import Foundation

/// Facade type erasing the type of the underlying datasource
public struct Navigator {
  private let _path: () -> [IdentifiedScreen]
  private let _go: (AnyScreen, ScreenID) -> Void
  private let _goToOnScreen: (AnyScreen, AnyScreen) -> Void
  private let _goToPath: ([AnyScreen], ScreenID) -> Void
  private let _goToPathOnScreen: ([AnyScreen], AnyScreen) -> Void
  private let _goBack: (AnyScreen) -> Void
  private let _goBackToID: (ScreenID) -> Void
  private let _replace: ([AnyScreen]) -> Void
  private let _dismiss: (ScreenID) -> Void
  private let _dismissScreen: (AnyScreen) -> Void
  private let _dismissSuccessor: (ScreenID) -> Void
  private let _dismissSuccessorOfScreen: (AnyScreen) -> Void
  private let _didAppear: (ScreenID) -> Void

  /// Retrieve the current value of the routing path
  /// - Returns: The current routing path
  /// - SeeAlso: `Navigator.debug()`
  func path() -> [IdentifiedScreen] {
    _path()
  }

  /// Append a screen after a  given `ScreenID`.
  ///
  /// `go(to:, on:)` appends the given screen after the screen associated with the passed `ScreenID`. If you call `go(to:, on:)` for a `ScreenID` that is not associated with the last screen in the current routing path, the routing path after the `ScreenID` is replaced with `[screen]` and therefore cut off.
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
  ///   - id: `ScreenID` used to identify where the destination should be appended
  public func go<S: Screen>(to screen: S, on id: ScreenID) {
    _go(screen.eraseToAnyScreen(), id)
  }

  /// Append a screen after a  given `ScreenID`.
  ///
  /// `go(to:, on:)` appends the given screen after the last occurence of the passed `Parent` screen object.
  /// If you call `go(to:, on:)` for a `Screen` that is not associated with the last screen in the current routing path, the routing path after the `Parent` is replaced with `[screen]` and therefore cut off.
  ///
  /// ## Example
  /// ```swift
  /// // Curent path [(Content, ID)]
  /// // [(A, 0), (B, 1)]
  /// navigator.go(to: C(), on: B())
  /// // New path
  /// // [(A, 0), (B, 1)], (C, 2)]
  /// ```
  ///
  /// - Parameters:
  ///   - screen: Destination
  ///   - parent: `Parent` screen object used to identify where the destination should be appended
  public func go<S: Screen, Parent: Screen>(to screen: S, on parent: Parent) {
    _goToOnScreen(screen.eraseToAnyScreen(), parent.eraseToAnyScreen())
  }

  /// Replace the path  after a given `ScreenID` with the passed path.
  ///
  /// `go(to:, on:)` appends the given path after the screen associated with the passed `ScreenID`. If you call `go(to:, on:)` for a `ScreenID` that is not associated with the last screen in the current routing path, the routing path after the `ScreenID` is replaced with `path` and potentially cut off.
  ///
  /// ## Example
  /// ```swift
  /// // Curent path [(Content, ID)]
  /// // [(A, 0), (B, 1)]
  ///
  /// navigator.go(
  ///  to: [C().eraseToAnyScreen(), D().eraseToAnyScreen()],
  ///  on: 0
  /// )
  ///
  /// // New path
  /// // [(A, 0), (C, 2), (D, 3)]
  /// ```
  ///
  /// - Parameters:
  ///   - path: New path after `id`
  ///   - id: `ScreenID` used to identify where the destination should be appended
  public func go(to path: [AnyScreen], on id: ScreenID) {
    _goToPath(path, id)
  }

  /// Replace the path  after the last occurence of a given `Parent` with the passed path.
  ///
  /// `go(to:, on:)` appends the given path after the last occurence of the passed `Parent` `Screen` object. If you call `go(to:, on:)` for a `Parent` screen that is not associated with the last screen in the current routing path, the routing path after the `ScreenID` is replaced with `path` and potentially cut off.
  ///
  /// ## Example
  /// ```swift
  /// // Curent path [(Content, ID)]
  /// // [(A, 0), (B, 1)]
  ///
  /// navigator.go(
  ///  to: [C().eraseToAnyScreen(), D().eraseToAnyScreen()],
  ///  on: A()
  /// )
  ///
  /// // New path
  /// // [(A, 0), (C, 2), (D, 3)]
  /// ```
  ///
  /// - Parameters:
  ///   - path: New path after `id`
  ///   - parent: `Screen` used to identify where the destination should be appended
  public func go<Parent: Screen>(to path: [AnyScreen], on parent: Parent) {
    _goToPathOnScreen(path, parent.eraseToAnyScreen())
  }

  /// Go back to the last occurence of the screen instance in the routing path.
  ///
  /// `goBack(to:)` trims the routing path to up to the last occurence of the passed screen.
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

  /// Go back to the specified `ScreenID` in the routing path.
  ///
  /// `goBack(to:)` trims the routing path to up to the last occurence of the passed screen.
  ///
  /// ## Example
  /// ```swift
  /// // Curent path [(Content, ID)]
  /// // [(A, 0), (B, 1), (C, 2)]
  ///
  /// navigator.goBack(to: 0)
  ///
  /// // New path
  /// // [(A, 0)]
  /// ```
  /// - Parameters:
  ///   - id: Destination ID
  public func goBack(to id: ScreenID) {
    _goBackToID(id)
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
  public func replace(path: [AnyScreen]) {
    _replace(path)
  }

  /// Removes the screen associated with the passed screenID from the routing path.
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

  /// Removes the last occurence screen from the routing path.
  ///
  /// `dismiss(screen:)` does not care take the screen's presentation style into account and cuts the routing path up to the passed id.
  ///
  /// ## Example
  /// ```swift
  /// // Curent path [(Content, ID)]
  /// // [(A, 0), (B, 1), (C, 2), (D,3)]
  ///
  /// navigator.dismiss(screen: C())
  ///
  /// // New path
  /// // [(A, 0), (B, 1)]
  /// ```
  ///
  /// - Parameters:
  ///   - screen: The screen that needs to be dismissed
  public func dismiss<S: Screen>(screen: S) {
    _dismissScreen(screen.eraseToAnyScreen())
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

  /// Removes successors of  the last occurence of the passed screen from the routing path.
  ///
  /// `dismissSuccessor(of id:)` does not care take the screen's presentation style into account and cuts the routing path after the passed id.
  ///
  /// ## Example
  /// ```swift
  /// // Curent path [(Content, ID)]
  /// // [(A, 0), (B, 1), (C, 2), (D,3)]
  ///
  /// navigator.dismissSuccessor(of: C())
  ///
  /// // New path
  /// // [(A, 0), (B, 1), (C, 2)]
  /// ```
  ///
  /// - Parameters:
  ///   - screen: The screen that needs to be dismissed
  public func dismissSuccessor<S: Screen>(of screen: S) {
    _dismissSuccessorOfScreen(screen.eraseToAnyScreen())
  }

  /// Sets the `hasAppeared` flag to `true` for the passed `ScreenID`.
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
    goToOnScreen: @escaping (AnyScreen, AnyScreen) -> Void,
    goToPath: @escaping ([AnyScreen], ScreenID) -> Void,
    goToPathOnScreen: @escaping ([AnyScreen], AnyScreen) -> Void,
    goBack: @escaping (AnyScreen) -> Void,
    goBackToID: @escaping (ScreenID) -> Void,
    replace: @escaping ([AnyScreen]) -> Void,
    dismiss: @escaping (ScreenID) -> Void,
    dismissScreen: @escaping (AnyScreen) -> Void,
    dismissSuccessor: @escaping (ScreenID) -> Void,
    dismissSuccessorOfScreen: @escaping (AnyScreen) -> Void,
    didAppear: @escaping (ScreenID) -> Void
  ) {
    self._path = path
    self._go = go
    self._goToOnScreen = goToOnScreen
    self._goToPath = goToPath
    self._goToPathOnScreen = goToPathOnScreen
    self._goBack = goBack
    self._goBackToID = goBackToID
    self._replace = replace
    self._dismiss = dismiss
    self._dismissScreen = dismissScreen
    self._dismissSuccessor = dismissSuccessor
    self._dismissSuccessorOfScreen = dismissSuccessorOfScreen
    self._didAppear = didAppear
  }
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
      goToOnScreen: { screen, parent in
        _goToOnScreen(screen, parent)
        print("Sent go(to: \(screen), on: \(parent)).\nNew path:")
        dump(path())
      },
      goToPath: { newPath, id in
        _goToPath(newPath, id)
        print("Sent go(to path: \(newPath), on: \(id)).\nNew path:")
        dump(path())
      },
      goToPathOnScreen: { newPath, parent in
        _goToPathOnScreen(newPath, parent)
        print("Sent go(to path: \(newPath), on: \(parent)).\nNew path:")
        dump(path())
      },
      goBack: { (predecessor) in
        _goBack(predecessor)
        print("Sent goBack(to: \(predecessor)).\nNew path:")
        dump(path())
      },
      goBackToID: { id in
        _goBackToID(id)
        print("Sent goBack(to: \(id)).\nNew path:")
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
      dismissScreen: { screen in
        _dismissScreen(screen)
        print("Sent dismiss(screen: \(screen)).\nNew path:")
        dump(path())
      },
      dismissSuccessor: { (id) in
        _dismissSuccessor(id)
        print("Sent dismissSuccessor(of: \(id)).\nNew path:")
        dump(path())
      },
      dismissSuccessorOfScreen: { screen in
        _dismissSuccessorOfScreen(screen)
        print("Sent dismissSuccessor(of: \(screen)).\nNew path:")
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
