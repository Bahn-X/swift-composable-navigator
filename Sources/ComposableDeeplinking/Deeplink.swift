import Foundation

public struct Deeplink: Hashable {
  public let components: [DeeplinkComponent]
}

public extension Deeplink {
  init?(url: URL, matching scheme: String) {
    guard url.scheme == scheme else {
      return nil
    }

    components = [DeeplinkComponent](url: url)
  }
}
