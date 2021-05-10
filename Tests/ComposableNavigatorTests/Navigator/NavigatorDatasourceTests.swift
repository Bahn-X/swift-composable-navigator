@testable import ComposableNavigator
import XCTest

final class NavigatorDatasourceTests: XCTestCase {
  let root = TestScreen(
    identifier: "root",
    presentationStyle: .push
  )

  let next = TestScreen(
    identifier: "next",
    presentationStyle: .push
  ).eraseToAnyScreen()

  let other = TestScreen(
    identifier: "other",
    presentationStyle: .push
  ).eraseToAnyScreen()

  // MARK: - Path
  func test_navigator_path_exposes_current_path() {
    let sut = Navigator.Datasource(
      root: root,
      screenID: { fatalError() }
    )

    XCTAssertEqual(sut.path, sut.wrappedInNavigator().path())
  }

  // MARK: - go(to screen:, on:)
  func test_go_to() {
    let expectedNextID = ScreenID()

    let sut = Navigator.Datasource(
      root: root,
      screenID: { expectedNextID }
    )

    sut.wrappedInNavigator().go(to: next, on: .root)

    XCTAssertEqual(
      sut.path,
      NavigationPathUpdate(
        previous: [
          IdentifiedScreen(id: .root, content: self.root, hasAppeared: false),
        ],
        current: [
          IdentifiedScreen(id: .root, content: self.root, hasAppeared: false),
          IdentifiedScreen(id: expectedNextID, content: self.next, hasAppeared: false)
        ]
      )
    )
  }

  func test_go_to_on_screen() {
    let expectedNextID = ScreenID()

    let sut = Navigator.Datasource(
      root: root,
      screenID: { expectedNextID }
    )

    sut.wrappedInNavigator().go(to: next, on: self.root.eraseToAnyScreen())

    XCTAssertEqual(
      sut.path,
      NavigationPathUpdate(
        previous: [
          IdentifiedScreen(id: .root, content: self.root, hasAppeared: false),
        ],
        current: [
          IdentifiedScreen(id: .root, content: self.root, hasAppeared: false),
          IdentifiedScreen(id: expectedNextID, content: self.next, hasAppeared: false)
        ]
      )
    )
  }

  // MARK: - go(to newPath:)
  func test_goTo_path_no_matching_elements() {
    let expectedNextID = ScreenID()
    let newID = ScreenID()

    let previousPath = [
      IdentifiedScreen(id: .root, content: root, hasAppeared: true),
      IdentifiedScreen(id: expectedNextID, content: next, hasAppeared: true)
    ]

    let sut = Navigator.Datasource(
      path: previousPath,
      screenID: { newID }
    )

    let first = TestScreen(identifier: "first", presentationStyle: .push)
    let second = TestScreen(identifier: "second", presentationStyle: .push)


    let appendedPath = [
      first.eraseToAnyScreen(),
      second.eraseToAnyScreen()
    ]

    sut.wrappedInNavigator().go(to: appendedPath, on: .root)

    XCTAssertEqual(
      sut.path,
      NavigationPathUpdate(
        previous: previousPath,
        current: [
          IdentifiedScreen(
            id: .root,
            content: root,
            hasAppeared: true
          ),
          IdentifiedScreen(
            id: newID,
            content: first.eraseToAnyScreen(),
            hasAppeared: false
          ),
          IdentifiedScreen(
            id: newID,
            content: second.eraseToAnyScreen(),
            hasAppeared: false
          ),
        ]
      )
    )
  }

  func test_goTo_path_no_matching_elements_on_screen() {
    let expectedNextID = ScreenID()
    let newID = ScreenID()

    let previousPath = [
      IdentifiedScreen(id: .root, content: root, hasAppeared: true),
      IdentifiedScreen(id: expectedNextID, content: next, hasAppeared: true)
    ]

    let sut = Navigator.Datasource(
      path: previousPath,
      screenID: { newID }
    )

    let first = TestScreen(identifier: "first", presentationStyle: .push)
    let second = TestScreen(identifier: "second", presentationStyle: .push)


    let appendedPath = [
      first.eraseToAnyScreen(),
      second.eraseToAnyScreen()
    ]

    sut.wrappedInNavigator().go(to: appendedPath, on: self.root.eraseToAnyScreen())

    XCTAssertEqual(
      sut.path,
      NavigationPathUpdate(
        previous: previousPath,
        current: [
          IdentifiedScreen(
            id: .root,
            content: root,
            hasAppeared: true
          ),
          IdentifiedScreen(
            id: newID,
            content: first.eraseToAnyScreen(),
            hasAppeared: false
          ),
          IdentifiedScreen(
            id: newID,
            content: second.eraseToAnyScreen(),
            hasAppeared: false
          ),
        ]
      )
    )
  }

