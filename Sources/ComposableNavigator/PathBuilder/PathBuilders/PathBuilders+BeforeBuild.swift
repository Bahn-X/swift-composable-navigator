public extension PathBuilder {
    func beforeBuild(perform action: @escaping () -> Void) -> _PathBuilder<Content> {
        _PathBuilder(
            buildPath: { path in
                action()
                return build(path: path)
            }
        )
    }
}
