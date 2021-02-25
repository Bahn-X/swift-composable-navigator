import ComposableNavigator
import SwiftUI
import XCTest

final class NavigationTree_ConditionalTests: XCTestCase {
  let path = [
    IdentifiedScreen(
      id: .root,
      content: TestScreen(identifier: "", presentationStyle: .push),
      hasAppeared: false
    )
  ]

  // MARK: - If
  func test_if_builds_then_builder_if_condition_is_true() {
    var thenBuilderInvocations = [[IdentifiedScreen]]()

    let path = [
      IdentifiedScreen(
        id: .root,
        content: TestScreen(identifier: "", presentationStyle: .push),
        hasAppeared: false
      )
    ]

    let expectedThenBuilderInvocations = [
      path
    ]

    let sut = EmptyNavigationTree()
      .If { true }
        then: {
          _PathBuilder(
            buildPath: { path -> EmptyView? in
              thenBuilderInvocations.append(path)
              return nil
            }
          )
        }

    XCTAssertNil(sut.build(path: path))
    XCTAssertEqual(expectedThenBuilderInvocations, thenBuilderInvocations)
  }

  func test_ifElse_builds_then_builder_if_condition_is_true() {
    var thenBuilderInvocations = [[IdentifiedScreen]]()
    var elseBuilderInvocations = [[IdentifiedScreen]]()

    let expectedThenBuilderInvocations = [
      path
    ]

    let expectedElseBuilderInvocations = [
      [IdentifiedScreen]()
    ]

    let sut = EmptyNavigationTree()
      .If { true }
        then: {
          _PathBuilder(
            buildPath: { path -> EmptyView? in
              thenBuilderInvocations.append(path)
              return nil
            }
          )

        }
        else: {
          _PathBuilder(
            buildPath: { path -> EmptyView? in
              elseBuilderInvocations.append(path)
              return nil
            }
          )
        }

    XCTAssertNil(sut.build(path: path))
    XCTAssertEqual(expectedThenBuilderInvocations, thenBuilderInvocations)
    XCTAssertEqual(expectedElseBuilderInvocations, elseBuilderInvocations)
  }

  func test_ifElse_builds_else_builder_if_condition_is_false() {
    var thenBuilderInvocations = [[IdentifiedScreen]]()
    var elseBuilderInvocations = [[IdentifiedScreen]]()

    let expectedThenBuilderInvocations = [
      [IdentifiedScreen]()
    ]

    let expectedElseBuilderInvocations = [
      path
    ]

    let sut = EmptyNavigationTree().If { false }
      then: {
        _PathBuilder(
          buildPath: { path -> EmptyView? in
            thenBuilderInvocations.append(path)
            return nil
          }
        )
      }
      else: {
        _PathBuilder(
          buildPath: { path -> EmptyView? in
            elseBuilderInvocations.append(path)
            return nil
          }
        )
      }

    XCTAssertNil(sut.build(path: path))
    XCTAssertEqual(expectedThenBuilderInvocations, thenBuilderInvocations)
    XCTAssertEqual(expectedElseBuilderInvocations, elseBuilderInvocations)
  }

  // MARK: - ifLet
  func test_ifLet_without_elseBuilder_builds_thenBuilder_ifLetContent_not_nil() {
    let letContent = 1
    var thenBuilderInvocations = [[IdentifiedScreen]]()
    let expectedThenBuilderInvocations = [
      path
    ]

    var unwrappedContents = [Int]()
    let expectedUnwrappedContents = [1]

    let sut = EmptyNavigationTree()
      .IfLet { letContent }
        then: { unwrapped -> _PathBuilder<EmptyView> in
          unwrappedContents.append(unwrapped)

          return _PathBuilder(
            buildPath: { path -> EmptyView? in
              thenBuilderInvocations.append(path)
              return EmptyView()
            }
          )
        }

    XCTAssertNotNil(sut.build(path: path))
    XCTAssertEqual(expectedThenBuilderInvocations, thenBuilderInvocations)
    XCTAssertEqual(expectedUnwrappedContents, unwrappedContents)
  }

  func test_ifLet_builds_thenBuilder_ifLetContent_not_nil() {
    let letContent = 1
    var thenBuilderInvocations = [[IdentifiedScreen]]()
    var elseBuilderInvocations = [[IdentifiedScreen]]()

    let expectedThenBuilderInvocations = [
      path
    ]

    let expectedElseBuilderInvocations = [
      [IdentifiedScreen]()
    ]

    var unwrappedContents = [Int]()
    let expectedUnwrappedContents = [1]

    let sut = EmptyNavigationTree()
      .IfLet { letContent }
        then: { unwrapped -> _PathBuilder<EmptyView> in
          unwrappedContents.append(unwrapped)

          return _PathBuilder(
            buildPath: { path -> EmptyView? in
              thenBuilderInvocations.append(path)
              return EmptyView()
            }
          )
        }
        else: {
          _PathBuilder(
            buildPath: { path -> EmptyView? in
              elseBuilderInvocations.append(path)
              return nil
            }
          )
        }

    XCTAssertNotNil(sut.build(path: path))
    XCTAssertEqual(expectedThenBuilderInvocations, thenBuilderInvocations)
    XCTAssertEqual(expectedElseBuilderInvocations, elseBuilderInvocations)
    XCTAssertEqual(expectedUnwrappedContents, unwrappedContents)
  }

  func test_ifLet_builds_elseBuilder_ifLetContent_is_nil() {
    var thenBuilderInvocations = [[IdentifiedScreen]]()
    var elseBuilderInvocations = [[IdentifiedScreen]]()

    let expectedThenBuilderInvocations = [[IdentifiedScreen]]()

    let expectedElseBuilderInvocations = [path]

    var unwrappedContents = [Int]()
    let expectedUnwrappedContents = [Int]()

    let sut = EmptyNavigationTree()
      .IfLet { Optional<Int>.none }
        then: { unwrapped -> _PathBuilder<EmptyView> in
          unwrappedContents.append(unwrapped)

          return _PathBuilder(
            buildPath: { path -> EmptyView? in
              thenBuilderInvocations.append(path)
              return nil
            }
          )
        }
        else: {
          _PathBuilder(
            buildPath: { path -> EmptyView? in
              elseBuilderInvocations.append(path)
              return EmptyView()
            }
          )
        }

    XCTAssertNotNil(sut.build(path: path))
    XCTAssertEqual(expectedThenBuilderInvocations, thenBuilderInvocations)
    XCTAssertEqual(expectedElseBuilderInvocations, elseBuilderInvocations)
    XCTAssertEqual(expectedUnwrappedContents, unwrappedContents)
  }

  // MARK: - ifScreen
  func test_ifScreen_builds_path_if_screen_matches() {
    let screen = TestScreen(identifier: "", presentationStyle: .push).eraseToAnyScreen()

    var builtScreens = [AnyScreen]()
    var builtPaths = [[IdentifiedScreen]]()

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

    let path = [
      IdentifiedScreen(id: .root, content: NonMatching(), hasAppeared: false)
    ]

    var builtScreens = [AnyScreen]()
    var builtPaths = [[IdentifiedScreen]]()

    let expectedScreens = [AnyScreen]()
    let expectedPaths = [[IdentifiedScreen]]()

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

    let path = [
      IdentifiedScreen(id: .root, content: NonMatching(), hasAppeared: false)
    ]

    var builtScreens = [AnyScreen]()
    var builtPaths = [[IdentifiedScreen]]()
    var builtElsePaths = [[IdentifiedScreen]]()

    let expectedScreens = [AnyScreen]()
    let expectedPaths = [[IdentifiedScreen]]()
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
