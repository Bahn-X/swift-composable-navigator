import XCTest

class Base {
  let app: XCUIApplication
  
  init(app: XCUIApplication) {
    self.app = app
  }
  
  func pop<Predecessor: Base>(to predecessor: Predecessor) -> Predecessor {
    app.backButton.tap()
    return predecessor
  }
}
