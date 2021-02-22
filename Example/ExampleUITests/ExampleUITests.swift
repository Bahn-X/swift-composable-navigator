import Example
import XCTest

class ComposableNavigatorUITests: XCTestCase {
  var app: XCUIApplication!
  
  override func setUp() {
    app = XCUIApplication()
    app.launch()
    continueAfterFailure = false
  }
  
  func test_push() {
    Home(app: app)
      .goToDetail(for: "0")
      .assertVisible()
      .goToBackToHome()
      .assertVisible()
  }

  func test_push_push() {
    Home(app: app)
      .goToDetail(for: "0")
      .assertVisible()
      .goToShortcuts()
      .assertVisible()
      .goToBackToHome()
      .assertVisible()
  }

  func test_push_sheet() {
    Home(app: app)
      .goToDetail(for: "0")
      .assertVisible()
      .goToSettings()
      .assertVisible()
      .goBackToHome()
      .assertVisible()
  }
  
  func test_sheet() {
    Home(app: app)
      .goToSettings()
      .assertVisible()
      .dismissSheet()
      .assertVisible()
  }

  func test_sheet_sheet() {
    Home(app: app)
      .goToSettings()
      .assertVisible()
      .goToShortcutsSheet()
      .assertVisible()
      .goToBackToHome()
      .assertVisible()
  }

  func test_sheet_push() {
    Home(app: app)
      .goToSettings()
      .assertVisible()
      .goToShortcutsPush()
      .assertVisible()
      .goToBackToHome()
      .assertVisible()
  }

  func test_sheet_push_to_push_sheet_sheet() {
    Home(app: app)
      .goToSettings()
      .assertVisible()
      .goToShortcutsPush()
      .assertVisible()
      .goToDetailSettingsShortcutsSheet()
      .assertVisible()
      .goToBackToHome()
      .assertVisible()
  }

  func test_detail_one_settings_to_detail_zero_settings() {
    Home(app: app)
      .goToDetail(for: "1")
      .assertVisible()
      .goToSettings()
      .shortcuts
      .goToDetailZeroSettings()
      .assertVisible()
      .dismissSheet()
      .assertVisible()
      .goToBackToHome()
      .assertVisible()
  }
}
