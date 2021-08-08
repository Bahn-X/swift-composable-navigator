extension ActiveNavigationTree {
  func initializeDefaultContents(
    for id: ScreenID,
    contents: [DefaultTabContent],
    initScreenID: @escaping () -> ScreenID
  ) -> ActiveNavigationTree {
    map { element in
      element.initializeDefaultContents(
        for: id,
        contents: contents,
        initScreenID: initScreenID
      )
    }
  }
}

extension ActiveNavigationTreeElement {
  func initializeDefaultContents(
    for id: ScreenID,
    contents: [DefaultTabContent],
    initScreenID: @escaping () -> ScreenID
  ) -> ActiveNavigationTreeElement {
    switch self {
    case .screen:
      return self

    case .tabbed(let screen):
      return .tabbed(
        screen.initializeDefaultContents(
          for: id,
          contents: contents,
          initScreenID: initScreenID
        )
      )
    }
  }
}

extension TabScreen {
  func initializeDefaultContents(
    for id: ScreenID,
    contents: [DefaultTabContent],
    initScreenID: @escaping () -> ScreenID
  ) -> TabScreen {
    if id == self.id {
      let inactiveTabs = contents.compactMap { defaultContent -> Tab? in
        guard activeTab.id != defaultContent.tag else {
          return nil
        }

        let currentPath = self.inactiveTabs.first(where: { $0.id == defaultContent.tag })

        return Tab(
          id: defaultContent.tag,
          path: currentPath?.path ?? [
            defaultContent.content.toNavigationTreeElement(screenID: initScreenID)
          ]
        )
      }

      return TabScreen(
        id: self.id,
        activeTab: self.activeTab,
        inactiveTabs: Set(inactiveTabs),
        presentationStyle: self.presentationStyle,
        hasAppeared: self.hasAppeared
      )
    } else {
      return TabScreen(
        id: self.id,
        activeTab: Tab(
          id: activeTab.id,
          path: activeTab.path.initializeDefaultContents(
            for: id,
            contents: contents,
            initScreenID: initScreenID
          )
        ),
        inactiveTabs: Set(
          inactiveTabs.map { inactiveTab in
            Tab(
              id: inactiveTab.id,
              path: inactiveTab.path.initializeDefaultContents(
                for: id,
                contents: contents,
                initScreenID: initScreenID
              )
            )
          }
        ),
        presentationStyle: presentationStyle,
        hasAppeared: hasAppeared
      )
    }
  }
}
