import Foundation

public struct DeeplinkComponent: Equatable {
  public enum QueryItem: Equatable {
    case flag
    case value(String)
  }

  public let name: String
  public let queryItems: [String: QueryItem]?

  init(name: String, queryItems: [String: QueryItem]?) {
    self.name = name
    self.queryItems = queryItems
  }

  public init?(url: URL) {
    guard let host = url.host else {
      return nil
    }

    self.name = host
    self.queryItems = URLComponents(
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
          .flatMap(QueryItem.value)
          ?? .flag
      }
    )
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
