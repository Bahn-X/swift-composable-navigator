public extension PathBuilder {
    /// Performs an action before this path builder is built.
    func beforeBuild(perform action: @escaping () -> Void) -> _PathBuilder<Content> {
        _PathBuilder(
            buildPath: { path in
                action()
                return build(path: path)
            }
        )
    }
}
