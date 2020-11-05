import Foundation

public struct RouterState: Equatable {
  var screens: [ScreenID: ScreenState]
}

public enum RouterAction: Equatable {
  case goTo(AnyRoute)
  
  case pop(on: ScreenID)
  case dismissSheet(on: ScreenID)
}

struct RouterEnvironment {
  let uuid: () -> UUID
}
