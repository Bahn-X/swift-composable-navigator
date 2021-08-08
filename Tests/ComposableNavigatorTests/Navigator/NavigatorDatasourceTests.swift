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

  struct Tab: Activatable {
    let identifier: String

    static let active = Tab(identifier: "active")
    static let inactive = Tab(identifier: "inactive")
  }

  // MARK: - Path
  func test_navigator_path_exposes_current_path() {
    let sut = Navigator.Datasource(
      root: root,
      screenID: { fatalError() }
    )

    XCTAssertEqual(sut.navigationTree, sut.wrappedInNavigator().navigationTree())
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
      sut.navigationTree,
      NavigationTreeUpdate(
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

  func test_go_to_screen_on_tab() {
    let tabbedID = ScreenID()
    let expectedNextID = ScreenID()

    let firstTabID = ScreenID()
    let firstTab = TestScreen(identifier: "firstTab", presentationStyle: .push)

    let tabScreen = TabScreen(
      id: tabbedID,
      activeTab: TabScreen.Tab(
        id: Tab.active,
        path: [
          .screen(
            IdentifiedScreen(
              id: firstTabID,
              content: firstTab,
              hasAppeared: false
            )
          )
        ]
      ),
      inactiveTabs: [],
      presentationStyle: .push,
      hasAppeared: false
    )

    let previousPath: ActiveNavigationTree = [
      .screen(
        IdentifiedScreen(
          id: .root,
          content: root,
          hasAppeared: false
        )
      ),
      .tabbed(
        tabScreen
      )
    ]

    let sut = Navigator.Datasource(
      navigationTree: previousPath,
      screenID: { expectedNextID }
    )

    sut.wrappedInNavigator().go(to: next, on: tabbedID, forceNavigation: false)

    XCTAssertEqual(
      sut.navigationTree,
      NavigationTreeUpdate(
        previous: previousPath,
        current: [
          .screen(
            IdentifiedScreen(id: .root, content: self.root, hasAppeared: false)
          ),
          .tabbed(tabScreen),
          .screen(
            IdentifiedScreen(id: expectedNextID, content: self.next, hasAppeared: false)
          )
        ]
      )
    )
  }

  func test_go_to_screen_in_active_tab() {
    let tabbedID = ScreenID()
    let expectedNextID = ScreenID()

    let firstTabID = ScreenID()
    let firstTab = TestScreen(identifier: "firstTab", presentationStyle: .push)

    let previousPath: ActiveNavigationTree = [
      .screen(
        IdentifiedScreen(
          id: .root,
          content: root,
          hasAppeared: false
        )
      ),
      .tabbed(
        TabScreen(
          id: tabbedID,
          activeTab: TabScreen.Tab(
            id: Tab.active,
            path: [
              .screen(
                IdentifiedScreen(
                  id: firstTabID,
                  content: firstTab,
                  hasAppeared: false
                )
              )
            ]
          ),
          inactiveTabs: [],
          presentationStyle: .push,
          hasAppeared: false
        )
      )
    ]

    let sut = Navigator.Datasource(
      navigationTree: previousPath,
      screenID: { expectedNextID }
    )

    sut.wrappedInNavigator().go(to: next, on: firstTabID, forceNavigation: false)

    XCTAssertEqual(
      sut.navigationTree,
      NavigationTreeUpdate(
        previous: previousPath,
        current: [
          .screen(
            IdentifiedScreen(id: .root, content: self.root, hasAppeared: false)
          ),
          .tabbed(
            TabScreen(
              id: tabbedID,
              activeTab: TabScreen.Tab(
                id: Tab.active,
                path: [
                  .screen(
                    IdentifiedScreen(
                      id: firstTabID,
                      content: firstTab,
                      hasAppeared: false
                    )
                  ),
                  .screen(
                    IdentifiedScreen(
                      id: expectedNextID,
                      content: next,
                      hasAppeared: false
                    )
                  )
                ]
              ),
              inactiveTabs: [],
              presentationStyle: .push,
              hasAppeared: false
            )
          ),
        ]
      )
    )
  }

  func test_go_to_screen_in_inactive_tab() {
    let tabbedID = ScreenID()
    let expectedNextID = ScreenID()

    let activeTabID = ScreenID()
    let activeTab = TestScreen(identifier: "activeTab", presentationStyle: .push)

    let inactiveTabID = ScreenID()
    let inactiveTab = TestScreen(identifier: "inactiveTab", presentationStyle: .push)

    let previousPath: ActiveNavigationTree = [
      .screen(
        IdentifiedScreen(
          id: .root,
          content: root,
          hasAppeared: false
        )
      ),
      .tabbed(
        TabScreen(
          id: tabbedID,
          activeTab: TabScreen.Tab(
            id: Tab.active,
            path: [
              .screen(
                IdentifiedScreen(
                  id: activeTabID,
                  content: activeTab,
                  hasAppeared: false
                )
              )
            ]
          ),
          inactiveTabs: [
            TabScreen.Tab(
              id: Tab.inactive,
              path: [
                .screen(
                  IdentifiedScreen(
                    id: inactiveTabID,
                    content: inactiveTab,
                    hasAppeared: false
                  )
                )
              ]
            )
          ],
          presentationStyle: .push,
          hasAppeared: false
        )
      )
    ]

    let sut = Navigator.Datasource(
      navigationTree: previousPath,
      screenID: { expectedNextID }
    )

    sut.wrappedInNavigator().go(to: next, on: inactiveTabID, forceNavigation: false)

    XCTAssertEqual(
      sut.navigationTree,
      NavigationTreeUpdate(
        previous: previousPath,
        current: [
          .screen(
            IdentifiedScreen(id: .root, content: self.root, hasAppeared: false)
          ),
          .tabbed(
            TabScreen(
              id: tabbedID,
              activeTab: TabScreen.Tab(
                id: Tab.active,
                path: [
                  .screen(
                    IdentifiedScreen(
                      id: activeTabID,
                      content: activeTab,
                      hasAppeared: false
                    )
                  )
                ]
              ),
              inactiveTabs: [
                TabScreen.Tab(
                  id: Tab.inactive,
                  path: [
                    .screen(
                      IdentifiedScreen(
                        id: inactiveTabID,
                        content: inactiveTab,
                        hasAppeared: false
                      )
                    ),
                    .screen(
                      IdentifiedScreen(
                        id: expectedNextID,
                        content: next,
                        hasAppeared: false
                      )
                    )
                  ]
                )
              ],
              presentationStyle: .push,
              hasAppeared: false
            )
          ),
        ]
      )
    )
  }

  func test_go_to_screen_in_inactive_tab_forcing_navigation() {
    let tabbedID = ScreenID()
    let expectedNextID = ScreenID()

    let activeTabID = ScreenID()
    let activeTab = TestScreen(identifier: "activeTab", presentationStyle: .push)

    let inactiveTabID = ScreenID()
    let inactiveTab = TestScreen(identifier: "inactiveTab", presentationStyle: .push)

    let previousPath: ActiveNavigationTree = [
      .screen(
        IdentifiedScreen(
          id: .root,
          content: root,
          hasAppeared: false
        )
      ),
      .tabbed(
        TabScreen(
          id: tabbedID,
          activeTab: TabScreen.Tab(
            id: Tab.active,
            path: [
              .screen(
                IdentifiedScreen(
                  id: activeTabID,
                  content: activeTab,
                  hasAppeared: false
                )
              )
            ]
          ),
          inactiveTabs: [
            TabScreen.Tab(
              id: Tab.inactive,
              path: [
                .screen(
                  IdentifiedScreen(
                    id: inactiveTabID,
                    content: inactiveTab,
                    hasAppeared: false
                  )
                )
              ]
            )
          ],
          presentationStyle: .push,
          hasAppeared: false
        )
      ),
      .screen(
        IdentifiedScreen(
          id: ScreenID(),
          content: root,
          hasAppeared: false
        )
      )
    ]

    let sut = Navigator.Datasource(
      navigationTree: previousPath,
      screenID: { expectedNextID }
    )

    sut.wrappedInNavigator().go(to: next, on: inactiveTabID, forceNavigation: true)

    XCTAssertEqual(
      sut.navigationTree,
      NavigationTreeUpdate(
        previous: previousPath,
        current: [
          .screen(
            IdentifiedScreen(id: .root, content: self.root, hasAppeared: false)
          ),
          .tabbed(
            TabScreen(
              id: tabbedID,
              activeTab: TabScreen.Tab(
                id: Tab.inactive,
                path: [
                  .screen(
                    IdentifiedScreen(
                      id: inactiveTabID,
                      content: inactiveTab,
                      hasAppeared: false
                    )
                  ),
                  .screen(
                    IdentifiedScreen(
                      id: expectedNextID,
                      content: next,
                      hasAppeared: false
                    )
                  )
                ]
              ),
              inactiveTabs: [
                TabScreen.Tab(
                  id: Tab.active,
                  path: [
                    .screen(
                      IdentifiedScreen(
                        id: activeTabID,
                        content: activeTab,
                        hasAppeared: false
                      )
                    )
                  ]
                )
              ],
              presentationStyle: .push,
              hasAppeared: false
            )
          )
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
      sut.navigationTree,
      NavigationTreeUpdate(
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
    ].map(ActiveNavigationPathElement.screen)

    sut.wrappedInNavigator().go(to: appendedPath, on: .root)

    XCTAssertEqual(
      sut.navigationTree,
      NavigationTreeUpdate(
        previous: previousPath,
        current: [
          IdentifiedScreen(
            id: .root,
            content: root,
            hasAppeared: false
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
    ].map(ActiveNavigationPathElement.screen)

    sut.wrappedInNavigator().go(to: appendedPath, on: root.eraseToAnyScreen())

    XCTAssertEqual(
      sut.navigationTree,
      NavigationTreeUpdate(
        previous: previousPath,
        current: [
          IdentifiedScreen(
            id: .root,
            content: root,
            hasAppeared: false
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

  func test_goTo_path_in_tabbed_in_active_tab() {
    let newID = ScreenID()
    let tabID = ScreenID()

    let activeTabID = ScreenID()
    let inactiveTabID = ScreenID()

    let activeTabContent = TestScreen(identifier: "activeTabContent", presentationStyle: .push)
    let inactiveTabContent = TestScreen(identifier: "inactiveTabContent", presentationStyle: .push)

    let previousPath: ActiveNavigationTree = [
      .screen(
        IdentifiedScreen(
          id: .root,
          content: root,
          hasAppeared: true
        )
      ),
      .tabbed(
        TabScreen(
          id: tabID,
          activeTab: TabScreen.Tab(
            id: Tab.active,
            path: [
              .screen(
                IdentifiedScreen(
                  id: activeTabID,
                  content: activeTabContent,
                  hasAppeared: true
                )
              )
            ]
          ),
          inactiveTabs: [
            TabScreen.Tab(
              id: Tab.inactive,
              path: [
                .screen(
                  IdentifiedScreen(
                    id: inactiveTabID,
                    content: inactiveTabContent,
                    hasAppeared: true
                  )
                )
              ]
            )
          ],
          presentationStyle: .push,
          hasAppeared: true
        )
      )
    ]

    let sut = Navigator.Datasource(
      navigationTree: previousPath,
      screenID: { newID }
    )

    let newScreen = TestScreen(identifier: "newScreen", presentationStyle: .push)

    let newPath: ActiveNavigationPath = [
      .screen(newScreen.eraseToAnyScreen())
    ]

    sut.wrappedInNavigator().go(
      to: newPath,
      on: activeTabID
    )

    XCTAssertEqual(
      sut.navigationTree,
      NavigationTreeUpdate(
        previous: previousPath,
        current: [
          .screen(
            IdentifiedScreen(
              id: .root,
              content: root,
              hasAppeared: true
            )
          ),
          .tabbed(
            TabScreen(
              id: tabID,
              activeTab: TabScreen.Tab(
                id: Tab.active,
                path: [
                  .screen(
                    IdentifiedScreen(
                      id: activeTabID,
                      content: activeTabContent,
                      hasAppeared: true
                    )
                  ),
                  .screen(
                    IdentifiedScreen(
                      id: newID,
                      content: newScreen,
                      hasAppeared: false
                    )
                  )
                ]
              ),
              inactiveTabs: [
                TabScreen.Tab(
                  id: Tab.inactive,
                  path: [
                    .screen(
                      IdentifiedScreen(
                        id: inactiveTabID,
                        content: inactiveTabContent,
                        hasAppeared: true
                      )
                    )
                  ]
                )
              ],
              presentationStyle: .push,
              hasAppeared: true
            )
          )
        ]
      )
    )
  }

  func test_goTo_path_in_tabbed_switching_tabs() {
    let newID = ScreenID()
    let tabID = ScreenID()

    let activeTabID = ScreenID()
    let inactiveTabID = ScreenID()

    let activeTabContent = TestScreen(identifier: "activeTabContent", presentationStyle: .push)
    let inactiveTabContent = TestScreen(identifier: "inactiveTabContent", presentationStyle: .push)

    let previousPath: ActiveNavigationTree = [
      .screen(
        IdentifiedScreen(
          id: .root,
          content: root,
          hasAppeared: true
        )
      ),
      .tabbed(
        TabScreen(
          id: tabID,
          activeTab: TabScreen.Tab(
            id: Tab.active,
            path: [
              .screen(
                IdentifiedScreen(
                  id: activeTabID,
                  content: activeTabContent,
                  hasAppeared: true
                )
              )
            ]
          ),
          inactiveTabs: [
            TabScreen.Tab(
              id: Tab.inactive,
              path: [
                .screen(
                  IdentifiedScreen(
                    id: inactiveTabID,
                    content: inactiveTabContent,
                    hasAppeared: true
                  )
                )
              ]
            )
          ],
          presentationStyle: .push,
          hasAppeared: true
        )
      )
    ]

    let sut = Navigator.Datasource(
      navigationTree: previousPath,
      screenID: { newID }
    )

    let newScreen = TestScreen(identifier: "newScreen", presentationStyle: .push)

    let newPath: ActiveNavigationPath = [
      .screen(newScreen.eraseToAnyScreen())
    ]

    sut.wrappedInNavigator().go(
      to: newPath,
      on: inactiveTabContent.eraseToAnyScreen()
    )

    XCTAssertEqual(
      sut.navigationTree,
      NavigationTreeUpdate(
        previous: previousPath,
        current: [
          .screen(
            IdentifiedScreen(
              id: .root,
              content: root,
              hasAppeared: true
            )
          ),
          .tabbed(
            TabScreen(
              id: tabID,
              activeTab: TabScreen.Tab(
                id: Tab.inactive,
                path: [
                  .screen(
                    IdentifiedScreen(
                      id: inactiveTabID,
                      content: inactiveTabContent,
                      hasAppeared: true
                    )
                  ),
                  .screen(
                    IdentifiedScreen(
                      id: newID,
                      content: newScreen,
                      hasAppeared: false
                    )
                  )
                ]
              ),
              inactiveTabs: [
                TabScreen.Tab(
                  id: Tab.active,
                  path: [
                    .screen(
                      IdentifiedScreen(
                        id: activeTabID,
                        content: activeTabContent,
                        hasAppeared: true
                      )
                    )
                  ]
                )
              ],
              presentationStyle: .push,
              hasAppeared: true
            )
          )
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
      next.eraseToAnyScreen(),
      TestScreen(identifier: "newDetail", presentationStyle: .push).eraseToAnyScreen(),
    ].map(ActiveNavigationPathElement.screen)

    sut.wrappedInNavigator().go(to: appendedPath, on: .root)

    XCTAssertEqual(
      sut.navigationTree,
      NavigationTreeUpdate(
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
    ].map(ActiveNavigationPathElement.screen)

    sut.wrappedInNavigator().go(to: appendedPath, on: self.root.eraseToAnyScreen())

    XCTAssertEqual(
      sut.navigationTree,
      NavigationTreeUpdate(
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
    ].map(ActiveNavigationPathElement.screen)

    sut.wrappedInNavigator().go(to: appendedPath, on: .root)

    XCTAssertEqual(
      sut.navigationTree,
      NavigationTreeUpdate(
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
    ].map(ActiveNavigationPathElement.screen)

    sut.wrappedInNavigator().go(to: appendedPath, on: self.root.eraseToAnyScreen())

    XCTAssertEqual(
      sut.navigationTree,
      NavigationTreeUpdate(
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
      sut.navigationTree,
      NavigationTreeUpdate(
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
      sut.navigationTree,
      NavigationTreeUpdate(
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
      sut.navigationTree,
      NavigationTreeUpdate(
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
      sut.navigationTree,
      NavigationTreeUpdate(
        previous: [],
        current: path
      )
    )
  }

  // MARK: - replace(path:)
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
    ].map(ActiveNavigationPathElement.screen)

    sut.wrappedInNavigator().replace(path: newPath)

    XCTAssertEqual(
      sut.navigationTree,
      NavigationTreeUpdate(
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

    sut.wrappedInNavigator().replace(
      path: [next, next, next]
        .map(ActiveNavigationPathElement.screen)
    )

    XCTAssertEqual(
      sut.navigationTree,
      NavigationTreeUpdate(
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
      sut.navigationTree,
      NavigationTreeUpdate(previous: [], current: path)
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
    ].map(ActiveNavigationPathElement.screen)

    sut.wrappedInNavigator().replace(path: newPath)

    XCTAssertEqual(
      sut.navigationTree,
      NavigationTreeUpdate(
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
    ].map(ActiveNavigationPathElement.screen)

    sut.wrappedInNavigator().replace(path: newPath)

    XCTAssertEqual(
      sut.navigationTree,
      NavigationTreeUpdate(
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

  func test_replace_path_in_tabbed_in_active_tab() {
    let newID = ScreenID()
    let tabID = ScreenID()

    let activeTabID = ScreenID()
    let inactiveTabID = ScreenID()

    let activeTabContent = TestScreen(identifier: "activeTabContent", presentationStyle: .push)
    let inactiveTabContent = TestScreen(identifier: "inactiveTabContent", presentationStyle: .push)

    let previousPath: ActiveNavigationTree = [
      .screen(
        IdentifiedScreen(
          id: .root,
          content: root,
          hasAppeared: true
        )
      ),
      .tabbed(
        TabScreen(
          id: tabID,
          activeTab: TabScreen.Tab(
            id: Tab.active,
            path: [
              .screen(
                IdentifiedScreen(
                  id: activeTabID,
                  content: activeTabContent,
                  hasAppeared: true
                )
              )
            ]
          ),
          inactiveTabs: [
            TabScreen.Tab(
              id: Tab.inactive,
              path: [
                .screen(
                  IdentifiedScreen(
                    id: inactiveTabID,
                    content: inactiveTabContent,
                    hasAppeared: true
                  )
                )
              ]
            )
          ],
          presentationStyle: .push,
          hasAppeared: true
        )
      )
    ]

    let sut = Navigator.Datasource(
      navigationTree: previousPath,
      screenID: { newID }
    )

    let newScreen = TestScreen(identifier: "newScreen", presentationStyle: .push)

    let newPath: ActiveNavigationPath = [
      .screen(root.eraseToAnyScreen()),
      .tabbed(
        .init(
          active: Tab.active,
          path: [
            .screen(activeTabContent.eraseToAnyScreen()),
            .screen(newScreen.eraseToAnyScreen())
          ]
        )
      )
    ]

    sut.wrappedInNavigator().replace(path: newPath)

    XCTAssertEqual(
      sut.navigationTree,
      NavigationTreeUpdate(
        previous: previousPath,
        current: [
          .screen(
            IdentifiedScreen(
              id: .root,
              content: root,
              hasAppeared: true
            )
          ),
          .tabbed(
            TabScreen(
              id: tabID,
              activeTab: TabScreen.Tab(
                id: Tab.active,
                path: [
                  .screen(
                    IdentifiedScreen(
                      id: activeTabID,
                      content: activeTabContent,
                      hasAppeared: true
                    )
                  ),
                  .screen(
                    IdentifiedScreen(
                      id: newID,
                      content: newScreen,
                      hasAppeared: false
                    )
                  )
                ]
              ),
              inactiveTabs: [
                TabScreen.Tab(
                  id: Tab.inactive,
                  path: [
                    .screen(
                      IdentifiedScreen(
                        id: inactiveTabID,
                        content: inactiveTabContent,
                        hasAppeared: true
                      )
                    )
                  ]
                )
              ],
              presentationStyle: .push,
              hasAppeared: true
            )
          )
        ]
      )
    )
  }

  func test_replace_path_in_tabbed_switching_tabs() {
    let newID = ScreenID()
    let tabID = ScreenID()

    let activeTabID = ScreenID()
    let inactiveTabID = ScreenID()

    let activeTabContent = TestScreen(identifier: "activeTabContent", presentationStyle: .push)
    let inactiveTabContent = TestScreen(identifier: "inactiveTabContent", presentationStyle: .push)

    let previousPath: ActiveNavigationTree = [
      .screen(
        IdentifiedScreen(
          id: .root,
          content: root,
          hasAppeared: true
        )
      ),
      .tabbed(
        TabScreen(
          id: tabID,
          activeTab: TabScreen.Tab(
            id: Tab.active,
            path: [
              .screen(
                IdentifiedScreen(
                  id: activeTabID,
                  content: activeTabContent,
                  hasAppeared: true
                )
              )
            ]
          ),
          inactiveTabs: [
            TabScreen.Tab(
              id: Tab.inactive,
              path: [
                .screen(
                  IdentifiedScreen(
                    id: inactiveTabID,
                    content: inactiveTabContent,
                    hasAppeared: true
                  )
                )
              ]
            )
          ],
          presentationStyle: .push,
          hasAppeared: true
        )
      )
    ]

    let sut = Navigator.Datasource(
      navigationTree: previousPath,
      screenID: { newID }
    )

    let newScreen = TestScreen(identifier: "newScreen", presentationStyle: .push)

    let newPath: ActiveNavigationPath = [
      .screen(root.eraseToAnyScreen()),
      .tabbed(
        .init(
          active: Tab.inactive,
          path: [
            .screen(inactiveTabContent.eraseToAnyScreen()),
            .screen(newScreen.eraseToAnyScreen())
          ]
        )
      )
    ]

    sut.wrappedInNavigator().replace(path: newPath)

    XCTAssertEqual(
      sut.navigationTree,
      NavigationTreeUpdate(
        previous: previousPath,
        current: [
          .screen(
            IdentifiedScreen(
              id: .root,
              content: root,
              hasAppeared: true
            )
          ),
          .tabbed(
            TabScreen(
              id: tabID,
              activeTab: TabScreen.Tab(
                id: Tab.inactive,
                path: [
                  .screen(
                    IdentifiedScreen(
                      id: inactiveTabID,
                      content: inactiveTabContent,
                      hasAppeared: true
                    )
                  ),
                  .screen(
                    IdentifiedScreen(
                      id: newID,
                      content: newScreen,
                      hasAppeared: false
                    )
                  )
                ]
              ),
              inactiveTabs: [
                TabScreen.Tab(
                  id: Tab.active,
                  path: [
                    .screen(
                      IdentifiedScreen(
                        id: activeTabID,
                        content: activeTabContent,
                        hasAppeared: true
                      )
                    )
                  ]
                )
              ],
              presentationStyle: .push,
              hasAppeared: true
            )
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
      sut.navigationTree,
      NavigationTreeUpdate(
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
      sut.navigationTree,
      NavigationTreeUpdate(
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
      sut.navigationTree,
      NavigationTreeUpdate(
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
      sut.navigationTree,
      NavigationTreeUpdate(
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
      sut.navigationTree,
      NavigationTreeUpdate(
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
      sut.navigationTree,
      NavigationTreeUpdate(
        previous: [],
        current: path
      )
    )
  }

  func test_dismiss_tabbed_tab_id() {
    let tabID = ScreenID()

    let first = ScreenID()
    let second = ScreenID()

    let path: ActiveNavigationTree = [
      .screen(IdentifiedScreen(id: .root, content: root, hasAppeared: false)),
      .tabbed(
        TabScreen(
          id: tabID,
          activeTab: TabScreen.Tab(
            id: Tab.active,
            path: [
              .screen(IdentifiedScreen(id: first, content: root, hasAppeared: false)),
              .screen(IdentifiedScreen(id: second, content: root, hasAppeared: false))
            ]
          ),
          inactiveTabs: [],
          presentationStyle: .push,
          hasAppeared: false
        )
      )
    ]

    let sut = Navigator.Datasource(
      navigationTree: path,
      screenID: { fatalError("unimplemented") }
    )

    sut.wrappedInNavigator().dismiss(id: tabID)

    XCTAssertEqual(
      sut.navigationTree,
      NavigationTreeUpdate(
        previous: path,
        current: [.screen(IdentifiedScreen(id: .root, content: root, hasAppeared: false))]
      )
    )
  }

  func test_dismiss_tabbed_active_tab_first() {
    let tabID = ScreenID()

    let first = ScreenID()
    let second = ScreenID()

    let path: ActiveNavigationTree = [
      .screen(IdentifiedScreen(id: .root, content: root, hasAppeared: false)),
      .tabbed(
        TabScreen(
          id: tabID,
          activeTab: TabScreen.Tab(
            id: Tab.active,
            path: [
              .screen(IdentifiedScreen(id: first, content: root, hasAppeared: false)),
              .screen(IdentifiedScreen(id: second, content: root, hasAppeared: false))
            ]
          ),
          inactiveTabs: [],
          presentationStyle: .push,
          hasAppeared: false
        )
      )
    ]

    let sut = Navigator.Datasource(
      navigationTree: path,
      screenID: { fatalError("unimplemented") }
    )

    sut.wrappedInNavigator().dismiss(id: first)

    XCTAssertEqual(
      sut.navigationTree,
      NavigationTreeUpdate(
        previous: path,
        current: [.screen(IdentifiedScreen(id: .root, content: root, hasAppeared: false))]
      )
    )
  }

  func test_dismiss_tabbed_active_tab_tail() {
    let tabID = ScreenID()
    let first = ScreenID()
    let second = ScreenID()

    let path: ActiveNavigationTree = [
      .screen(IdentifiedScreen(id: .root, content: root, hasAppeared: false)),
      .tabbed(
        TabScreen(
          id: tabID,
          activeTab: TabScreen.Tab(
            id: Tab.active,
            path: [
              .screen(IdentifiedScreen(id: first, content: root, hasAppeared: false)),
              .screen(IdentifiedScreen(id: second, content: root, hasAppeared: false))
            ]
          ),
          inactiveTabs: [],
          presentationStyle: .push,
          hasAppeared: false
        )
      )
    ]

    let sut = Navigator.Datasource(
      navigationTree: path,
      screenID: { fatalError("unimplemented") }
    )

    sut.wrappedInNavigator().dismiss(id: second)

    XCTAssertEqual(
      sut.navigationTree,
      NavigationTreeUpdate(
        previous: path,
        current: [
          .screen(IdentifiedScreen(id: .root, content: root, hasAppeared: false)),
          .tabbed(
            TabScreen(
              id: tabID,
              activeTab: TabScreen.Tab(
                id: Tab.active,
                path: [
                  .screen(IdentifiedScreen(id: first, content: root, hasAppeared: false))
                ]
              ),
              inactiveTabs: [],
              presentationStyle: .push,
              hasAppeared: false
            )
          )
        ]
      )
    )
  }

  func test_dismiss_tabbed_inactive_tab_tail() {
    let tabID = ScreenID()

    let first = ScreenID()
    let second = ScreenID()
    let third = ScreenID()
    let fourth = ScreenID()

    let path: ActiveNavigationTree = [
      .screen(IdentifiedScreen(id: .root, content: root, hasAppeared: false)),
      .tabbed(
        TabScreen(
          id: tabID,
          activeTab: TabScreen.Tab(
            id: Tab.active,
            path: [
              .screen(IdentifiedScreen(id: first, content: root, hasAppeared: false)),
              .screen(IdentifiedScreen(id: second, content: root, hasAppeared: false))
            ]
          ),
          inactiveTabs: [
            TabScreen.Tab(
              id: Tab.inactive,
              path: [
                .screen(IdentifiedScreen(id: third, content: root, hasAppeared: false)),
                .screen(IdentifiedScreen(id: fourth, content: root, hasAppeared: false))
              ]
            )
          ],
          presentationStyle: .push,
          hasAppeared: false
        )
      )
    ]

    let sut = Navigator.Datasource(
      navigationTree: path,
      screenID: { fatalError("unimplemented") }
    )

    sut.wrappedInNavigator().dismiss(id: fourth)

    XCTAssertEqual(
      sut.navigationTree,
      NavigationTreeUpdate(
        previous: path,
        current: [
          .screen(IdentifiedScreen(id: .root, content: root, hasAppeared: false)),
          .tabbed(
            TabScreen(
              id: tabID,
              activeTab: TabScreen.Tab(
                id: Tab.active,
                path: [
                  .screen(IdentifiedScreen(id: first, content: root, hasAppeared: false)),
                  .screen(IdentifiedScreen(id: second, content: root, hasAppeared: false))
                ]
              ),
              inactiveTabs: [
                TabScreen.Tab(
                  id: Tab.inactive,
                  path: [
                    .screen(IdentifiedScreen(id: third, content: root, hasAppeared: false))
                  ]
                )
              ],
              presentationStyle: .push,
              hasAppeared: false
            )
          )
        ]
      )
    )
  }

  func test_dismiss_tabbed_inactive_tab_head() {
    let tabID = ScreenID()

    let first = ScreenID()
    let second = ScreenID()
    let third = ScreenID()
    let fourth = ScreenID()

    let path: ActiveNavigationTree = [
      .screen(IdentifiedScreen(id: .root, content: root, hasAppeared: false)),
      .tabbed(
        TabScreen(
          id: tabID,
          activeTab: TabScreen.Tab(
            id: Tab.active,
            path: [
              .screen(IdentifiedScreen(id: first, content: root, hasAppeared: false)),
              .screen(IdentifiedScreen(id: second, content: root, hasAppeared: false))
            ]
          ),
          inactiveTabs: [
            TabScreen.Tab(
              id: Tab.inactive,
              path: [
                .screen(IdentifiedScreen(id: third, content: root, hasAppeared: false)),
                .screen(IdentifiedScreen(id: fourth, content: root, hasAppeared: false))
              ]
            )
          ],
          presentationStyle: .push,
          hasAppeared: false
        )
      )
    ]

    let sut = Navigator.Datasource(
      navigationTree: path,
      screenID: { fatalError("unimplemented") }
    )

    sut.wrappedInNavigator().dismiss(id: third)

    XCTAssertEqual(
      sut.navigationTree,
      NavigationTreeUpdate(
        previous: path,
        current: [
          .screen(IdentifiedScreen(id: .root, content: root, hasAppeared: false))
        ]
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
      sut.navigationTree,
      NavigationTreeUpdate(
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
      sut.navigationTree,
      NavigationTreeUpdate(
        previous: previousPath,
        current: [
          IdentifiedScreen(id: .root, content: self.root, hasAppeared: false),
          IdentifiedScreen(id: first, content: self.next, hasAppeared: false)
        ]
      )
    )
  }

  func test_dismissSuccessor_of_tabbed_tabID() {
    let first = ScreenID()
    let second = ScreenID()

    let tabbed = TabScreen(
      id: first,
      activeTab: TabScreen.Tab(
        id: Tab.active,
        path: []
      ),
      inactiveTabs: [],
      presentationStyle: .push,
      hasAppeared: false
    )

    let previousPath: ActiveNavigationTree = [
      .screen(
        IdentifiedScreen(
          id: .root,
          content: root,
          hasAppeared: false
        )
      ),
      .tabbed(tabbed),
      .screen(
        IdentifiedScreen(
          id: second,
          content: root,
          hasAppeared: false
        )
      )
    ]

    let sut = Navigator.Datasource(
      navigationTree: previousPath,
      screenID: { fatalError("unimplemented") }
    )

    sut.wrappedInNavigator().dismissSuccessor(of: first)

    XCTAssertEqual(
      sut.navigationTree,
      NavigationTreeUpdate(
        previous: previousPath,
        current: [
          .screen(
            IdentifiedScreen(id: .root, content: self.root, hasAppeared: false)
          ),
          .tabbed(tabbed)
        ]
      )
    )
  }

  func test_dismissSuccessor_of_in_tabbed_path() {
    let first = ScreenID()
    let second = ScreenID()

    let pathID = ScreenID()

    let previousPath: ActiveNavigationTree = [
      .screen(
        IdentifiedScreen(
          id: .root,
          content: root,
          hasAppeared: false
        )
      ),
      .tabbed(
        TabScreen(
          id: first,
          activeTab: TabScreen.Tab(
            id: Tab.active,
            path: [
              .screen(
                IdentifiedScreen(id: pathID, content: root, hasAppeared: false)
              ),
              .screen(
                IdentifiedScreen(id: second, content: root, hasAppeared: false)
              )
            ]
          ),
          inactiveTabs: [
            TabScreen.Tab(
              id: Tab.inactive,
              path: [
                .screen(
                  IdentifiedScreen(id: pathID, content: root, hasAppeared: false)
                ),
                .screen(
                  IdentifiedScreen(id: second, content: root, hasAppeared: false)
                )
              ]
            )
          ],
          presentationStyle: .push,
          hasAppeared: false
        )
      ),
      .screen(
        IdentifiedScreen(
          id: second,
          content: root,
          hasAppeared: false
        )
      )
    ]

    let sut = Navigator.Datasource(
      navigationTree: previousPath,
      screenID: { fatalError("unimplemented") }
    )

    sut.wrappedInNavigator().dismissSuccessor(of: pathID)

    XCTAssertEqual(
      sut.navigationTree,
      NavigationTreeUpdate(
        previous: previousPath,
        current: [
          .screen(
            IdentifiedScreen(
              id: .root,
              content: self.root,
              hasAppeared: false
            )
          ),
          .tabbed(
            TabScreen(
              id: first,
              activeTab: TabScreen.Tab(
                id: Tab.active,
                path: [
                  .screen(
                    IdentifiedScreen(id: pathID, content: root, hasAppeared: false)
                  )
                ]
              ),
              inactiveTabs: [
                TabScreen.Tab(
                  id: Tab.inactive,
                  path: [
                    .screen(
                      IdentifiedScreen(id: pathID, content: root, hasAppeared: false)
                    )
                  ]
                )
              ],
              presentationStyle: .push,
              hasAppeared: false
            )
          ),
          .screen(
            IdentifiedScreen(
              id: second,
              content: root,
              hasAppeared: false
            )
          )
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
      sut.navigationTree,
      NavigationTreeUpdate(
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
      sut.navigationTree,
      NavigationTreeUpdate(
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
      sut.navigationTree,
      NavigationTreeUpdate(
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
      sut.navigationTree,
      NavigationTreeUpdate(
        previous: previousPath,
        current: expectedPath
      )
    )
  }

  func test_replaceContent_of_tab_root() {
    let previousPath: ActiveNavigationTree = [
      .tabbed(
        TabScreen(
          id: .root,
          activeTab: TabScreen.Tab(
            id: Tab.active,
            path: []
          ),
          inactiveTabs: [],
          presentationStyle: .push,
          hasAppeared: false
        )
      )
    ]

    let expectedContent = TestScreen(
      identifier: "newContent",
      presentationStyle: .push
    ).eraseToAnyScreen()

    let expectedPath: ActiveNavigationTree = [
      .screen(
        IdentifiedScreen(
          id: .root,
          content: expectedContent,
          hasAppeared: false
        )
      )
    ]

    let sut = Navigator.Datasource(
      navigationTree: previousPath,
      screenID: { fatalError("unimplemented") }
    )

    sut.wrappedInNavigator().replaceContent(of: .root, with: expectedContent)

    XCTAssertEqual(
      sut.navigationTree,
      NavigationTreeUpdate(
        previous: previousPath,
        current: expectedPath
      )
    )
  }

  func test_replaceContent_in_tabbed_path() {
    let pathID = ScreenID()

    let previousPath: ActiveNavigationTree = [
      .tabbed(
        TabScreen(
          id: .root,
          activeTab: TabScreen.Tab(
            id: Tab.active,
            path: [
              .screen(
                IdentifiedScreen(
                  id: pathID,
                  content: next,
                  hasAppeared: false
                )
              )
            ]
          ),
          inactiveTabs: [
            TabScreen.Tab(
              id: Tab.inactive,
              path: [
                .screen(
                  IdentifiedScreen(
                    id: pathID,
                    content: next,
                    hasAppeared: false
                  )
                )
              ]
            )
          ],
          presentationStyle: .push,
          hasAppeared: false
        )
      )
    ]

    let expectedContent = TestScreen(
      identifier: "newContent",
      presentationStyle: .push
    ).eraseToAnyScreen()

    let expectedPath: ActiveNavigationTree = [
      .tabbed(
        TabScreen(
          id: .root,
          activeTab: TabScreen.Tab(
            id: Tab.active,
            path: [
              .screen(
                IdentifiedScreen(
                  id: pathID,
                  content: expectedContent,
                  hasAppeared: false
                )
              )
            ]
          ),
          inactiveTabs: [
            TabScreen.Tab(
              id: Tab.inactive,
              path: [
                .screen(
                  IdentifiedScreen(
                    id: pathID,
                    content: expectedContent,
                    hasAppeared: false
                  )
                )
              ]
            )
          ],
          presentationStyle: .push,
          hasAppeared: false
        )
      )
    ]

    let sut = Navigator.Datasource(
      navigationTree: previousPath,
      screenID: { fatalError("unimplemented") }
    )

    sut.wrappedInNavigator().replaceContent(of: pathID, with: expectedContent)

    XCTAssertEqual(
      sut.navigationTree,
      NavigationTreeUpdate(
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
      sut.navigationTree,
      NavigationTreeUpdate(
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
      sut.navigationTree,
      NavigationTreeUpdate(
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
      sut.navigationTree,
      NavigationTreeUpdate(
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
      sut.navigationTree,
      NavigationTreeUpdate(
        previous: previousPath,
        current: [
          IdentifiedScreen(id: .root, content: root, hasAppeared: false),
          IdentifiedScreen(id: first, content: next, hasAppeared: false),
          IdentifiedScreen(id: second, content: root, hasAppeared: true)
        ]
      )
    )
  }

  func test_didAppear_tabbed_root() {
    let first = ScreenID()
    let second = ScreenID()
    let tabRoot = ScreenID()

    let previousPath: ActiveNavigationTree = [
      .screen(IdentifiedScreen(id: .root, content: root, hasAppeared: false)),
      .screen(IdentifiedScreen(id: first, content: next, hasAppeared: false)),
      .tabbed(
        TabScreen(
          id: tabRoot,
          activeTab: TabScreen.Tab(
            id: Tab.active,
            path: [
              .screen(
                IdentifiedScreen(
                  id: second,
                  content: root,
                  hasAppeared: false
                )
              )
            ]
          ),
          inactiveTabs: [],
          presentationStyle: .push,
          hasAppeared: false
        )
      ),
    ]

    let sut = Navigator.Datasource(
      navigationTree: previousPath,
      screenID: { fatalError("unimplemented") }
    )

    sut.wrappedInNavigator().didAppear(id: tabRoot)

    XCTAssertEqual(
      sut.navigationTree,
      NavigationTreeUpdate(
        previous: previousPath,
        current: [
          .screen(IdentifiedScreen(id: .root, content: root, hasAppeared: false)),
          .screen(IdentifiedScreen(id: first, content: next, hasAppeared: false)),
          .tabbed(
            TabScreen(
              id: tabRoot,
              activeTab: TabScreen.Tab(
                id: Tab.active,
                path: [
                  .screen(
                    IdentifiedScreen(
                      id: second,
                      content: root,
                      hasAppeared: false
                    )
                  )
                ]
              ),
              inactiveTabs: [],
              presentationStyle: .push,
              hasAppeared: true
            )
          ),
        ]
      )
    )
  }

  func test_didAppear_tabbed_in_paths() {
    let first = ScreenID()
    let second = ScreenID()
    let third = ScreenID()
    let tabRoot = ScreenID()

    let previousPath: ActiveNavigationTree = [
      .screen(IdentifiedScreen(id: .root, content: root, hasAppeared: false)),
      .screen(IdentifiedScreen(id: first, content: next, hasAppeared: false)),
      .tabbed(
        TabScreen(
          id: tabRoot,
          activeTab: TabScreen.Tab(
            id: Tab.active,
            path: [
              .screen(
                IdentifiedScreen(
                  id: second,
                  content: root,
                  hasAppeared: false
                )
              ),
              .screen(
                IdentifiedScreen(
                  id: third,
                  content: next,
                  hasAppeared: false
                )
              )
            ]
          ),
          inactiveTabs: [
            TabScreen.Tab(
              id: Tab.inactive,
              path: [
                .screen(
                  IdentifiedScreen(
                    id: second,
                    content: root,
                    hasAppeared: false
                  )
                ),
                .screen(
                  IdentifiedScreen(
                    id: third,
                    content: next,
                    hasAppeared: false
                  )
                )
              ]
            )
          ],
          presentationStyle: .push,
          hasAppeared: false
        )
      ),
    ]

    let sut = Navigator.Datasource(
      navigationTree: previousPath,
      screenID: { fatalError("unimplemented") }
    )

    sut.wrappedInNavigator().didAppear(id: third)

    XCTAssertEqual(
      sut.navigationTree,
      NavigationTreeUpdate(
        previous: previousPath,
        current: [
          .screen(IdentifiedScreen(id: .root, content: root, hasAppeared: false)),
          .screen(IdentifiedScreen(id: first, content: next, hasAppeared: false)),
          .tabbed(
            TabScreen(
              id: tabRoot,
              activeTab: TabScreen.Tab(
                id: Tab.active,
                path: [
                  .screen(
                    IdentifiedScreen(
                      id: second,
                      content: root,
                      hasAppeared: false
                    )
                  ),
                  .screen(
                    IdentifiedScreen(
                      id: third,
                      content: next,
                      hasAppeared: true
                    )
                  )
                ]
              ),
              inactiveTabs: [
                TabScreen.Tab(
                  id: Tab.inactive,
                  path: [
                    .screen(
                      IdentifiedScreen(
                        id: second,
                        content: root,
                        hasAppeared: false
                      )
                    ),
                    .screen(
                      IdentifiedScreen(
                        id: third,
                        content: next,
                        hasAppeared: true
                      )
                    )
                  ]
                )
              ],
              presentationStyle: .push,
              hasAppeared: false
            )
          )
        ]
      )
    )
  }

  // MARK: - setActive(id:)
  func test_setActive_on_screen_does_nothing() {
    let first = ScreenID()

    let previousPath: ActiveNavigationTree = [
      .screen(IdentifiedScreen(id: first, content: root, hasAppeared: false)),
    ]

    let sut = Navigator.Datasource(
      navigationTree: previousPath,
      screenID: { fatalError("unimplemented") }
    )

    sut.wrappedInNavigator().activate(Tab.active)

    XCTAssertEqual(
      sut.navigationTree,
      NavigationTreeUpdate(
        previous: [],
        current: previousPath
      )
    )
  }

  func test_setActive_on_tabbed_keeps_active_tab_active() {
    let first = ScreenID()
    let second = ScreenID()
    let tabbedID = ScreenID()

    let previousPath: ActiveNavigationTree = [
      .tabbed(
        TabScreen(
          id: tabbedID,
          activeTab: TabScreen.Tab(
            id: Tab.active,
            path: [
              .screen(
                IdentifiedScreen(
                  id: first,
                  content: root,
                  hasAppeared: false
                )
              )
            ]
          ),
          inactiveTabs: [
            TabScreen.Tab(
              id: Tab.inactive,
              path: [
                .screen(
                  IdentifiedScreen(
                    id: second,
                    content: root,
                    hasAppeared: false
                  )
                )
              ]
            )
          ],
          presentationStyle: .push,
          hasAppeared: false
        )
      )
    ]

    let sut = Navigator.Datasource(
      navigationTree: previousPath,
      screenID: { fatalError("unimplemented") }
    )

    sut.wrappedInNavigator().activate(Tab.active)

    XCTAssertEqual(
      sut.navigationTree,
      NavigationTreeUpdate(
        previous: [],
        current: previousPath
      )
    )
  }

  func test_setActive_on_tabbed_activates_inactive_tab() {
    let first = ScreenID()
    let second = ScreenID()
    let tabbedID = ScreenID()

    let previousPath: ActiveNavigationTree = [
      .tabbed(
        TabScreen(
          id: tabbedID,
          activeTab: TabScreen.Tab(
            id: Tab.active,
            path: [
              .screen(
                IdentifiedScreen(
                  id: first,
                  content: root,
                  hasAppeared: false
                )
              )
            ]
          ),
          inactiveTabs: [
            TabScreen.Tab(
              id: Tab.inactive,
              path: [
                .screen(
                  IdentifiedScreen(
                    id: second,
                    content: root,
                    hasAppeared: false
                  )
                )
              ]
            )
          ],
          presentationStyle: .push,
          hasAppeared: false
        )
      )
    ]

    let sut = Navigator.Datasource(
      navigationTree: previousPath,
      screenID: { fatalError("unimplemented") }
    )

    sut.wrappedInNavigator().activate(Tab.inactive)

    XCTAssertEqual(
      sut.navigationTree,
      NavigationTreeUpdate(
        previous: previousPath,
        current: [
          .tabbed(
            TabScreen(
              id: tabbedID,
              activeTab:
                TabScreen.Tab(
                  id: Tab.inactive,
                  path: [
                    .screen(
                      IdentifiedScreen(
                        id: second,
                        content: root,
                        hasAppeared: false
                      )
                    )
                  ]
                ),
              inactiveTabs: [
                TabScreen.Tab(
                  id: Tab.active,
                  path: [
                    .screen(
                      IdentifiedScreen(
                        id: first,
                        content: root,
                        hasAppeared: false
                      )
                    )
                  ]
                )
              ],
              presentationStyle: .push,
              hasAppeared: false
            )
          )
        ]
      )
    )
  }

  // MARK: - Initialise Default Contents
  func test_initialise_default_contents_of_tabbed() {
    let first = ScreenID()
    let tabbedID = ScreenID()
    let expectedNewID = ScreenID()

    let previousPath: ActiveNavigationTree = [
      .tabbed(
        TabScreen(
          id: tabbedID,
          activeTab: TabScreen.Tab(
            id: Tab.active,
            path: [
              .screen(
                IdentifiedScreen(
                  id: first,
                  content: root,
                  hasAppeared: false
                )
              )
            ]
          ),
          inactiveTabs: [],
          presentationStyle: .push,
          hasAppeared: false
        )
      )
    ]

    let sut = Navigator.Datasource(
      navigationTree: previousPath,
      screenID: { expectedNewID }
    )

    sut.initializeDefaultContents(
      for: tabbedID,
      contents: [
        DefaultTabContent(
          tag: Tab.inactive.eraseToAnyActivatable(),
          content: .screen(root.eraseToAnyScreen())
        )
      ]
    )

    XCTAssertEqual(
      sut.navigationTree,
      NavigationTreeUpdate(
        previous: previousPath,
        current: [
          .tabbed(
            TabScreen(
              id: tabbedID,
              activeTab: TabScreen.Tab(
                id: Tab.active,
                path: [
                  .screen(
                    IdentifiedScreen(
                      id: first,
                      content: root,
                      hasAppeared: false
                    )
                  )
                ]
              ),
              inactiveTabs: [
                TabScreen.Tab(
                  id: Tab.inactive,
                  path: [
                    .screen(
                      IdentifiedScreen(
                        id: expectedNewID,
                        content: root,
                        hasAppeared: false
                      )
                    )
                  ]
                )
              ],
              presentationStyle: .push,
              hasAppeared: false
            )
          )
        ]
      )
    )
  }

  func test_initialise_default_contents_of_tabbed_ignores_present_tabs() {
    let first = ScreenID()
    let second = ScreenID()
    let tabbedID = ScreenID()
    let unexpectedNewID = ScreenID()

    let previousPath: ActiveNavigationTree = [
      .tabbed(
        TabScreen(
          id: tabbedID,
          activeTab: TabScreen.Tab(
            id: Tab.active,
            path: [
              .screen(
                IdentifiedScreen(
                  id: first,
                  content: root,
                  hasAppeared: false
                )
              )
            ]
          ),
          inactiveTabs: [
            TabScreen.Tab(
              id: Tab.inactive,
              path: [
                .screen(
                  IdentifiedScreen(
                    id: second,
                    content: root,
                    hasAppeared: false
                  )
                )
              ]
            )
          ],
          presentationStyle: .push,
          hasAppeared: false
        )
      )
    ]

    let sut = Navigator.Datasource(
      navigationTree: previousPath,
      screenID: { unexpectedNewID }
    )

    sut.initializeDefaultContents(
      for: tabbedID,
      contents: [
        DefaultTabContent(
          tag: Tab.active.eraseToAnyActivatable(),
          content: .screen(root.eraseToAnyScreen())
        ),
        DefaultTabContent(
          tag: Tab.inactive.eraseToAnyActivatable(),
          content: .screen(root.eraseToAnyScreen())
        )
      ]
    )

    XCTAssertEqual(
      sut.navigationTree,
      NavigationTreeUpdate(
        previous: [],
        current: previousPath
      )
    )
  }
}

private extension Navigator.Datasource {
  func wrappedInNavigator() -> Navigator {
    Navigator(dataSource: self)
  }
}
