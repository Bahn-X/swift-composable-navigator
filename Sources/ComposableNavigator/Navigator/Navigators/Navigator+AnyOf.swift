import Foundation

public extension Navigator {
  static func anyOf(
    _ navigators: [Navigator]
  ) -> Navigator {
    Navigator(
        lateInit: { dataSource in
          let initializedNavigators = navigators.map {
            $0.lateInit(dataSource: dataSource)
          }

          return Navigator(
            buildPath: { path -> Routed? in
              return initializedNavigators
                .compactMap { $0.build(path: path) }
                .first
            },
            parse: { (components: [DeeplinkComponent]) in
              initializedNavigators
                .compactMap { $0.parse(components: components) }
                .first
            }
          )
        }
    )
  }

  static func anyOf(
    _ navigators: Navigator...
  ) -> Navigator {
    anyOf(navigators)
  }
}
