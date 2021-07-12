extension ActiveNavigationTree {
  func dismiss(id: ScreenID) -> ActiveNavigationTree {
    guard id != first?.id else { return self }

    if let firstIndex = firstIndex(
        where: { pathElement in pathElement.representedIDs.contains(id) }
    ) {
      return Array(prefix(upTo: firstIndex))
    }

    return map { element in
      if case .tabbed(let screen) = element {
        return .tabbed(screen.dismiss(id: id))
      }
      return element
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
