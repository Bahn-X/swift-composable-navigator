public extension PathBuilder {
  /**
   Wildcard path builders replace any screen with a predefined one.

   Based on the example for the conditional path builder, you might run into a situation in which your deeplink parser parses a routing path that can only be handled by the homeScreenBuilder. This would lead to an empty application, which is unfortunate.

   To mitigate this problem, you can combine a conditional path builder with a wildcard path builder:

   ```swift
   .conditional(
       either: .wildcard(
           screen: HomeScreen(),
           pathBuilder: HomeScreen.builder(store: homeStore)
       ),
       or: wildcard(
           screen: LoginScreen(),
           loginScreen(store: loginStore)
       ),
       basedOn: { user.isLoggedIn }
   )
   ```

   This is example basically states: Whatever path I get, the first element should be a defined screen.

   # ⚠️ Warning ⚠️
   If you use a wildcard path builder in as part of an anyOf path builder, make sure it is the last one in the list. If it isn't, it will swallow all screens and the path builders listed after the wildcard will be ignored.

   - Parameters:
      - screen:
        The screen that replaces the current path element.
      - pathBuilder:
        The path builder used to build the altered path.
  */
  static func wildcard<S: Screen>(
    screen: S,
    pathBuilder: PathBuilder
  ) -> PathBuilder {
    PathBuilder(
      buildPath: { path in
        guard let identifiedWildcard = path.first.map(
            { IdentifiedScreen(id: $0.id, content: screen.eraseToAnyScreen(), hasAppeared: $0.hasAppeared) }
        ) else {
          return nil
        }
        
        return pathBuilder.build(path: [identifiedWildcard] + path[1...])
      }
    )
  }
}
