import ComposableNavigator
import SwiftUI
import XCTest

final class PathBuilder_BeforeBuildTests: XCTestCase {
  func test_executes_perform_closure_before_build() {
    let pathBuilder = _PathBuilder(buildPath: { _ -> EmptyView? in nil })
    var performClosureCalled = false


    let sut = pathBuilder.beforeBuild {
      performClosureCalled = true
    }

    XCTAssertNil(sut.build(path: .empty))
    XCTAssertTrue(performClosureCalled)
  }
}
