

public protocol NavigationTree: PathBuilder {
  associatedtype Builder: PathBuilder
  @NavigationTreeBuilder var builder: Builder { get }
}

extension NavigationTree {
  public func build(path: [IdentifiedScreen]) -> Builder.Content? {
    builder.build(path: path)
  }
}
