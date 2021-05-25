extension NavigationPath {
  func lastOccurrence(of content: AnyScreen) -> ScreenID? {
    reversed()
      .first(where: { $0.contents().contains(content) })?
      .lastOccurrence(of: content)
  }
}

extension NavigationPathElement {
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
    if activeTab.head.contents().contains(content) {
      return activeTab.head.lastOccurrence(of: content)
    }

    if activeTab.tail.contents().contains(content) {
      return activeTab.tail.lastOccurrence(of: content)
    }

    if let firstInactive = inactiveTabs.first(where: { tab in
      tab.head.contents().contains(content)
    }) {
      return firstInactive.head.lastOccurrence(of: content)
    }

    if let firstInactive = inactiveTabs.first(where: { tab in
      tab.tail.contents().contains(content)
    }) {
      return firstInactive.tail.lastOccurrence(of: content)
    }

    return nil
  }
}
