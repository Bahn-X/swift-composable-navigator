public typealias ActiveNavigationTree = [ActiveNavigationTreeElement]

extension ActiveNavigationTree {
  func ids() -> Set<ScreenID> {
    reduce(into: Set<ScreenID>()) { acc, element in
      acc.formUnion(element.ids())
    }
  }

  func contents() -> Set<AnyScreen> {
    reduce(into: Set<AnyScreen>()) { acc, element in
      acc.formUnion(element.contents())
    }
  }

  func activePath() -> ActiveNavigationPath {
    map { element in
      switch element {
      case let .screen(screen):
        return .screen(screen.content)
      case let .tabbed(screen):
        return .tabbed(
          ActiveNavigationPathElement.ActiveTab(
            id: screen.activeTab.id,
            path: screen.activeTab.path.activePath()
          )
        )
      }
    }
  }
}
