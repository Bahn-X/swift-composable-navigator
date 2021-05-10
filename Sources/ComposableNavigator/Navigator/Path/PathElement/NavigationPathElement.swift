public enum NavigationPathElement: Hashable {
  case screen(IdentifiedScreen)

  public var id: ScreenID {
    switch self {
    case .screen(let screen):
      return screen.id
    }
  }

  public func ids() -> Set<ScreenID> {
    switch self {
    case .screen(let screen):
      return [screen.id]
    }
  }

  public var content: AnyScreen {
    switch self {
    case .screen(let screen):
      return screen.content
    }
  }

  public var hasAppeared: Bool {
    switch self {
    case .screen(let screen):
      return screen.hasAppeared
    }
  }
}
