extension ActiveNavigationTree {
  func go(
    to path: ActiveNavigationPath,
    on id: ScreenID,
    forceNavigation: Bool,
    screenID: () -> ScreenID
  ) -> ActiveNavigationTree {
    if let index = self.firstIndex(where: { $0.id == id }) {
      let element: ActiveNavigationPathElement = {
        switch self[index] {
        case let .screen(screen):
          return .screen(screen.content)
        case let .tabbed(screen):
          return .tabbed(
            .init(
              active: screen.activeTab.id,
              path: screen.activeTab.path.activePath()
            )
          )
        }
      }()

      return Array(prefix(upTo: index)) + Array(suffix(from: index)).update(
        with: [element] + path,
        screenID: screenID
      )
    }

    if let childIndex = firstIndex(where: { $0.ids().contains(id) }) {
      var newPath = forceNavigation ? Array(prefix(through: childIndex)): self

      newPath[childIndex] = newPath[childIndex].go(
        to: path,
        on: id,
        forceNavigation: forceNavigation,
        screenID: screenID
      )

      return newPath
    }

    return self
  }

  func update(
    with path: ActiveNavigationPath,
    screenID: () -> ScreenID
  ) -> ActiveNavigationTree {
    guard self.count > 0 else {
      return path.toNavigationTree(screenID: screenID)
    }

    let zipped = zip(self, path)

    let firstNonMatchingIndex = zipped.prefix(
      while: { treeElement, pathElement in
        treeElement.matches(element: pathElement)
      }
    ).count 

    let matchingIndexRange = 0..<firstNonMatchingIndex

    let updatedPath = zipped.enumerated().map { index, element in
      element.0.update(
        with: element.1,
        screenID: screenID,
        forceNewID: !matchingIndexRange.contains(index)
      )
    }

    let itemsToAppend = path.count - updatedPath.count
    let appendix = itemsToAppend >= 0
      ? Array(path.toNavigationTree(screenID: screenID).suffix(from: updatedPath.count))
      : []

    let lastElementShouldBecomeVisible = matchingIndexRange != indices

    return updatedPath.enumerated().map { (index, element) in
      let lastElementShouldBeUpdated = lastElementShouldBecomeVisible
        ? (index != matchingIndexRange.endIndex.advanced(by: -1))
        : true

      return element.setHasAppeared(
        id: element.id,
        matchingIndexRange.contains(index)
          && lastElementShouldBeUpdated
          && element.hasAppeared
      )
    } + appendix
  }
}

extension ActiveNavigationTreeElement {
  func go(
    to path: ActiveNavigationPath,
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
          to: path,
          on: id,
          forceNavigation: forceNavigation,
          screenID: screenID
        )
      )
    }
  }

  func matches(element: ActiveNavigationPathElement) -> Bool {
    switch (self, element) {
    case let (.screen(old), .screen(new)) where old.content == new:
      return true
    case let (.tabbed(old), .tabbed(new))
      where old.activeTab.id == new.id || old.inactiveTabs.map(\.id).contains(new.id):
      return true
    case (_, .screen), (_, .tabbed):
      return false
    }
  }

  func update(
    with element: ActiveNavigationPathElement,
    screenID: () -> ScreenID,
    forceNewID: Bool
  ) -> ActiveNavigationTreeElement {
    switch (self, element) {
    case let (.screen(old), .screen(new)) where old.content == new:
      return .screen(
        IdentifiedScreen(
          id: forceNewID ? screenID(): old.id,
          content: new,
          hasAppeared: old.hasAppeared
        )
      )

    case let (.tabbed(old), .tabbed(new))
      where old.activeTab.id == new.id || old.inactiveTabs.map(\.id).contains(new.id):
      let newTabbed = old.activate(new.id)
      return .tabbed(
        TabScreen(
          id: forceNewID ? screenID(): newTabbed.id,
          activeTab: TabScreen.Tab(
            id: newTabbed.activeTab.id,
            path: newTabbed.activeTab.path.update(
              with: new.path,
              screenID: screenID
            )
          ),
          inactiveTabs: newTabbed.inactiveTabs,
          presentationStyle: newTabbed.presentationStyle,
          hasAppeared: newTabbed.hasAppeared
        )
      )

    case let (old, .screen(new)):
      return .screen(
        IdentifiedScreen(
          id: old.id == .root ? .root: screenID(),
          content: new,
          hasAppeared: false
        )
      )

    case let (old, .tabbed(new)):
      return .tabbed(
        TabScreen(
          id: old.id == .root ? .root: screenID(),
          activeTab: TabScreen.Tab(
            id: new.id,
            path: new.path.toNavigationTree(screenID: screenID)
          ),
          inactiveTabs: [],
          presentationStyle: new.path.first?.presentationStyle ?? .push,
          hasAppeared: false
        )
      )
    }
  }
}

extension TabScreen {
  func go(
    to path: ActiveNavigationPath,
    on id: ScreenID,
    forceNavigation: Bool,
    screenID: () -> ScreenID
  ) -> TabScreen {
    if activeTab.path.ids().contains(id) {
      let newPath = activeTab.path.go(
        to: path,
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
        to: path,
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
