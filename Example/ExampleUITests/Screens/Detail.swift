import XCTest

class Detail: Base {
  let id: String
  lazy var accessibilityIdentifiers = AccessibilityIdentifier.DetailScreen(id: id)

  lazy var shortcutsButton = app
    .buttons[accessibilityIdentifiers.shortcuts]
    .await()

  lazy var settingsButton = app
    .buttons[accessibilityIdentifiers.settings]
    .await()

  var shortcuts: NavigationShortcuts {
    NavigationShortcuts(accessibilityPrefix: "detail.\(id)", app: app)
  }

  init(app: XCUIApplication, id: String) {
    self.id = id
    super.init(app: app)
  }

  @discardableResult
  func assertVisible() -> Self {
    XCTAssertTrue(shortcutsButton.exists)
    return self
  }

  @discardableResult
  func goToShortcuts() -> NavigationShortcuts {
    shortcutsButton.tap()

    return NavigationShortcuts(
      accessibilityPrefix: "shortcuts",
      app: app
    )
  }

  @discardableResult
  func goToSettings() -> Settings<Detail> {
    settingsButton.tap()
    
    return Settings(
      predecessor: self,
      prefix: "detail.\(id)",
      app: app
    )
  }

  @discardableResult
  func goToBackToHome() -> Home {
    return pop(to: Home(app: app))
  }
}
