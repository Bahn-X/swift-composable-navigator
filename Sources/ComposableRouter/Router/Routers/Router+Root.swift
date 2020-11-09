import ComposableArchitecture

public extension Router {
  static func root(
    store: Store<RouterState, RouterAction>,
    router: Router
  ) -> Router {
    let route = { (action: RouterAction) in
      ViewStore(store).send(action)
    }

    return Router(
      route: route,
      buildPath: router.build,
      parse: router.parse
    )
  }
}
