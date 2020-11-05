import Foundation

public struct Coordinator {
  private let _coordinate: (CoordinatorAction) -> Void
  private let _buildRoute: (AnyRoute) -> Coordinated?
  private let _parse: (URL) -> AnyRoute?

  public init(
    coordinate: @escaping (CoordinatorAction) -> Void,
    buildRoute: @escaping (AnyRoute) -> Coordinated?,
    parse: @escaping (URL) -> AnyRoute?
  ) {
    self._coordinate = coordinate
    self._buildRoute = buildRoute
    self._parse = parse
  }

  public func coordinate(_ action: CoordinatorAction) {
    _coordinate(action)
  }

  func build(_ route: AnyRoute) -> Coordinated? {
    _buildRoute(route)
  }

  func parse(_ url: URL) -> AnyRoute? {
    _parse(url)
  }
}
