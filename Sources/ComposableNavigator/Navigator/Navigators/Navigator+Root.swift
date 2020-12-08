import ComposableArchitecture

public extension Navigator {
  static func root(
    dataSource: Navigator.DataSource,
    navigator: Navigator
  ) -> Navigator {
    let route = { (action: NavigatorAction) in
      ViewStore(dataSource).send(action)
    }

    return Navigator(
      route: route,
      buildPath: navigator.build(dataSource:path:),
      parse: navigator.parse
    )
  }
}
