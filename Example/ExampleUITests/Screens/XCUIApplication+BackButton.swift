import XCTest

extension XCUIApplication {
  var backButton: XCUIElement {
    navigationBars.buttons.element(boundBy: 0).await()
  }
}
