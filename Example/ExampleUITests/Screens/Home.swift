@testable import Example
import XCTest

class Home: Base {
  var settingsButton: XCUIElement {
    app.buttons[AccessibilityIdentifier.HomeScreen.settingsNavigationBarItem].await()
  }

  func detail(for id: String) -> XCUIElement {
    app.buttons[AccessibilityIdentifier.HomeScreen.detail(for: id)].await()
  }

  func detailSettings(for id: String) -> XCUIElement {
    app.buttons[AccessibilityIdentifier.HomeScreen.detailSettings(for: id)].await()
  }

  @discardableResult
  func assertVisible() -> Self {
    XCTAssertTrue(settingsButton.exists)
    return self
  }

  @discardableResult
  func goToSettings() -> Settings<Home> {
    settingsButton.tap()
    return Settings(predecessor: self, prefix: "home", app: app)
  }

  @discardableResult
  func goToDetail(for id: String) -> Detail {
    detail(for: id).tap()
    return Detail(app: app, id: id)
  }

  @discardableResult
  func goToDetailSettings(for id: String) -> Detail {
    detail(for: id).tap()
    return Detail(app: app, id: id)
  }
}
