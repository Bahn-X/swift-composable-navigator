import Foundation

/// First class representation of a deeplink based on URLs
public struct Deeplink: Hashable {
  public let components: [DeeplinkComponent]
}

extension Deeplink {
  /// Initialise a deeplink from a URL, matching the passed Scheme
  ///
  /// Typically used to parse deeplinks from URL scheme triggers
  ///
  /// # Example
  /// ```swift
  /// // scheme://name?flag&value=123
  /// let url = URL(string: "scheme://name?flag&value=123")!
  ///
  /// let deeplink = Deeplink(
  ///   url: url,
  ///   matching: "scheme"
  /// )
  ///
  /// deeplink.components == [
  ///   DeeplinkComponent(
  ///     name: "name",
  ///     arguments: [
  ///       "flag": .flag,
  ///       "value": "123"
  ///     ]
  ///   )
  /// ] // True
  /// ```
  public init?(url: URL, matching scheme: String) {
    guard url.scheme == scheme else {
      return nil
    }

    components = [DeeplinkComponent](url: url)
  }
}
