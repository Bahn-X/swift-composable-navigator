public struct IdentifiedScreen: Hashable, Identifiable {
  public let id: ScreenID
  public let content: AnyScreen
  public var hasAppeared = false

  public init(id: ScreenID, content: AnyScreen, hasAppeared: Bool = false) {
    self.id = id
    self.content = content
  }

  public init<S: Screen>(id: ScreenID, content: S, hasAppeared: Bool = false) {
    self.id = id
    self.content = content.eraseToAnyScreen()
  }
}
