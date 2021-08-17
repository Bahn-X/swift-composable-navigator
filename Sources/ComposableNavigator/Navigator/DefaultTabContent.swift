public struct DefaultTabContent {
  public let tag: AnyActivatable
  public let content: ActiveNavigationPathElement

  public init<A: Activatable>(tag: A, content: ActiveNavigationPathElement) {
    self.tag = tag.eraseToAnyActivatable()
    self.content = content
  }
}
