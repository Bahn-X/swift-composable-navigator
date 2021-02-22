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

  lazy var shortscutsSheetButton = app
    .buttons[accessibilityIdentifiers.shortcutsSheet]
    .await()

  lazy var shortscutsPushButton = app
    .buttons[accessibilityIdentifiers.shortcutsPush]
    .await()

  init(predecessor: Predecessor, prefix: String, app: XCUIApplication) {
    self.predecessor = predecessor
    self.prefix = prefix
    super.init(app: app)
  }

  @discardableResult
  func assertVisible() -> Self {
    XCTAssertTrue(shortscutsSheetButton.exists)
    return self
  }

  @discardableResult
  func goToShortcutsPush() -> NavigationShortcuts {
    shortscutsPushButton.tap()
    return NavigationShortcuts(accessibilityPrefix: "shortcuts", app: app)
  }

  @discardableResult
  func goToShortcutsSheet() -> NavigationShortcuts {
    shortscutsSheetButton.tap()
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
