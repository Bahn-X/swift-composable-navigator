import ComposableArchitecture
@testable import ComposableRouter
import XCTest

final class RouterReducerTests: XCTestCase {
  let root = TestRoute(
    identifier: "root",
    presentationStyle: .push
  )

  let next = TestRoute(
    identifier: "next",
    presentationStyle: .push
  )

  func test_go_to() {
    let expectedNextID = ScreenID()
    let testStore = TestStore(
      initialState: RouterState(root: root),
      reducer: routerReducer,
      environment: RouterEnvironment(screenID: { expectedNextID })
    )

    testStore.assert(
      .send(
        .go(to: next, on: .root),
        { state in
          state.path = [
            IdentifiedScreen(id: .root, content: self.root),
            IdentifiedScreen(id: expectedNextID, content: self.next)
          ]
        }
      )
    )
  }

  func test_goBack_to_existing() {
    let expectedNextID = ScreenID()
    let testStore = TestStore(
      initialState: RouterState(
        path: [
            IdentifiedScreen(id: .root, content: root),
            IdentifiedScreen(id: expectedNextID, content: next)
        ]
      ),
      reducer: routerReducer,
      environment: RouterEnvironment(screenID: { fatalError("unimplemented") })
    )

    testStore.assert(
      .send(
        .goBack(to: root),
        { state in
          state.path = [
            IdentifiedScreen(id: .root, content: self.root)
          ]
        }
      )
    )
  }

  func test_goBack_to_non_existing() {
    let expectedNextID = ScreenID()
    let testStore = TestStore(
      initialState: RouterState(
        path: [
          IdentifiedScreen(id: .root, content: root),
          IdentifiedScreen(id: expectedNextID, content: next)
        ]
      ),
      reducer: routerReducer,
      environment: RouterEnvironment(screenID: { fatalError("unimplemented") })
    )

    let nonExistent = TestRoute(identifier: "non-existent", presentationStyle: .push)

    testStore.assert(
      .send(
        .goBack(to: nonExistent)
      )
    )
  }

  func test_replace_path() {
    let expectedNextID = ScreenID()
    let testStore = TestStore(
      initialState: RouterState(
        path: [
          IdentifiedScreen(id: .root, content: root),
          IdentifiedScreen(id: expectedNextID, content: next)
        ]
      ),
      reducer: routerReducer,
      environment: RouterEnvironment(screenID: { expectedNextID })
    )

    let newPath = [
      TestRoute(identifier: "newRoot", presentationStyle: .push).eraseToAnyScreen(),
      TestRoute(identifier: "newDetail", presentationStyle: .push).eraseToAnyScreen(),
    ]

    testStore.assert(
      .send(
        .replace(path: newPath),
        { state in
          state.path = [
            IdentifiedScreen(id: .root, content: TestRoute(identifier: "newRoot", presentationStyle: .push)),
            IdentifiedScreen(id: expectedNextID, content: TestRoute(identifier: "newDetail", presentationStyle: .push))
          ]
        }
      )
    )
  }

  func test_dismiss_root_doesNothing() {
    let testStore = TestStore(
      initialState: RouterState(
        path: [
          IdentifiedScreen(id: .root, content: root)
        ]
      ),
      reducer: routerReducer,
      environment: RouterEnvironment(screenID: { fatalError("unimplemented") })
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
      initialState: RouterState(
        path: [
          IdentifiedScreen(id: .root, content: root),
          IdentifiedScreen(id: first, content: next),
          IdentifiedScreen(id: second, content: root)
        ]
      ),
      reducer: routerReducer,
      environment: RouterEnvironment(screenID: { fatalError("unimplemented") })
    )

    testStore.assert(
      .send(
        .dismiss(second),
        { state in
          state.path = [
            IdentifiedScreen(id: .root, content: self.root),
            IdentifiedScreen(id: first, content: self.next)
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
      initialState: RouterState(
        path: [
          IdentifiedScreen(id: .root, content: root),
          IdentifiedScreen(id: first, content: next),
          IdentifiedScreen(id: second, content: root)
        ]
      ),
      reducer: routerReducer,
      environment: RouterEnvironment(screenID: { fatalError("unimplemented") })
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
      initialState: RouterState(
        path: [
          IdentifiedScreen(id: .root, content: root),
          IdentifiedScreen(id: first, content: next),
          IdentifiedScreen(id: second, content: root)
        ]
      ),
      reducer: routerReducer,
      environment: RouterEnvironment(screenID: { fatalError("unimplemented") })
    )

    testStore.assert(
      .send(
        .dismissSuccessor(of: first),
        { state in
          state.path = [
            IdentifiedScreen(id: .root, content: self.root),
            IdentifiedScreen(id: first, content: self.next)
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
      initialState: RouterState(
        path: [
          IdentifiedScreen(id: .root, content: root),
          IdentifiedScreen(id: first, content: next),
          IdentifiedScreen(id: second, content: root)
        ]
      ),
      reducer: routerReducer,
      environment: RouterEnvironment(screenID: { fatalError("unimplemented") })
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
        initialState: RouterState(
          path: [
            IdentifiedScreen(id: .root, content: root),
            IdentifiedScreen(id: first, content: next),
            IdentifiedScreen(id: second, content: root)
          ]
        ),
        reducer: routerReducer,
        environment: RouterEnvironment(screenID: { fatalError("unimplemented") })
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
          initialState: RouterState(
            path: [
              IdentifiedScreen(id: .root, content: root),
              IdentifiedScreen(id: first, content: next),
              IdentifiedScreen(id: second, content: root)
            ]
          ),
          reducer: routerReducer,
          environment: RouterEnvironment(screenID: { fatalError("unimplemented") })
        )

        testStore.assert(
          .send(
            .didAppear(second),
            { state in
                state.path[2].didAppear = true
            }
          )
        )
    }
}
