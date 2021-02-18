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

  lazy var path = [
    testScreen(with: "0")
  ]

  let expectedView = TestView(id: 0)

  let testBuilder = _PathBuilder<TestView>(
    buildPath: { path in
      guard !path.isEmpty else {
        return nil
      }

      return TestView(id: 0)
    }
  )

  func test_onDismiss_calls_perform_with_any_screen_when_path_changes() {
    let path = [
      testScreen(with: "0")
    ]
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

    var builtView = sut.build(path: path)
    XCTAssertFalse(dismissCalled)
    XCTAssertEqual(expectedView, builtView)

    builtView = sut.build(path: [])

    XCTAssertTrue(dismissCalled)
    XCTAssertNil(builtView)
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

    var builtView = sut.build(path: path)
    XCTAssertFalse(dismissCalled)
    XCTAssertEqual(expectedView, builtView)

    builtView = sut.build(path: [])

    XCTAssertTrue(dismissCalled)
    XCTAssertNil(builtView)
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

    var builtView = sut.build(path: path)
    XCTAssertFalse(dismissCalled)
    XCTAssertEqual(expectedView, builtView)

    builtView = sut.build(path: [])

    XCTAssertTrue(dismissCalled)
    XCTAssertNil(builtView)
  }
}
