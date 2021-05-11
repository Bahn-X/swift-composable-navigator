extension NavigationPath {
  func didAppear(id: ScreenID) -> NavigationPath {
    setHasAppeared(id: id, true)
  }

  func setHasAppeared(id: ScreenID, _ newValue: Bool) -> NavigationPath {
    map { element in
      element.setHasAppeared(id: id, newValue)
    }
  }
}

extension NavigationPathElement {
  func setHasAppeared(id: ScreenID, _ newValue: Bool) -> NavigationPathElement {
    switch self {
    case .screen(let screen) where id == screen.id:
      return .screen(
        IdentifiedScreen(
          id: screen.id,
          content: screen.content,
          hasAppeared: newValue
        )
      )
    case .screen:
      return self
    case .tabbed(let screen):
      return .tabbed(
        screen.setHasAppeared(id: id, newValue)
      )
    }
  }
}

extension TabScreen {
  func setHasAppeared(id: ScreenID, _ newValue: Bool) -> TabScreen {
    if self.id == id || activeTab.id == id {
      return TabScreen(
        id: self.id,
        activeTab: Tab(
          head: activeTab.head.setHasAppeared(id: activeTab.id, newValue),
          tail: activeTab.tail
        ),
        inactiveTabs: inactiveTabs
      )
    }

    if activeTab.tail.ids().contains(id) {
      return TabScreen(
        id: self.id,
        activeTab: Tab(
          head: activeTab.head,
          tail: activeTab.tail.setHasAppeared(id: id, newValue)
        ),
        inactiveTabs: inactiveTabs
      )
    }

    if let tab = inactiveTabs.first(where: { $0.id == id }) {
      return TabScreen(
        id: self.id,
        activeTab: activeTab,
        inactiveTabs: inactiveTabs
          .subtracting([tab])
          .union([Tab(head: tab.head.setHasAppeared(id: id, newValue), tail: tab.tail)])
      )
    }

    if let tab = inactiveTabs.first(where: { $0.tail.ids().contains(id) }) {
      return TabScreen(
        id: self.id,
        activeTab: activeTab,
        inactiveTabs: inactiveTabs
          .subtracting([tab])
          .union([Tab(head: tab.head, tail: tab.tail.setHasAppeared(id: id, newValue))])
      )
    }

    return self
  }
}