  func test_goTo_path_appending_partially_matching_path_elements() {
    let expectedNextID = ScreenID()
    let newID = ScreenID()

    let previousPath = [
      IdentifiedScreen(id: .root, content: root, hasAppeared: true),
      IdentifiedScreen(id: expectedNextID, content: next, hasAppeared: true),
      IdentifiedScreen(id: expectedNextID, content: next, hasAppeared: true)
    ]

    let sut = Navigator.Datasource(
      path: previousPath,
      screenID: { newID }
    )

    let appendedPath = [
      TestScreen(identifier: "next", presentationStyle: .push).eraseToAnyScreen(),
      TestScreen(identifier: "newDetail", presentationStyle: .push).eraseToAnyScreen(),
    ]

    sut.wrappedInNavigator().go(to: appendedPath, on: .root)

    XCTAssertEqual(
      sut.path,
      NavigationPathUpdate(
        previous: previousPath,
        current: [
          IdentifiedScreen(
            id: .root,
            content: root,
            hasAppeared: true
          ),
          IdentifiedScreen(
            id: expectedNextID,
            content: next,
            hasAppeared: false
          ),
          IdentifiedScreen(
            id: newID,
            content: TestScreen(identifier: "newDetail", presentationStyle: .push),
            hasAppeared: false
          ),
        ]
      )
    )
  }

  func test_goTo_path_appending_partially_matching_path_elements_on_screen() {
    let expectedNextID = ScreenID()
    let newID = ScreenID()

    let previousPath = [
      IdentifiedScreen(id: .root, content: root, hasAppeared: true),
      IdentifiedScreen(id: expectedNextID, content: next, hasAppeared: true),
      IdentifiedScreen(id: expectedNextID, content: next, hasAppeared: true)
    ]

    let sut = Navigator.Datasource(
      path: previousPath,
      screenID: { newID }
    )

    let appendedPath = [
      TestScreen(identifier: "next", presentationStyle: .push).eraseToAnyScreen(),
      TestScreen(identifier: "newDetail", presentationStyle: .push).eraseToAnyScreen(),
    ]

    sut.wrappedInNavigator().go(to: appendedPath, on: self.root.eraseToAnyScreen())

    XCTAssertEqual(
      sut.path,
      NavigationPathUpdate(
        previous: previousPath,
        current: [
          IdentifiedScreen(
            id: .root,
            content: root,
            hasAppeared: true
          ),
          IdentifiedScreen(
            id: expectedNextID,
            content: next,
            hasAppeared: false
          ),
          IdentifiedScreen(
            id: newID,
            content: TestScreen(identifier: "newDetail", presentationStyle: .push),
            hasAppeared: false
          ),
        ]
      )
    )
  }

  func test_goTo_path_appending_current_path_elements() {
    let newID = ScreenID()

    let previousPath = [
      IdentifiedScreen(id: .root, content: root, hasAppeared: true)
    ]

    let sut = Navigator.Datasource(
      path: previousPath,
      screenID: { newID }
    )


    let appendedPath = [
      TestScreen(identifier: "next", presentationStyle: .push).eraseToAnyScreen()
    ]

    sut.wrappedInNavigator().go(to: appendedPath, on: .root)

    XCTAssertEqual(
      sut.path,
      NavigationPathUpdate(
        previous: previousPath,
        current: [
          IdentifiedScreen(
            id: .root,
            content: root,
            hasAppeared: true
          ),
          IdentifiedScreen(
            id: newID,
            content: next,
            hasAppeared: false
          )
        ]
      )
    )
  }

