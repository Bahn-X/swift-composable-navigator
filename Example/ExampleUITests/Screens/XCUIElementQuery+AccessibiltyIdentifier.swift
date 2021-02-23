@testable import Example
import XCTest

extension XCUIElementQuery {
  subscript(identifier: AccessibilityIdentifier) -> XCUIElement {
    return self[identifier.value]
  }
}
