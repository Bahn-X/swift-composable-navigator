import ComposableNavigator

/// Convenience Type allowing to define DeeplinkParser based on a closure.
public struct DeeplinkParser {
  private let _parse: (Deeplink) -> [AnyScreen]?

  public init(parse: @escaping (Deeplink) -> [AnyScreen]?) {
    self._parse = parse
  }

  /// Parses a Deeplink to a routing path
  ///
  /// - Returns: If the DeepLinkParser is responsible for the passed deeplink, it returns the built routing path
  public func parse(_ deeplink: Deeplink) -> [AnyScreen]? {
    _parse(deeplink)
  }
}
