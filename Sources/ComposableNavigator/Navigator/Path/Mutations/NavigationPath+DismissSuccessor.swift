extension NavigationPath {
  func dismissSuccessor(of id: ScreenID) -> NavigationPath {
    if let firstIndex = firstIndex(where: { pathElement in pathElement.id == id }) {
      return Array(prefix(through: firstIndex))
    }

    return map { pathElement in
      if case .tabbed(let screen) = pathElement {
        return .tabbed(screen.dismissSuccessor(of: id))
      }
      return pathElement
    }
  }
}

extension TabScreen {
  func dismissSuccessor(of id: ScreenID) -> TabScreen {
    return TabScreen(
      id: self.id,
      activeTab: Tab(
        id: activeTab.id,
        path: activeTab.path.dismissSuccessor(of: id)
      ),
      inactiveTabs: Set(
        inactiveTabs.map { inactiveTab in
          Tab(
            id: inactiveTab.id,
            path: inactiveTab.path.dismissSuccessor(of: id)
          )
        }
      ),
      presentationStyle: presentationStyle,
      hasAppeared: hasAppeared
    )
  }
}
