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
      guard let head: S = path.first?.content.unwrap() else {
        return nil
      }

      return Routed(
        store: store,
        content: build(head),
        next: nesting?.build(path:)
      )
    }

    let parse = { (components: [DeeplinkComponent]) -> [AnyScreen]? in
      guard let head = components.first,
            let firstScreen = parse(head) else {
        return nil
      }

      let tail = Array(components.dropFirst())
      let nestedScreens = (nesting?.parse(components: tail) ?? [])

      return [firstScreen.eraseToAnyScreen()] + nestedScreens
    }

    return Router(
      buildPath: buildPath,
      parse: parse
    )
  }
}
