import SwiftUI

public enum NavigatorKey: EnvironmentKey {
  public static let defaultValue: Navigator = .stub()
}


public extension EnvironmentValues {
  var navigator: Navigator {
    get { self[NavigatorKey.self] }
    set { self[NavigatorKey.self] = newValue }
  }
}
