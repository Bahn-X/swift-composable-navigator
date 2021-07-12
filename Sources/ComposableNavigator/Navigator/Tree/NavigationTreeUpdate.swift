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
    return path.first(where: { $0.id == id })
  }

  private func extractSuccessor(
    of id: ScreenID,
    from path: ActiveNavigationTree
  ) -> ActiveNavigationTreeElement? {
    guard let successorIndex = path.firstIndex(where: { $0.id == id })?.advanced(by: 1),
          path.indices.contains(successorIndex)
    else {
      return nil
    }

    return path[successorIndex]
  }
}
