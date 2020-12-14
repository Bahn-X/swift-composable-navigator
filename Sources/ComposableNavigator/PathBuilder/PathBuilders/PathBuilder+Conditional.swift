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

  static func `if`<LetContent>(
    `let`: @escaping () -> LetContent?,
    then: @escaping (LetContent) -> PathBuilder,
    else: PathBuilder? = nil
  ) -> PathBuilder {
    PathBuilder(
      buildPath: { path in
        if let letContent = `let`() {
          return then(letContent).build(path: path)
        } else {
          return `else`?.build(path: path)
        }
      }
    )
  }
}
