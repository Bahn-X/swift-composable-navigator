import Foundation

public struct Router {
  private let _route: (RouterAction) -> Void
  private let _buildPath: ([IdentifiedScreen]) -> Routed?
  private let _parse: ([DeeplinkComponent]) -> [AnyScreen]?

  public init(
    route: @escaping (RouterAction) -> Void = { _ in
      fatalError("route unimplemented. Wrap your Router in a Root router.")
    },
    buildPath: @escaping ([IdentifiedScreen]) -> Routed?,
    parse: @escaping ([DeeplinkComponent]) -> [AnyScreen]?
  ) {
    self._route = route
    self._buildPath = buildPath
    self._parse = parse
  }

  public func route(_ action: RouterAction) -> Void {
    _route(action)
  }

  func build(_ path: [IdentifiedScreen]) -> Routed? {
    _buildPath(path)
  }

  func parse(_ url: [DeeplinkComponent]) -> [AnyScreen]? {
    _parse(url)
  }
}
