@testable import ComposableNavigator
import SnapshotTesting
import SwiftUI
import XCTest

final class RootTests: XCTestCase {
  func test_root_wraps_content_in_navigation_view() {
    let expectedPath = [
      IdentifiedScreen(
        id: .root,
        content: TestScreen(identifier: "0", presentationStyle: .push),
        hasAppeared: false
      )
    ]

    var onAppearCalled = false

    let root = Root(
      dataSource: Navigator.Datasource(
        path: expectedPath
      ),
      pathBuilder: _PathBuilder(
        buildPath: { path in
          Text("A")
            .navigationBarTitle("Navbar title")
            .onAppear {
              XCTAssertEqual(expectedPath, path)
              onAppearCalled = true
            }
        }
      )
    )

    assertSnapshot(matching: root, as: .image(layout: .device(config: .iPhone8)))
    XCTAssertTrue(onAppearCalled)
  }
}
