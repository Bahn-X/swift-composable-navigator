public extension PathBuilder {
  /// Performs an action before this `PathBuilder` is built.
  func beforeBuild(perform action: @escaping () -> Void) -> _PathBuilder<Content> {
    _PathBuilder { pathElement in
      action()
      return build(pathElement: pathElement)
    }
  }
}
