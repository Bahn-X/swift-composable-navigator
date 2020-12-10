import ComposableArchitecture
import Foundation
import SwiftUI

public extension Navigator {
  /**
   Creates a navigator responsible for a single screen.

   - Parameters:
   - onAppear:
   Called whenever the screen appears. The passed bool is true, if it is the screens initial appear.
   - content:
   Closure describing how to build a SwiftUI view given the screen data.
   - nesting:
   Any navigators that can follow after this screen
   */
  static func screen<S: Screen, Content: View>(
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
              next: nesting?
                .lateInit(dataSource: dataSource)
                .build(path:)
            )
          }
        )
      }
    )
  }

  /**
   Creates a navigator responsible for a single screen type, ignoring any attributes of the screen.

   - Parameters:
    - type:
      Defines which screens are handled by the navigator.
    - onAppear:
      Called whenever the screen appears. The passed bool is true, if it is the screens initial appear.
    - content:
      Closure describing how to build a SwiftUI view, if the current path element is of the defined screen type.
    - nesting:
      Any navigators that can follow after this screen
   */
  static func screen<S: Screen, Content: View>(
    _ type: S.Type,
    onAppear: @escaping (Bool) -> Void = { _ in },
    @ViewBuilder content build: @escaping () -> Content,
    nesting: Navigator? = nil
  ) -> Navigator {
    Navigator(
      lateInit: { dataSource in
        Navigator(
          buildPath: { (path: [IdentifiedScreen]) -> Routed? in
            guard path.first?.content.is(S.self) ?? false else {
              return nil
            }

            return Routed(
              dataSource: dataSource,
              content: build(),
              onAppear: onAppear,
              next: nesting?
                .lateInit(dataSource: dataSource)
                .build(path:)
            )
          }
        )
      }
    )
  }
}
