public extension PathBuilder {
  static let empty = PathBuilder(
    buildPath: { _ in nil }
  )
}
