import ComposableArchitecture
import Foundation
import SwiftUI

extension Coordinator {
  static func matching<R: Route, Content: View>(
    store: Store<CoordinatorState, CoordinatorAction>,
    parse: @escaping (URL) -> R?,
    @ViewBuilder content build: @escaping (R) -> Content
  ) -> Coordinator {
    let coordinate = { (action: CoordinatorAction) in
      ViewStore(store).send(action)
    }

    let buildRoute = { (route: AnyRoute) -> Coordinated? in
      guard let unwrappedRoute: R = route.unwrap() else {
        return nil
      }

      return Coordinated(
        store: store,
        buildRoute: { _ in fatalError(".matching coordinator implementation should replace this closure") },
        content: { build(unwrappedRoute) }
      )
    }

    let parseURL = { url in
      parse(url)
        .flatMap { $0.eraseToAnyRoute() }
    }

    return Coordinator(
      coordinate: coordinate,
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
