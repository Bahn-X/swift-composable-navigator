import Foundation

public struct IdentifiedScreen: Hashable, Identifiable {
  public let id: ScreenID
  let content: AnyScreen

  var hasAppeared = false

  public init(id: ScreenID, content: AnyScreen) {
    self.id = id
    self.content = content
  }

  public init<S: Screen>(id: ScreenID, content: S) {
    self.id = id
    self.content = content.eraseToAnyScreen()
  }
}
