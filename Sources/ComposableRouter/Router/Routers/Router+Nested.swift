import ComposableArchitecture
import Foundation
import SwiftUI

public extension Router {
  static func nested<R: Route, Content: View>(
    store: Store<RouterState, RouterAction>,
    parse: @escaping (URL) -> R?,
    @ViewBuilder content build: @escaping (R) -> Content,
    next: Router
  ) -> Router {
    let buildPath = { (path: [ScreenState]) -> Routed? in
      guard let route: R = path.first?.content.unwrap() else {
        return nil
      }
      let tail = Array(path.dropFirst())

      return Routed(
        store: store,
        content: build(route),
        next: tail.first.flatMap { nextScreen in
          Routed.Next(screenState: nextScreen, content: next.build(tail))
        }
      )
    }

    let parse = { (url: [URL]) -> [AnyRoute]? in
      guard let first = url.first else {
        return nil
      }

      let tail = Array(url.dropFirst())

      return parse(first).flatMap { first in
        [first.eraseToAnyRoute()] + (next.parse(tail) ?? [])
      }
    }

    return Router(
      buildPath: buildPath,
      parse: parse
    )
  }
}
