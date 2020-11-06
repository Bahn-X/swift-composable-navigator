import Foundation

//swiftymocky: AutoMockable
public protocol Route: Hashable, Identifiable {
  var id: ScreenID { get }
  var presentationStyle: ScreenPresentationStyle { get }
}

public extension Route {
  func eraseToAnyRoute() -> AnyRoute {
    AnyRoute(self)
  }
}
