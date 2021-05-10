import ComposableNavigator
import SwiftUI
import XCTest

final class PathBuilder_BeforeBuildTests: XCTestCase {
  func test_executes_perform_closure_before_build() {
    let pathElement = TestScreen(
        identifier: "",
        presentationStyle: .push
    ).asPathElement()

    let pathBuilder = PathBuilders.empty
    var performClosureCalled = false

    let sut = pathBuilder.beforeBuild {
      performClosureCalled = true
    }

    XCTAssertNil(sut.build(pathElement: pathElement))
    XCTAssertTrue(performClosureCalled)
  }
}
