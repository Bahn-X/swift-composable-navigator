import XCTest

extension XCUIElement {
  func await(_ timeout: TimeInterval = 6.0) -> XCUIElement {
    _ = exists(after: timeout, pollInterval: 0.2)
    return self
  }
  
  func exists(after timeout: TimeInterval, pollInterval: TimeInterval) -> Bool {
    var elapsed: TimeInterval = 0
    while elapsed < timeout {
      if waitForExistence(timeout: pollInterval) {
        return true
      }
      
      elapsed += pollInterval
    }
    
    return false
  }
}
