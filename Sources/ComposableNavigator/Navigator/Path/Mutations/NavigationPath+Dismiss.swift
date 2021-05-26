extension NavigationPath {
  func dismiss(id: ScreenID) -> NavigationPath {
    if let firstIndex = firstIndex(
      where: { pathElement in
        switch pathElement {
        case .screen(let screen):
          return screen.id == id
        case .tabbed(let screen):
          return screen.id == id || screen.tabIDs.contains(id)
        }
      }
    ) {
      return Array(prefix(upTo: firstIndex))
    }

    return map { pathElement in
      if case .tabbed(let screen) = pathElement {
        return .tabbed(screen.dismiss(id: id))
      }
      return pathElement
    }
  }
}

extension TabScreen {
  func dismiss(id: ScreenID) -> TabScreen {
    guard ids().contains(id) else {
      return self
    }

    if activeTab.tail.ids().contains(id) {
      return TabScreen(
        id: self.id,
        activeTab: Tab(
          head: activeTab.head,
          tail: activeTab.tail.dismiss(id: id)
        ),
        inactiveTabs: inactiveTabs
      )
    }

    return TabScreen(
      id: self.id,
      activeTab: activeTab,
      inactiveTabs: Set(
        inactiveTabs.map { inactiveTab in
          Tab(head: inactiveTab.head, tail: inactiveTab.tail.dismiss(id: id))
        }
      )
    )
  }
}
