import Foundation

//swiftymocky: AutoMockable
public protocol Route: Hashable {
  var presentationStyle: ScreenPresentationStyle { get }
}

public extension Route {
  func eraseToAnyRoute() -> AnyRoute {
    AnyRoute(self)
  }
}
