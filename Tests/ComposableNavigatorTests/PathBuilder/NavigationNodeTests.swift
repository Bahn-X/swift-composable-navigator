@testable import ComposableNavigator
import SnapshotTesting
import SwiftUI
import XCTest

final class NavigationNodeTests: XCTestCase {
  func test_calls_closure_on_initial_appear() {
    var onAppearClosureInvocations = [Bool]()
    let expectedInvocations = [true]

    let dataSource = Navigator.Datasource(
      path: [
        IdentifiedScreen(
          id: .root,
          content: TestScreen(identifier: "0", presentationStyle: .push),
          hasAppeared: false
        )
      ]
    )

    let routed = NavigationNode(
      content: Text("A"),
      onAppear: { initialAppear in onAppearClosureInvocations.append(initialAppear) },
      buildSuccessor: { _ -> EmptyView? in nil }
    )
    .frame(width: 20, height: 20)
    .environmentObject(dataSource)
    .environment(\.currentScreenID, .root)
    .environment(\.navigator, Navigator(dataSource: dataSource).debug())

    assertSnapshot(matching: routed, as: .image)

    XCTAssertEqual(expectedInvocations, onAppearClosureInvocations)
  }

  func test_calls_closure_on_consequent_appear() {
    var onAppearClosureInvocations = [Bool]()
    let expectedInvocations = [false]

    let dataSource = Navigator.Datasource(
      path: [
        IdentifiedScreen(
          id: .root,
          content: TestScreen(identifier: "0", presentationStyle: .push),
          hasAppeared: true
        )
      ]
    )

    let routed = NavigationNode(
      content: Text("A"),
      onAppear: { initialAppear in onAppearClosureInvocations.append(initialAppear) },
      buildSuccessor: { _ -> EmptyView? in nil }
    )
    .frame(width: 20, height: 20)
    .environmentObject(dataSource)
    .environment(\.currentScreenID, .root)
    .environment(\.navigator, Navigator(dataSource: dataSource).debug())

    assertSnapshot(matching: routed, as: .image)

    XCTAssertEqual(expectedInvocations, onAppearClosureInvocations)
  }
}
