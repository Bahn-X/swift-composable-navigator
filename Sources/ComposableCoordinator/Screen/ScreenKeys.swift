import SwiftUI

enum ParentScreenID: EnvironmentKey {
  static let defaultValue: ScreenID? = nil
}

enum CurrentScreenID: EnvironmentKey {
  static let defaultValue: ScreenID = ScreenID()
}

extension EnvironmentValues {
  var parentScreenID: ScreenID? {
    get { self[ParentScreenID.self] }
    set { self[ParentScreenID.self] = newValue }
  }
  
  var currentScreenID: ScreenID {
    get { self[CurrentScreenID.self] }
    set { self[CurrentScreenID.self] = newValue }
  }
}
