import Foundation

public extension PathBuilder {
  static func anyOf(
    _ builders: [PathBuilder]
  ) -> PathBuilder {
    PathBuilder(
        buildPath: { path in
            for builder in builders {
                if let view = builder.build(path: path) {
                  return view
                }
            }
            return nil
        }
    )
  }

  static func anyOf(
    _ builders: PathBuilder...
  ) -> PathBuilder {
    anyOf(builders)
  }
}
