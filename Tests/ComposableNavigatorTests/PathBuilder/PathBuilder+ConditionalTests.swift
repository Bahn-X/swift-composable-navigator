import ComposableNavigator
import SwiftUI
import XCTest

final class PathBuilder_Conditional_Tests: XCTestCase {
  let pathElement = TestScreen(identifier: "", presentationStyle: .push)

  // MARK: - If
  func test_if_builds_then_builder_if_condition_is_true() {
    var thenBuilderInvocations = [AnyScreen]()

    let expectedThenBuilderInvocations = [
      pathElement.eraseToAnyScreen()
    ]

    let sut = PathBuilders
      .if(
        { return true },
        then: _PathBuilder { path -> EmptyView? in
          thenBuilderInvocations.append(path)
          return nil
        }
      )

    XCTAssertNil(sut.build(pathElement: pathElement))
    XCTAssertEqual(expectedThenBuilderInvocations, thenBuilderInvocations)
  }

  func test_ifElse_builds_then_builder_if_condition_is_true() {
    var thenBuilderInvocations = [AnyScreen]()
    var elseBuilderInvocations = [AnyScreen]()

    let expectedThenBuilderInvocations = [
      pathElement.eraseToAnyScreen()
    ]

    let expectedElseBuilderInvocations = [AnyScreen]()

    let sut = PathBuilders
      .if (
        { true },
        then: _PathBuilder { path -> EmptyView? in
          thenBuilderInvocations.append(path)
          return nil
        }
        ,
        else: _PathBuilder { path -> EmptyView? in
          elseBuilderInvocations.append(path)
          return nil
        }
      )

    XCTAssertNil(sut.build(pathElement: pathElement))
    XCTAssertEqual(expectedThenBuilderInvocations, thenBuilderInvocations)
    XCTAssertEqual(expectedElseBuilderInvocations, elseBuilderInvocations)
  }

  func test_ifElse_builds_else_builder_if_condition_is_false() {
    var thenBuilderInvocations = [AnyScreen]()
    var elseBuilderInvocations = [AnyScreen]()

    let expectedThenBuilderInvocations = [AnyScreen]()

    let expectedElseBuilderInvocations = [
      pathElement.eraseToAnyScreen()
    ]

    let sut = PathBuilders.if (
      { false },
      then: _PathBuilder { path -> EmptyView? in
        thenBuilderInvocations.append(path)
        return nil
      },
      else: _PathBuilder { path -> EmptyView? in
        elseBuilderInvocations.append(path)
        return nil
      }
    )

    XCTAssertNil(sut.build(pathElement: pathElement))
    XCTAssertEqual(expectedThenBuilderInvocations, thenBuilderInvocations)
    XCTAssertEqual(expectedElseBuilderInvocations, elseBuilderInvocations)
  }

  // MARK: - ifLet
  func test_ifLet_without_elseBuilder_builds_thenBuilder_ifLetContent_not_nil() {
    let letContent = 1
    var thenBuilderInvocations = [AnyScreen]()
    let expectedThenBuilderInvocations = [
      pathElement.eraseToAnyScreen()
    ]

    var unwrappedContents = [Int]()
    let expectedUnwrappedContents = [1]

    let sut = PathBuilders
      .if(let: { letContent },
          then: { unwrapped -> _PathBuilder<EmptyView> in
            unwrappedContents.append(unwrapped)

            return _PathBuilder { path -> EmptyView? in
              thenBuilderInvocations.append(path)
              return EmptyView()
            }
          }
      )

    XCTAssertNotNil(sut.build(pathElement: pathElement))
    XCTAssertEqual(expectedThenBuilderInvocations, thenBuilderInvocations)
    XCTAssertEqual(expectedUnwrappedContents, unwrappedContents)
  }

  func test_ifLet_builds_thenBuilder_ifLetContent_not_nil() {
    let letContent = 1
    var thenBuilderInvocations = [AnyScreen]()
    var elseBuilderInvocations = [AnyScreen]()

    let expectedThenBuilderInvocations = [
      pathElement.eraseToAnyScreen()
    ]

    let expectedElseBuilderInvocations = [AnyScreen]()

    var unwrappedContents = [Int]()
    let expectedUnwrappedContents = [1]

    let sut = PathBuilders
      .if(
        let: { letContent },
        then: { unwrapped -> _PathBuilder<EmptyView> in
          unwrappedContents.append(unwrapped)

          return _PathBuilder { path -> EmptyView? in
            thenBuilderInvocations.append(path)
            return EmptyView()
          }
        },
        else:
          _PathBuilder { path -> EmptyView? in
            elseBuilderInvocations.append(path)
            return nil
          }
      )

    XCTAssertNotNil(sut.build(pathElement: pathElement))
    XCTAssertEqual(expectedThenBuilderInvocations, thenBuilderInvocations)
    XCTAssertEqual(expectedElseBuilderInvocations, elseBuilderInvocations)
    XCTAssertEqual(expectedUnwrappedContents, unwrappedContents)
  }

  func test_ifLet_builds_elseBuilder_ifLetContent_is_nil() {
    var thenBuilderInvocations = [AnyScreen]()
    var elseBuilderInvocations = [AnyScreen]()

    let expectedThenBuilderInvocations = [AnyScreen]()

    let expectedElseBuilderInvocations = [pathElement.eraseToAnyScreen()]

    var unwrappedContents = [Int]()
    let expectedUnwrappedContents = [Int]()

    let sut = PathBuilders
      .if(
        let: { Optional<Int>.none },
        then: { unwrapped -> _PathBuilder<EmptyView> in
          unwrappedContents.append(unwrapped)

          return _PathBuilder { path -> EmptyView? in
            thenBuilderInvocations.append(path)
            return nil
          }
        },
        else: _PathBuilder { path -> EmptyView? in
          elseBuilderInvocations.append(path)
          return EmptyView()
        }
      )

    XCTAssertNotNil(sut.build(pathElement: pathElement))
    XCTAssertEqual(expectedThenBuilderInvocations, thenBuilderInvocations)
    XCTAssertEqual(expectedElseBuilderInvocations, elseBuilderInvocations)
    XCTAssertEqual(expectedUnwrappedContents, unwrappedContents)
  }
}
