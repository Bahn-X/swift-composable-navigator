import Foundation

public struct CoordinatorState: Equatable {
  var screens: [ScreenID: ScreenState]
}

public enum CoordinatorAction: Equatable {
  case goTo(AnyRoute)
  
  case pop(on: ScreenID)
  case dismissSheet(on: ScreenID)
}

struct CoordinatorEnvironment {
  let uuid: () -> UUID
}
