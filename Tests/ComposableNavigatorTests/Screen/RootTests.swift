@testable import ComposableNavigator
import SnapshotTesting
import SwiftUI
import XCTest

final class RootTests: XCTestCase {
  func test_root_wraps_content_in_navigation_view() {
    let rootScreen = TestScreen(identifier: "0", presentationStyle: .push)

    let expectedPath = rootScreen.eraseToAnyScreen()
    var onAppearCalled = false

    let root = Root(
      dataSource: Navigator.Datasource(
        root: rootScreen
      ),
      pathBuilder: _PathBuilder { pathElement in
        Text("A")
          .navigationBarTitle("Navbar title")
          .onAppear {
            XCTAssertEqual(expectedPath, pathElement)
            onAppearCalled = true
          }
      }
    )

    assertSnapshot(matching: root, as: .image(layout: .device(config: .iPhone8)))
    XCTAssertTrue(onAppearCalled)
  }
}
