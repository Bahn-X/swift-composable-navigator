import ComposableNavigator
import XCTest

final class NavigationTree_EmptyTests: XCTestCase {
  func test_build_returns_nil() {
    let path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: TestScreen(identifier: "0", presentationStyle: .push),
        hasAppeared: false
      )
    )

    struct TestNavigationTree: NavigationTree {
        var builder: some PathBuilder {
            Empty()
        }
    }
    
    let sut = TestNavigationTree()

    XCTAssertNil(sut.build(path: path))
  }
}
