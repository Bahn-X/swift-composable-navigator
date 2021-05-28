extension NavigationPath {
  func replaceContent(of id: ScreenID, with newContent: AnyScreen) -> NavigationPath {
    map { element in
      element.replaceContent(of: id, with: newContent)
    }
  }
}

extension NavigationPathElement {
  func replaceContent(of id: ScreenID, with newContent: AnyScreen) -> NavigationPathElement {
    switch self {
    case .screen(let screen) where id == screen.id:
      return .screen(
        IdentifiedScreen(
          id: screen.id,
          content: newContent,
          hasAppeared: screen.hasAppeared
        )
      )
    case .screen(let screen):
      return .screen(screen)
    case .tabbed(let screen) where id == screen.id:
      return .screen(
        IdentifiedScreen(
          id: screen.id,
          content: newContent,
          hasAppeared: screen.hasAppeared
        )
      )
    case .tabbed(let screen):
      return .tabbed(screen.replaceContent(of: id, with: newContent))
    }
  }
}

extension TabScreen {
  func replaceContent(of id: ScreenID, with newContent: AnyScreen) -> TabScreen {
    return TabScreen(
      id: self.id,
      activeTab: Tab(
        id: activeTab.id,
        path: activeTab.path.replaceContent(of: id, with: newContent)
      ),
      inactiveTabs: Set(
        inactiveTabs.map { inactiveTab in
          Tab(
            id: inactiveTab.id,
            path: inactiveTab.path.replaceContent(of: id, with: newContent)
          )
        }
      ),
      presentationStyle: presentationStyle,
      hasAppeared: hasAppeared
    )
  }
}
