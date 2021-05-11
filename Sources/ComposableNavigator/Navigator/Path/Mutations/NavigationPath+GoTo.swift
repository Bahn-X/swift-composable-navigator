extension NavigationPath {
  func go(
    to successor: AnyScreen,
    on id: ScreenID,
    forceNavigation: Bool,
    screenID: () -> ScreenID
  ) -> NavigationPath {
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

extension NavigationPathElement {
  func go(
    to successor: AnyScreen,
    on id: ScreenID,
    forceNavigation: Bool,
    screenID: () -> ScreenID
  ) -> NavigationPathElement {
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
    if id == activeTab.id {
      let newTail: NavigationPath = [
        .screen(
          IdentifiedScreen(
            id: screenID(),
            content: successor,
            hasAppeared: false
          )
        )
      ]

      return TabScreen(
        id: self.id,
        activeTab: Tab(
          head: activeTab.head,
          tail: newTail
        ),
        inactiveTabs: inactiveTabs
      )
    }

    if let tab = inactiveTabs.first(where: { tab in tab.id == id }) {
      let newTail: NavigationPath = [
        .screen(
          IdentifiedScreen(
            id: screenID(),
            content: successor,
            hasAppeared: false
          )
        )
      ]

      let updatedTab = Tab(head: tab.head, tail: newTail)

      if forceNavigation {
        return TabScreen(
          id: self.id,
          activeTab: updatedTab,
          inactiveTabs: inactiveTabs
            .filter { $0.id != tab.id }
            .union([activeTab])
        )
      } else {
        return TabScreen(
          id: self.id,
          activeTab: activeTab,
          inactiveTabs: inactiveTabs
            .filter { $0.id != tab.id }
            .union([updatedTab])
        )
      }
    }

    if activeTab.tail.ids().contains(id) {
      let newTail = activeTab.tail.go(
        to: successor,
        on: id,
        forceNavigation: forceNavigation,
        screenID: screenID
      )

      return TabScreen(
        id: self.id,
        activeTab: Tab(
          head: activeTab.head,
          tail: newTail
        ),
        inactiveTabs: inactiveTabs
      )
    }

    if let tab = inactiveTabs.first(where: { tab in tab.tail.ids().contains(id) }) {
      let newTail = tab.tail.go(
        to: successor,
        on: id,
        forceNavigation: forceNavigation,
        screenID: screenID
      )

      let updatedTab = Tab(head: tab.head, tail: newTail)

      if forceNavigation {
        return TabScreen(
          id: self.id,
          activeTab: updatedTab,
          inactiveTabs: inactiveTabs
            .filter { $0.id != tab.id }
            .union([activeTab])
        )
      } else {
        return TabScreen(
          id: self.id,
          activeTab: activeTab,
          inactiveTabs: inactiveTabs
            .filter { $0.id != tab.id }
            .union([updatedTab])
        )
      }
    }

    return self
  }
}
