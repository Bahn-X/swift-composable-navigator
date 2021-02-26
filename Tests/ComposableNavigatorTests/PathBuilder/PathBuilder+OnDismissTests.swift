import ComposableNavigator
import SwiftUI
import XCTest

final class PathBuilder_OnDismissTest: XCTestCase {
  func testScreen(with id: String) -> IdentifiedScreen {
    IdentifiedScreen(
      id: .root,
      content: TestScreen(identifier: id, presentationStyle: .push),
      hasAppeared: false
    )
  }

  lazy var path = PathComponentUpdate(
      previous: testScreen(with: "0"),
      current: nil
  )

  let expectedView = TestView(id: 0)

  let testBuilder = _PathBuilder<TestView>(
    buildPath: { _ in
      TestView(id: 0)
    }
  )

  func test_onDismiss_calls_perform_with_any_screen_when_path_changes() {

    var dismissCalled = false

    let sut = testBuilder
      .onDismiss(
        perform: { (screen) in
          dismissCalled = true
          XCTAssertEqual(
            screen,
            self.testScreen(with: "0").content
          )
        }
      )

    XCTAssertEqual(expectedView, sut.build(path: path))
    XCTAssertTrue(dismissCalled)
  }

  func test_onDismiss_calls_perform_with_screen_when_path_changes() {
    var dismissCalled = false

    let sut = testBuilder
      .onDismiss(
        perform: { (screen: TestScreen) in
          dismissCalled = true
          XCTAssertEqual(
            screen,
            self.testScreen(with: "0").content.unwrap()
          )
        }
      )

    XCTAssertEqual(expectedView, sut.build(path: path))
    XCTAssertTrue(dismissCalled)
  }

  func test_onDismiss_of_calls_perform_when_path_changes() {
    var dismissCalled = false

    let sut = testBuilder
      .onDismiss(
        of: TestScreen.self,
        perform: {
          dismissCalled = true
        }
      )

    XCTAssertEqual(expectedView, sut.build(path: path))
    XCTAssertTrue(dismissCalled)
  }
}
