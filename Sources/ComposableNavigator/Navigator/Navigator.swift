import Foundation

/// Facade type erasing the type of the underlying datasource
public struct Navigator {
  private let _navigationTree: () -> NavigationTreeUpdate
  private let _go: (AnyScreen, ScreenID, Bool) -> Void
  private let _goToOnScreen: (AnyScreen, AnyScreen, Bool) -> Void
  private let _goToPath: (ActiveNavigationPath, ScreenID) -> Void
  private let _goToPathOnScreen: (ActiveNavigationPath, AnyScreen) -> Void
  private let _goBack: (AnyScreen) -> Void
  private let _goBackToID: (ScreenID) -> Void
  private let _replace: (ActiveNavigationPath) -> Void
  private let _dismiss: (ScreenID) -> Void
  private let _dismissScreen: (AnyScreen) -> Void
  private let _dismissSuccessor: (ScreenID) -> Void
  private let _dismissSuccessorOfScreen: (AnyScreen) -> Void
  private let _replaceContent: (ScreenID, AnyScreen) -> Void
  private let _replaceScreen: (AnyScreen, AnyScreen) -> Void

  private let _didAppear: (ScreenID) -> Void
  private let _activate: (AnyActivatable) -> Void

  /// Retrieve the current value of the navigation path
  /// - Returns: The current navigation path
  /// - SeeAlso: `Navigator.debug()`
  func navigationTree() -> NavigationTreeUpdate {
    _navigationTree()
  }

  /// Append a screen after a  given `ScreenID`.
  ///
  /// `go(to:, on:)` appends the given screen after the screen associated with the passed `ScreenID`. If you call `go(to:, on:)` for a `ScreenID` that is not associated with the last screen in the current navigation path, the navigation path after the `ScreenID` is replaced with `[screen]` and therefore cut off.
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
  public func go<S: Screen>(
    to screen: S,
    on id: ScreenID,
    forceNavigation: Bool = false
  ) {
    _go(screen.eraseToAnyScreen(), id, forceNavigation)
  }

  /// Append a screen after a  given `Screen`.
  ///
  /// `go(to:, on:)` appends the given screen after the last occurrence of the passed `Parent` screen object.
  /// If you call `go(to:, on:)` for a `Screen` that is not associated with the last screen in the current navigation path, the navigation path after the `Parent` is replaced with `[screen]` and therefore cut off.
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
  public func go<S: Screen, Parent: Screen>(
    to screen: S,
    on parent: Parent,
    forceNavigation: Bool = false
  ) {
    _goToOnScreen(screen.eraseToAnyScreen(), parent.eraseToAnyScreen(), forceNavigation)
  }

  /// Replace the path  after a given `ScreenID` with the passed path.
  ///
  /// `go(to:, on:)` appends the given path after the screen associated with the passed `ScreenID`. If you call `go(to:, on:)` for a `ScreenID` that is not associated with the last screen in the current navigation path, the navigation path after the `ScreenID` is replaced with `path` and potentially cut off.
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
  ///   - id: `ScreenID` used to identify where the path should be appended
  public func go(to path: ActiveNavigationPath, on id: ScreenID) {
    _goToPath(path, id)
  }

  /// Replace the path after the last occurrence of a given `Parent` with the passed path.
  ///
  /// `go(to:, on:)` appends the given path after the last occurrence of the passed `Parent` `Screen` object. If you call `go(to:, on:)` for a `Parent` screen that is not associated with the last screen in the current navigation path, the navigation path after the `ScreenID` is replaced with `path` and potentially cut off.
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
  ///   - path: New path after `Parent`
  ///   - parent: `Screen` used to identify where the path should be appended
  public func go<Parent: Screen>(to path: ActiveNavigationPath, on parent: Parent) {
    _goToPathOnScreen(path, parent.eraseToAnyScreen())
  }

  /// Go back to the last occurrence of the screen instance in the navigation path.
  ///
  /// `goBack(to:)` trims the navigation path to up to the last occurrence of the passed screen.
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

  /// Go back to the specified `ScreenID` in the navigation path.
  ///
  /// `goBack(to:)` trims the navigation path to up to the last occurrence of the passed screen.
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

  /// Replace the current navigation path with a new navigation path.
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
  ///   - path: The new navigation path
  public func replace(path: ActiveNavigationPath) {
    _replace(path)
  }

