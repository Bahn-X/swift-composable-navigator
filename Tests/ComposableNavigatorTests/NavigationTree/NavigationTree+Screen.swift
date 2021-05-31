@testable import ComposableNavigator
import SwiftUI
import XCTest

final class NavigationTree_ScreenTests: XCTestCase {
  let testScreen = TestScreen(identifier: "", presentationStyle: .push)

  // MARK: - (Screen) -> View
  func test_closure_based_non_matching_screen_does_not_build_path() {
    struct NonMatching: Screen {
      let presentationStyle: ScreenPresentationStyle = .push
    }

    var nestingPathBuilderInvocations = [ActiveNavigationTreeElement]()

    let pathElement = NonMatching().asPathElement()

    let expectedNestingPathBuilderInvocations = [ActiveNavigationTreeElement]()
    
    let sut = EmptyNavigationTree().Screen(
      content: { (screen: TestScreen) in EmptyView() },
      nesting: {
        _PathBuilder { pathElement -> EmptyView? in
          nestingPathBuilderInvocations.append(pathElement)
          return EmptyView()
        }
      }
    )

    XCTAssertNil(sut.build(pathElement: pathElement))
    XCTAssertEqual(expectedNestingPathBuilderInvocations, nestingPathBuilderInvocations)
  }

  func test_closure_based_matching_screen_buildsPath() {
    let pathElement = TestScreen(identifier: "0", presentationStyle: .push).asPathElement()

    let sut = EmptyNavigationTree().Screen(
      content: { (screen: TestScreen) in EmptyView() }
    )

    XCTAssertNotNil(sut.build(pathElement: pathElement))
  }

  func test_closure_based_onAppear_in_built_view_calls_passed_action() {
    let pathElement = TestScreen(identifier: "0", presentationStyle: .push).asPathElement()

    var onAppearInvocations = [Bool]()
    let expectedOnAppearInvocations = [
      true,
      false
    ]

    let sut = EmptyNavigationTree().Screen(
      onAppear: { initialAppear in
        onAppearInvocations.append(initialAppear)
      },
      content: { (screen: TestScreen) in EmptyView() }
    )

    let builtView = sut.build(pathElement: pathElement)
    builtView?.onAppear(true)
    builtView?.onAppear(false)

    XCTAssertEqual(expectedOnAppearInvocations, onAppearInvocations)
  }

  func test_closure_based_next_in_built_view_calls_nesting_path_builder() {
    let pathElement = TestScreen(identifier: "0", presentationStyle: .push).asPathElement()

    var nextInvocations = [ActiveNavigationTreeElement]()
    let expectedNextInvocations = [
      pathElement
    ]

    let sut = EmptyNavigationTree().Screen(
      content: { (screen: TestScreen) in EmptyView() },
      nesting: {
        _PathBuilder { path -> EmptyView? in
          nextInvocations.append(path)
          return nil
        }
      }
    )

    let builtView = sut.build(pathElement: pathElement)
    _ = builtView?.buildSuccessor(pathElement)

    XCTAssertEqual(expectedNextInvocations, nextInvocations)
  }

  // MARK: - Screen.Type, () -> View
  func test_type_based_non_matching_screen_does_not_build_path() {
    struct NonMatching: Screen {
      let presentationStyle: ScreenPresentationStyle = .push
    }

    var nestingPathBuilderInvocations = [ActiveNavigationTreeElement]()

    let pathElement = NonMatching().asPathElement()

    let expectedNestingPathBuilderInvocations = [ActiveNavigationTreeElement]()

    let sut = EmptyNavigationTree().Screen(
      TestScreen.self,
      content: { EmptyView() },
      nesting: {
        _PathBuilder { path -> EmptyView? in
          nestingPathBuilderInvocations.append(path)
          return EmptyView()
        }
      }
    )

    XCTAssertNil(sut.build(pathElement: pathElement))
    XCTAssertEqual(expectedNestingPathBuilderInvocations, nestingPathBuilderInvocations)
  }

  func test_type_based_matching_screen_buildsPath() {
    let pathElement = TestScreen(identifier: "0", presentationStyle: .push).asPathElement()

    let sut = EmptyNavigationTree().Screen(
      TestScreen.self,
      content: { EmptyView() }
    )

    let builtView = sut.build(pathElement: pathElement)

    XCTAssertNotNil(builtView)
  }

  func test_type_based_onAppear_in_built_view_calls_passed_action() {
    let pathElement = TestScreen(identifier: "0", presentationStyle: .push).asPathElement()

    var onAppearInvocations = [Bool]()
    let expectedOnAppearInvocations = [
      true,
      false
    ]

    let sut = EmptyNavigationTree().Screen(
      TestScreen.self,
      onAppear: { initialAppear in
        onAppearInvocations.append(initialAppear)
      },
      content: { EmptyView() }
    )

    let builtView = sut.build(pathElement: pathElement)
    builtView?.onAppear(true)
    builtView?.onAppear(false)

    XCTAssertEqual(expectedOnAppearInvocations, onAppearInvocations)
  }

  func test_type_based_next_in_built_view_calls_nesting_path_builder() {
    let pathElement = TestScreen(identifier: "0", presentationStyle: .push).asPathElement()

    var nextInvocations = [ActiveNavigationTreeElement]()
    let expectedNextInvocations = [
      pathElement
    ]

    let sut = EmptyNavigationTree().Screen(
      TestScreen.self,
      content: { EmptyView() },
      nesting: {
        _PathBuilder { pathElement -> EmptyView? in
          nextInvocations.append(pathElement)
          return nil
        }
      }
    )

    let builtView = sut.build(pathElement: pathElement)
    _ = builtView?.buildSuccessor(pathElement)

    XCTAssertEqual(expectedNextInvocations, nextInvocations)
  }
}
