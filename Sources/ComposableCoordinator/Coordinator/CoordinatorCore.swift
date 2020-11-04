import Foundation

public struct CoordinatorState: Equatable {
  var screens: [ScreenID: ScreenState]
}

public enum CoordinatorAction: Equatable {
  case goTo(AnyRoute)
  
  case pushDismissed(on: ScreenID)
  case sheetDismissed(on: ScreenID)
}

struct CoordinatorEnvironment {
  let uuid: () -> UUID
}
