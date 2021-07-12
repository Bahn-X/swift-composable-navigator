extension ActiveNavigationTree {
  func go(
    to successor: AnyScreen,
    on id: ScreenID,
    forceNavigation: Bool,
    screenID: () -> ScreenID
  ) -> ActiveNavigationTree {
    if let index = self.firstIndex(where: { $0.id == id }) {
      return prefix(through: index) + [
        .screen(
          IdentifiedScreen(
            id: screenID(),
            content: successor,
            hasAppeared: false
          )
        )
      ]
    }

    if let childIndex = firstIndex(where: { $0.ids().contains(id) }) {
      var newPath = forceNavigation ? Array(prefix(through: childIndex)): self

      newPath[childIndex] = newPath[childIndex].go(
        to: successor,
        on: id,
        forceNavigation: forceNavigation,
        screenID: screenID
      )

      return newPath
    }

    return self
  }
}

extension ActiveNavigationTreeElement {
  func go(
    to successor: AnyScreen,
    on id: ScreenID,
    forceNavigation: Bool,
    screenID: () -> ScreenID
  ) -> ActiveNavigationTreeElement {
    switch self {
    case .screen:
      return self
    case .tabbed(let screen):
      return .tabbed(
        screen.go(
          to: successor,
          on: id,
          forceNavigation: forceNavigation,
          screenID: screenID
        )
      )
    }
  }
}

extension TabScreen {
  func go(
    to successor: AnyScreen,
    on id: ScreenID,
    forceNavigation: Bool,
    screenID: () -> ScreenID
  ) -> TabScreen {
    if activeTab.path.ids().contains(id) {
      let newPath = activeTab.path.go(
        to: successor,
        on: id,
        forceNavigation: forceNavigation,
        screenID: screenID
      )

      return TabScreen(
        id: self.id,
        activeTab: Tab(
          id: activeTab.id,
          path: newPath
        ),
        inactiveTabs: inactiveTabs,
        presentationStyle: presentationStyle,
        hasAppeared: hasAppeared
      )
    }

    if let tab = inactiveTabs.first(where: { tab in tab.path.ids().contains(id) }) {
      let newPath = tab.path.go(
        to: successor,
        on: id,
        forceNavigation: forceNavigation,
        screenID: screenID
      )

      let updatedTab = Tab(id: tab.id, path: newPath)

      if forceNavigation {
        return TabScreen(
          id: self.id,
          activeTab: updatedTab,
          inactiveTabs: inactiveTabs
            .subtracting([tab])
            .union([activeTab]),
          presentationStyle: presentationStyle,
          hasAppeared: hasAppeared
        )
      } else {
        return TabScreen(
          id: self.id,
          activeTab: activeTab,
          inactiveTabs: inactiveTabs
            .subtracting([tab])
            .union([updatedTab]),
          presentationStyle: presentationStyle,
          hasAppeared: hasAppeared
        )
      }
    }

    return self
  }
}
