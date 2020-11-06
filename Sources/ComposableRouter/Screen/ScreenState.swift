import Foundation

public struct ScreenState: Hashable, Identifiable {
  public let id: ScreenID
  let content: AnyRoute
}
