import ComposableNavigator
import SwiftUI
import XCTest

final class NavigationTree_WildcardTest: XCTestCase {
  let testScreen = TestScreen(identifier: "0", presentationStyle: .push)

  func test_buildsWildcardView_for_non_matching_screen() {
    struct NonMatching: Screen {
      let presentationStyle: ScreenPresentationStyle = .push
    }

    let pathElement = NonMatching().eraseToAnyScreen()

    let sut = EmptyNavigationTree().Wildcard(
      screen: testScreen,
      pathBuilder: _PathBuilder { path -> EmptyView? in
        let expected = self.testScreen.eraseToAnyScreen()

        XCTAssertEqual(expected, path)
        return EmptyView()
      }
    )

    let builtScreen = sut.build(pathElement: pathElement)

    XCTAssertNotNil(builtScreen)
  }

  func test_buildsWildcardView_for_matching_screen() {
    let sut = EmptyNavigationTree().Wildcard(
      screen: testScreen,
      pathBuilder: _PathBuilder { pathElement -> EmptyView? in
        XCTAssertEqual(self.testScreen.eraseToAnyScreen(), pathElement)
        return EmptyView()
      }
    )

    let builtScreen = sut.build(
      pathElement: testScreen
    )

    XCTAssertNotNil(builtScreen)
  }
}
