import XCTest

class Settings<Predecessor: Base>: Base {
  let predecessor: Predecessor
  let prefix: String

  var shortcuts: NavigationShortcuts {
    NavigationShortcuts(accessibilityPrefix: "settings", app: app)
  }

  var accessibilityIdentifiers: AccessibilityIdentifier.SettingsScreen {
    AccessibilityIdentifier.SettingsScreen(prefix: prefix)
  }

  var shortcutsSheetButton: XCUIElement {
    app.buttons[accessibilityIdentifiers.shortcutsSheet].await()
  }

  var shortcutsPushButton: XCUIElement {
    app.buttons[accessibilityIdentifiers.shortcutsPush].await()
  }

  init(predecessor: Predecessor, prefix: String, app: XCUIApplication) {
    self.predecessor = predecessor
    self.prefix = prefix
    super.init(app: app)
  }

  @discardableResult
  func assertVisible() -> Self {
    XCTAssertTrue(shortcutsSheetButton.exists)
    return self
  }

  @discardableResult
  func goToShortcutsPush() -> NavigationShortcuts {
    shortcutsPushButton.tap()
    return NavigationShortcuts(accessibilityPrefix: "shortcuts", app: app)
  }

  @discardableResult
  func goToShortcutsSheet() -> NavigationShortcuts {
    shortcutsSheetButton.tap()
    return NavigationShortcuts(accessibilityPrefix: "shortcuts", app: app)
  }

  @discardableResult
  func dismissSheet() -> Predecessor {
    app.swipeDown(velocity: .fast)
    return predecessor
  }

  @discardableResult
  func goBackToHome() -> Home {
    shortcuts.goToBackToHome()
  }
}
