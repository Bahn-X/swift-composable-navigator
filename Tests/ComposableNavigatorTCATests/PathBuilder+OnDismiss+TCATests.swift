import ComposableArchitecture
import ComposableNavigator
import ComposableNavigatorTCA
import SwiftUI
import XCTest

final class PathBuilder_OnDismiss_TCATests: XCTestCase {
  typealias State = Int

  enum Action<S: Screen>: Equatable {
    case anyScreen(AnyScreen)
    case screen(S)
    case action
  }

  struct NonMatching: Screen {
    let presentationStyle: ScreenPresentationStyle = .push
  }
  
  func test_on_dismiss_of_anyScreen_sends_action_into_store() {
    var receivedActions = [Action<TestScreen>]()
    let expectedActions = [
      Action<TestScreen>.anyScreen(TestScreen().eraseToAnyScreen())
    ]

    let firstPath = [
      IdentifiedScreen(id: .root, content: TestScreen(), hasAppeared: false)
    ]

    let secondPath = [
      IdentifiedScreen(id: .root, content: NonMatching(), hasAppeared: false)
    ]

    var builtPaths = [[IdentifiedScreen]]()
    let expectedBuildPaths = [
      firstPath,
      secondPath
    ]

    let reducer = Reducer<State, Action<TestScreen>, Void> { _, action, _ in
      receivedActions.append(action)
      return .none
    }

    let store = Store(
      initialState: 0,
      reducer: reducer,
      environment: ()
    )

    let sut = _PathBuilder(
      buildPath: { path -> EmptyView? in
        builtPaths.append(path)
        return EmptyView()
      }
    ).onDismiss(
      send: { (screen: AnyScreen) in .anyScreen(screen)},
      into: store
    )

    XCTAssertNotNil(sut.build(path: firstPath))
    XCTAssertNotNil(sut.build(path: secondPath))
    XCTAssertEqual(expectedBuildPaths, builtPaths)
    XCTAssertEqual(expectedActions, receivedActions)
  }

  func test_type_based_on_dismiss_of_matching_screen_sends_action_into_store() {
    var receivedActions = [Action<TestScreen>]()
    let expectedActions = [
      Action<TestScreen>.action
    ]

    let firstPath = [
      IdentifiedScreen(id: .root, content: TestScreen(), hasAppeared: false)
    ]

    let secondPath = [
      IdentifiedScreen(id: .root, content: NonMatching(), hasAppeared: false)
    ]

    var builtPaths = [[IdentifiedScreen]]()
    let expectedBuildPaths = [
      firstPath,
      secondPath
    ]

    let reducer = Reducer<State, Action<TestScreen>, Void> { _, action, _ in
      receivedActions.append(action)
      return .none
    }

    let store = Store(
      initialState: 0,
      reducer: reducer,
      environment: ()
    )

    let sut = _PathBuilder(
      buildPath: { path -> EmptyView? in
        builtPaths.append(path)
        return EmptyView()
      }
    ).onDismiss(
      of: TestScreen.self,
      send: .action,
      into: store
    )

    XCTAssertNotNil(sut.build(path: firstPath))
    XCTAssertNotNil(sut.build(path: secondPath))
    XCTAssertEqual(expectedBuildPaths, builtPaths)
    XCTAssertEqual(expectedActions, receivedActions)
  }

  func test_closure_based_on_dismiss_of_matching_screen_sends_action_into_store() {
    var receivedActions = [Action<TestScreen>]()
    let expectedActions = [
      Action<TestScreen>.screen(TestScreen())
    ]

    let firstPath = [
      IdentifiedScreen(id: .root, content: TestScreen(), hasAppeared: false)
    ]

    let secondPath = [
      IdentifiedScreen(id: .root, content: NonMatching(), hasAppeared: false)
    ]

    var builtPaths = [[IdentifiedScreen]]()
    let expectedBuildPaths = [
      firstPath,
      secondPath
    ]

    let reducer = Reducer<State, Action<TestScreen>, Void> { _, action, _ in
      receivedActions.append(action)
      return .none
    }

    let store = Store(
      initialState: 0,
      reducer: reducer,
      environment: ()
    )

    let sut = _PathBuilder(
      buildPath: { path -> EmptyView? in
        builtPaths.append(path)
        return EmptyView()
      }
    ).onDismiss(
      send: { (screen: TestScreen) in Action.screen(screen) },
      into: store
    )

    XCTAssertNotNil(sut.build(path: firstPath))
    XCTAssertNotNil(sut.build(path: secondPath))
    XCTAssertEqual(expectedBuildPaths, builtPaths)
    XCTAssertEqual(expectedActions, receivedActions)
  }
}
