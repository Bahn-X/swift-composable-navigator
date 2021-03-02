import ComposableArchitecture
@testable import ComposableNavigator
import ComposableNavigatorTCA
import SnapshotTesting
import SwiftUI
import XCTest

final class PathBuilder_OnDismiss_TCATests: XCTestCase {
  typealias State = Int

  let nextID = ScreenID()

  enum Action<S: Screen>: Equatable {
    case anyScreen(AnyScreen)
    case screen(S)
    case action
  }

  struct NonMatching: Screen {
    let presentationStyle: ScreenPresentationStyle = .push
  }

  func dataSource() -> Navigator.Datasource {
    Navigator.Datasource(
      path: [
        IdentifiedScreen(id: .root, content: TestScreen(), hasAppeared: false),
        IdentifiedScreen(id: nextID, content: TestScreen(), hasAppeared: false)
      ]
    )
  }
  
  func test_on_dismiss_of_anyScreen_sends_action_into_store() {
    let dataSource = self.dataSource()

    var receivedActions = [Action<TestScreen>]()
    let expectedActions = [
      Action<TestScreen>.anyScreen(TestScreen().eraseToAnyScreen())
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
      buildPath: { path -> Color? in .red }
    )
    .onDismiss(
      send: { (screen: AnyScreen) in .anyScreen(screen)},
      into: store
    )

    let content = sut
      .build(path: dataSource.path.component(for: nextID))?
      .environment(\.parentScreenID, .root)
      .environmentObject(dataSource)
      .frame(width: 20, height: 20)

    // Assert snapshot to force view building
    assertSnapshot(matching: content, as: .image)

    dataSource.dismiss(id: nextID)

    XCTAssertEqual(expectedActions, receivedActions)
  }

  func test_type_based_on_dismiss_of_matching_screen_sends_action_into_store() {
    let dataSource = self.dataSource()

    var receivedActions = [Action<TestScreen>]()
    let expectedActions = [
      Action<TestScreen>.action
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
      buildPath: { path -> Color? in .red }
    )
    .onDismiss(
      of: TestScreen.self,
      send: .action,
      into: store
    )

    let content = sut
      .build(path: dataSource.path.component(for: nextID))?
      .environment(\.parentScreenID, .root)
      .environmentObject(dataSource)
      .frame(width: 20, height: 20)

    // Assert snapshot to force view building
    assertSnapshot(matching: content, as: .image)

    dataSource.dismiss(id: nextID)

    XCTAssertEqual(expectedActions, receivedActions)
  }

  func test_closure_based_on_dismiss_of_matching_screen_sends_action_into_store() {
    let dataSource = self.dataSource()

    var receivedActions = [Action<TestScreen>]()
    let expectedActions = [
      Action<TestScreen>.screen(TestScreen())
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
      buildPath: { path -> Color? in .red }
    )
    .onDismiss(
      send: { (screen: TestScreen) in Action.screen(screen) },
      into: store
    )

    let content = sut
      .build(path: dataSource.path.component(for: nextID))?
      .environment(\.parentScreenID, .root)
      .environmentObject(dataSource)
      .frame(width: 20, height: 20)

    // Assert snapshot to force view building
    assertSnapshot(matching: content, as: .image)

    dataSource.dismiss(id: nextID)

    XCTAssertEqual(expectedActions, receivedActions)
  }
}
