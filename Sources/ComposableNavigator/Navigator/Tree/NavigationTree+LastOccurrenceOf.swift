extension ActiveNavigationTree {
  func lastOccurrence(of content: AnyScreen) -> ScreenID? {
    reversed()
      .first(where: { $0.contents().contains(content) })?
      .lastOccurrence(of: content)
  }
}

extension ActiveNavigationTreeElement {
  func lastOccurrence(of content: AnyScreen) -> ScreenID? {
    switch self {
    case .screen(let screen):
      return screen.content == content ? screen.id: nil
    case .tabbed(let screen):
      return screen.lastOccurrence(of: content)
    }
  }
}

extension TabScreen {
  func lastOccurrence(of content: AnyScreen) -> ScreenID? {
    if activeTab.path.contents().contains(content) {
      return activeTab.path.lastOccurrence(of: content)
    }

    if let firstInactive = inactiveTabs.first(
        where: { tab in tab.path.contents().contains(content) }
    ) {
      return firstInactive.path.lastOccurrence(of: content)
    }
    return nil
  }
}
