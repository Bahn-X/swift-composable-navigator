public indirect enum NavigationPathElement: Hashable {
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
      return screen.activeTab.head.content
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
      return screen.activeTab.head.hasAppeared
    }
  }
}
