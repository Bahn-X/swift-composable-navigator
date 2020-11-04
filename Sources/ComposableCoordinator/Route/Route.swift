import Foundation

public protocol Route: Hashable {
  var presentationStyle: ScreenPresentationStyle { get }
}

public extension Route {
  func eraseToAnyRoute() -> AnyRoute {
    AnyRoute(self)
  }
}
