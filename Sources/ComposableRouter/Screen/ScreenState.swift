import Foundation

public struct ScreenState: Hashable, Identifiable {
  public let id: ScreenID
  let content: AnyRoute

  public init(id: ScreenID, content: AnyRoute) {
    self.id = id
    self.content = content
  }

  public init<R: Route>(id: ScreenID, content: R) {
    self.id = id
    self.content = content.eraseToAnyRoute()
  }
}