  func test_goTo_path_appending_current_path_elements_on_screen() {
    let newID = ScreenID()

    let previousPath = [
      IdentifiedScreen(id: .root, content: root, hasAppeared: true)
    ]

    let sut = Navigator.Datasource(
      path: previousPath,
      screenID: { newID }
    )

    let appendedPath = [
      TestScreen(identifier: "next", presentationStyle: .push).eraseToAnyScreen()
    ]

    sut.wrappedInNavigator().go(to: appendedPath, on: self.root.eraseToAnyScreen())

    XCTAssertEqual(
      sut.path,
      NavigationPathUpdate(
        previous: previousPath,
        current: [
          IdentifiedScreen(
            id: .root,
            content: root,
            hasAppeared: true
          ),
          IdentifiedScreen(
            id: newID,
            content: next,
            hasAppeared: false
          )
        ]
      )
    )
  }

  // MARK: - goBack(to predecessor:)
  func test_goBack_to_existing_id() {
    let expectedNextID = ScreenID()

    let previousPath = [
      IdentifiedScreen(id: .root, content: root, hasAppeared: false),
      IdentifiedScreen(id: expectedNextID, content: next, hasAppeared: false)
    ]

    let sut = Navigator.Datasource(
      path: previousPath,
      screenID: { fatalError("unimplemented") }
    )

    sut.wrappedInNavigator().goBack(to: root.eraseToAnyScreen())

    XCTAssertEqual(
      sut.path,
      NavigationPathUpdate(
        previous: previousPath,
        current: [
          IdentifiedScreen(id: .root, content: self.root, hasAppeared: false)
        ]
      )
    )
  }

  func test_goBack_to_existing_screen() {
    let expectedNextID = ScreenID()

    let previousPath = [
      IdentifiedScreen(id: .root, content: root, hasAppeared: false),
      IdentifiedScreen(id: expectedNextID, content: next, hasAppeared: false)
    ]

    let sut = Navigator.Datasource(
      path: previousPath,
      screenID: { fatalError("unimplemented") }
    )

    sut.wrappedInNavigator().goBack(to: .root)

    XCTAssertEqual(
      sut.path,
      NavigationPathUpdate(
        previous: previousPath,
        current: [
          IdentifiedScreen(id: .root, content: self.root, hasAppeared: false)
        ]
      )
    )
  }

  func test_goBack_to_non_existing_id() {
    let expectedNextID = ScreenID()

    let path = [
      IdentifiedScreen(id: .root, content: root, hasAppeared: false),
      IdentifiedScreen(id: expectedNextID, content: next, hasAppeared: false)
    ]

    let sut = Navigator.Datasource(
      path: path,
      screenID: { fatalError("unimplemented") }
    )

    let nonExistent = TestScreen(identifier: "non-existent", presentationStyle: .push)

    sut.wrappedInNavigator().goBack(to: nonExistent.eraseToAnyScreen())

    XCTAssertEqual(
      sut.path,
      NavigationPathUpdate(
        previous: [],
        current: path
      )
    )
  }

  func test_goBack_to_non_existing_screen() {
    let expectedNextID = ScreenID()

    let path = [
      IdentifiedScreen(id: .root, content: root, hasAppeared: false),
      IdentifiedScreen(id: expectedNextID, content: next, hasAppeared: false)
    ]

    let sut = Navigator.Datasource(
      path: path,
      screenID: { fatalError("unimplemented") }
    )

    sut.wrappedInNavigator().goBack(to: ScreenID())

    XCTAssertEqual(
      sut.path,
      NavigationPathUpdate(
        previous: [],
        current: path
      )
    )
  }

  // MARK: - replace(path: [AnyScreen])
  func test_replace_path() {
    let expectedNextID = ScreenID()
    let newID = ScreenID()

    let previousPath = [
      IdentifiedScreen(id: .root, content: root, hasAppeared: true),
      IdentifiedScreen(id: expectedNextID, content: next, hasAppeared: false)
    ]

    let sut = Navigator.Datasource(
      path: previousPath,
      screenID: { newID }
    )


    let newPath = [
      TestScreen(identifier: "newRoot", presentationStyle: .push).eraseToAnyScreen(),
      TestScreen(identifier: "newDetail", presentationStyle: .push).eraseToAnyScreen(),
    ]

    sut.wrappedInNavigator().replace(path: newPath)

    XCTAssertEqual(
      sut.path,
      NavigationPathUpdate(
        previous: previousPath,
        current: [
          IdentifiedScreen(
            id: .root,
            content: TestScreen(identifier: "newRoot", presentationStyle: .push),
            hasAppeared: false
          ),
          IdentifiedScreen(
            id: newID,
            content: TestScreen(identifier: "newDetail", presentationStyle: .push),
            hasAppeared: false
          ),
        ]
      )
    )
  }

