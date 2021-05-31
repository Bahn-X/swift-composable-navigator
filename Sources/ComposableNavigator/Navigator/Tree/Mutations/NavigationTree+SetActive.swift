extension ActiveNavigationTree {
  func activate(_ activatable: AnyActivatable) -> ActiveNavigationTree {
    map { element in
      element.activate(activatable)
    }
  }
}

extension ActiveNavigationTreeElement {
  func activate(_ activatable: AnyActivatable) -> ActiveNavigationTreeElement {
    switch self {
    case .screen:
      return self
    case .tabbed(let screen):
      return .tabbed(screen.activate(activatable))
    }
  }
}

extension TabScreen {
  func activate(_ activatable: AnyActivatable) -> TabScreen {
    if let tab = inactiveTabs.first(where: { $0.id == activatable }) {
      return TabScreen(
        id: id,
        activeTab: tab,
        inactiveTabs: inactiveTabs
          .subtracting([tab])
          .union([activeTab]),
        presentationStyle: presentationStyle,
        hasAppeared: hasAppeared
      )
    } else {
      return TabScreen(
        id: id,
        activeTab: Tab(
          id: activeTab.id,
          path: activeTab.path.activate(activatable)
        ),
        inactiveTabs: Set(
          inactiveTabs.map { tab in
            Tab(
              id: tab.id,
              path: tab.path.activate(activatable)
            )
          }
        ),
        presentationStyle: presentationStyle,
        hasAppeared: hasAppeared
      )
    }
  }
}
