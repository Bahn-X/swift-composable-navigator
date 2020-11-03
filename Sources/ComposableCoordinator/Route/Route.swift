import Foundation

public struct Route: Hashable {
  public let url: URL
  public let arguments: AnyHashable

  public init<H: Hashable>(url: URL, arguments: H) {
    self.url = url
    self.arguments = arguments
  }
}
