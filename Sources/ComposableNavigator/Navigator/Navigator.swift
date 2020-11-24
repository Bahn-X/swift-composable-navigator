import Foundation

public struct Navigator {
  private let _route: (NavigatorAction) -> Void
  private let _buildPath: ([IdentifiedScreen]) -> Routed?
  private let _parse: ([DeeplinkComponent]) -> [AnyScreen]?

  public init(
    route: @escaping (NavigatorAction) -> Void = { _ in
      fatalError("route unimplemented. Wrap your Router in a Root navigator.")
    },
    buildPath: @escaping ([IdentifiedScreen]) -> Routed?,
    parse: @escaping ([DeeplinkComponent]) -> [AnyScreen]?
  ) {
    self._route = route
    self._buildPath = buildPath
    self._parse = parse
  }

  public func route(_ action: NavigatorAction) -> Void {
    _route(action)
  }

  func build(path: [IdentifiedScreen]) -> Routed? {
    _buildPath(path)
  }

  func parse(components: [DeeplinkComponent]) -> [AnyScreen]? {
    _parse(components)
  }
}