  func test_replace_path_with_new_path() {
    let pathElementID = ScreenID()
    let expectedNextID = ScreenID()
    let previousPath = [
      IdentifiedScreen(id: .root, content: root, hasAppeared: true),
      IdentifiedScreen(id: pathElementID, content: next, hasAppeared: true),
      IdentifiedScreen(id: pathElementID, content: next, hasAppeared: true)
    ]

    let sut = Navigator.Datasource(
      path: previousPath,
      screenID: { expectedNextID }
    )

    sut.wrappedInNavigator().replace(path: next, next, next)

    XCTAssertEqual(
      sut.path,
      NavigationPathUpdate(
        previous: previousPath,
        current: [
          IdentifiedScreen(
            id: .root,
            content: next,
            hasAppeared: false
          ),
          IdentifiedScreen(
            id: expectedNextID,
            content: next,
            hasAppeared: false
          ),
          IdentifiedScreen(
            id: expectedNextID,
            content: next,
            hasAppeared: false
          ),
        ]
      )
    )
  }

  func test_replace_path_with_empty_path() {
    let pathElementID = ScreenID()
    let expectedNextID = ScreenID()
    let path = [
      IdentifiedScreen(id: .root, content: root, hasAppeared: true),
      IdentifiedScreen(id: pathElementID, content: next, hasAppeared: true),
      IdentifiedScreen(id: pathElementID, content: next, hasAppeared: true)
    ]

    let sut = Navigator.Datasource(
      path: path,
      screenID: { expectedNextID }
    )
    sut.wrappedInNavigator().replace(path: [])

    XCTAssertEqual(
      sut.path,
      NavigationPathUpdate(previous: [], current: path)
    )
  }

  func test_replace_path_with_exact_same_path() {
    let pathElementID = ScreenID()
    let expectedNextID = ScreenID()
    let previousPath = [
      IdentifiedScreen(id: .root, content: root, hasAppeared: true),
      IdentifiedScreen(id: pathElementID, content: next, hasAppeared: true),
      IdentifiedScreen(id: pathElementID, content: next, hasAppeared: true)
    ]

    let sut = Navigator.Datasource(
      path: previousPath,
      screenID: { expectedNextID }
    )

    let newPath = [
      root.eraseToAnyScreen(),
      next,
      next
    ]

    sut.wrappedInNavigator().replace(path: newPath)

    XCTAssertEqual(
      sut.path,
      NavigationPathUpdate(
        previous: [],
        current: [
          IdentifiedScreen(
            id: .root,
            content: root,
            hasAppeared: true
          ),
          IdentifiedScreen(
            id: pathElementID,
            content: next,
            hasAppeared: true
          ),
          IdentifiedScreen(
            id: pathElementID,
            content: next,
            hasAppeared: true
          )
        ]
      )
    )
  }

  func test_replace_path_same_path_appending_elements() {
    let pathElementID = ScreenID()
    let expectedNextID = ScreenID()

    let previousPath = [
      IdentifiedScreen(id: .root, content: root, hasAppeared: true),
      IdentifiedScreen(id: pathElementID, content: next, hasAppeared: true),
      IdentifiedScreen(id: pathElementID, content: next, hasAppeared: true)
    ]

    let sut = Navigator.Datasource(
      path: previousPath,
      screenID: { expectedNextID }
    )

    let newPath = [
      root.eraseToAnyScreen(),
      next,
      other,
      next
    ]

    sut.wrappedInNavigator().replace(path: newPath)

    XCTAssertEqual(
      sut.path,
      NavigationPathUpdate(
        previous: previousPath,
        current: [
          IdentifiedScreen(
            id: .root,
            content: root,
            hasAppeared: true
          ),
          IdentifiedScreen(
            id: pathElementID,
            content: next,
            hasAppeared: false
          ),
          IdentifiedScreen(
            id: expectedNextID,
            content: other,
            hasAppeared: false
          ),
          IdentifiedScreen(
            id: expectedNextID,
            content: next,
            hasAppeared: false
          )
        ]
      )
    )
  }

  // MARK: - dismiss(id:)
  func test_dismiss_root_id_doesNothing() {
    let path = [
      IdentifiedScreen(id: .root, content: root, hasAppeared: false)
    ]

    let sut = Navigator.Datasource(
      path: path,
      screenID: { fatalError("unimplemented") }
    )

    sut.wrappedInNavigator().dismiss(id: .root)

    XCTAssertEqual(
      sut.path,
      NavigationPathUpdate(
        previous: [],
        current: path
      )
    )
  }

