import ComposableArchitecture
@testable import ComposableNavigator
@testable import ComposableNavigatorTCA
import XCTest

final class NavigatorReducerTests: XCTestCase {
  let root = TestScreen(
    identifier: "root",
    presentationStyle: .push
  )

  let next = TestScreen(
    identifier: "next",
    presentationStyle: .push
  ).eraseToAnyScreen()

  func test_go_to() {
    let expectedNextID = ScreenID()
    let testStore = TestStore(
      initialState: NavigatorState(root: root),
      reducer: navigatorReducer,
      environment: NavigatorEnvironment(screenID: { expectedNextID })
    )

    testStore.assert(
      .send(
        .go(to: next, on: .root),
        { state in
          state.path = [
            IdentifiedScreen(id: .root, content: self.root, hasAppeared: false),
            IdentifiedScreen(id: expectedNextID, content: self.next, hasAppeared: false)
          ]
        }
      )
    )
  }

  func test_goBack_to_existing() {
    let expectedNextID = ScreenID()
    let testStore = TestStore(
      initialState: NavigatorState(
        path: [
          IdentifiedScreen(id: .root, content: root, hasAppeared: false),
          IdentifiedScreen(id: expectedNextID, content: next, hasAppeared: false)
        ]
      ),
      reducer: navigatorReducer,
      environment: NavigatorEnvironment(screenID: { fatalError("unimplemented") })
    )

    testStore.assert(
      .send(
        .goBack(to: root.eraseToAnyScreen()),
        { state in
          state.path = [
            IdentifiedScreen(id: .root, content: self.root, hasAppeared: false)
          ]
        }
      )
    )
  }

  func test_goBack_to_non_existing() {
    let expectedNextID = ScreenID()
    let testStore = TestStore(
      initialState: NavigatorState(
        path: [
          IdentifiedScreen(id: .root, content: root, hasAppeared: false),
          IdentifiedScreen(id: expectedNextID, content: next, hasAppeared: false)
        ]
      ),
      reducer: navigatorReducer,
      environment: NavigatorEnvironment(screenID: { fatalError("unimplemented") })
    )

    let nonExistent = TestScreen(identifier: "non-existent", presentationStyle: .push)

    testStore.assert(
      .send(
        .goBack(to: nonExistent.eraseToAnyScreen())
      )
    )
  }

  func test_replace_path() {
    let expectedNextID = ScreenID()
    let testStore = TestStore(
      initialState: NavigatorState(
        path: [
          IdentifiedScreen(id: .root, content: root, hasAppeared: false),
          IdentifiedScreen(id: expectedNextID, content: next, hasAppeared: false)
        ]
      ),
      reducer: navigatorReducer,
      environment: NavigatorEnvironment(screenID: { expectedNextID })
    )

    let newPath = [
      TestScreen(identifier: "newRoot", presentationStyle: .push).eraseToAnyScreen(),
      TestScreen(identifier: "newDetail", presentationStyle: .push).eraseToAnyScreen(),
    ]

    testStore.assert(
      .send(
        .replace(path: newPath),
        { state in
          state.path = [
            IdentifiedScreen(id: .root, content: TestScreen(identifier: "newRoot", presentationStyle: .push), hasAppeared: false),
            IdentifiedScreen(id: expectedNextID, content: TestScreen(identifier: "newDetail", presentationStyle: .push), hasAppeared: false)
          ]
        }
      )
    )
  }

  func test_dismiss_root_doesNothing() {
    let testStore = TestStore(
      initialState: NavigatorState(
        path: [
          IdentifiedScreen(id: .root, content: root, hasAppeared: false)
        ]
      ),
      reducer: navigatorReducer,
      environment: NavigatorEnvironment(screenID: { fatalError("unimplemented") })
    )

    testStore.assert(
      .send(
        .dismiss(.root)
      )
    )
  }

