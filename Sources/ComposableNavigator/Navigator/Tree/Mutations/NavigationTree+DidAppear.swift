extension ActiveNavigationTree {
  func didAppear(id: ScreenID) -> ActiveNavigationTree {
    setHasAppeared(id: id, true)
  }

  func setHasAppeared(id: ScreenID, _ newValue: Bool) -> ActiveNavigationTree {
    map { element in
      element.setHasAppeared(id: id, newValue)
    }
  }
}

extension ActiveNavigationTreeElement {
  func setHasAppeared(id: ScreenID, _ newValue: Bool) -> ActiveNavigationTreeElement {
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
    if self.id == id {
      return TabScreen(
        id: id,
        activeTab: activeTab,
        inactiveTabs: inactiveTabs,
        presentationStyle: presentationStyle,
        hasAppeared: newValue
      )
    }

    return TabScreen(
        id: self.id,
        activeTab: Tab(
            id: activeTab.id,
            path: activeTab.path.setHasAppeared(id: id, newValue)
        ),
        inactiveTabs: Set(
            inactiveTabs.map { tab in
                Tab(id: tab.id, path: tab.path.setHasAppeared(id: id, newValue))
            }
        ),
        presentationStyle: presentationStyle,
        hasAppeared: hasAppeared
    )
  }
}
