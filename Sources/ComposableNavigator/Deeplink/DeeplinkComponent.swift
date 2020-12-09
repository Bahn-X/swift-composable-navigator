import Foundation

public struct DeeplinkComponent: Hashable {
  public enum Argument: Hashable {
    case flag
    case value(String)
  }

  public let name: String
  public let arguments: [String: Argument]?

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

  init(name: String, queryItems: [String: Argument]?) {
    self.name = name
    self.arguments = queryItems
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
