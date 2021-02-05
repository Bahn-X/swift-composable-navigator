import SwiftUI

/// EnvironmentKey identifying the `ScreenID` of the screen preceding the screen the view is embedded in
public enum ParentScreenID: EnvironmentKey {
  /// The `ScreenID` of the screen preceding the screen the view is embedded in
  ///
  /// ComposableNavigator makes sure that this value is always filled with the correct value, as long as you embed your content in a `Root` view.
  ///
  /// - SeeAlso: `Root.swift`
  public static let defaultValue: ScreenID? = nil
}

/// EnvironmentKey identifying the `ScreenID` of the screen the view is embedded in
public enum CurrentScreenID: EnvironmentKey {
  /// The `ScreenID` of the screen the view is embedded in
  ///
  /// ComposableNavigator makes sure that this value is always filled with the correct value, as long as you embed your content in a `Root` view.
  ///
  /// - SeeAlso: `Root.swift`
  public static let defaultValue: ScreenID = ScreenID()
}

public extension EnvironmentValues {
  /// The `ScreenID` of the screen preceding the screen the view is embedded in
  var parentScreenID: ScreenID? {
    get { self[ParentScreenID.self] }
    set { self[ParentScreenID.self] = newValue }
  }

  /// The `ScreenID` of the screen the view is embedded in
  var currentScreenID: ScreenID {
    get { self[CurrentScreenID.self] }
    set { self[CurrentScreenID.self] = newValue }
  }
}
