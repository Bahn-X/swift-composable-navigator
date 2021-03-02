import ComposableNavigator
import SwiftUI
import XCTest

final class NavigationTree_ConditionalTests: XCTestCase {
  let path = PathComponentUpdate(
    previous: nil,
    current: IdentifiedScreen(
      id: .root,
      content: TestScreen(identifier: "", presentationStyle: .push),
      hasAppeared: false
    )
  )

  // MARK: - ifScreen
  func test_ifScreen_builds_path_if_screen_matches() {
    let screen = TestScreen(identifier: "", presentationStyle: .push).eraseToAnyScreen()

    var builtScreens = [AnyScreen]()
    var builtPaths = [PathComponentUpdate]()

    let expectedScreens = [
      screen.eraseToAnyScreen()
    ]

    let expectedPaths = [
      path
    ]

    let sut = EmptyNavigationTree()
      .If { (screen: TestScreen) in
        _PathBuilder(
          buildPath: { path -> EmptyView? in
            builtScreens.append(screen.eraseToAnyScreen())
            builtPaths.append(path)
            return EmptyView()
          }
        )
      }

    XCTAssertNotNil(sut.build(path: path))
    XCTAssertEqual(expectedPaths, builtPaths)
    XCTAssertEqual(expectedScreens, builtScreens)
  }

  func test_ifScreen_does_not_build_path_if_screen_does_not_match() {
    struct NonMatching: Screen {
      let presentationStyle: ScreenPresentationStyle = .push
    }

    let path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(id: .root, content: NonMatching(), hasAppeared: false)
    )

    var builtScreens = [AnyScreen]()
    var builtPaths = [PathComponentUpdate]()

    let expectedScreens = [AnyScreen]()
    let expectedPaths = [PathComponentUpdate]()

    let sut = EmptyNavigationTree()
      .If { (screen: TestScreen) in
        _PathBuilder(
          buildPath: { path -> EmptyView? in
            builtScreens.append(screen.eraseToAnyScreen())
            builtPaths.append(path)
            return EmptyView()
          }
        )
      }

    XCTAssertNil(sut.build(path: path))
    XCTAssertEqual(expectedPaths, builtPaths)
    XCTAssertEqual(expectedScreens, builtScreens)
  }

  func test_ifScreen_builds_else_builder_if_screen_does_not_match() {
    struct NonMatching: Screen {
      let presentationStyle: ScreenPresentationStyle = .push
    }

    let path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(id: .root, content: NonMatching(), hasAppeared: false)
    )

    var builtScreens = [AnyScreen]()
    var builtPaths = [PathComponentUpdate]()
    var builtElsePaths = [PathComponentUpdate]()

    let expectedScreens = [AnyScreen]()
    let expectedPaths = [PathComponentUpdate]()
    let expectedElsePaths = [path]

    let sut = EmptyNavigationTree()
      .If { (screen: TestScreen) in
        return _PathBuilder(
          buildPath: { path -> EmptyView? in
            builtScreens.append(screen.eraseToAnyScreen())
            builtPaths.append(path)
            return nil
          }
        )
      }
      else: {
        _PathBuilder(
          buildPath: { path -> EmptyView? in
            builtElsePaths.append(path)
            return EmptyView()
          }
        )
      }

    XCTAssertNotNil(sut.build(path: path))
    XCTAssertEqual(expectedPaths, builtPaths)
    XCTAssertEqual(expectedScreens, builtScreens)
    XCTAssertEqual(expectedElsePaths, builtElsePaths)
  }
}
