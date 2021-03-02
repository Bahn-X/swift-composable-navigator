import SwiftUI

/// EnvironmentKey identifying the `Navigator` allowing navigation path mutations
public enum NavigatorKey: EnvironmentKey {
  public static let defaultValue: Navigator = .stub
}

/// EnvironmentKey used to pass down treatSheetDismissAsAppearInPresenter down the view hierarchy
public enum TreatSheetDismissAsAppearInPresenterKey: EnvironmentKey {
  public static let defaultValue: Bool = false
}

public extension EnvironmentValues {
  /// The `Navigator` allowing navigation path mutations
  ///
  ///  Can be used to directly navigate from a Vanilla SwiftUI.
  ///
  /// ```swift
  /// struct RootView: View {
  ///   @Environment(\.navigator) var navigator: Navigator
  ///   @Environment(\.currentScreenID) var screenID: ScreenID
  ///
  ///   var body: some View {
  ///    Button(
  ///      action: { navigator.go(to: DetailScreen(), on: screenID) },
  ///      label: Text("Go to DetailScreen")
  ///   }
  /// }
  /// ```
  var navigator: Navigator {
    get { self[NavigatorKey.self] }
    set { self[NavigatorKey.self] = newValue }
  }

  /// `viewAppeared(animated:)` is not called in SwiftUI and UIKit when a ViewController dismisses a sheet. This environment value allows you to override this behaviour.
  ///
  /// Use `.environment(\.treatSheetDismissAsAppearInPresenter, true)` on your Root view to get onAppear events for sheet dismissals.
  ///
  /// **Example**
  /// ```swift
  ///  Root(
  ///    dataSource: dataSource,
  ///    pathBuilder: pathBuilder
  ///  )
  ///  .environment(\.treatSheetDismissAsAppearInPresenter, true)
  ///  ```
  var treatSheetDismissAsAppearInPresenter: Bool {
    get { self[TreatSheetDismissAsAppearInPresenterKey.self] }
    set { self[TreatSheetDismissAsAppearInPresenterKey.self] = newValue }
  }
}
