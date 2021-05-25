@testable import ComposableNavigator
import XCTest

final class NavigationPath_LastOccurrenceOf: XCTestCase {
  let content = TestScreen(identifier: "0", presentationStyle: .push)
  let otherContent = TestScreen(identifier: "other", presentationStyle: .push)
  let expectedID = ScreenID()
  let tabID = ScreenID()

  func test_lastOccurrence_rootLevel() {
    let expectedID = ScreenID()

    let path: NavigationPath = [
      .screen(IdentifiedScreen(id: .root, content: content, hasAppeared: false)),
      .tabbed(
        TabScreen(
          id: tabID,
          activeTab: TabScreen.Tab(
            head: .screen(
              IdentifiedScreen(id: ScreenID(), content: content, hasAppeared: false)
            ),
            tail: [
              .screen(
                IdentifiedScreen(id: ScreenID(), content: content, hasAppeared: false)
              )
            ]
          ),
          inactiveTabs: [
            TabScreen.Tab(
              head: .screen(
                IdentifiedScreen(id: ScreenID(), content: content, hasAppeared: false)
              ),
              tail: [
                .screen(
                  IdentifiedScreen(id: ScreenID(), content: content, hasAppeared: false)
                )
              ]
            ),
          ]
        )
      ),
      .screen(IdentifiedScreen(id: expectedID, content: content, hasAppeared: false))
    ]

    let id = path.lastOccurrenceOf(
      content: content.eraseToAnyScreen()
    )

    XCTAssertEqual(expectedID, id)
  }

  func test_lastOccurrence_childLevel_tabbed_active_head() {
    let expectedID = ScreenID()
    let tabID = ScreenID()

    let path: NavigationPath = [
      .screen(IdentifiedScreen(id: .root, content: content, hasAppeared: false)),
      .tabbed(
        TabScreen(
          id: tabID,
          activeTab: TabScreen.Tab(
            head: .screen(
              IdentifiedScreen(id: expectedID, content: content, hasAppeared: false)
            ),
            tail: [
              .screen(
                IdentifiedScreen(id: ScreenID(), content: otherContent, hasAppeared: false)
              )
            ]
          ),
          inactiveTabs: [
            TabScreen.Tab(
              head: .screen(
                IdentifiedScreen(id: ScreenID(), content: otherContent, hasAppeared: false)
              ),
              tail: [
                .screen(
                  IdentifiedScreen(id: ScreenID(), content: otherContent, hasAppeared: false)
                )
              ]
            ),
          ]
        )
      ),
      .screen(IdentifiedScreen(id: ScreenID(), content: otherContent, hasAppeared: false))
    ]

    let id = path.lastOccurrenceOf(
      content: content.eraseToAnyScreen()
    )

    XCTAssertEqual(expectedID, id)
  }

  func test_lastOccurrence_childLevel_tabbed_in_active_tail() {
    let path: NavigationPath = [
      .screen(IdentifiedScreen(id: .root, content: content, hasAppeared: false)),
      .tabbed(
        TabScreen(
          id: tabID,
          activeTab: TabScreen.Tab(
            head: .screen(
              IdentifiedScreen(id: ScreenID(), content: otherContent, hasAppeared: false)
            ),
            tail: [
              .screen(
                IdentifiedScreen(id: expectedID, content: content, hasAppeared: false)
              )
            ]
          ),
          inactiveTabs: [
            TabScreen.Tab(
              head: .screen(
                IdentifiedScreen(id: ScreenID(), content: otherContent, hasAppeared: false)
              ),
              tail: [
                .screen(
                  IdentifiedScreen(id: ScreenID(), content: otherContent, hasAppeared: false)
                )
              ]
            ),
          ]
        )
      ),
      .screen(IdentifiedScreen(id: ScreenID(), content: otherContent, hasAppeared: false))
    ]

    let id = path.lastOccurrenceOf(
      content: content.eraseToAnyScreen()
    )

    XCTAssertEqual(expectedID, id)
  }

  func test_lastOccurrence_childLevel_tabbed_in_inactive_tab_head() {
    let path: NavigationPath = [
      .screen(IdentifiedScreen(id: .root, content: content, hasAppeared: false)),
      .tabbed(
        TabScreen(
          id: tabID,
          activeTab: TabScreen.Tab(
            head: .screen(
              IdentifiedScreen(id: ScreenID(), content: otherContent, hasAppeared: false)
            ),
            tail: [
              .screen(
                IdentifiedScreen(id: ScreenID(), content: otherContent, hasAppeared: false)
              )
            ]
          ),
          inactiveTabs: [
            TabScreen.Tab(
              head: .screen(
                IdentifiedScreen(id: expectedID, content: content, hasAppeared: false)
              ),
              tail: [
                .screen(
                  IdentifiedScreen(id: ScreenID(), content: otherContent, hasAppeared: false)
                )
              ]
            ),
          ]
        )
      ),
      .screen(IdentifiedScreen(id: ScreenID(), content: otherContent, hasAppeared: false))
    ]

    let id = path.lastOccurrenceOf(
      content: content.eraseToAnyScreen()
    )

    XCTAssertEqual(expectedID, id)
  }

  func test_lastOccurrence_childLevel_tabbed_in_inactive_tab_tail() {
    let path: NavigationPath = [
      .screen(IdentifiedScreen(id: .root, content: content, hasAppeared: false)),
      .tabbed(
        TabScreen(
          id: tabID,
          activeTab: TabScreen.Tab(
            head: .screen(
              IdentifiedScreen(id: ScreenID(), content: otherContent, hasAppeared: false)
            ),
            tail: [
              .screen(
                IdentifiedScreen(id: ScreenID(), content: otherContent, hasAppeared: false)
              )
            ]
          ),
          inactiveTabs: [
            TabScreen.Tab(
              head: .screen(
                IdentifiedScreen(id: ScreenID(), content: otherContent, hasAppeared: false)
              ),
              tail: [
                .screen(
                  IdentifiedScreen(id: expectedID, content: content, hasAppeared: false)
                )
              ]
            ),
          ]
        )
      ),
      .screen(IdentifiedScreen(id: ScreenID(), content: otherContent, hasAppeared: false))
    ]

    let id = path.lastOccurrenceOf(
      content: content.eraseToAnyScreen()
    )

    XCTAssertEqual(expectedID, id)
  }
}
