import ComposableArchitecture
import Foundation

extension Router {
  static func nested(
    store: Store<RouterState, RouterAction>,
    _ root: Router,
    next: Router
  ) -> Router {
    let buildPath = { (path: [ScreenState]) -> Routed? in
      guard let route = path.first else {
        return nil
      }

      return root.build([route]).flatMap { root in
        let tail = Array(path.dropFirst())
        guard let tailFirst = tail.first else {
          return nil
        }
        var r = root
        r.next = Routed.Next(screenState: tailFirst, content: next.build(tail))
        return r
      }
    }

    let parse = { (url: URL) -> [AnyRoute]? in
      let path = url.absoluteString
        .split(separator: "/")
        .map(String.init)
        .compactMap(URL.init(string:))

      guard let head = path.first else {
        return nil
      }

      let tail = path.dropFirst()
          .map(\.absoluteString)
          .joined(separator: "/")
//        .compactMap(URL.init(string:))

      // TODO: figure out parsing and if we should use [URL] instead of URL
      return [] // root.parse(head) + next.parse(tail)
    }

    return Router(
      buildPath: buildPath,
      parse: parse
    )
  }
}
