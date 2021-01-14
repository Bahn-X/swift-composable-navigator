public struct DeeplinkParser {
  private let _parse: (Deeplink) -> [AnyScreen]?

  public init(parse: @escaping (Deeplink) -> [AnyScreen]?) {
    self._parse = parse
  }

  public func parse(_ deeplink: Deeplink) -> [AnyScreen]? {
    _parse(deeplink)
  }
}
