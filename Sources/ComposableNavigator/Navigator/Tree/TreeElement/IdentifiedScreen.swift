/// An identified representation of a `Screen` in a navigation path
public struct IdentifiedScreen: Hashable, Identifiable {
  public let id: ScreenID
  public let content: AnyScreen
  public var hasAppeared: Bool

  public init(id: ScreenID, content: AnyScreen, hasAppeared: Bool) {
    self.id = id
    self.content = content
    self.hasAppeared = hasAppeared
  }

  public init<S: Screen>(id: ScreenID, content: S, hasAppeared: Bool) {
    self.id = id
    self.content = content.eraseToAnyScreen()
    self.hasAppeared = hasAppeared
  }
}
