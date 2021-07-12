@testable import ComposableNavigator
import XCTest

final class NavigationPath_LastOccurrenceOf: XCTestCase {
  let content = TestScreen(identifier: "0", presentationStyle: .push)
  let otherContent = TestScreen(identifier: "other", presentationStyle: .push)
  let expectedID = ScreenID()
  let tabID = ScreenID()

  struct Tab: Activatable {}

  func test_lastOccurrence_rootLevel() {
    let expectedID = ScreenID()

    let path: ActiveNavigationTree = [
      .screen(
        IdentifiedScreen(
          id: .root,
          content: content,
          hasAppeared: false
        )
      ),
      .tabbed(
        TabScreen(
          id: tabID,
          activeTab: TabScreen.Tab(
            id: Tab(),
            path: [
              .screen(
                IdentifiedScreen(
                  id: ScreenID(),
                  content: content,
                  hasAppeared: false
                )
              )
            ]
          ),
          inactiveTabs: [
            TabScreen.Tab(
              id: Tab(),
              path: [
                .screen(
                  IdentifiedScreen(
                    id: ScreenID(),
                    content: content,
                    hasAppeared: false
                  )
                )
              ]
            ),
          ],
          presentationStyle: .push,
          hasAppeared: false
        )
      ),
      .screen(
        IdentifiedScreen(
          id: expectedID,
          content: content,
          hasAppeared: false
        )
      )
    ]

    let id = path.lastOccurrence(
      of: content.eraseToAnyScreen()
    )

    XCTAssertEqual(expectedID, id)
  }

  func test_lastOccurrence_childLevel_tabbed_active_path() {
    let expectedID = ScreenID()
    let tabID = ScreenID()

    let path: ActiveNavigationTree = [
      .screen(IdentifiedScreen(id: .root, content: content, hasAppeared: false)),
      .tabbed(
        TabScreen(
          id: tabID,
          activeTab: TabScreen.Tab(
            id: Tab(),
            path: [
              .screen(
                IdentifiedScreen(
                  id: expectedID,
                  content: content,
                  hasAppeared: false
                )
              )
            ]
          ),
          inactiveTabs: [
            TabScreen.Tab(
              id: Tab(),
              path: [
                .screen(
                  IdentifiedScreen(
                    id: ScreenID(),
                    content: otherContent,
                    hasAppeared: false
                  )
                )
              ]
            ),
          ],
          presentationStyle: .push,
          hasAppeared: false
        )
      ),
      .screen(
        IdentifiedScreen(
          id: ScreenID(),
          content: otherContent,
          hasAppeared: false
        )
      )
    ]

    let id = path.lastOccurrence(
      of: content.eraseToAnyScreen()
    )

    XCTAssertEqual(expectedID, id)
  }

  func test_lastOccurrence_childLevel_tabbed_in_inactive_tab_path() {
    let path: ActiveNavigationTree = [
      .screen(IdentifiedScreen(id: .root, content: content, hasAppeared: false)),
      .tabbed(
        TabScreen(
          id: tabID,
          activeTab: TabScreen.Tab(
            id: Tab(),
            path: [
              .screen(
                IdentifiedScreen(
                  id: ScreenID(),
                  content: otherContent,
                  hasAppeared: false
                )
              )
            ]
          ),
          inactiveTabs: [
            TabScreen.Tab(
              id: Tab(),
              path: [
                .screen(
                  IdentifiedScreen(id: expectedID, content: content, hasAppeared: false)
                )
              ]
            ),
          ],
          presentationStyle: .push,
          hasAppeared: false
        )
      ),
      .screen(
        IdentifiedScreen(
          id: ScreenID(),
          content: otherContent,
          hasAppeared: false
        )
      )
    ]

    let id = path.lastOccurrence(
      of: content.eraseToAnyScreen()
    )

    XCTAssertEqual(expectedID, id)
  }
}
