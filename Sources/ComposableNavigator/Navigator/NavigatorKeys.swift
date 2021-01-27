import SwiftUI

public enum NavigatorKey: EnvironmentKey {
  public static let defaultValue: Navigator = .stub()
}

public enum TreatSheetDismissAsAppearInPresenterKey: EnvironmentKey {
  public static let defaultValue: Bool = false
}

public extension EnvironmentValues {
  var navigator: Navigator {
    get { self[NavigatorKey.self] }
    set { self[NavigatorKey.self] = newValue }
  }
  
  var treatSheetDismissAsAppearInPresenter: Bool {
    get { self[TreatSheetDismissAsAppearInPresenterKey.self] }
    set { self[TreatSheetDismissAsAppearInPresenterKey.self] = newValue }
  }
}
