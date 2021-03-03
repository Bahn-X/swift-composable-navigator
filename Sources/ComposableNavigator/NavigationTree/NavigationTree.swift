public protocol NavigationTree: PathBuilder {
  associatedtype Builder: PathBuilder
  @NavigationTreeBuilder var builder: Builder { get }
}

extension NavigationTree {
  public func build(pathElement: AnyScreen) -> Builder.Content? {
    builder.build(pathElement: pathElement)
  }
}
