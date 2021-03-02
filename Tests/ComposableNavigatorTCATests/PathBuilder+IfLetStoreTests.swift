import ComposableArchitecture
import ComposableNavigator
import ComposableNavigatorTCA
import SwiftUI
import XCTest

final class PathBuilder_IfLetStoreTests: XCTestCase {
  // MARK: - ifLet
  func test_ifLet_builds_then_builder_with_unwrapped_store_if_state_initialised() {
    var innerBuildCalled = false

    let store = Store<Optional<Int>, Void>(
      initialState: 0,
      reducer: .empty,
      environment: ()
    )

    let expectedPath = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: TestScreen(),
        hasAppeared: false
      )
    )

    let sut = PathBuilders.ifLetStore(
      store: store,
      then: { store in
        _PathBuilder(
          buildPath: { path -> EmptyView? in
            XCTAssertEqual(expectedPath, path)
            XCTAssertEqual(ViewStore(store).state, 0)
            innerBuildCalled = true
            return EmptyView()
          }
        )
      }
    )

    XCTAssertNotNil(sut.build(path: expectedPath))
    XCTAssertTrue(innerBuildCalled)
  }

  func test_ifLet_builds_nil_if_state_nil() {
    var innerBuildCalled = false

    let store = Store<Optional<Int>, Void>(
      initialState: nil,
      reducer: .empty,
      environment: ()
    )

    let expectedPath = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: TestScreen(),
        hasAppeared: false
      )
    )

    let sut = PathBuilders.ifLetStore(
      store: store,
      then: { store in
        _PathBuilder(
          buildPath: { path -> EmptyView? in
            innerBuildCalled = true
            return EmptyView()
          }
        )
      }
    )

    XCTAssertNil(sut.build(path: expectedPath))
    XCTAssertFalse(innerBuildCalled)
  }

  // MARK: - ifLet else
  func test_ifLetElse_builds_then_builder_with_unwrapped_store_if_state_initialised() {
    let store = Store<Optional<Int>, Void>(
      initialState: 0,
      reducer: .empty,
      environment: ()
    )

    var thenBuilderInvocations = [PathComponentUpdate]()
    var elseBuilderInvocations = [PathComponentUpdate]()

    let expectedPath = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: TestScreen(),
        hasAppeared: false
      )
    )

    let expectedThenBuilderInvocations = [
      expectedPath
    ]

    let expectedElseBuilderInvocations = [PathComponentUpdate]()

    let sut = PathBuilders.ifLetStore(
      store: store,
      then: { store in
        _PathBuilder(
          buildPath: { path -> EmptyView? in
            XCTAssertEqual(ViewStore(store).state, 0)

            thenBuilderInvocations.append(path)

            return EmptyView()
          }
        )
      },
      else: _PathBuilder(
        buildPath: { path -> EmptyView? in
          elseBuilderInvocations.append(path)
          return EmptyView()
        }
      )
    )

    XCTAssertNotNil(sut.build(path: expectedPath))
    XCTAssertEqual(expectedThenBuilderInvocations, thenBuilderInvocations)
    XCTAssertEqual(expectedElseBuilderInvocations, elseBuilderInvocations)
  }

  func test_ifLetElse_builds_else_builder_if_state_nil() {
    let store = Store<Optional<Int>, Void>(
      initialState: nil,
      reducer: .empty,
      environment: ()
    )

    var thenBuilderInvocations = [PathComponentUpdate]()
    var elseBuilderInvocations = [PathComponentUpdate]()

    let expectedPath = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: TestScreen(),
        hasAppeared: false
      )
    )

    let expectedThenBuilderInvocations = [PathComponentUpdate]()

    let expectedElseBuilderInvocations = [
      expectedPath
    ]

    let sut = PathBuilders.ifLetStore(
      store: store,
      then: { store in
        _PathBuilder(
          buildPath: { path -> EmptyView? in
            thenBuilderInvocations.append(path)
            return EmptyView()
          }
        )
      },
      else: _PathBuilder(
        buildPath: { path -> EmptyView? in
          elseBuilderInvocations.append(path)
          return EmptyView()
        }
      )
    )

    XCTAssertNotNil(sut.build(path: expectedPath))
    XCTAssertEqual(expectedThenBuilderInvocations, thenBuilderInvocations)
    XCTAssertEqual(expectedElseBuilderInvocations, elseBuilderInvocations)
  }
}
