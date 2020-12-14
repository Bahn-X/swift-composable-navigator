public extension PathBuilder {
  static func wildcard<S: Screen>(
    screen: S,
    pathBuilder: PathBuilder
  ) -> PathBuilder {
    PathBuilder(
      buildPath: { path in
        guard let identifiedWildcard = path.first.map({ IdentifiedScreen(id: $0.id, content: screen.eraseToAnyScreen()) }) else {
          return nil
        }
        
        return pathBuilder.build(path: [identifiedWildcard] + path[1...])
      }
    )
  }
}
