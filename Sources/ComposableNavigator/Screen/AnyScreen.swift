public struct AnyScreen: Hashable {
  let screen: AnyHashable
  let presentationStyle: ScreenPresentationStyle

  public init<S: Screen>(_ route: S) {
    self.screen = route
    self.presentationStyle = route.presentationStyle
  }

  public func unwrap<S: Screen>() -> S? {
    screen as? S
  }

  public func `is`<S: Screen>(_ screenType: S.Type) -> Bool {
    (screen as? S) != nil
  }
}
