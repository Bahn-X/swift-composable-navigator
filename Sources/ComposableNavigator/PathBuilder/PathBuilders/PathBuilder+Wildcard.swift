import SwiftUI

public extension PathBuilders {
  /// Wildcard View replaces the current path element with the passed wildcard, when it appears.
  ///
  /// - SeeAlso: `PathBuilders.wildcard(screen:, pathBuilder:)`
  struct WildcardView<Content: View, Wildcard: Screen>: View {
    @Environment(\.navigator) var navigator
    @Environment(\.currentScreenID) var id
    let wildcard: Wildcard
    let content: Content

    public var body: some View {
      content
        .uiKitOnAppear {
          navigator.replaceContent(of: id, with: wildcard)
        }
    }
  }

  ///  Wildcard `PathBuilder`s replace any screen with a predefined one.
  ///
  ///  Based on the example for the conditional `PathBuilder`, you might run into a situation in which your deeplink parser parses a navigation path that can only be handled by the homeScreenBuilder. This would lead to an empty application, which is unfortunate.
  ///
  ///  To mitigate this problem, you can combine a conditional `PathBuilder` with a wildcard `PathBuilder`:
  ///
  ///  ```swift
  ///  .conditional(
  ///      either: .wildcard(
  ///          screen: HomeScreen(),
  ///          pathBuilder: HomeScreen.Builder(store: homeStore)
  ///      ),
  ///      or: wildcard(
  ///          screen: LoginScreen(),
  ///          loginScreen(store: loginStore)
  ///     ),
  ///      basedOn: { user.isLoggedIn }
  ///  )
  ///  ```
  ///
  ///  This is example basically states: Whatever path I get, the first element should be a defined screen.
  ///
  ///  # ⚠️ Warning ⚠️
  ///  If you use a wildcard `PathBuilder` in as part of an anyOf `PathBuilder`, make sure it is the last one in the list. If it isn't, it will swallow all screens and the `PathBuilder`s listed after the wildcard will be unreachable.
  ///
  ///  - Parameters:
  ///     - screen:
  ///       The screen that replaces the current path element.
  ///     - pathBuilder:
  ///       The `PathBuilder` used to build the altered path.
  static func wildcard<
    S: Screen,
    ContentBuilder: PathBuilder,
    Content
  >(
    screen: S,
    pathBuilder: ContentBuilder
  ) -> _PathBuilder<WildcardView<Content, S>> where ContentBuilder.Content == Content {
    _PathBuilder { pathElement in
      pathBuilder.build(
        pathElement: pathElement.wildcard(
          screen: screen
        )
      )
      .flatMap { content in
        WildcardView(
          wildcard: screen,
          content: content
        )
      }
    }
  }
}

extension ActiveNavigationTreeElement {
  func wildcard<S: Screen>(screen: S) -> ActiveNavigationTreeElement {
    switch self {
    case .screen, .tabbed:
      return .screen(
        IdentifiedScreen(
          id: id,
          content: screen,
          hasAppeared: hasAppeared
        )
      )
    }
  }
}
