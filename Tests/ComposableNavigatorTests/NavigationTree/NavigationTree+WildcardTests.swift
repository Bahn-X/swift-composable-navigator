import ComposableNavigator
import SwiftUI
import XCTest

final class NavigationTree_WildcardTest: XCTestCase {
  let testScreen = TestScreen(identifier: "0", presentationStyle: .push)

  lazy var identifiedTestScreen = IdentifiedScreen(
    id: .root,
    content: testScreen,
    hasAppeared: false
  )

  func test_emptyPath_calls_through_to_underlying_pathbuilder_with_empty_path() {
    var underlyingPathBuilderCalled = false

    let sut = EmptyNavigationTree().Wildcard(
      screen: testScreen,
      pathBuilder: _PathBuilder(
        buildPath: { path -> EmptyView? in
          underlyingPathBuilderCalled = path.isEmpty
          return nil
        }
      )
    )

    XCTAssertNil(sut.build(path: []))
    XCTAssertTrue(underlyingPathBuilderCalled)
  }

  func test_buildsWildcardView_for_non_matching_screen() {
    struct NonMatching: Screen {
      let presentationStyle: ScreenPresentationStyle = .push
    }

    let sut = EmptyNavigationTree().Wildcard(
      screen: testScreen,
      pathBuilder: _PathBuilder(
        buildPath: { path -> EmptyView? in
          XCTAssertEqual([self.identifiedTestScreen], path)
          return EmptyView()
        }
      )
    )

    let builtScreen = sut.build(
      path: [
        IdentifiedScreen(
          id: .root,
          content: NonMatching(),
          hasAppeared: false
        )
      ]
    )

    XCTAssertNotNil(builtScreen)
  }

  func test_buildsWildcardView_for_matching_screen() {
    let sut = EmptyNavigationTree().Wildcard(
      screen: testScreen,
      pathBuilder: _PathBuilder(
        buildPath: { path -> EmptyView? in
          XCTAssertEqual([self.identifiedTestScreen], path)
          return EmptyView()
        }
      )
    )

    let builtScreen = sut.build(
      path: [identifiedTestScreen]
    )

    XCTAssertNotNil(builtScreen)
  }
}
