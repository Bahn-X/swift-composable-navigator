import ComposableNavigator
import XCTest

final class PathBuilder_EmptyTests: XCTestCase {
  func test_build_returns_nil() {
    let path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: TestScreen(identifier: "0", presentationStyle: .push),
        hasAppeared: false
      )
    )

    let sut = PathBuilders.empty

    XCTAssertNil(sut.build(path: path))
  }
}
