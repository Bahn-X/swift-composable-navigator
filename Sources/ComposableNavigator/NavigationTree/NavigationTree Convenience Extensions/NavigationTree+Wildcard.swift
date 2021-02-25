extension NavigationTree {
  /// Convenience wrapper around PathBuilders.wildcard. Replaces any screen with a predefined one.
  ///
  ///  Based on the example for the conditional `PathBuilder`, you might run into a situation in which your deeplink parser parses a routing path that can only be handled by the homeScreenBuilder. This would lead to an empty application, which is unfortunate.
  ///
  ///  To mitigate this problem, you can combine a conditional `PathBuilder` with a wildcard `PathBuilder`:
  ///
  ///  ```swift
  ///  .conditional(
  ///      either: .wildcard(
  ///          screen: HomeScreen(),
  ///          pathBuilder: HomeScreen.builder(store: homeStore)
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
  ///  If you use a wildcard `PathBuilder` in as part of an anyOf `PathBuilder`, make sure it is the last one in the list. If it isn't, it will swallow all screens and the `PathBuilder`s listed after the wildcard will be ignored.
  ///
  ///  - Parameters:
  ///     - screen:
  ///       The screen that replaces the current path element.
  ///     - pathBuilder:
  ///       The `PathBuilder` used to build the altered path.
  public func Wildcard<
    S: Screen,
    ContentBuilder: PathBuilder,
    Content
  >(
    screen: S,
    pathBuilder: ContentBuilder
  ) -> _PathBuilder<PathBuilders.WildcardView<Content,S>> where ContentBuilder.Content == Content {
    PathBuilders.wildcard(screen: screen, pathBuilder: pathBuilder)
  }
}
