import ComposableNavigator
import XCTest

final class PathBuilder_EmptyTests: XCTestCase {
  func test_build_returns_nil() {
    let pathElement = TestScreen(identifier: "0", presentationStyle: .push)
    
    let sut = PathBuilders.empty

    XCTAssertNil(sut.build(pathElement: pathElement))
  }
}