  /// Removes the screen associated with the passed screenID from the navigation path.
  ///
  /// `dismiss(id:)` does not care take the screen's presentation style into account and cuts the navigation path up to the passed id.
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

  /// Removes the last occurrence screen from the navigation path.
  ///
  /// `dismiss(screen:)` does not care take the screen's presentation style into account and cuts the navigation path up to the passed id.
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

  /// Removes the screen successors from the navigation path.
  ///
  /// `dismissSuccessor(of id:)` does not care take the screen's presentation style into account and cuts the navigation path after the passed id.
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

  /// Removes successors of  the last occurrence of the passed screen from the navigation path.
  ///
  /// `dismissSuccessor(of screen:)` does not care take the screen's presentation style into account and cuts the navigation path after the passed id.
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

  /// Replace the `Screen` associated with an id with a new `Screen`
  ///
  /// `replaceContent(of id:, with:)` replaces the content associated with the passed `ScreenID` and will not assign a new `ScreenID` to the changed path element.
  ///
  /// ## Example
  /// ```swift
  /// // Curent path [(Content, ID)]
  /// // [(A, 0), (B, 1), (C, 2), (D,3)]
  ///
  /// navigator.replaceContent(of: 0, with: E())
  ///
  /// // New path
  /// // [(E, 0), (B, 1), (C, 2), (D,3)]
  /// ```
  ///
  /// - Parameters:
  ///   - id: `ScreenID` used to identify the screen that needs to be replaced
  ///   - newContent: The new screen that will replace the screen associated with the passed `ScreenID`
  public func replaceContent<NewContent: Screen>(of id: ScreenID, with newContent: NewContent) {
    _replaceContent(id, newContent.eraseToAnyScreen())
  }

  /// Replace the last occurrence of a `Screen` with a new `Screen`
  ///
  /// `replace(screen:, with:)` replaces the last occurrence of the passed `Screen` with the passed newContent `Screen` and will not assign a new `ScreenID` to the changed path element.
  ///
  /// ## Example
  /// ```swift
  /// // Curent path [(Content, ID)]
  /// // [(A, 0), (B, 1), (C, 2), (D,3)]
  ///
  /// navigator.replace(screen: A(), with: E())
  ///
  /// // New path
  /// // [(E, 0), (B, 1), (C, 2), (D,3)]
  /// ```
  ///
  /// - Parameters:
  ///   - screen: `Screen` getting replaced
  ///   - newContent: The new screen that will replace the screen associated with the passed `ScreenID`
  public func replace<OldContent: Screen, NewContent: Screen>(
    screen: OldContent,
    with newContent: NewContent
  ) {
    _replaceScreen(screen.eraseToAnyScreen(), newContent.eraseToAnyScreen())
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

  /// Activates the passed `ScreenID`.
  ///
  /// Depending on the context, activating a screen can mean different things.
  /// For TabScreens, setting a screen as active switches the active tab.
  ///
  /// - Parameters:
  ///   - id: ScreenID identifying the active screen
  public func activate<A: Activatable>(_ activatable: A) {
    _activate(activatable.eraseToAnyActivatable())
  }

  public init(
    navigationTree: @escaping () -> NavigationTreeUpdate,
    go: @escaping (AnyScreen, ScreenID, Bool) -> Void,
    goToOnScreen: @escaping (AnyScreen, AnyScreen, Bool) -> Void,
    goToPath: @escaping (ActiveNavigationPath, ScreenID) -> Void,
    goToPathOnScreen: @escaping (ActiveNavigationPath, AnyScreen) -> Void,
    goBack: @escaping (AnyScreen) -> Void,
    goBackToID: @escaping (ScreenID) -> Void,
    replace: @escaping (ActiveNavigationPath) -> Void,
    dismiss: @escaping (ScreenID) -> Void,
    dismissScreen: @escaping (AnyScreen) -> Void,
    dismissSuccessor: @escaping (ScreenID) -> Void,
    dismissSuccessorOfScreen: @escaping (AnyScreen) -> Void,
    replaceContent: @escaping (ScreenID, AnyScreen) -> Void,
    replaceScreen: @escaping (AnyScreen, AnyScreen) -> Void,
    didAppear: @escaping (ScreenID) -> Void,
    activate: @escaping (AnyActivatable) -> Void
  ) {
    self._navigationTree = navigationTree
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
    self._replaceContent = replaceContent
    self._replaceScreen = replaceScreen
    self._didAppear = didAppear
    self._activate = activate
  }
}
