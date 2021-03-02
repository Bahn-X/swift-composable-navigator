public struct PathUpdate: Equatable {
  public let previous: [IdentifiedScreen]
  public let current: [IdentifiedScreen]

  public func component(for id: ScreenID) -> PathComponentUpdate {
    PathComponentUpdate(
      previous: extractPathComponent(for: id, from: previous),
      current: extractPathComponent(for: id, from: current)
    )
  }

  public func successor(of id: ScreenID) -> PathComponentUpdate {
    PathComponentUpdate(
      previous: extractSuccessor(of: id, from: previous),
      current: extractSuccessor(of: id, from: current)
    )
  }

  private func extractPathComponent(
    for id: ScreenID,
    from path: [IdentifiedScreen]
  ) -> IdentifiedScreen? {
    return path.first(where: { $0.id == id })
  }

  private func extractSuccessor(
    of id: ScreenID,
    from path: [IdentifiedScreen]
  ) -> IdentifiedScreen? {
    guard let successorIndex = path.firstIndex(where: { $0.id == id })?.advanced(by: 1),
          path.indices.contains(successorIndex)
    else {
      return nil
    }

    return path[successorIndex]
  }
}
