import ComposableNavigator
import SwiftUI
import XCTest

final class PathBuilder_Conditional_Tests: XCTestCase {
  let path = PathComponentUpdate(
    previous: nil,
    current: IdentifiedScreen(
      id: .root,
      content: TestScreen(identifier: "", presentationStyle: .push),
      hasAppeared: false
    )
  )

  // MARK: - If
  func test_if_builds_then_builder_if_condition_is_true() {
    var thenBuilderInvocations = [PathComponentUpdate]()

    let expectedThenBuilderInvocations = [
      path
    ]

    let sut = PathBuilders
      .if { true }
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
    var thenBuilderInvocations = [PathComponentUpdate]()
    var elseBuilderInvocations = [PathComponentUpdate]()

    let expectedThenBuilderInvocations = [
      path
    ]

    let expectedElseBuilderInvocations = [PathComponentUpdate]()

    let sut = PathBuilders
      .if (
        { true },
        then: _PathBuilder(
          buildPath: { path -> EmptyView? in
            thenBuilderInvocations.append(path)
            return nil
          }
        ),
        else: _PathBuilder(
          buildPath: { path -> EmptyView? in
            elseBuilderInvocations.append(path)
            return nil
          }
        )
      )

    XCTAssertNil(sut.build(path: path))
    XCTAssertEqual(expectedThenBuilderInvocations, thenBuilderInvocations)
    XCTAssertEqual(expectedElseBuilderInvocations, elseBuilderInvocations)
  }

  func test_ifElse_builds_else_builder_if_condition_is_false() {
    var thenBuilderInvocations = [PathComponentUpdate]()
    var elseBuilderInvocations = [PathComponentUpdate]()

    let expectedThenBuilderInvocations = [PathComponentUpdate]()

    let expectedElseBuilderInvocations = [
      path
    ]

    let sut = PathBuilders.if (
      { false },
      then: _PathBuilder(
        buildPath: { path -> EmptyView? in
          thenBuilderInvocations.append(path)
          return nil
        }
      )
      ,
      else: _PathBuilder(
        buildPath: { path -> EmptyView? in
          elseBuilderInvocations.append(path)
          return nil
        }
      )
    )

    XCTAssertNil(sut.build(path: path))
    XCTAssertEqual(expectedThenBuilderInvocations, thenBuilderInvocations)
    XCTAssertEqual(expectedElseBuilderInvocations, elseBuilderInvocations)
  }

  // MARK: - ifLet
  func test_ifLet_without_elseBuilder_builds_thenBuilder_ifLetContent_not_nil() {
    let letContent = 1
    var thenBuilderInvocations = [PathComponentUpdate]()
    let expectedThenBuilderInvocations = [
      path
    ]

    var unwrappedContents = [Int]()
    let expectedUnwrappedContents = [1]

    let sut = PathBuilders
      .if(let: { letContent },
          then: { unwrapped -> _PathBuilder<EmptyView> in
            unwrappedContents.append(unwrapped)

            return _PathBuilder(
              buildPath: { path -> EmptyView? in
                thenBuilderInvocations.append(path)
                return EmptyView()
              }
            )
          }
      )

    XCTAssertNotNil(sut.build(path: path))
    XCTAssertEqual(expectedThenBuilderInvocations, thenBuilderInvocations)
    XCTAssertEqual(expectedUnwrappedContents, unwrappedContents)
  }

  func test_ifLet_builds_thenBuilder_ifLetContent_not_nil() {
    let letContent = 1
    var thenBuilderInvocations = [PathComponentUpdate]()
    var elseBuilderInvocations = [PathComponentUpdate]()

    let expectedThenBuilderInvocations = [
      path
    ]

    let expectedElseBuilderInvocations = [PathComponentUpdate]()

    var unwrappedContents = [Int]()
    let expectedUnwrappedContents = [1]

    let sut = PathBuilders
      .if(
        let: { letContent },
        then: { unwrapped -> _PathBuilder<EmptyView> in
          unwrappedContents.append(unwrapped)

          return _PathBuilder(
            buildPath: { path -> EmptyView? in
              thenBuilderInvocations.append(path)
              return EmptyView()
            }
          )
        },
        else:
          _PathBuilder(
            buildPath: { path -> EmptyView? in
              elseBuilderInvocations.append(path)
              return nil
            }
          )
      )

    XCTAssertNotNil(sut.build(path: path))
    XCTAssertEqual(expectedThenBuilderInvocations, thenBuilderInvocations)
    XCTAssertEqual(expectedElseBuilderInvocations, elseBuilderInvocations)
    XCTAssertEqual(expectedUnwrappedContents, unwrappedContents)
  }

  func test_ifLet_builds_elseBuilder_ifLetContent_is_nil() {
    var thenBuilderInvocations = [PathComponentUpdate]()
    var elseBuilderInvocations = [PathComponentUpdate]()

    let expectedThenBuilderInvocations = [PathComponentUpdate]()

    let expectedElseBuilderInvocations = [path]

    var unwrappedContents = [Int]()
    let expectedUnwrappedContents = [Int]()

    let sut = PathBuilders
      .if(
        let: { Optional<Int>.none },
        then: { unwrapped -> _PathBuilder<EmptyView> in
          unwrappedContents.append(unwrapped)

          return _PathBuilder(
            buildPath: { path -> EmptyView? in
              thenBuilderInvocations.append(path)
              return nil
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

    XCTAssertNotNil(sut.build(path: path))
    XCTAssertEqual(expectedThenBuilderInvocations, thenBuilderInvocations)
    XCTAssertEqual(expectedElseBuilderInvocations, elseBuilderInvocations)
    XCTAssertEqual(expectedUnwrappedContents, unwrappedContents)
  }
}
