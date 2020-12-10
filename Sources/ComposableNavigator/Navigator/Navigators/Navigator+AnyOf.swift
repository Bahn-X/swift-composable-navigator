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
            for navigator in initializedNavigators {
              if let view = navigator.build(path: path) {
                return view
              }
            }
            return nil
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
