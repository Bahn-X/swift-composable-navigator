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

  func test_buildsWildcardView_for_non_matching_screen() {
    struct NonMatching: Screen {
      let presentationStyle: ScreenPresentationStyle = .push
    }

    let pathUpdate = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: NonMatching(),
        hasAppeared: false
      )
    )

    let sut = EmptyNavigationTree().Wildcard(
      screen: testScreen,
      pathBuilder: _PathBuilder(
        buildPath: { path -> EmptyView? in
          let expected = PathComponentUpdate(
            previous: nil,
            current: IdentifiedScreen(
              id: .root,
              content: self.testScreen,
              hasAppeared: false
            )
          )

          XCTAssertEqual(expected, path)
          return EmptyView()
        }
      )
    )

    let builtScreen = sut.build(
      path: pathUpdate
    )

    XCTAssertNotNil(builtScreen)
  }

  func test_buildsWildcardView_for_matching_screen() {
    let pathUpdate = PathComponentUpdate(
      previous: nil,
      current: identifiedTestScreen
    )

    let sut = EmptyNavigationTree().Wildcard(
      screen: testScreen,
      pathBuilder: _PathBuilder(
        buildPath: { path -> EmptyView? in
          XCTAssertEqual(pathUpdate, path)
          return EmptyView()
        }
      )
    )

    let builtScreen = sut.build(
      path: pathUpdate
    )

    XCTAssertNotNil(builtScreen)
  }
}