  func test_dismiss_root_screen_doesNothing() {
    let path =  [
      IdentifiedScreen(id: .root, content: root, hasAppeared: false)
    ]

    let sut = Navigator.Datasource(
      path: path,
      screenID: { fatalError("unimplemented") }
    )

    sut.wrappedInNavigator().dismiss(screen: root.eraseToAnyScreen())

    XCTAssertEqual(
      sut.path,
      NavigationPathUpdate(
        previous: [],
        current: path
      )
    )
  }

  func test_dismiss_existing_id() {
    let first = ScreenID()
    let second = ScreenID()

    let previousPath = [
      IdentifiedScreen(id: .root, content: root, hasAppeared: false),
      IdentifiedScreen(id: first, content: next, hasAppeared: false),
      IdentifiedScreen(id: second, content: root, hasAppeared: false)
    ]

    let sut = Navigator.Datasource(
      path: previousPath,
      screenID: { fatalError("unimplemented") }
    )

    sut.wrappedInNavigator().dismiss(id: second)

    XCTAssertEqual(
      sut.path,
      NavigationPathUpdate(
        previous: previousPath,
        current: [
          IdentifiedScreen(id: .root, content: self.root, hasAppeared: false),
          IdentifiedScreen(id: first, content: self.next, hasAppeared: false)
        ]
      )
    )
  }

  func test_dismiss_existing_screen() {
    let first = ScreenID()
    let second = ScreenID()
    let previousPath = [
      IdentifiedScreen(id: .root, content: root, hasAppeared: false),
      IdentifiedScreen(id: first, content: next, hasAppeared: false),
      IdentifiedScreen(id: second, content: root, hasAppeared: false)
    ]

    let sut = Navigator.Datasource(
      path: previousPath,
      screenID: { fatalError("unimplemented") }
    )

    sut.wrappedInNavigator().dismiss(screen: root.eraseToAnyScreen())

    XCTAssertEqual(
      sut.path,
      NavigationPathUpdate(
        previous: previousPath,
        current: [
          IdentifiedScreen(id: .root, content: self.root, hasAppeared: false),
          IdentifiedScreen(id: first, content: self.next, hasAppeared: false)
        ]
      )
    )
  }

  func test_dismiss_non_existing_id() {
    let first = ScreenID()
    let second = ScreenID()
    let third = ScreenID()
    let path = [
      IdentifiedScreen(id: .root, content: root, hasAppeared: false),
      IdentifiedScreen(id: first, content: next, hasAppeared: false),
      IdentifiedScreen(id: second, content: root, hasAppeared: false)
    ]

    let sut = Navigator.Datasource(
      path: path,
      screenID: { fatalError("unimplemented") }
    )

    sut.wrappedInNavigator().dismiss(id: third)

    XCTAssertEqual(
      sut.path,
      NavigationPathUpdate(
        previous: [],
        current: path
      )
    )
  }

  func test_dismiss_non_existing_screen() {
    let first = ScreenID()
    let second = ScreenID()
    let path = [
      IdentifiedScreen(id: .root, content: root, hasAppeared: false),
      IdentifiedScreen(id: first, content: next, hasAppeared: false),
      IdentifiedScreen(id: second, content: root, hasAppeared: false)
    ]

    let sut = Navigator.Datasource(
      path: path,
      screenID: { fatalError("unimplemented") }
    )

    sut.wrappedInNavigator().dismiss(
      screen: TestScreen(identifier: "non-existent", presentationStyle: .push).eraseToAnyScreen()
    )

    XCTAssertEqual(
      sut.path,
      NavigationPathUpdate(
        previous: [],
        current: path
      )
    )
  }

  // MARK: - dismissSuccessor(of:)
  func test_dismissSuccessor_of_id() {
    let first = ScreenID()
    let second = ScreenID()
    let previousPath = [
      IdentifiedScreen(id: .root, content: root, hasAppeared: false),
      IdentifiedScreen(id: first, content: next, hasAppeared: false),
      IdentifiedScreen(id: second, content: root, hasAppeared: false)
    ]

    let sut = Navigator.Datasource(
      path: previousPath,
      screenID: { fatalError("unimplemented") }
    )

    sut.wrappedInNavigator().dismissSuccessor(of: first)

    XCTAssertEqual(
      sut.path,
      NavigationPathUpdate(
        previous: previousPath,
        current: [
          IdentifiedScreen(id: .root, content: self.root, hasAppeared: false),
          IdentifiedScreen(id: first, content: self.next, hasAppeared: false)
        ]
      )
    )
  }

