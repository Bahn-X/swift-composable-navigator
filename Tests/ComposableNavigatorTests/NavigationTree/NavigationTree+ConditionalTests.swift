import ComposableNavigator
import SwiftUI
import XCTest

final class NavigationTree_ConditionalTests: XCTestCase {
  struct NonMatching: Screen {
    let presentationStyle: ScreenPresentationStyle = .push
  }

  let pathElement = TestScreen(identifier: "", presentationStyle: .push).asPathElement()

  // MARK: - ifScreen
  func test_ifScreen_builds_path_if_screen_matches() {
    var builtScreens = [AnyScreen]()
    var builtPaths = [ActiveNavigationTreeElement]()

    let expectedScreens = [
      pathElement.content
    ]

    let expectedPaths = [
      pathElement
    ]

    let sut = EmptyNavigationTree()
      .If { (screen: TestScreen) in
        _PathBuilder { pathElement -> EmptyView? in
          builtScreens.append(screen.eraseToAnyScreen())
          builtPaths.append(pathElement)
          return EmptyView()
        }
      }

    XCTAssertNotNil(sut.build(pathElement: pathElement))
    XCTAssertEqual(expectedPaths, builtPaths)
    XCTAssertEqual(expectedScreens, builtScreens)
  }

  func test_ifScreen_does_not_build_path_if_screen_does_not_match() {
    struct NonMatching: Screen {
      let presentationStyle: ScreenPresentationStyle = .push
    }

    var builtScreens = [AnyScreen]()
    var builtPaths = [ActiveNavigationTreeElement]()

    let expectedScreens = [AnyScreen]()
    let expectedPaths = [ActiveNavigationTreeElement]()

    let sut = EmptyNavigationTree()
      .If { (screen: TestScreen) in
        _PathBuilder { pathElement -> EmptyView? in
          builtScreens.append(screen.eraseToAnyScreen())
          builtPaths.append(pathElement)
          return EmptyView()
        }
      }

    XCTAssertNil(sut.build(pathElement: NonMatching().asPathElement()))
    XCTAssertEqual(expectedPaths, builtPaths)
    XCTAssertEqual(expectedScreens, builtScreens)
  }

  func test_ifScreen_builds_else_builder_if_screen_does_not_match() {
    var builtScreens = [AnyScreen]()
    var builtPaths = [ActiveNavigationTreeElement]()
    var builtElsePaths = [ActiveNavigationTreeElement]()

    let expectedScreens = [AnyScreen]()
    let expectedPaths = [ActiveNavigationTreeElement]()
    let expectedElsePaths = [NonMatching().asPathElement()]

    let sut = EmptyNavigationTree()
      .If { (screen: TestScreen) in
        return _PathBuilder { pathElement -> EmptyView? in
          builtScreens.append(screen.eraseToAnyScreen())
          builtPaths.append(pathElement)
          return nil
        }
      }
      else: {
        _PathBuilder { pathElement -> EmptyView? in
          builtElsePaths.append(pathElement)
          return EmptyView()
        }
      }

    XCTAssertNotNil(sut.build(pathElement: NonMatching().asPathElement()))
    XCTAssertEqual(expectedPaths, builtPaths)
    XCTAssertEqual(expectedScreens, builtScreens)
    XCTAssertEqual(expectedElsePaths, builtElsePaths)
  }
}
