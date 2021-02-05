import Foundation

/// First class representation of a URL path component
///
/// # Example
/// ```swift
/// // scheme://name?flag&value=123
/// DeeplinkComponent(
///    name: "name",
///    arguments: [
///      "flag": .flag,
///      "value": "123"
///    ]
/// )
/// ```
public struct DeeplinkComponent: Hashable {
  public enum Argument: Hashable {
    case flag
    case value(String)
  }

  public let name: String
  public let arguments: [String: Argument]?

  /// Initialise a deeplink component from a URL
  ///
  /// # Example
  /// ```swift
  /// // scheme://name?flag&value=123
  /// DeeplinkComponent(
  ///    name: "name",
  ///    arguments: [
  ///      "flag": .flag,
  ///      "value": "123"
  ///    ]
  /// )
  /// ```
  public init?(url: URL) {
    guard let host = url.host else {
      return nil
    }

    self.name = host
    self.arguments = URLComponents(
      url: url,
      resolvingAgainstBaseURL: false
    )?
    .queryItems?
    .reduce(
      into: [:],
      { items, item in
        items[item.name] = item
          .value?
          .removingPercentEncoding
          .flatMap(Argument.value)
          ?? .flag
      }
    )
  }

  public init(name: String, arguments: [String: Argument]? = nil) {
    self.name = name
    self.arguments = arguments
  }
}

extension Array where Element == DeeplinkComponent {
  init(url: URL) {
    self = url.absoluteString
      .dropFirst(url.scheme?.count.advanced(by: 3) ?? 0)
      .split(separator: "/")
      .map { "scheme://\($0)" }
      .compactMap(URL.init(string:))
      .compactMap(DeeplinkComponent.init(url:))
  }
}
