import ComposableNavigator
import SwiftUI
import XCTest

final class PathBuilder_EraseCircularPathTests: XCTestCase {
  struct CircularNavigationTree: NavigationTree {
    var builder: some PathBuilder {
      Screen(
        TestScreen.self,
        content: { EmptyView() },
        nesting: { CircularNavigationTree().eraseCircularNavigationPath() }
      )
    }
  }

  func test_if_wrapped_builds_path_erases_to_AnyView() {
    let sut = CircularNavigationTree().eraseCircularNavigationPath()

    let built = sut.build(
      pathElement: TestScreen(
        identifier: "",
        presentationStyle: .push
      ).asPathElement()
    )

    XCTAssertNotNil(built)
  }

  func test_if_wrapped_does_not_build_path_returns_nil() {
    let sut = _PathBuilder<Never> { _ in nil }
      .eraseCircularNavigationPath()

    let built = sut.build(
      pathElement: TestScreen(
        identifier: "",
        presentationStyle: .push
      ).asPathElement()
    )

    XCTAssertNil(built)
  }
}
