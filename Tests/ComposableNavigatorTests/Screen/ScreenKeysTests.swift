import ComposableNavigator
import SwiftUI
import XCTest

final class ScreenKeysTests: XCTestCase {
  func test_parentScreenID_get_set() {
    let expectedScreenID = ScreenID()
    var environment = EnvironmentValues()

    XCTAssertNil(environment.parentScreenID)
    environment.parentScreenID = expectedScreenID
    XCTAssertEqual(environment.parentScreenID, expectedScreenID)
  }

  func test_currentScreenID_get_set() {
    let expectedScreenID = ScreenID()
    var environment = EnvironmentValues()

    XCTAssertNotEqual(environment.currentScreenID, .root)
    environment.currentScreenID = expectedScreenID
    XCTAssertEqual(environment.currentScreenID, expectedScreenID)
  }

  func test_parentScreen_get_set() {
    let expectedScreen = TestScreen(identifier: "0", presentationStyle: .push).eraseToAnyScreen()
    var environment = EnvironmentValues()

    XCTAssertNil(environment.parentScreen)
    environment.parentScreen = expectedScreen
    XCTAssertEqual(environment.parentScreen, expectedScreen)
  }

  func test_currentScreen_get_set() {
    let expectedScreen = TestScreen(identifier: "0", presentationStyle: .push).eraseToAnyScreen()
    var environment = EnvironmentValues()

    XCTAssertNotEqual(environment.currentScreen, expectedScreen)
    environment.currentScreen = expectedScreen
    XCTAssertEqual(environment.currentScreen, expectedScreen)
  }
}
