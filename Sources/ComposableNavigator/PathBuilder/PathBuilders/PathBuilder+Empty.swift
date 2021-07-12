public extension PathBuilders {
  struct EmptyBuilder: PathBuilder {
    public func build(pathElement: ActiveNavigationTreeElement) -> Never? { nil }
  }

  /// The empty `PathBuilder` does not build any screen and just returns nil for all screens.
  ///
  /// The .empty PathBuilder can be used as a stub value.
  static var empty: EmptyBuilder {
    EmptyBuilder()
  }
}
