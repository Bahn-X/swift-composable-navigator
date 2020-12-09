import SwiftUI

public extension Navigator {
    struct Wildcard<S: Screen>: Hashable {
        public let screen: S
        public let deeplinkComponent: DeeplinkComponent

        public init(screen: S, deeplinkComponent: DeeplinkComponent) {
            self.screen = screen
            self.deeplinkComponent = deeplinkComponent
        }
    }

    static func wildcard<S: Screen>(
        wildcard: Wildcard<S>,
        navigator: Navigator
    ) -> Navigator {
        Navigator(
            lateInit: { dataSource in
                Navigator(
                    buildPath: { path in
                        guard let first = path.first.map({ IdentifiedScreen(id: $0.id, content: wildcard.screen) }) else {
                            return nil
                        }

                        return navigator.build(path: [first] + path[1...])
                    },
                    parse: { components in
                        return navigator.parse(components: [wildcard.deeplinkComponent] + components[1...])
                    }
                )
            }
        )
    }
}
