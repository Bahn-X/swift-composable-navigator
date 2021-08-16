public struct TabScreen: Hashable, Screen {
  public struct Tab: Hashable {
    public let id: AnyActivatable
    public let path: ActiveNavigationTree

    init<A: Activatable>(id: A, path: ActiveNavigationTree) {
      self.id = id.eraseToAnyActivatable()
      self.path = path
    }

    public func ids() -> Set<ScreenID> {
      path.ids()
    }
  }

  public let id: ScreenID
  public let activeTab: Tab
  public let inactiveTabs: Set<Tab>

  public let presentationStyle: ScreenPresentationStyle
  public var hasAppeared: Bool

  public func ids() -> Set<ScreenID> {
    inactiveTabs.reduce(
      into: Set<ScreenID>(activeTab.ids().union([id])),
      { acc, tab in
        acc.formUnion(tab.ids())
      }
    )
  }

  public func contents() -> Set<AnyScreen> {
    inactiveTabs.reduce(
      into: activeTab.path.contents(),
      { acc, tab in
        acc.formUnion(tab.path.contents())
      }
    )
  }

  public func path(for tab: AnyActivatable) -> ActiveNavigationTree? {
    if activeTab.id == tab {
      return activeTab.path
    }

    if let inactiveTab = inactiveTabs.first(where: { $0.id == tab }) {
      return inactiveTab.path
    }

    return nil
  }
}
