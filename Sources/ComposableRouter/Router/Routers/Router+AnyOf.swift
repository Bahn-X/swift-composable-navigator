import Foundation

public extension Router {
  static func anyOf(
    _ routers: [Router]
  ) -> Router {
    let buildPath = { path -> Routed? in
      return routers
        .compactMap { $0.build(path: path) }
        .first
    }

    let parse = { (components: [DeeplinkComponent]) in
      routers
        .compactMap { $0.parse(components: components) }
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
