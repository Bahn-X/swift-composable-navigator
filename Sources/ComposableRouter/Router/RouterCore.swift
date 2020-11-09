import Foundation

public struct RouterState: Equatable {
  var screens: [ScreenState]
  
  public init(screens: [ScreenState]) {
    self.screens = screens
  }
}

public enum RouterAction: Equatable {
  case goTo(AnyRoute)
  
  case pop(on: ScreenID)
  case dismissSheet(on: ScreenID)
}

struct RouterEnvironment {
  let screenID: () -> ScreenID
}
