import ComposableArchitecture
import Foundation
import SwiftUI

public extension Router {
  static func screen<S: Screen, Content: View>(
    store: Store<RouterState, RouterAction>,
    parse: @escaping (DeeplinkComponent) -> S?,
    @ViewBuilder content build: @escaping (S) -> Content,
    nesting: Router? = nil
  ) -> Router {
    let buildPath = { (path: [IdentifiedScreen]) -> Routed? in
      guard let route: S = path.first?.content.unwrap() else {
        return nil
      }
      let tail = Array(path.dropFirst())

      return Routed(
        store: store,
        content: build(route),
        next: {
          guard let nesting = nesting,
                let nextScreen = tail.first,
                let nextContent = nesting.build(tail)
          else {
            return nil
          }
          return Routed.Next(screenState: nextScreen, content: nextContent)
        }()
      )
    }

    let parse = { (url: [DeeplinkComponent]) -> [AnyScreen]? in
      guard let first = url.first, let firstScreen = parse(first) else {
        return nil
      }

      let tail = Array(url.dropFirst())
      let nestedScreens = (nesting?.parse(tail) ?? [])

      return [firstScreen.eraseToAnyScreen()] + nestedScreens
    }

    return Router(
      buildPath: buildPath,
      parse: parse
    )
  }
}
