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

  func path() -> [IdentifiedScreen] {
    _path()
  }

  public func go<S: Screen>(to screen: S, on id: ScreenID) {
    _go(screen.eraseToAnyScreen(), id)
  }

  public func go(to path: [AnyScreen], on id: ScreenID) {
    _goToPath(path, id)
  }

  public func goBack<S: Screen>(to route: S) {
    _goBack(route.eraseToAnyScreen())
  }
  
  public func replace(path: AnyScreen...) {
    _replace(path)
  }

  public func replace(path: [AnyScreen]) {
    _replace(path)
  }

  public func dismiss(id: ScreenID) {
    _dismiss(id)
  }

  public func dismissSuccessor(id: ScreenID) {
    _dismissSuccessor(id)
  }

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
  static func stub(
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
}

// MARK: - Debug
public extension Navigator {
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
