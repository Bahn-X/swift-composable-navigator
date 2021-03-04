public struct PathComponentUpdate: Hashable {
  public let previous: IdentifiedScreen?
  public let current: IdentifiedScreen?

  public init(previous: IdentifiedScreen?, current: IdentifiedScreen?) {
    self.previous = previous
    self.current = current
  }
}
