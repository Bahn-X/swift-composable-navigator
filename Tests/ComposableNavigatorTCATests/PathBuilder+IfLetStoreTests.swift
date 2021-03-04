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

    let expectedPath = TestScreen().eraseToAnyScreen()

    let sut = PathBuilders.ifLetStore(
      store: store,
      then: { store in
        _PathBuilder { pathElement -> EmptyView? in
          XCTAssertEqual(expectedPath, pathElement)
          XCTAssertEqual(ViewStore(store).state, 0)
          innerBuildCalled = true
          return EmptyView()
        }
      }
    )

    XCTAssertNotNil(sut.build(pathElement: expectedPath))
    XCTAssertTrue(innerBuildCalled)
  }

  func test_ifLet_builds_nil_if_state_nil() {
    var innerBuildCalled = false

    let store = Store<Optional<Int>, Void>(
      initialState: nil,
      reducer: .empty,
      environment: ()
    )

    let expectedPath = TestScreen().eraseToAnyScreen()

    let sut = PathBuilders.ifLetStore(
      store: store,
      then: { store in
        _PathBuilder { pathElement -> EmptyView? in
          innerBuildCalled = true
          return EmptyView()
        }
      }
    )

    XCTAssertNil(sut.build(pathElement: expectedPath))
    XCTAssertFalse(innerBuildCalled)
  }

  // MARK: - ifLet else
  func test_ifLetElse_builds_then_builder_with_unwrapped_store_if_state_initialised() {
    let store = Store<Optional<Int>, Void>(
      initialState: 0,
      reducer: .empty,
      environment: ()
    )

    var thenBuilderInvocations = [AnyScreen]()
    var elseBuilderInvocations = [AnyScreen]()

    let expectedPath =  TestScreen().eraseToAnyScreen()

    let expectedThenBuilderInvocations = [
      expectedPath
    ]

    let expectedElseBuilderInvocations = [AnyScreen]()

    let sut = PathBuilders.ifLetStore(
      store: store,
      then: { store in
        _PathBuilder { pathElement -> EmptyView? in
          XCTAssertEqual(ViewStore(store).state, 0)

          thenBuilderInvocations.append(pathElement)

          return EmptyView()
        }
      },
      else: _PathBuilder { pathElement -> EmptyView? in
        elseBuilderInvocations.append(pathElement)
        return EmptyView()
      }
    )

    XCTAssertNotNil(sut.build(pathElement: expectedPath))
    XCTAssertEqual(expectedThenBuilderInvocations, thenBuilderInvocations)
    XCTAssertEqual(expectedElseBuilderInvocations, elseBuilderInvocations)
  }

  func test_ifLetElse_builds_else_builder_if_state_nil() {
    let store = Store<Optional<Int>, Void>(
      initialState: nil,
      reducer: .empty,
      environment: ()
    )

    var thenBuilderInvocations = [AnyScreen]()
    var elseBuilderInvocations = [AnyScreen]()

    let expectedPath = TestScreen().eraseToAnyScreen()

    let expectedThenBuilderInvocations = [AnyScreen]()

    let expectedElseBuilderInvocations = [
      expectedPath
    ]

    let sut = PathBuilders.ifLetStore(
      store: store,
      then: { store in
        _PathBuilder { pathElement -> EmptyView? in
          thenBuilderInvocations.append(pathElement)
          return EmptyView()
        }
      },
      else: _PathBuilder { pathElement -> EmptyView? in
        elseBuilderInvocations.append(pathElement)
        return EmptyView()
      }
    )

    XCTAssertNotNil(sut.build(pathElement: expectedPath))
    XCTAssertEqual(expectedThenBuilderInvocations, thenBuilderInvocations)
    XCTAssertEqual(expectedElseBuilderInvocations, elseBuilderInvocations)
  }
}
