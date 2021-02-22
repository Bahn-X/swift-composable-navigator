import XCTest

class NavigationShortcuts: Base {
  let accessibilityPrefix: String

  var accessibilityIdentifiers: AccessibilityIdentifier.NavigationShortcuts {
    AccessibilityIdentifier.NavigationShortcuts(prefix: accessibilityPrefix)
  }

  lazy var detailZeroSettingsButton = app
    .buttons[accessibilityIdentifiers.detailSettings]
    .await()

  lazy var detailSettingsShortcutsPush =  app
    .buttons[accessibilityIdentifiers.detailSettingsShortcutsPush]
    .await()

  lazy var detailSettingsShortcutsSheet =  app
    .buttons[accessibilityIdentifiers.detailSettingsShortcutsSheet]
    .await()

  lazy var backToHome = app
    .buttons[accessibilityIdentifiers.home]
    .await()

  init(accessibilityPrefix: String, app: XCUIApplication) {
    self.accessibilityPrefix = accessibilityPrefix
    super.init(app: app)
  }

  @discardableResult
  func assertVisible() -> Self {
    XCTAssertTrue(backToHome.exists)
    return self
  }

  @discardableResult
  func goToDetailZeroSettings() -> Settings<Detail> {
    detailZeroSettingsButton.tap()
    return Settings(
      predecessor: Detail(app: app, id: "0"),
      prefix: "detail.0",
      app: app
    )
  }

  @discardableResult
  func goToDetailSettingsShortcutsPush() -> NavigationShortcuts {
    detailSettingsShortcutsPush.tap()
    return NavigationShortcuts(accessibilityPrefix: "shortcuts", app: app)
  }

  @discardableResult
  func goToDetailSettingsShortcutsSheet() -> NavigationShortcuts {
    detailSettingsShortcutsSheet.tap()
    return NavigationShortcuts(accessibilityPrefix: "shortcuts", app: app)
  }

  func goToBackToHome() -> Home {
    backToHome.tap()
    return Home(app: app)
  }
}
