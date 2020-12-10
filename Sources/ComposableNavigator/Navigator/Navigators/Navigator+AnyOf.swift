import Foundation

public extension Navigator {
  static func anyOf(
    _ navigators: [Navigator]
  ) -> Navigator {
    Navigator(
      lateInit: { dataSource in
        return Navigator(
          buildPath: { path -> Routed? in
            for navigator in navigators {
              if let view = navigator.lateInit(dataSource: dataSource).build(path: path) {
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
