public extension Coordinator {
  static func combine(
    _ coordinators: [Coordinator]
  ) -> Coordinator {
    let buildRoute = { route -> Coordinated? in
      return coordinators
        .compactMap { $0.build(route) }
        .first
    }

    return Coordinator(
      coordinate: { action in
        coordinators.forEach { $0.coordinate(action) }
      },
      buildRoute: { route in
        buildRoute(route).map {
          var next = $0
          next.buildRoute = buildRoute
          return next
        }
      },
      parse: { url in
        coordinators
          .compactMap { $0.parse(url) }
          .first
      }
    )
  }

  static func combine(
    _ coordinators: Coordinator...
  ) -> Coordinator {
    combine(coordinators)
  }
}
