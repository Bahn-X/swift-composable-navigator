public extension PathBuilder {
  /**
   The empty path builder does not build any screen and just returns nil for all screens.

   Only use .empty as a stub value.
  */
  static let empty = PathBuilder(
    buildPath: { _ in nil }
  )
}
