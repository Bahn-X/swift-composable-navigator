import SwiftUI

public extension Navigator {
  static func wildcard<S: Screen>(
    screen: S,
    navigator: Navigator
  ) -> Navigator {
    Navigator(
      lateInit: { dataSource in
        Navigator(
          buildPath: { path in
            guard let identifiedWildcard = path.first.map({ IdentifiedScreen(id: $0.id, content: screen.eraseToAnyScreen()) }) else {
              return nil
            }

            return navigator.build(path: [identifiedWildcard] + path[1...])
          }
        )
      }
    )
  }
}
