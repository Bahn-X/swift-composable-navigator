public struct NavigationTreeElementUpdate: Hashable {
  public let previous: ActiveNavigationTreeElement?
  public let current: ActiveNavigationTreeElement?

  public init(previous: ActiveNavigationTreeElement?, current: ActiveNavigationTreeElement?) {
    self.previous = previous
    self.current = current
  }
}
