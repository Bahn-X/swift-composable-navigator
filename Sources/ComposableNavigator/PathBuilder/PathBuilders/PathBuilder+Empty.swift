public extension PathBuilders {
  /// The empty `PathBuilder` does not build any screen and just returns nil for all screens.
  ///
  /// The .empty PathBuilder can be used as a stub value.
  static var empty: EmptyBuilder {
    EmptyBuilder()
  }
}

public struct EmptyBuilder: PathBuilder {
  public func build(path: [IdentifiedScreen]) -> Never? { nil }
}
