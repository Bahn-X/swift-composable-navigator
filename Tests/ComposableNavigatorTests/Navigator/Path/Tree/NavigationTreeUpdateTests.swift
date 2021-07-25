@testable import ComposableNavigator
import XCTest

final class NavigationTreeUpdateTests: XCTestCase {
  let screen = ActiveNavigationTreeElement.screen(
    IdentifiedScreen(
      id: .root,
      content: TestScreen(identifier: "root", presentationStyle: .push),
      hasAppeared: false
    )
  )

  enum Tabs: Activatable {
    case a
    case b
  }

  // MARK: - component(for: id)
  func test_component_for_existing_screen_id_in_flat_path() {
    let sut = NavigationTreeUpdate(
      previous: [screen],
      current: [screen]
    )

    let expectedComponent = NavigationTreeElementUpdate(
      previous: screen,
      current: screen
    )

    XCTAssertEqual(sut.component(for: screen.id), expectedComponent)
  }

  func test_component_for_existing_tabbed_id_in_flat_path() {
    let tabID = ScreenID()
    let activeElement = ActiveNavigationTreeElement.tabbed(
      TabScreen(
        id: tabID,
        activeTab: TabScreen.Tab(
          id: Tabs.a,
          path: [screen]
        ),
        inactiveTabs: [],
        presentationStyle: .push,
        hasAppeared: false
      )
    )

    let sut = NavigationTreeUpdate(
      previous: [activeElement],
      current: [activeElement]
    )

    let expectedComponent = NavigationTreeElementUpdate(
      previous: activeElement,
      current: activeElement
    )

    XCTAssertEqual(sut.component(for: tabID), expectedComponent)
  }

  func test_component_for_no_longer_existent_id_in_flat_path() {
    let sut = NavigationTreeUpdate(
      previous: [screen],
      current: []
    )

    let expectedComponent = NavigationTreeElementUpdate(
      previous: screen,
      current: nil
    )

    XCTAssertEqual(sut.component(for: screen.id), expectedComponent)
  }

  func test_component_for_existing_id_in_tabbed_path() {
    let tabID = ScreenID()
    let activeElement = ActiveNavigationTreeElement.tabbed(
      TabScreen(
        id: tabID,
        activeTab: TabScreen.Tab(
          id: Tabs.a,
          path: [screen]
        ),
        inactiveTabs: [],
        presentationStyle: .push,
        hasAppeared: false
      )
    )

    let sut = NavigationTreeUpdate(
      previous: [activeElement],
      current: [activeElement]
    )

    let expectedComponent = NavigationTreeElementUpdate(
      previous: screen,
      current: screen
    )

    XCTAssertEqual(sut.component(for: screen.id), expectedComponent)
  }

  func test_component_for_no_longer_existent_id_in_tabbed_path() {
    let tabID = ScreenID()
    let activeElement = ActiveNavigationTreeElement.tabbed(
      TabScreen(
        id: tabID,
        activeTab: TabScreen.Tab(
          id: Tabs.a,
          path: [screen]
        ),
        inactiveTabs: [],
        presentationStyle: .push,
        hasAppeared: false
      )
    )

    let updatedActiveElement = ActiveNavigationTreeElement.tabbed(
      TabScreen(
        id: tabID,
        activeTab: TabScreen.Tab(
          id: Tabs.a,
          path: []
        ),
        inactiveTabs: [],
        presentationStyle: .push,
        hasAppeared: false
      )
    )

    let sut = NavigationTreeUpdate(
      previous: [activeElement],
      current: [updatedActiveElement]
    )

    let expectedComponent = NavigationTreeElementUpdate(
      previous: screen,
      current: nil
    )

    XCTAssertEqual(sut.component(for: screen.id), expectedComponent)
  }

  // MARK: - successor(of: id)
  let successor = ActiveNavigationTreeElement.screen(
    IdentifiedScreen(
      id: ScreenID(),
      content: TestScreen(identifier: "successor", presentationStyle: .push),
      hasAppeared: false
    )
  )

  func test_successor_of_existing_screen_id_in_flat_path() {
    let sut = NavigationTreeUpdate(
      previous: [
        screen,
        successor
      ],
      current: [
        screen,
        successor
      ]
    )

    let expectedComponent = NavigationTreeElementUpdate(
      previous: successor,
      current: successor
    )

    XCTAssertEqual(sut.successor(of: screen.id), expectedComponent)
  }

  func test_successor_of_existing_screen_id_without_successor_in_flat_path() {
    let sut = NavigationTreeUpdate(
      previous: [
        screen,
        successor
      ],
      current: [
        screen
      ]
    )

    let expectedComponent = NavigationTreeElementUpdate(
      previous: successor,
      current: nil
    )

    XCTAssertEqual(sut.successor(of: screen.id), expectedComponent)
  }

  func test_successor_of_no_longer_existent_screen_id_in_flat_path() {
    let sut = NavigationTreeUpdate(
      previous: [
        screen,
        successor
      ],
      current: []
    )

    let expectedComponent = NavigationTreeElementUpdate(
      previous: successor,
      current: nil
    )

    XCTAssertEqual(sut.successor(of: screen.id), expectedComponent)
  }

  func test_successor_of_existing_id_in_tabbed_path() {
    let tabID = ScreenID()
    let activeElement = ActiveNavigationTreeElement.tabbed(
      TabScreen(
        id: tabID,
        activeTab: TabScreen.Tab(
          id: Tabs.a,
          path: [
            screen,
            successor
          ]
        ),
        inactiveTabs: [],
        presentationStyle: .push,
        hasAppeared: false
      )
    )

    let sut = NavigationTreeUpdate(
      previous: [activeElement],
      current: [activeElement]
    )

    let expectedComponent = NavigationTreeElementUpdate(
      previous: successor,
      current: successor
    )

    XCTAssertEqual(sut.successor(of: screen.id), expectedComponent)
  }

  func test_successor_of_existing_id_in_tabbed_path_without_successor() {
    let tabID = ScreenID()
    let activeElement = ActiveNavigationTreeElement.tabbed(
      TabScreen(
        id: tabID,
        activeTab: TabScreen.Tab(
          id: Tabs.a,
          path: [
            screen
          ]
        ),
        inactiveTabs: [],
        presentationStyle: .push,
        hasAppeared: false
      )
    )

    let sut = NavigationTreeUpdate(
      previous: [activeElement],
      current: [activeElement]
    )

    let expectedComponent = NavigationTreeElementUpdate(
      previous: nil,
      current: nil
    )

    XCTAssertEqual(sut.successor(of: screen.id), expectedComponent)
  }

  func test_successor_of_no_longer_existent_id_in_tabbed_path() {
    let tabID = ScreenID()
    let activeElement = ActiveNavigationTreeElement.tabbed(
      TabScreen(
        id: tabID,
        activeTab: TabScreen.Tab(
          id: Tabs.a,
          path: [
            screen,
            successor
          ]
        ),
        inactiveTabs: [],
        presentationStyle: .push,
        hasAppeared: false
      )
    )

    let updatedActiveElement = ActiveNavigationTreeElement.tabbed(
      TabScreen(
        id: tabID,
        activeTab: TabScreen.Tab(
          id: Tabs.a,
          path: []
        ),
        inactiveTabs: [],
        presentationStyle: .push,
        hasAppeared: false
      )
    )

    let sut = NavigationTreeUpdate(
      previous: [activeElement],
      current: [updatedActiveElement]
    )

    let expectedComponent = NavigationTreeElementUpdate(
      previous: successor,
      current: nil
    )

    XCTAssertEqual(sut.successor(of: screen.id), expectedComponent)
  }
}
