public struct NavigationPathUpdate: Equatable {
  public let previous: NavigationPath
  public let current: NavigationPath

  public func component(for id: ScreenID) -> NavigationPathElementUpdate {
    NavigationPathElementUpdate(
      previous: extractPathComponent(for: id, from: previous),
      current: extractPathComponent(for: id, from: current)
    )
  }

  public func successor(of id: ScreenID) -> NavigationPathElementUpdate {
    NavigationPathElementUpdate(
      previous: extractSuccessor(of: id, from: previous),
      current: extractSuccessor(of: id, from: current)
    )
  }

  private func extractPathComponent(
    for id: ScreenID,
    from path: NavigationPath
  ) -> NavigationPathElement? {
    return path.first(where: { $0.id == id })
  }

  private func extractSuccessor(
    of id: ScreenID,
    from path: NavigationPath
  ) -> NavigationPathElement? {
    guard let successorIndex = path.firstIndex(where: { $0.id == id })?.advanced(by: 1),
          path.indices.contains(successorIndex)
    else {
      return nil
    }

    return path[successorIndex]
  }
}
