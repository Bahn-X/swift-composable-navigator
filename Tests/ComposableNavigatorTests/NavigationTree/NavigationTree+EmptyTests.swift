import ComposableNavigator
import XCTest

final class NavigationTree_EmptyTests: XCTestCase {
  func test_build_returns_nil() {
    let pathElement = TestScreen(identifier: "0", presentationStyle: .push)
    
    struct TestNavigationTree: NavigationTree {
      var builder: some PathBuilder {
        Empty()
      }
    }
    
    let sut = TestNavigationTree()
    
    XCTAssertNil(sut.build(pathElement: pathElement))
  }
}
