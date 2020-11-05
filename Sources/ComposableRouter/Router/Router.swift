import Foundation

public struct Router {
  private let _route: (RouterAction) -> Bool
  private let _buildRoute: (AnyRoute) -> Routed?
  private let _parse: (URL) -> [AnyRoute]?

  public init(
    route: @escaping (RouterAction) -> Bool,
    buildRoute: @escaping (AnyRoute) -> Routed?,
    parse: @escaping (URL) -> [AnyRoute]?
  ) {
    self._route = route
    self._buildRoute = buildRoute
    self._parse = parse
  }

  public func route(_ action: RouterAction) -> Bool {
    _route(action)
  }

  func build(_ route: AnyRoute) -> Routed? {
    _buildRoute(route)
  }

  func parse(_ url: URL) -> [AnyRoute]? {
    _parse(url)
  }
}
