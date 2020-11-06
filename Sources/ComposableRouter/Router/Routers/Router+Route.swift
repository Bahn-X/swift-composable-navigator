import ComposableArchitecture
import Foundation
import SwiftUI

extension Router {
  static func route<R: Route, Content: View>(
    store: Store<RouterState, RouterAction>,
    parse: @escaping (URL) -> R?,
    @ViewBuilder content build: @escaping (R) -> Content
  ) -> Router {
    let buildPath = { (path: [ScreenState]) -> Routed? in
      guard let unwrappedScreenState = path.first,
            let route: R = unwrappedScreenState.content.unwrap() else {
        return nil
      }

      return Routed(
        store: store,
        content: build(route),
        next: nil
      )
    }

    let parseURL = { url in
      parse(url).flatMap { [$0.eraseToAnyRoute()] }
    }

    return Router(
      buildPath: buildPath,
      parse: parseURL
    )
  }
}
