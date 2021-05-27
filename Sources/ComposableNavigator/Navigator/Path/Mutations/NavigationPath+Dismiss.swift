extension NavigationPath {
  func dismiss(id: ScreenID) -> NavigationPath {
    if let firstIndex = firstIndex(
        where: { pathElement in pathElement.representedIDs.contains(id) }
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
    return TabScreen(
      id: self.id,
      activeTab: Tab(
        id: activeTab.id,
        path: activeTab.path.dismiss(id: id)
      ),
      inactiveTabs: Set(
        inactiveTabs.map { inactiveTab in
          Tab(
            id: inactiveTab.id,
            path: inactiveTab.path.dismiss(id: id)
          )
        }
      ),
      presentationStyle: presentationStyle,
      hasAppeared: hasAppeared
    )
  }
}
