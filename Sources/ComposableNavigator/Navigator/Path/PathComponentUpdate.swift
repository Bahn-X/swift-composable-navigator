public struct PathComponentUpdate: Hashable {
  public let previous: IdentifiedScreen?
  public let current: IdentifiedScreen?

  public init(previous: IdentifiedScreen?, current: IdentifiedScreen?) {
    self.previous = previous
    self.current = current
  }
}

extension PathComponentUpdate {
  public static let empty = PathComponentUpdate(previous: nil, current: nil)

  public var ignoringCurrent: PathComponentUpdate {
    PathComponentUpdate(previous: previous, current: nil)
  }
}
