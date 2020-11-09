import Foundation

public extension Router {
  static func anyOf(
    _ routers: [Router]
  ) -> Router {
    let buildPath = { route -> Routed? in
      return routers
        .compactMap { $0.build(route) }
        .first
    }

    let parse = { (url: [URL]) in
      routers
        .compactMap { $0.parse(url) }
        .first
    }

    return Router(
      buildPath: buildPath,
      parse: parse
    )
  }

  static func anyOf(
    _ routers: Router...
  ) -> Router {
    anyOf(routers)
  }
}
