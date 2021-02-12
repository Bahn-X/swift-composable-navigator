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

  // MARK: - go(to screen:, on:)
  func test_go_to() {
    let expectedNextID = ScreenID()

    let sut = Navigator.Datasource(
      root: root,
      screenID: { expectedNextID }
    )

    sut.go(to: next, on: .root)

    XCTAssertEqual(
      sut.path,
      [
        IdentifiedScreen(id: .root, content: self.root, hasAppeared: false),
        IdentifiedScreen(id: expectedNextID, content: self.next, hasAppeared: false)
      ]
    )
  }

  func test_go_to_on_screen() {
    let expectedNextID = ScreenID()

    let sut = Navigator.Datasource(
      root: root,
      screenID: { expectedNextID }
    )

    sut.go(to: next, on: self.root.eraseToAnyScreen())

    XCTAssertEqual(
      sut.path,
      [
        IdentifiedScreen(id: .root, content: self.root, hasAppeared: false),
        IdentifiedScreen(id: expectedNextID, content: self.next, hasAppeared: false)
      ]
    )
  }

  // MARK: - go(to newPath:)
  func test_goTo_path_no_matching_elements() {
    let expectedNextID = ScreenID()
    let newID = ScreenID()

    let sut = Navigator.Datasource(
      path: [
        IdentifiedScreen(id: .root, content: root, hasAppeared: true),
        IdentifiedScreen(id: expectedNextID, content: next, hasAppeared: true)
      ],
      screenID: { newID }
    )

    let first = TestScreen(identifier: "first", presentationStyle: .push)
    let second = TestScreen(identifier: "second", presentationStyle: .push)


    let appendedPath = [
      first.eraseToAnyScreen(),
      second.eraseToAnyScreen()
    ]

    sut.go(to: appendedPath, on: .root)

    XCTAssertEqual(
      sut.path,
      [
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
  }

  func test_goTo_path_no_matching_elements_on_screen() {
    let expectedNextID = ScreenID()
    let newID = ScreenID()

    let sut = Navigator.Datasource(
      path: [
        IdentifiedScreen(id: .root, content: root, hasAppeared: true),
        IdentifiedScreen(id: expectedNextID, content: next, hasAppeared: true)
      ],
      screenID: { newID }
    )

    let first = TestScreen(identifier: "first", presentationStyle: .push)
    let second = TestScreen(identifier: "second", presentationStyle: .push)


    let appendedPath = [
      first.eraseToAnyScreen(),
      second.eraseToAnyScreen()
    ]

    sut.go(to: appendedPath, on: self.root.eraseToAnyScreen())

    XCTAssertEqual(
      sut.path,
      [
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
  }

  func test_goTo_path_appending_partially_matching_path_elements() {
    let expectedNextID = ScreenID()
    let newID = ScreenID()

    let sut = Navigator.Datasource(
      path: [
        IdentifiedScreen(id: .root, content: root, hasAppeared: true),
        IdentifiedScreen(id: expectedNextID, content: next, hasAppeared: true),
        IdentifiedScreen(id: expectedNextID, content: next, hasAppeared: true)
      ],
      screenID: { newID }
    )


    let appendedPath = [
      TestScreen(identifier: "next", presentationStyle: .push).eraseToAnyScreen(),
      TestScreen(identifier: "newDetail", presentationStyle: .push).eraseToAnyScreen(),
    ]

    sut.go(to: appendedPath, on: .root)

    XCTAssertEqual(
      sut.path,
      [
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
  }

  func test_goTo_path_appending_partially_matching_path_elements_on_screen() {
    let expectedNextID = ScreenID()
    let newID = ScreenID()

    let sut = Navigator.Datasource(
      path: [
        IdentifiedScreen(id: .root, content: root, hasAppeared: true),
        IdentifiedScreen(id: expectedNextID, content: next, hasAppeared: true),
        IdentifiedScreen(id: expectedNextID, content: next, hasAppeared: true)
      ],
      screenID: { newID }
    )


    let appendedPath = [
      TestScreen(identifier: "next", presentationStyle: .push).eraseToAnyScreen(),
      TestScreen(identifier: "newDetail", presentationStyle: .push).eraseToAnyScreen(),
    ]

    sut.go(to: appendedPath, on: self.root.eraseToAnyScreen())

    XCTAssertEqual(
      sut.path,
      [
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
  }

  func test_goTo_path_appending_current_path_elements() {
    let expectedNextID = ScreenID()
    let newID = ScreenID()

    let sut = Navigator.Datasource(
      path: [
        IdentifiedScreen(id: .root, content: root, hasAppeared: true),
        IdentifiedScreen(id: expectedNextID, content: next, hasAppeared: true)
      ],
      screenID: { newID }
    )


    let appendedPath = [
      TestScreen(identifier: "next", presentationStyle: .push).eraseToAnyScreen()
    ]

    sut.go(to: appendedPath, on: .root)

    XCTAssertEqual(
      sut.path,
      [
        IdentifiedScreen(
          id: .root,
          content: root,
          hasAppeared: true
        ),
        IdentifiedScreen(
          id: expectedNextID,
          content: next,
          hasAppeared: true
        )
      ]
    )
  }

  func test_goTo_path_appending_current_path_elements_on_screen() {
    let expectedNextID = ScreenID()
    let newID = ScreenID()

    let sut = Navigator.Datasource(
      path: [
        IdentifiedScreen(id: .root, content: root, hasAppeared: true),
        IdentifiedScreen(id: expectedNextID, content: next, hasAppeared: true)
      ],
      screenID: { newID }
    )


    let appendedPath = [
      TestScreen(identifier: "next", presentationStyle: .push).eraseToAnyScreen()
    ]

    sut.go(to: appendedPath, on: self.root.eraseToAnyScreen())

    XCTAssertEqual(
      sut.path,
      [
        IdentifiedScreen(
          id: .root,
          content: root,
          hasAppeared: true
        ),
        IdentifiedScreen(
          id: expectedNextID,
          content: next,
          hasAppeared: true
        )
      ]
    )
  }

  // MARK: - goBack(to predecessor:)
  func test_goBack_to_existing_id() {
    let expectedNextID = ScreenID()

    let sut = Navigator.Datasource(
      path: [
        IdentifiedScreen(id: .root, content: root, hasAppeared: false),
        IdentifiedScreen(id: expectedNextID, content: next, hasAppeared: false)
      ],
      screenID: { fatalError("unimplemented") }
    )

    sut.goBack(to: root.eraseToAnyScreen())

    XCTAssertEqual(
      sut.path,
      [
        IdentifiedScreen(id: .root, content: self.root, hasAppeared: false)
      ]
    )
  }

  func test_goBack_to_existing_screen() {
    let expectedNextID = ScreenID()

    let sut = Navigator.Datasource(
      path: [
        IdentifiedScreen(id: .root, content: root, hasAppeared: false),
        IdentifiedScreen(id: expectedNextID, content: next, hasAppeared: false)
      ],
      screenID: { fatalError("unimplemented") }
    )

    sut.goBack(to: .root)

    XCTAssertEqual(
      sut.path,
      [
        IdentifiedScreen(id: .root, content: self.root, hasAppeared: false)
      ]
    )
  }

  func test_goBack_to_non_existing_id() {
    let expectedNextID = ScreenID()

    let sut = Navigator.Datasource(
      path: [
        IdentifiedScreen(id: .root, content: root, hasAppeared: false),
        IdentifiedScreen(id: expectedNextID, content: next, hasAppeared: false)
      ],
      screenID: { fatalError("unimplemented") }
    )

    let nonExistent = TestScreen(identifier: "non-existent", presentationStyle: .push)

    sut.goBack(to: nonExistent.eraseToAnyScreen())

    XCTAssertEqual(
      sut.path,
      [
        IdentifiedScreen(id: .root, content: root, hasAppeared: false),
        IdentifiedScreen(id: expectedNextID, content: next, hasAppeared: false)
      ]
    )
  }

  func test_goBack_to_non_existing_screen() {
    let expectedNextID = ScreenID()

    let sut = Navigator.Datasource(
      path: [
        IdentifiedScreen(id: .root, content: root, hasAppeared: false),
        IdentifiedScreen(id: expectedNextID, content: next, hasAppeared: false)
      ],
      screenID: { fatalError("unimplemented") }
    )

    sut.goBack(to: ScreenID())

    XCTAssertEqual(
      sut.path,
      [
        IdentifiedScreen(id: .root, content: root, hasAppeared: false),
        IdentifiedScreen(id: expectedNextID, content: next, hasAppeared: false)
      ]
    )
  }

  // MARK: - replace(path: [AnyScreen])
  func test_replace_path() {
    let expectedNextID = ScreenID()
    let newID = ScreenID()

    let sut = Navigator.Datasource(
      path: [
        IdentifiedScreen(id: .root, content: root, hasAppeared: true),
        IdentifiedScreen(id: expectedNextID, content: next, hasAppeared: false)
      ],
      screenID: { newID }
    )


    let newPath = [
      TestScreen(identifier: "newRoot", presentationStyle: .push).eraseToAnyScreen(),
      TestScreen(identifier: "newDetail", presentationStyle: .push).eraseToAnyScreen(),
    ]

    sut.replace(path: newPath)

    XCTAssertEqual(
      sut.path,
      [
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
  }

  func test_replace_path_with_new_path() {
    let pathElementID = ScreenID()
    let expectedNextID = ScreenID()

    let sut = Navigator.Datasource(
      path: [
        IdentifiedScreen(id: .root, content: root, hasAppeared: true),
        IdentifiedScreen(id: pathElementID, content: next, hasAppeared: true),
        IdentifiedScreen(id: pathElementID, content: next, hasAppeared: true)
      ],
      screenID: { expectedNextID }
    )


    let newPath = [
      next,
      next,
      next
    ]

    sut.replace(path: newPath)

    XCTAssertEqual(
      sut.path,
      [
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
    sut.replace(path: [])

    XCTAssertEqual(sut.path, path)
  }

  func test_replace_path_with_exact_same_path() {
    let pathElementID = ScreenID()
    let expectedNextID = ScreenID()

    let sut = Navigator.Datasource(
      path: [
        IdentifiedScreen(id: .root, content: root, hasAppeared: true),
        IdentifiedScreen(id: pathElementID, content: next, hasAppeared: true),
        IdentifiedScreen(id: pathElementID, content: next, hasAppeared: true)
      ],
      screenID: { expectedNextID }
    )


    let newPath = [
      root.eraseToAnyScreen(),
      next,
      next
    ]

    sut.replace(path: newPath)

    XCTAssertEqual(
      sut.path,
      [
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
  }

  func test_replace_path_same_path_appending_elements() {
    let pathElementID = ScreenID()
    let expectedNextID = ScreenID()

    let sut = Navigator.Datasource(
      path: [
        IdentifiedScreen(id: .root, content: root, hasAppeared: true),
        IdentifiedScreen(id: pathElementID, content: next, hasAppeared: true),
        IdentifiedScreen(id: pathElementID, content: next, hasAppeared: true)
      ],
      screenID: { expectedNextID }
    )


    let newPath = [
      root.eraseToAnyScreen(),
      next,
      other,
      next
    ]

    sut.replace(path: newPath)

    XCTAssertEqual(
      sut.path,
      [
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
  }

  // MARK: - dismiss(id:)
  func test_dismiss_root_id_doesNothing() {
    let sut = Navigator.Datasource(
      path: [
        IdentifiedScreen(id: .root, content: root, hasAppeared: false)
      ],
      screenID: { fatalError("unimplemented") }
    )

    sut.dismiss(id: .root)

    XCTAssertEqual(
      sut.path,
      [
        IdentifiedScreen(id: .root, content: root, hasAppeared: false)
      ]
    )
  }

  func test_dismiss_root_screen_doesNothing() {
    let sut = Navigator.Datasource(
      path: [
        IdentifiedScreen(id: .root, content: root, hasAppeared: false)
      ],
      screenID: { fatalError("unimplemented") }
    )

    sut.dismiss(screen: root.eraseToAnyScreen())

    XCTAssertEqual(
      sut.path,
      [
        IdentifiedScreen(id: .root, content: root, hasAppeared: false)
      ]
    )
  }

  func test_dismiss_existing_id() {
    let first = ScreenID()
    let second = ScreenID()

    let sut = Navigator.Datasource(
      path: [
        IdentifiedScreen(id: .root, content: root, hasAppeared: false),
        IdentifiedScreen(id: first, content: next, hasAppeared: false),
        IdentifiedScreen(id: second, content: root, hasAppeared: false)
      ],
      screenID: { fatalError("unimplemented") }
    )

    sut.dismiss(id: second)

    XCTAssertEqual(
      sut.path,
      [
        IdentifiedScreen(id: .root, content: self.root, hasAppeared: false),
        IdentifiedScreen(id: first, content: self.next, hasAppeared: false)
      ]
    )
  }

  func test_dismiss_existing_screen() {
    let first = ScreenID()
    let second = ScreenID()

    let sut = Navigator.Datasource(
      path: [
        IdentifiedScreen(id: .root, content: root, hasAppeared: false),
        IdentifiedScreen(id: first, content: next, hasAppeared: false),
        IdentifiedScreen(id: second, content: root, hasAppeared: false)
      ],
      screenID: { fatalError("unimplemented") }
    )

    sut.dismiss(screen: root.eraseToAnyScreen())

    XCTAssertEqual(
      sut.path,
      [
        IdentifiedScreen(id: .root, content: self.root, hasAppeared: false),
        IdentifiedScreen(id: first, content: self.next, hasAppeared: false)
      ]
    )
  }

  func test_dismiss_non_existing_id() {
    let first = ScreenID()
    let second = ScreenID()
    let third = ScreenID()

    let sut = Navigator.Datasource(
      path: [
        IdentifiedScreen(id: .root, content: root, hasAppeared: false),
        IdentifiedScreen(id: first, content: next, hasAppeared: false),
        IdentifiedScreen(id: second, content: root, hasAppeared: false)
      ],
      screenID: { fatalError("unimplemented") }
    )

    sut.dismiss(id: third)

    XCTAssertEqual(
      sut.path,
      [
        IdentifiedScreen(id: .root, content: root, hasAppeared: false),
        IdentifiedScreen(id: first, content: next, hasAppeared: false),
        IdentifiedScreen(id: second, content: root, hasAppeared: false)
      ]
    )
  }

  func test_dismiss_non_existing_screen() {
    let first = ScreenID()
    let second = ScreenID()

    let sut = Navigator.Datasource(
      path: [
        IdentifiedScreen(id: .root, content: root, hasAppeared: false),
        IdentifiedScreen(id: first, content: next, hasAppeared: false),
        IdentifiedScreen(id: second, content: root, hasAppeared: false)
      ],
      screenID: { fatalError("unimplemented") }
    )

    sut.dismiss(
      screen: TestScreen(identifier: "non-existent", presentationStyle: .push).eraseToAnyScreen()
    )

    XCTAssertEqual(
      sut.path,
      [
        IdentifiedScreen(id: .root, content: root, hasAppeared: false),
        IdentifiedScreen(id: first, content: next, hasAppeared: false),
        IdentifiedScreen(id: second, content: root, hasAppeared: false)
      ]
    )
  }

  // MARK: - dismissSuccessor(of:)
  func test_dismissSuccessor_of_id() {
    let first = ScreenID()
    let second = ScreenID()

    let sut = Navigator.Datasource(
      path: [
        IdentifiedScreen(id: .root, content: root, hasAppeared: false),
        IdentifiedScreen(id: first, content: next, hasAppeared: false),
        IdentifiedScreen(id: second, content: root, hasAppeared: false)
      ],
      screenID: { fatalError("unimplemented") }
    )

    sut.dismissSuccessor(of: first)

    XCTAssertEqual(
      sut.path,
      [
        IdentifiedScreen(id: .root, content: self.root, hasAppeared: false),
        IdentifiedScreen(id: first, content: self.next, hasAppeared: false)
      ]
    )
  }

  func test_dismissSuccessor_of_screen() {
    let first = ScreenID()
    let second = ScreenID()

    let sut = Navigator.Datasource(
      path: [
        IdentifiedScreen(id: .root, content: root, hasAppeared: false),
        IdentifiedScreen(id: first, content: next, hasAppeared: false),
        IdentifiedScreen(id: second, content: root, hasAppeared: false)
      ],
      screenID: { fatalError("unimplemented") }
    )

    sut.dismissSuccessor(of: next)

    XCTAssertEqual(
      sut.path,
      [
        IdentifiedScreen(id: .root, content: self.root, hasAppeared: false),
        IdentifiedScreen(id: first, content: self.next, hasAppeared: false)
      ]
    )
  }

  func test_dismissSuccessor_of_non_existing_id() {
    let first = ScreenID()
    let second = ScreenID()
    let third = ScreenID()

    let sut = Navigator.Datasource(
      path: [
        IdentifiedScreen(id: .root, content: root, hasAppeared: false),
        IdentifiedScreen(id: first, content: next, hasAppeared: false),
        IdentifiedScreen(id: second, content: root, hasAppeared: false)
      ],
      screenID: { fatalError("unimplemented") }
    )

    sut.dismissSuccessor(of: third)

    XCTAssertEqual(
      sut.path, [
        IdentifiedScreen(id: .root, content: root, hasAppeared: false),
        IdentifiedScreen(id: first, content: next, hasAppeared: false),
        IdentifiedScreen(id: second, content: root, hasAppeared: false)
      ]
    )
  }

  func test_dismissSuccessor_of_non_existing_screen() {
    let first = ScreenID()
    let second = ScreenID()

    let sut = Navigator.Datasource(
      path: [
        IdentifiedScreen(id: .root, content: root, hasAppeared: false),
        IdentifiedScreen(id: first, content: next, hasAppeared: false),
        IdentifiedScreen(id: second, content: root, hasAppeared: false)
      ],
      screenID: { fatalError("unimplemented") }
    )

    sut.dismissSuccessor(
      of: TestScreen(identifier: "non-existent", presentationStyle: .push).eraseToAnyScreen()
    )

    XCTAssertEqual(
      sut.path, [
        IdentifiedScreen(id: .root, content: root, hasAppeared: false),
        IdentifiedScreen(id: first, content: next, hasAppeared: false),
        IdentifiedScreen(id: second, content: root, hasAppeared: false)
      ]
    )
  }

  func test_dismissSuccessor_of_last() {
    let first = ScreenID()
    let second = ScreenID()

    let sut = Navigator.Datasource(
      path: [
        IdentifiedScreen(id: .root, content: root, hasAppeared: false),
        IdentifiedScreen(id: first, content: next, hasAppeared: false),
        IdentifiedScreen(id: second, content: root, hasAppeared: false)
      ],
      screenID: { fatalError("unimplemented") }
    )

    sut.dismissSuccessor(of: second)

    XCTAssertEqual(
      sut.path,
      [
        IdentifiedScreen(id: .root, content: root, hasAppeared: false),
        IdentifiedScreen(id: first, content: next, hasAppeared: false),
        IdentifiedScreen(id: second, content: root, hasAppeared: false)
      ]
    )
  }

  // MARK: - replaceContent(of:, with:)
  func test_replaceContent_of_existent_id_with_newContent() {
    let first = ScreenID()
    let second = ScreenID()

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
      path: [
        IdentifiedScreen(id: .root, content: root, hasAppeared: false),
        IdentifiedScreen(id: first, content: next, hasAppeared: false),
        IdentifiedScreen(id: second, content: root, hasAppeared: false)
      ],
      screenID: { fatalError("unimplemented") }
    )

    sut.replaceContent(of: .root, with: expectedContent)

    XCTAssertEqual(
      sut.path,
      expectedPath
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

    sut.replaceContent(of: third, with: expectedContent)

    XCTAssertEqual(
      sut.path,
      expectedPath
    )
  }

  // MARK: - replace(screen:, with:)
  func test_replace_existent_screen_with_newContent() {
    let first = ScreenID()
    let second = ScreenID()

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
      path: [
        IdentifiedScreen(id: .root, content: root, hasAppeared: false),
        IdentifiedScreen(id: first, content: next, hasAppeared: false),
        IdentifiedScreen(id: second, content: root, hasAppeared: false)
      ],
      screenID: { fatalError("unimplemented") }
    )

    sut.replace(screen: root.eraseToAnyScreen(), with: expectedContent)

    XCTAssertEqual(
      sut.path,
      expectedPath
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

    sut.replace(screen: nonExistent, with: expectedContent)
    
    XCTAssertEqual(
      sut.path,
      expectedPath
    )
  }
  
  // MARK: - didAppear(id:)
  func test_didAppear() {
    let first = ScreenID()
    let second = ScreenID()

    let sut = Navigator.Datasource(
      path: [
        IdentifiedScreen(id: .root, content: root, hasAppeared: false),
        IdentifiedScreen(id: first, content: next, hasAppeared: false),
        IdentifiedScreen(id: second, content: root, hasAppeared: false)
      ],
      screenID: { fatalError("unimplemented") }
    )

    sut.didAppear(id: second)

    XCTAssertEqual(
      sut.path,
      [
        IdentifiedScreen(id: .root, content: root, hasAppeared: false),
        IdentifiedScreen(id: first, content: next, hasAppeared: false),
        IdentifiedScreen(id: second, content: root, hasAppeared: true)
      ]
    )
  }
}
