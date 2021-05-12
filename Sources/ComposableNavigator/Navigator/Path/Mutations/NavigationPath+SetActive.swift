extension NavigationPath {
  func setActive(id: ScreenID) -> NavigationPath {
    var newPath = self

    if let firstIndex = firstIndex(where: { $0.ids().contains(id) }) {
      newPath[firstIndex] = newPath[firstIndex].setActive(id: id)
    }

    return newPath
  }
}

extension NavigationPathElement {
  func setActive(id: ScreenID) -> NavigationPathElement {
    switch self {
    case .screen:
      return self
    case .tabbed(let screen):
      return .tabbed(screen.setActive(id: id))
    }
  }
}

extension TabScreen {
  func setActive(id: ScreenID) -> TabScreen {
    guard id != activeTab.id, id != self.id, ids().contains(id) else {
      return self
    }

    if let inactiveTab =
        // if id is an inactive tab id, set active tab
        inactiveTabs.first(where: { $0.id == id })
        // if id is an id in a tab, set active tab and set active on tail.
        ?? inactiveTabs.first(where: { $0.ids().contains(id) }).map(
          { tab in
            Tab(head: tab.head, tail: tab.tail.setActive(id: id))
          }
        )
    {
      let hasAppeared: Bool
      switch (
        activeTab.head.content.presentationStyle,
        inactiveTab.head.content.presentationStyle
      ) {
      case (.push, .push), (.sheet, .sheet):
        hasAppeared = activeTab.head.hasAppeared
      default:
        hasAppeared = false
      }

      let newHead = inactiveTab.head.setHasAppeared(
        id: inactiveTab.id, hasAppeared
      )
      let newTab = Tab(head: newHead, tail: inactiveTab.tail)

      return TabScreen(
        id: self.id,
        activeTab: newTab,
        inactiveTabs: inactiveTabs
          .filter { tab in tab.id != inactiveTab.id }
          .union([activeTab])
      )
    }

    // if id is not an id in a tab, do nothing
    return self
  }
}
