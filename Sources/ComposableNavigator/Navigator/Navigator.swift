import Foundation

public protocol NavigatorDatasource: ObservableObject {
  var path: [IdentifiedScreen] { get }
}

public struct Navigator {
  private let _go: (AnyScreen, ScreenID) -> Void
  private let _goBack: (AnyScreen) -> Void
  private let _replace: ([AnyScreen]) -> Void
  private let _dismiss: (ScreenID) -> Void
  private let _dismissSuccessor: (ScreenID) -> Void
  private let _didAppear: (ScreenID) -> Void

  public func go<S: Screen>(to screen: S, on id: ScreenID) {
    _go(screen.eraseToAnyScreen(), id)
  }

  public func goBack<S: Screen>(to route: S) {
    _goBack(route.eraseToAnyScreen())
  }

  public func replace(path: AnyScreen...) {
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
    go: @escaping (AnyScreen, ScreenID) -> Void,
    goBack: @escaping (AnyScreen) -> Void,
    replace: @escaping ([AnyScreen]) -> Void,
    dismiss: @escaping (ScreenID) -> Void,
    dismissSuccessor: @escaping (ScreenID) -> Void,
    didAppear: @escaping (ScreenID) -> Void
  ) {
      self._go = go
      self._goBack = goBack
      self._replace = replace
      self._dismiss = dismiss
      self._dismissSuccessor = dismissSuccessor
      self._didAppear = didAppear
  }
}

extension Navigator {
  static let stub = Navigator(
    go: { _, _ in fatalError("go(to:) unimplemented in stub") },
    goBack: { _ in fatalError("goBack(to:) unimplemented in stub") },
    replace: { _ in fatalError("replace(path:) unimplemented in stub") },
    dismiss: { _ in fatalError("dismiss(id:) unimplemented in stub") },
    dismissSuccessor: { _ in fatalError("dismissSuccessor(of:) unimplemented in stub") },
    didAppear: { _ in fatalError("didAppear(id:) unimplemented in stub") }
  )
}
