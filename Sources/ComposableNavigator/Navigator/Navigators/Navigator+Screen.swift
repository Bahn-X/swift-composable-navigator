import ComposableArchitecture
import Foundation
import SwiftUI

public extension Navigator {
  /**
   Creates a navigator responsible for a single screen.

   - Parameters:
   - parse:
   Closure describing how to parse the screen from a given deeplink component.
   - onAppear:
   Called whenever the screen appears. The passed bool is true, if it is the screens initial appear.
   - content:
   Closure describing how to build a SwiftUI view given the screen data.
   - nesting:
   Any navigators that can follow after this screen
   */
  static func screen<S: Screen, Content: View>(
    parse: @escaping (DeeplinkComponent) -> S?,
    onAppear: @escaping (Bool) -> Void = { _ in },
    @ViewBuilder content build: @escaping (S) -> Content,
    nesting: Navigator? = nil
  ) -> Navigator {
    Navigator(
      lateInit: { dataSource in
        Navigator(
          buildPath: { (path: [IdentifiedScreen]) -> Routed? in
            guard let head: S = path.first?.content.unwrap() else {
              return nil
            }

            return Routed(
              dataSource: dataSource,
              content: build(head),
              onAppear: onAppear,
              next: nesting
                .flatMap { $0.lateInit(dataSource: dataSource) }?
                .build(path:)
            )
          },
          parse: { (components: [DeeplinkComponent]) -> [AnyScreen]? in
            guard let head = components.first,
                  let firstScreen = parse(head) else {
              return nil
            }

            let tail = Array(components.dropFirst())
            let nestedScreens = (nesting?.parse(components: tail) ?? [])

            return [firstScreen.eraseToAnyScreen()] + nestedScreens
          }
        )
      }
    )
  }
}
