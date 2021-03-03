@testable import ComposableNavigator
import SnapshotTesting
import SwiftUI
import XCTest

final class PathBuilder_OnDismissTest: XCTestCase {
  let testScreenID = ScreenID()

  struct RootScreen: Screen {
    let presentationStyle: ScreenPresentationStyle = .push
  }

  func testScreen(with id: String) -> IdentifiedScreen {
    IdentifiedScreen(
      id: testScreenID,
      content: TestScreen(identifier: id, presentationStyle: .push),
      hasAppeared: false
    )
  }

  lazy var pathElement = testScreen(with: "0").content

  func dataSource() -> Navigator.Datasource {
    Navigator.Datasource(
      path: [
        IdentifiedScreen(id: .root, content: RootScreen(), hasAppeared: true),
        testScreen(with: "0")
      ]
    )
  }

  let expectedView = TestView(id: 0)

  let testBuilder = _PathBuilder<TestView> { _ in
    TestView(id: 0)
  }

  func test_onDismiss_calls_perform_with_any_screen_when_path_changes() {
    let dataSource = self.dataSource()
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

    let content = sut.build(pathElement: pathElement)?
      .environment(\.parentScreenID, .root)
      .environmentObject(dataSource)
      .frame(width: 20, height: 20)

    // Force view building by asserting snapshots
    assertSnapshot(
      matching: content,
      as: .image
    )

    dataSource.dismiss(id: testScreenID)

    XCTAssertEqual(expectedView, sut.build(pathElement: pathElement)?.content)
    XCTAssertTrue(dismissCalled)
  }

  func test_onDismiss_calls_perform_with_screen_when_path_changes() {
    let dataSource = self.dataSource()
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

    let content = sut.build(pathElement: pathElement)?
      .environment(\.parentScreenID, .root)
      .environmentObject(dataSource)
      .frame(width: 20, height: 20)

    // Force view building by asserting snapshots
    assertSnapshot(
      matching: content,
      as: .image
    )

    dataSource.dismiss(id: testScreenID)

    XCTAssertEqual(expectedView, sut.build(pathElement: pathElement)?.content)
    XCTAssertTrue(dismissCalled)
  }

  func test_onDismiss_of_calls_perform_when_path_changes() {
    let dataSource = self.dataSource()
    var dismissCalled = false

    let sut = testBuilder
      .onDismiss(
        of: TestScreen.self,
        perform: {
          dismissCalled = true
        }
      )

    let content = sut.build(pathElement: pathElement)?
      .environment(\.parentScreenID, .root)
      .environmentObject(dataSource)
      .frame(width: 20, height: 20)

    // Force view building by asserting snapshots
    assertSnapshot(
      matching: content,
      as: .image
    )

    dataSource.dismiss(id: testScreenID)

    XCTAssertEqual(expectedView, sut.build(pathElement: pathElement)?.content)
    XCTAssertTrue(dismissCalled)
  }
}
