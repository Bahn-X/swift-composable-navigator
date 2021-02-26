public struct PathUpdate: Equatable {
  public let previous: [IdentifiedScreen]
  public let current: [IdentifiedScreen]

  public func update(for id: ScreenID) -> PathComponentUpdate {
    PathComponentUpdate(
      previous: extractPathComponent(for: id, from: previous),
      current: extractPathComponent(for: id, from: current)
    )
  }

  private func extractPathComponent(
    for id: ScreenID,
    from path: [IdentifiedScreen]
  ) -> PathComponent? {
    guard let index = path.firstIndex(where: { $0.id == id }) else {
      return nil
    }

    let content = path[index].content
    let successorIndex = index.advanced(by: 1)

    guard path.indices.contains(successorIndex) else {
      return PathComponent(content: content, successor: nil)
    }

    return PathComponent(
      content: content,
      successor: path[successorIndex].content
    )
  }
}
