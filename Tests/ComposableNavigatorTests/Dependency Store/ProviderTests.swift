@testable import ComposableNavigator
import SnapshotTesting
import SwiftUI
import XCTest

final class ProviderTests: XCTestCase {
  private class Store: ObservableObject {
    @Published var content: String = "Content"
  }

  let dependencyStore = DependencyStore()
  let screenID = ScreenID()
  lazy var dataSource = Navigator.Datasource(
    path: [
      IdentifiedScreen(
        id: .root,
        content: TestScreen(identifier: "0", presentationStyle: .push),
        hasAppeared: false
      ),
      IdentifiedScreen(
        id: screenID,
        content: TestScreen(identifier: "0", presentationStyle: .push),
        hasAppeared: false
      )
    ]
  )

  override func setUp() {
    super.setUp()
    dependencyStore.reset()
  }

  func test_provider_exposes_dependency_value() {
    let sut = UIHostingController(
      rootView: Provider(
        initialize: { _, _ in "Content" },
        dependencyStore: dependencyStore,
        content: { content in
          Text(content)
            .frame(width: 100, height: 20)
        }
      )
      .environmentObject(dataSource)
      .environment(\.currentScreenID, screenID)
    )

    assertSnapshot(matching: sut, as: .image)
  }

  func test_provider_observing_updates_view_after_change() {
    let store = Store()

    let sut = UIHostingController(
      rootView: Provider(
        observing: { _, _ in store },
        dependencyStore: dependencyStore,
        content: { store in
          Text(store.content)
            .frame(width: 100, height: 20)
        }
      )
      .environmentObject(dataSource)
      .environment(\.currentScreenID, screenID)
    )

    assertSnapshot(matching: sut, as: .image)

    store.content = "New Content"

    assertSnapshot(matching: sut, as: .image)
  }

  func test_deinits_dependency_on_dismiss() {
    let store = Store()

    let sut = UIHostingController(
      rootView: Provider(
        observing: { _, _ in store },
        dependencyStore: dependencyStore,
        content: { store in
          Text(store.content)
            .frame(width: 100, height: 20)
        }
      )
      .environmentObject(dataSource)
      .environment(\.currentScreenID, screenID)
    )

    assertSnapshot(matching: sut, as: .image)

    XCTAssertNotNil(
      dependencyStore.get(
        dependency: Store.self,
        in: DependencyStore.Scope(screenID.uuidString)
      )
    )

    dataSource.dismiss(id: screenID)

    XCTAssertNil(
      dependencyStore.get(
        dependency: Store.self,
        in: DependencyStore.Scope(screenID.uuidString)
      )
    )
  }
}
