public struct AnyRoute: Hashable {
  let route: AnyHashable
  let presentationStyle: ScreenPresentationStyle

  public init<R: Route>(_ route: R) {
    self.route = route
    self.presentationStyle = route.presentationStyle
  }

  public func unwrap<R: Route>() -> R? {
    route as? R
  }

  public func `is`<R: Route>(_ routeType: R.Type) -> Bool {
    (route as? R) != nil
  }
}
