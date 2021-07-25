public struct NavigationTreeUpdate: Equatable {
  public let previous: ActiveNavigationTree
  public let current: ActiveNavigationTree

  public func component(for id: ScreenID) -> NavigationTreeElementUpdate {
    NavigationTreeElementUpdate(
      previous: extractPathComponent(for: id, from: previous),
      current: extractPathComponent(for: id, from: current)
    )
  }

  public func successor(of id: ScreenID) -> NavigationTreeElementUpdate {
    NavigationTreeElementUpdate(
      previous: extractSuccessor(of: id, from: previous),
      current: extractSuccessor(of: id, from: current)
    )
  }

  private func extractPathComponent(
    for id: ScreenID,
    from path: ActiveNavigationTree
  ) -> ActiveNavigationTreeElement? {
    if let elementInFlatPath = path.first(where: { $0.id == id }) {
      return elementInFlatPath
    }

    if let elementContainingID = path.first(where: { $0.ids().contains(id) }) {
      switch elementContainingID {
      case .screen:
        return elementContainingID
      case let .tabbed(tabbedScreen):
        return (tabbedScreen.inactiveTabs + [tabbedScreen.activeTab])
          .first(where: { $0.ids().contains(id) })
          .flatMap { tab in
            extractPathComponent(for: id, from: tab.path)
          }
      }
    }

    return nil
  }

  private func extractSuccessor(
    of id: ScreenID,
    from path: ActiveNavigationTree
  ) -> ActiveNavigationTreeElement? {
    if let flatSuccessorIndex = path.firstIndex(where: { $0.id == id })?.advanced(by: 1),
        path.indices.contains(flatSuccessorIndex) {
      return path[flatSuccessorIndex]
    }

    if let elementContainingID = path.first(where: { $0.ids().contains(id) }) {
      switch elementContainingID {
      case .screen:
        return nil
      case let .tabbed(tabbedScreen):
        return (tabbedScreen.inactiveTabs + [tabbedScreen.activeTab])
          .first(where: { $0.ids().contains(id) })
          .flatMap { tab in
            extractSuccessor(of: id, from: tab.path)
          }
      }
    }

    return nil
  }
}
