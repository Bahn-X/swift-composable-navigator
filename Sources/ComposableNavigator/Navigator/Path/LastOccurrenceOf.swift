extension NavigationPath {
  func lastOccurrenceOf(content: AnyScreen) -> ScreenID? {
    reversed()
      .first(where: { $0.contents().contains(content) })?
      .lastOccurrenceOf(content: content)
  }
}

extension NavigationPathElement {
  func lastOccurrenceOf(content: AnyScreen) -> ScreenID? {
    switch self {
    case .screen(let screen):
      return screen.content == content ? screen.id: nil
    case .tabbed(let screen):
      return screen.lastOccurrenceOf(content: content)
    }
  }
}

extension TabScreen {
  func lastOccurrenceOf(content: AnyScreen) -> ScreenID? {
    if activeTab.head.contents().contains(content) {
      return activeTab.head.lastOccurrenceOf(content: content)
    }

    if activeTab.tail.contents().contains(content) {
      return activeTab.tail.lastOccurrenceOf(content: content)
    }

    if let firstInactive = inactiveTabs.first(where: { tab in
      tab.head.contents().contains(content)
    }) {
      return firstInactive.head.lastOccurrenceOf(content: content)
    }

    if let firstInactive = inactiveTabs.first(where: { tab in
      tab.tail.contents().contains(content)
    }) {
      return firstInactive.tail.lastOccurrenceOf(content: content)
    }

    return nil
  }
}
