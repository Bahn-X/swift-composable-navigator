public extension PathBuilder {
  static func conditional(
    either: PathBuilder,
    or: PathBuilder,
    basedOn condition: @escaping () -> Bool
  ) -> PathBuilder {
    PathBuilder(
      buildPath: { path in
        if condition() {
          return either.build(path: path)
        } else {
          return or.build(path: path)
        }
      }
    )
  }
}
