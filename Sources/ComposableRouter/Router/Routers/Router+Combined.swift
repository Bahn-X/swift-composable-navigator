public extension Router {
  static func combine(
    _ routers: [Router]
  ) -> Router {
    let buildRoute = { route -> Routed? in
      return routers
        .compactMap { $0.build(route) }
        .first
    }

    return Router(
      route: { action in routers.first(where: { $0.route(action) }) != nil },
      buildRoute: { route in
        buildRoute(route).map {
          var next = $0
          next.buildRoute = buildRoute
          return next
        }
      },
      parse: { url in
        routers
          .compactMap { $0.parse(url) }
          .first
      }
    )
  }

  static func combine(
    _ coordinators: Router...
  ) -> Router {
    combine(coordinators)
  }
}