  func test_dismissSuccessor_of_screen() {
    let first = ScreenID()
    let second = ScreenID()
    let previousPath = [
      IdentifiedScreen(id: .root, content: root, hasAppeared: false),
      IdentifiedScreen(id: first, content: next, hasAppeared: false),
      IdentifiedScreen(id: second, content: root, hasAppeared: false)
    ]

    let sut = Navigator.Datasource(
      path: previousPath,
      screenID: { fatalError("unimplemented") }
    )

    sut.wrappedInNavigator().dismissSuccessor(of: next)

    XCTAssertEqual(
      sut.path,
      NavigationPathUpdate(
        previous: previousPath,
        current: [
          IdentifiedScreen(id: .root, content: self.root, hasAppeared: false),
          IdentifiedScreen(id: first, content: self.next, hasAppeared: false)
        ]
      )
    )
  }

  func test_dismissSuccessor_of_non_existing_id() {
    let first = ScreenID()
    let second = ScreenID()
    let third = ScreenID()
    let path = [
      IdentifiedScreen(id: .root, content: root, hasAppeared: false),
      IdentifiedScreen(id: first, content: next, hasAppeared: false),
      IdentifiedScreen(id: second, content: root, hasAppeared: false)
    ]

    let sut = Navigator.Datasource(
      path: path,
      screenID: { fatalError("unimplemented") }
    )

    sut.wrappedInNavigator().dismissSuccessor(of: third)

    XCTAssertEqual(
      sut.path,
      NavigationPathUpdate(
        previous: [],
        current: path
      )
    )
  }

  func test_dismissSuccessor_of_non_existing_screen() {
    let first = ScreenID()
    let second = ScreenID()
    let path = [
      IdentifiedScreen(id: .root, content: root, hasAppeared: false),
      IdentifiedScreen(id: first, content: next, hasAppeared: false),
      IdentifiedScreen(id: second, content: root, hasAppeared: false)
    ]

    let sut = Navigator.Datasource(
      path: path,
      screenID: { fatalError("unimplemented") }
    )

    sut.wrappedInNavigator().dismissSuccessor(
      of: TestScreen(identifier: "non-existent", presentationStyle: .push).eraseToAnyScreen()
    )

    XCTAssertEqual(
      sut.path,
      NavigationPathUpdate(
        previous: [],
        current: path
      )
    )
  }

  func test_dismissSuccessor_of_last() {
    let first = ScreenID()
    let second = ScreenID()
    let path = [
      IdentifiedScreen(id: .root, content: root, hasAppeared: false),
      IdentifiedScreen(id: first, content: next, hasAppeared: false),
      IdentifiedScreen(id: second, content: root, hasAppeared: false)
    ]

    let sut = Navigator.Datasource(
      path: path,
      screenID: { fatalError("unimplemented") }
    )

    sut.wrappedInNavigator().dismissSuccessor(of: second)

    XCTAssertEqual(
      sut.path,
      NavigationPathUpdate(
        previous: [],
        current: path
      )
    )
  }

  // MARK: - replaceContent(of:, with:)
  func test_replaceContent_of_existent_id_with_newContent() {
    let first = ScreenID()
    let second = ScreenID()
    let previousPath = [
      IdentifiedScreen(id: .root, content: root, hasAppeared: false),
      IdentifiedScreen(id: first, content: next, hasAppeared: false),
      IdentifiedScreen(id: second, content: root, hasAppeared: false)
    ]

    let expectedContent = TestScreen(
      identifier: "newContent",
      presentationStyle: .push
    ).eraseToAnyScreen()

    let expectedPath = [
      IdentifiedScreen(id: .root, content: expectedContent, hasAppeared: false),
      IdentifiedScreen(id: first, content: next, hasAppeared: false),
      IdentifiedScreen(id: second, content: root, hasAppeared: false)
    ]

    let sut = Navigator.Datasource(
      path: previousPath,
      screenID: { fatalError("unimplemented") }
    )

    sut.wrappedInNavigator().replaceContent(of: .root, with: expectedContent)

    XCTAssertEqual(
      sut.path,
      NavigationPathUpdate(
        previous: previousPath,
        current: expectedPath
      )
    )
  }