  func test_dismiss_existing() {
    let first = ScreenID()
    let second = ScreenID()

    let testStore = TestStore(
      initialState: NavigatorState(
        path: [
          IdentifiedScreen(id: .root, content: root, hasAppeared: false),
          IdentifiedScreen(id: first, content: next, hasAppeared: false),
          IdentifiedScreen(id: second, content: root, hasAppeared: false)
        ]
      ),
      reducer: navigatorReducer,
      environment: NavigatorEnvironment(screenID: { fatalError("unimplemented") })
    )

    testStore.assert(
      .send(
        .dismiss(second),
        { state in
          state.path = [
            IdentifiedScreen(id: .root, content: self.root, hasAppeared: false),
            IdentifiedScreen(id: first, content: self.next, hasAppeared: false)
          ]
        }
      )
    )
  }

  func test_dismiss_non_existing() {
    let first = ScreenID()
    let second = ScreenID()
    let third = ScreenID()

    let testStore = TestStore(
      initialState: NavigatorState(
        path: [
          IdentifiedScreen(id: .root, content: root, hasAppeared: false),
          IdentifiedScreen(id: first, content: next, hasAppeared: false),
          IdentifiedScreen(id: second, content: root, hasAppeared: false)
        ]
      ),
      reducer: navigatorReducer,
      environment: NavigatorEnvironment(screenID: { fatalError("unimplemented") })
    )

    testStore.assert(
      .send(
        .dismiss(third)
      )
    )
  }

  func test_dismissSuccessor_of_id() {
    let first = ScreenID()
    let second = ScreenID()

    let testStore = TestStore(
      initialState: NavigatorState(
        path: [
          IdentifiedScreen(id: .root, content: root, hasAppeared: false),
          IdentifiedScreen(id: first, content: next, hasAppeared: false),
          IdentifiedScreen(id: second, content: root, hasAppeared: false)
        ]
      ),
      reducer: navigatorReducer,
      environment: NavigatorEnvironment(screenID: { fatalError("unimplemented") })
    )

    testStore.assert(
      .send(
        .dismissSuccessor(of: first),
        { state in
          state.path = [
            IdentifiedScreen(id: .root, content: self.root, hasAppeared: false),
            IdentifiedScreen(id: first, content: self.next, hasAppeared: false)
          ]
        }
      )
    )
  }

  func test_dismissSuccessor_of_non_existing() {
    let first = ScreenID()
    let second = ScreenID()
    let third = ScreenID()

    let testStore = TestStore(
      initialState: NavigatorState(
        path: [
          IdentifiedScreen(id: .root, content: root, hasAppeared: false),
          IdentifiedScreen(id: first, content: next, hasAppeared: false),
          IdentifiedScreen(id: second, content: root, hasAppeared: false)
        ]
      ),
      reducer: navigatorReducer,
      environment: NavigatorEnvironment(screenID: { fatalError("unimplemented") })
    )

    testStore.assert(
      .send(
        .dismissSuccessor(of: third)
      )
    )
  }

  func test_dismissSuccessor_of_last() {
    let first = ScreenID()
    let second = ScreenID()

    let testStore = TestStore(
      initialState: NavigatorState(
        path: [
          IdentifiedScreen(id: .root, content: root, hasAppeared: false),
          IdentifiedScreen(id: first, content: next, hasAppeared: false),
          IdentifiedScreen(id: second, content: root, hasAppeared: false)
        ]
      ),
      reducer: navigatorReducer,
      environment: NavigatorEnvironment(screenID: { fatalError("unimplemented") })
    )

    testStore.assert(
      .send(
        .dismissSuccessor(of: second)
      )
    )
  }

  func test_didAppear() {
    let first = ScreenID()
    let second = ScreenID()

    let testStore = TestStore(
      initialState: NavigatorState(
        path: [
          IdentifiedScreen(id: .root, content: root, hasAppeared: false),
          IdentifiedScreen(id: first, content: next, hasAppeared: false),
          IdentifiedScreen(id: second, content: root, hasAppeared: false)
        ]
      ),
      reducer: navigatorReducer,
      environment: NavigatorEnvironment(screenID: { fatalError("unimplemented") })
    )

    testStore.assert(
      .send(
        .didAppear(second),
        { state in
          state.path[2].hasAppeared = true
        }
      )
    )
  }
}
