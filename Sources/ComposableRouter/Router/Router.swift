import Foundation

public struct Router {
  private let _route: (RouterAction) -> Void
  private let _buildPath: ([ScreenState]) -> Routed?
  private let _parse: ([URL]) -> [AnyRoute]?

  public init(
    route: @escaping (RouterAction) -> Void = { _ in
      fatalError("route unimplemented. Wrap your Router in a Root router.")
    },
    buildPath: @escaping ([ScreenState]) -> Routed?,
    parse: @escaping ([URL]) -> [AnyRoute]?
  ) {
    self._route = route
    self._buildPath = buildPath
    self._parse = parse
  }

  public func route(_ action: RouterAction) -> Void {
    _route(action)
  }

  func build(_ path: [ScreenState]) -> Routed? {
    _buildPath(path)
  }

  func parse(_ url: [URL]) -> [AnyRoute]? {
    _parse(url)
  }
}
