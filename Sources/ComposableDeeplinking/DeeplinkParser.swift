import ComposableNavigator

/// `DeeplinkParser`s parse `RoutingPath`s from `Deeplink`s.
///
/// `DeeplinkParser`s are wrapper structs around a pure `(Deeplink) -> [AnyScreen]?` function and support composition.
///
/// # Returns
///  If a deeplink parser handles the input `Deeplink`, it returns a `RoutingPath` in the form of an `AnyScreen` array.
///  If the deeplink parser is not responsible for parsing the deeplink, it returns nil.
public struct DeeplinkParser {
  private let _parse: (Deeplink) -> [AnyScreen]?

  public init(parse: @escaping (Deeplink) -> [AnyScreen]?) {
    self._parse = parse
  }

  /// Parses a Deeplink to a routing path
  ///
  /// - Returns: If the DeepLinkParser is responsible for the passed deeplink, it returns the built routing path. Else nil.
  public func parse(_ deeplink: Deeplink) -> [AnyScreen]? {
    _parse(deeplink)
  }
}