  func test_replaceContent_of_non_existent_screen_with_newContent() {
    let first = ScreenID()
    let second = ScreenID()
    let third = ScreenID()

    let expectedContent = TestScreen(
      identifier: "newContent",
      presentationStyle: .push
    ).eraseToAnyScreen()

    let expectedPath = [
      IdentifiedScreen(id: .root, content: root, hasAppeared: false),
      IdentifiedScreen(id: first, content: next, hasAppeared: false),
      IdentifiedScreen(id: second, content: root, hasAppeared: false)
    ]

    let sut = Navigator.Datasource(
      path: expectedPath,
      screenID: { fatalError("unimplemented") }
    )

    sut.wrappedInNavigator().replaceContent(of: third, with: expectedContent)

    XCTAssertEqual(
      sut.path,
      NavigationPathUpdate(
        previous: [],
        current: expectedPath
      )
    )
  }

  // MARK: - replace(screen:, with:)
  func test_replace_existent_screen_with_newContent() {
    let first = ScreenID()
    let second = ScreenID()
    let previousPath = [
      IdentifiedScreen(id: .root, content: root, hasAppeared: false),
      IdentifiedScreen(id: first, content: next, hasAppeared: false),
      IdentifiedScreen(id: second, content: root, hasAppeared: false)
    ]

    let expectedContent = TestScreen(
      identifier: "newContent",
      presentationStyle: .push
    ).eraseToAnyScreen()

    let expectedPath = [
      IdentifiedScreen(id: .root, content: root, hasAppeared: false),
      IdentifiedScreen(id: first, content: next, hasAppeared: false),
      IdentifiedScreen(id: second, content: expectedContent, hasAppeared: false)
    ]

    let sut = Navigator.Datasource(
      path: previousPath,
      screenID: { fatalError("unimplemented") }
    )

    sut.wrappedInNavigator().replace(screen: root.eraseToAnyScreen(), with: expectedContent)

    XCTAssertEqual(
      sut.path,
      NavigationPathUpdate(
        previous: previousPath,
        current: expectedPath
      )
    )
  }

  func test_replace_non_existent_screen_with_newContent() {
    let first = ScreenID()
    let second = ScreenID()
    let nonExistent = TestScreen(
      identifier: "non-existent",
      presentationStyle: .push
    ).eraseToAnyScreen()

    let expectedContent = TestScreen(
      identifier: "newContent",
      presentationStyle: .push
    ).eraseToAnyScreen()

    let expectedPath = [
      IdentifiedScreen(id: .root, content: root, hasAppeared: false),
      IdentifiedScreen(id: first, content: next, hasAppeared: false),
      IdentifiedScreen(id: second, content: root, hasAppeared: false)
    ]

    let sut = Navigator.Datasource(
      path: expectedPath,
      screenID: { fatalError("unimplemented") }
    )

    sut.wrappedInNavigator().replace(screen: nonExistent, with: expectedContent)
    
    XCTAssertEqual(
      sut.path,
      NavigationPathUpdate(
        previous: [],
        current: expectedPath
      )
    )
  }
  
  // MARK: - didAppear(id:)
  func test_didAppear() {
    let first = ScreenID()
    let second = ScreenID()
    let previousPath = [
      IdentifiedScreen(id: .root, content: root, hasAppeared: false),
      IdentifiedScreen(id: first, content: next, hasAppeared: false),
      IdentifiedScreen(id: second, content: root, hasAppeared: false)
    ]

    let sut = Navigator.Datasource(
      path: previousPath,
      screenID: { fatalError("unimplemented") }
    )
    
    sut.wrappedInNavigator().didAppear(id: second)

    XCTAssertEqual(
      sut.path,
      NavigationPathUpdate(
        previous: previousPath,
        current: [
          IdentifiedScreen(id: .root, content: root, hasAppeared: false),
          IdentifiedScreen(id: first, content: next, hasAppeared: false),
          IdentifiedScreen(id: second, content: root, hasAppeared: true)
        ]
      )
    )
  }
}

private extension Navigator.Datasource {
  func wrappedInNavigator() -> Navigator {
    Navigator(dataSource: self)
  }
}
