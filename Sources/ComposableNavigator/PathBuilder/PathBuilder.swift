public struct PathBuilder {
  private let _buildPath: ([IdentifiedScreen]) -> Routed?

  public init(buildPath: @escaping ([IdentifiedScreen]) -> Routed?) {
    self._buildPath = buildPath
  }

  public func build(path: [IdentifiedScreen]) -> Routed? {
    return _buildPath(path)
  }
}
