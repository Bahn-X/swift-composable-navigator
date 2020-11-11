import Foundation

public struct Deeplink {
  public let components: [DeeplinkComponent]

  public init?(url: URL, matching scheme: String) {
    guard url.scheme == scheme else {
      return nil
    }

    components = [DeeplinkComponent](url: url)
  }
}
