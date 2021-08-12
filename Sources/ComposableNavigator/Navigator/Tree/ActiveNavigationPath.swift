public typealias ActiveNavigationPath = [ActiveNavigationPathElement]

public extension ActiveNavigationPath {
  func toNavigationTree(screenID: () -> ScreenID) -> ActiveNavigationTree {
    map { $0.toNavigationTreeElement(screenID: screenID) }
  }
}

public indirect enum ActiveNavigationPathElement: Hashable {
  case screen(AnyScreen)
  case tabbed(ActiveTab)

  public static func tabbed<A: Activatable, S: Screen>(active: A, content: S) -> Self {
    .tabbed(
      .init(
        active: active,
        path: [.screen(content.eraseToAnyScreen())]
      )
    )
  }

  var presentationStyle: ScreenPresentationStyle {
    switch self {
    case let .screen(screen):
      return screen.presentationStyle
    case let .tabbed(screen):
      return screen.path.first?.presentationStyle ?? .push
    }
  }

  func toNavigationTreeElement(screenID: () -> ScreenID) -> ActiveNavigationTreeElement {
    switch self {
    case let .screen(screen):
      return .screen(
        IdentifiedScreen(
          id: screenID(),
          content: screen,
          hasAppeared: false
        )
      )
    case let .tabbed(screen):
      return .tabbed(
        TabScreen(
          id: screenID(),
          activeTab: TabScreen.Tab(
            id: screen.id,
            path: screen.path.toNavigationTree(screenID: screenID)
          ),
          inactiveTabs: [],
          presentationStyle: screen.path.first?.presentationStyle ?? .push,
          hasAppeared: false
        )
      )
    }
  }
}

// MARK: - Tabbed
public extension ActiveNavigationPathElement {
  struct ActiveTab: Hashable {
    let id: AnyActivatable
    let path: ActiveNavigationPath

    public init<A: Activatable>(active: A, path: ActiveNavigationPath) {
      self.id = active.eraseToAnyActivatable()
      self.path = path
    }
  }
}
