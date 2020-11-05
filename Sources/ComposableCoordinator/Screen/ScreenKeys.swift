import SwiftUI

public enum ParentScreenID: EnvironmentKey {
  public static let defaultValue: ScreenID? = nil
}

public enum CurrentScreenID: EnvironmentKey {
  public static let defaultValue: ScreenID = ScreenID()
}

public extension EnvironmentValues {
  var parentScreenID: ScreenID? {
    get { self[ParentScreenID.self] }
    set { self[ParentScreenID.self] = newValue }
  }
  
  var currentScreenID: ScreenID {
    get { self[CurrentScreenID.self] }
    set { self[CurrentScreenID.self] = newValue }
  }
}
