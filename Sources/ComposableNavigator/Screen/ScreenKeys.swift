import SwiftUI

/// EnvironmentKey identifying the `ScreenID` of the screen preceding the screen the view is embedded in
enum ParentScreenIDKey: EnvironmentKey {
  /// The `ScreenID` of the screen preceding the screen the view is embedded in
  ///
  /// ComposableNavigator makes sure that this value is always filled with the correct value, as long as you embed your content in a `Root` view.
  ///
  /// - SeeAlso: `Root.swift`
  static let defaultValue: ScreenID? = nil
}

/// EnvironmentKey identifying the `ScreenID` of the screen the view is embedded in
enum CurrentScreenIDKey: EnvironmentKey {
  /// The `ScreenID` of the screen the view is embedded in
  ///
  /// ComposableNavigator makes sure that this value is always filled with the correct value, as long as you embed your content in a `Root` view.
  ///
  /// - SeeAlso: `Root.swift`
  static let defaultValue: ScreenID = ScreenID()
}

/// EnvironmentKey identifying the `Screen` preceding the screen the view is embedded in
enum ParentScreenKey: EnvironmentKey {
  /// The screen preceding the screen the view is embedded in
  ///
  /// ComposableNavigator makes sure that this value is always filled with the correct value, as long as you embed your content in a `Root` view.
  ///
  /// - SeeAlso: `Root.swift`
  static let defaultValue: AnyScreen? = nil
}

/// EnvironmentKey identifying the `Screen` the view is embedded in
enum CurrentScreenKey: EnvironmentKey {
  /// The screen the view is embedded in
  ///
  /// ComposableNavigator makes sure that this value is always filled with the correct value, as long as you embed your content in a `Root` view.
  ///
  /// - SeeAlso: `Root.swift`
  static var defaultValue: AnyScreen {
    struct DummyScreen: Screen {
      let presentationStyle: ScreenPresentationStyle = .push
    }
    print("\\.currentScreen not set. Make sure to wrap your application in a Root view or inject a screen via .environment(\\.currentScreen, screen.eraseToAnyScreen()) for testing purposes.")
    return DummyScreen().eraseToAnyScreen()
  }
}

public extension EnvironmentValues {
  /// The `ScreenID` of the screen preceding the screen the view is embedded in
  var parentScreenID: ScreenID? {
    get { self[ParentScreenIDKey.self] }
    set { self[ParentScreenIDKey.self] = newValue }
  }

  /// The `ScreenID` of the screen the view is embedded in
  var currentScreenID: ScreenID {
    get { self[CurrentScreenIDKey.self] }
    set { self[CurrentScreenIDKey.self] = newValue }
  }

  /// The `Screen` preceding the screen the view is embedded in
  var parentScreen: AnyScreen? {
    get { self[ParentScreenKey.self] }
    set { self[ParentScreenKey.self] = newValue }
  }

  /// The `Screen` the view is embedded in
  var currentScreen: AnyScreen {
    get { self[CurrentScreenKey.self] }
    set { self[CurrentScreenKey.self] = newValue }
  }
}
