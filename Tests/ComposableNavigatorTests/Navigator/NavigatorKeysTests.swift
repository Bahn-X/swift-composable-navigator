import ComposableNavigator
import SwiftUI
import XCTest

final class NavigatorKeysTests: XCTestCase {
  func test_navigator_get_set_from_environment() {
    var newNavigatorCalled = false
    let newNavigator = Navigator.mock(
      dismiss: { _ in newNavigatorCalled = true }
    )

    var environment = EnvironmentValues()
    XCTAssertNoThrow(environment.navigator)
    environment.navigator = newNavigator
    let sut = environment.navigator
    sut.dismiss(id: ScreenID())
    XCTAssertTrue(newNavigatorCalled)
  }

  func test_treatSheetDismissAsAppearInPresenter_get_set_from_environment() {
    var environment = EnvironmentValues()
    XCTAssertFalse(environment.treatSheetDismissAsAppearInPresenter)
    environment.treatSheetDismissAsAppearInPresenter = true
    XCTAssertTrue(environment.treatSheetDismissAsAppearInPresenter)
  }
}
