import ComposableArchitecture

public extension Navigator {
  static func root(
    store: Store<NavigatorState, NavigatorAction>,
    navigator: Navigator
  ) -> Navigator {
    let route = { (action: NavigatorAction) in
      ViewStore(store).send(action)
    }

    return Navigator(
      route: route,
      buildPath: navigator.build,
      parse: navigator.parse
    )
  }
}
