import SwiftUI

public extension PathBuilders {
  /**
   Creates a path builder responsible for a single screen.

   The screen path builder describes how a single screen is built.  The content closure is only called if the path element's content of type HomeScreen.

   # Example
   ```swift
   PathBuilder.screen(
     content: { (screen: HomeScreen) in
       HomeView(...)
     },
     nesting: ...
   )
   ```

   The Home screen builder extracts `HomeScreen` instances from the routing path and uses it's nesting path builder to build the remaining path.

   - Parameters:
     - onAppear:
        Called whenever the screen appears. The passed bool is true, if it is the screens initial appear.
     - content:
        Closure describing how to build a SwiftUI view given the screen data.
     - nesting:
        Any path builder that can follow after this screen
   */
  static func screen<
    S: Screen,
    Content: View,
    SuccessorBuilder: PathBuilder,
    Successor
  >(
    onAppear: @escaping (Bool) -> Void = { _ in },
    @ViewBuilder content build: @escaping (S) -> Content,
    nesting: SuccessorBuilder
  ) -> _PathBuilder<Routed<Content, Successor>> where SuccessorBuilder.Content == Successor {
    _PathBuilder<Routed<Content, Successor>>(
      buildPath: { (path: [IdentifiedScreen]) -> Routed<Content, Successor>? in
        guard let head = path.first, let unwrapped: S = head.content.unwrap() else {
          return nil
        }

        return Routed(
          content: build(unwrapped),
          onAppear: onAppear,
          next: nesting.build(path:)
        )
      }
    )
  }

  /**
   Creates a path builder responsible for a single screen.

   The screen path builder describes how a single screen is built.  The content closure is only called if the path element's content of type HomeScreen.

   # Example
   ```swift
   PathBuilder.screen(
     content: { (screen: HomeScreen) in
       HomeView(...)
     }
   )
   ```

   The Home screen builder extracts `HomeScreen` instances from the routing path and uses it's nesting path builder to build the remaining path.

   - Parameters:
     - onAppear:
        Called whenever the screen appears. The passed bool is true, if it is the screens initial appear.
     - content:
        Closure describing how to build a SwiftUI view given the screen data.
   */
  static func screen<S: Screen, Content: View>(
    onAppear: @escaping (Bool) -> Void = { _ in },
    @ViewBuilder content build: @escaping (S) -> Content
  ) -> _PathBuilder<Routed<Content, Never>> {
    screen(
      onAppear: onAppear,
      content: build,
      nesting: PathBuilders.empty
    )
  }

  /**
   Creates a path builder responsible for a single screen.

   The screen path builder describes how a single screen is built.  The content closure is only called if the path element's content of type HomeScreen.

   # Example
   ```swift
   PathBuilder.screen(
     HomeScreen.self,
     content: {
       HomeView(...)
     },
     nesting: ...
   )
   ```

   The Home screen builder extracts `HomeScreen` instances from the routing path and uses it's nesting path builder to build the remaining path.

   - Parameters:
      - type:
        Defines which screens are handled by the path builder.
      - onAppear:
        Called whenever the screen appears. The passed bool is true, if it is the screens initial appear.
      - content:
        Closure describing how to build a SwiftUI view, if the current path element is of the defined screen type.
      - nesting:
        Any path builder that can follow after this screen
   */
  static func screen<
    S: Screen,
    Content: View,
    SuccessorBuilder: PathBuilder,
    Successor
  >(
    _ type: S.Type,
    onAppear: @escaping (Bool) -> Void = { _ in },
    @ViewBuilder content build: @escaping () -> Content,
    nesting: SuccessorBuilder
  ) -> _PathBuilder<Routed<Content, Successor>> where SuccessorBuilder.Content == Successor {
    _PathBuilder<Routed<Content, Successor>>(
      buildPath: { (path: [IdentifiedScreen]) -> Routed<Content, Successor>? in
        guard let head = path.first, head.content.is(S.self) else {
          return nil
        }

        return Routed(
          content: build(),
          onAppear: onAppear,
          next: nesting.build(path:)
        )
      }
    )
  }

  /**
   Creates a path builder responsible for a single screen.

   The screen path builder describes how a single screen is built.  The content closure is only called if the path element's content of type HomeScreen.

   # Example
   ```swift
   PathBuilder.screen(
     HomeScreen.self,
     content: {
       HomeView(...)
     }
   )
   ```

   The Home screen builder extracts `HomeScreen` instances from the routing path and uses it's nesting path builder to build the remaining path.

   - Parameters:
      - type:
        Defines which screens are handled by the path builder.
      - onAppear:
        Called whenever the screen appears. The passed bool is true, if it is the screens initial appear.
      - content:
        Closure describing how to build a SwiftUI view, if the current path element is of the defined screen type.
   */
  static func screen<S: Screen, Content: View>(
    _ type: S.Type,
    onAppear: @escaping (Bool) -> Void = { _ in },
    @ViewBuilder content build: @escaping () -> Content
  ) -> _PathBuilder<Routed<Content, Never>> {
    screen(
      type,
      onAppear: onAppear,
      content: build,
      nesting: PathBuilders.empty
    )
  }
}
