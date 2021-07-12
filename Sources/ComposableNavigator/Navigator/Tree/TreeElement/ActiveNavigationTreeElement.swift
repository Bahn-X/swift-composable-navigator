public indirect enum ActiveNavigationTreeElement: Hashable {
  case screen(IdentifiedScreen)
  case tabbed(TabScreen)

  public var id: ScreenID {
    switch self {
    case .screen(let screen):
      return screen.id
    case .tabbed(let screen):
      return screen.id
    }
  }

  public var representedIDs: Set<ScreenID> {
    switch self {
    case .screen(let screen):
      return [screen.id]
    case .tabbed(let screen):
      return screen.inactiveTabs.reduce(
        into: Set([screen.id, screen.activeTab.path.first?.id].compactMap { $0 }),
        { acc, inactiveTab in
          acc.formUnion([inactiveTab.path.first?.id].compactMap { $0 })
        }
      )
    }
  }

  public func ids() -> Set<ScreenID> {
    switch self {
    case .screen(let screen):
      return [screen.id]
    case .tabbed(let screen):
      return screen.ids()
    }
  }

  public var content: AnyScreen {
    switch self {
    case .screen(let screen):
      return screen.content
    case .tabbed(let screen):
      return screen.eraseToAnyScreen()
    }
  }

  public func contents() -> Set<AnyScreen> {
    switch self {
    case .screen(let screen):
      return [screen.content]
    case .tabbed(let screen):
      return screen.contents()
    }
  }

  public var hasAppeared: Bool {
    switch self {
    case .screen(let screen):
      return screen.hasAppeared
    case .tabbed(let screen):
      return screen.hasAppeared
    }
  }

  var activeNavigationPathElement: ActiveNavigationPathElement {
    switch self {
    case let .screen(screen):
      return .screen(screen.content)
    case let .tabbed(screen):
      return .tabbed(
        ActiveNavigationPathElement.ActiveTab(
          active: screen.activeTab.id,
          path: screen.activeTab.path.activePath()
        )
      )
    }
  }
}
