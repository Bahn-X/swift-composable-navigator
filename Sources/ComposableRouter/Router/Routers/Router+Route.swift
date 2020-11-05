import ComposableArchitecture
import Foundation
import SwiftUI

extension Router {
  static func route<R: Route, Content: View>(
    store: Store<RouterState, RouterAction>,
    parse: @escaping (URL) -> R?,
    @ViewBuilder content build: @escaping (R) -> Content
  ) -> Router {
    let route = { (action: RouterAction) -> Bool in
      ViewStore(store).send(action)
      return true
    }

    let buildRoute = { (route: AnyRoute) -> Routed? in
      guard let unwrappedRoute: R = route.unwrap() else {
        return nil
      }

      return Routed(
        store: store,
        buildRoute: { _ in fatalError(".matching coordinator implementation should replace this closure") },
        content: { build(unwrappedRoute) }
      )
    }

    let parseURL = { url in
      parse(url).flatMap { [$0.eraseToAnyRoute()] }
    }

    return Router(
      route: route,
      buildRoute: { route in
        buildRoute(route).map {
          var next = $0
          next.buildRoute = buildRoute
          return next
        }
      },
      parse: parseURL
    )
  }
}
