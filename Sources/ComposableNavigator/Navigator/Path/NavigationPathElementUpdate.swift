public struct NavigationPathElementUpdate: Hashable {
  public let previous: NavigationPathElement?
  public let current: NavigationPathElement?

  public init(previous: NavigationPathElement?, current: NavigationPathElement?) {
    self.previous = previous
    self.current = current
  }
}
