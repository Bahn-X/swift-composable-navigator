import Foundation
import ComposableArchitecture

public struct Navigator {
  public typealias DataSource = Store<NavigatorState, NavigatorAction>

  private let _route: (NavigatorAction) -> Void
  private let _buildPath: (DataSource, [IdentifiedScreen]) -> Routed?
  private let _parse: ([DeeplinkComponent]) -> [AnyScreen]?

  public init(
    route: @escaping (NavigatorAction) -> Void = { _ in
      fatalError("route unimplemented. Wrap your Navigator in a Root navigator.")
    },
    buildPath: @escaping (DataSource, [IdentifiedScreen]) -> Routed?,
    parse: @escaping ([DeeplinkComponent]) -> [AnyScreen]?
  ) {
    self._route = route
    self._buildPath = buildPath
    self._parse = parse
  }

  public func route(_ action: NavigatorAction) -> Void {
    _route(action)
  }

  func build(dataSource: DataSource, path: [IdentifiedScreen]) -> Routed? {
    return _buildPath(dataSource, path)
  }

  func parse(components: [DeeplinkComponent]) -> [AnyScreen]? {
    _parse(components)
  }
}
