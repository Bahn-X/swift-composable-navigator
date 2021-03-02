import SwiftUI

public extension PathBuilders {
  ///  PathBuilder responsible for a single screen.
  ///
  ///  The screen `PathBuilder` describes how a single screen is built.  The content closure is only called if the path element's content of type HomeScreen.
  ///
  ///  # Example
  ///  ```swift
  ///   PathBuilders.screen(
  ///    content: { (screen: HomeScreen) in
  ///      HomeView(...)
  ///    },
  ///     nesting: ...
  ///  )
  ///  ```
  ///
  ///  The Home screen builder extracts `HomeScreen` instances from the navigation path and uses it's nesting `PathBuilder` to build the remaining path.
  ///
  ///  - Parameters:
  ///    - onAppear:
  ///      Called whenever the screen appears. The passed bool is true, if it is the screens initial appear.
  ///    - content:
  ///      Closure describing how to build a SwiftUI view given the screen data.
  ///    - nesting:
  ///      Any `PathBuilder` that can follow after this screen
  static func screen<
    S: Screen,
    Content: View,
    Successor: PathBuilder
  >(
    onAppear: @escaping (Bool) -> Void = { _ in },
    @ViewBuilder content build: @escaping (S) -> Content,
    nesting: Successor
  ) -> _PathBuilder<NavigationNode<Content, Successor.Content>> {
    _PathBuilder<NavigationNode<Content, Successor.Content>>(
      buildPath: { path -> NavigationNode<Content, Successor.Content>? in
        guard let head = path.current, let unwrapped: S = head.content.unwrap() else {
          _ = nesting.build(path: .empty)
          return nil
        }

        return NavigationNode(
          content: build(unwrapped),
          onAppear: onAppear,
          buildSuccessor: nesting.build(path:)
        )
      }
    )
  }

  ///  PathBuilder responsible for a single screen.
  ///
  ///  The screen `PathBuilder` describes how a single screen is built.  The content closure is only called if the path element's content of type HomeScreen.
  ///
  ///  # Example
  ///  ```swift
  ///   PathBuilders.screen(
  ///    content: { (screen: HomeScreen) in
  ///      HomeView(...)
  ///    }
  ///   )
  ///  ```
  ///
  ///  The Home screen builder extracts `HomeScreen` instances from the navigation path and uses it's nesting `PathBuilder` to build the remaining path.
  ///
  ///  - Parameters:
  ///    - onAppear:
  ///      Called whenever the screen appears. The passed bool is true, if it is the screens initial appear.
  ///    - content:
  ///      Closure describing how to build a SwiftUI view given the screen data.
  static func screen<S: Screen, Content: View>(
    onAppear: @escaping (Bool) -> Void = { _ in },
    @ViewBuilder content build: @escaping (S) -> Content
  ) -> _PathBuilder<NavigationNode<Content, Never>> {
    screen(
      onAppear: onAppear,
      content: build,
      nesting: PathBuilders.empty
    )
  }

  /// Creates a `PathBuilder` responsible for a single screen.
  ///
  /// The screen `PathBuilder` describes how a single screen is built.  The content closure is only called if the path element's content of type HomeScreen.
  ///
  ///  # Example
  ///  ```swift
  ///  PathBuilders.screen(
  ///    HomeScreen.self,
  ///    content: {
  ///      HomeView(...)
  ///    },
  ///    nesting: ...
  ///  )
  ///  ```
  ///
  ///  The Home screen builder extracts `HomeScreen` instances from the navigation path and uses it's nesting `PathBuilder` to build the remaining path.
  ///
  ///  - Parameters:
  ///     - type:
  ///       Defines which screens are handled by the `PathBuilder`.
  ///     - onAppear:
  ///       Called whenever the screen appears. The passed bool is true, if it is the screens initial appear.
  ///     - content:
  ///       Closure describing how to build a SwiftUI view, if the current path element is of the defined screen type.
  ///    - nesting:
  ///      Any `PathBuilder` that can follow after this screen
  static func screen<
    S: Screen,
    Content: View,
    Successor: PathBuilder
  >(
    _ type: S.Type,
    onAppear: @escaping (Bool) -> Void = { _ in },
    @ViewBuilder content build: @escaping () -> Content,
    nesting: Successor
  ) -> _PathBuilder<NavigationNode<Content, Successor.Content>> {
    _PathBuilder<NavigationNode<Content, Successor.Content>>(
      buildPath: { path -> NavigationNode<Content, Successor.Content>? in
        guard let head = path.current, head.content.is(S.self) else {
          _ = nesting.build(path: .empty)
          return nil
        }

        return NavigationNode(
          content: build(),
          onAppear: onAppear,
          buildSuccessor: nesting.build(path:)
        )
      }
    )
  }

  /// PathBuilder responsible for a single screen.
  ///
  ///  The screen `PathBuilder` describes how a single screen is built.  The content closure is only called if the path element's content of type HomeScreen.
  ///
  ///  # Example
  ///  ```swift
  ///  PathBuilders.screen(
  ///    HomeScreen.self,
  ///    content: {
  ///      HomeView(...)
  ///    }
  ///  )
  ///   ```
  ///
  ///  The Home screen builder extracts `HomeScreen` instances from the navigation path and uses it's nesting `PathBuilder` to build the remaining path.
  ///
  ///  - Parameters:
  ///     - type:
  ///       Defines which screens are handled by the `PathBuilder`.
  ///     - onAppear:
  ///       Called whenever the screen appears. The passed bool is true, if it is the screens initial appear.
  ///     - content:
  ///       Closure describing how to build a SwiftUI view, if the current path element is of the defined screen type.
  static func screen<S: Screen, Content: View>(
    _ type: S.Type,
    onAppear: @escaping (Bool) -> Void = { _ in },
    @ViewBuilder content build: @escaping () -> Content
  ) -> _PathBuilder<NavigationNode<Content, Never>> {
    screen(
      type,
      onAppear: onAppear,
      content: build,
      nesting: PathBuilders.empty
    )
  }
}
