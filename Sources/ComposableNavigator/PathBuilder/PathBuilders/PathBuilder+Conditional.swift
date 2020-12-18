public extension PathBuilder {
  /**
   The conditional path builder controls which path builder is reponsible for building the routing path based on condition.

   In some cases, you want to make sure that the user will never be able to reach certain parts of your application. For example, you might want to show a login screen as long the user hasn't logged in. For these cases, you can use a conditional path builders.

   # Example
   ```swift
   .conditional(
       either: HomeScreen.builder(store: homeStore),
       or: LoginScreen.builder(store: loginStore),
       basedOn: { user.isLoggedIn }
   )
   ```

   The example here would never built routing paths using the HomeScreen.nuilder if the user isn't logged in. The condition is checked on each change of the routing path.

    - Parameters:
      - either:
        PathBuilder used to build the routing path, if the condition is true.
      - or:
        PathBuilder used to build the routing path, if the condition is false.
      - basedOn:
        Condition evaluated every time the routing path is built.
  */
  static func conditional(
    either: PathBuilder,
    or: PathBuilder,
    basedOn condition: @escaping () -> Bool
  ) -> PathBuilder {
    PathBuilder(
      buildPath: { path in
        if condition() {
          return either.build(path: path)
        } else {
          return or.build(path: path)
        }
      }
    )
  }

  /**
   The ifLet path builder unwraps an optional value and provides it to the path builder defining closure.

   # Example
   ```swift
   .if(
     let: { store.detailStore },
     then: { detailStore in
       DetailScreen.builder(store: detailStore)
     }
     else: // fallback if the value is not set.
   )
   ```
   - Parameters:
      - let:
        Closure unwrapping a value.
      - then:
        Closure defining the path builder based on the unwrapped screen object.
      - else:
        Fallback pathbuilder used if the screen cannot be unwrapped.
  */
  static func `if`<LetContent>(
    `let`: @escaping () -> LetContent?,
    then: @escaping (LetContent) -> PathBuilder,
    else: PathBuilder? = nil
  ) -> PathBuilder {
    PathBuilder(
      buildPath: { path in
        if let letContent = `let`() {
          return then(letContent).build(path: path)
        } else {
          return `else`?.build(path: path)
        }
      }
    )
  }

  /**
   The ifLet path builder unwraps a screen, if the path element matches the screen type, and provides it to the path builder defining closure.

   ```swift
   .if(
     screen: { (screen: DetailScreen) in
       DetailScreen.builder(store.detailStore(for: screen.id))
     },
     else: // fallback
   )
   ```

   - Parameters:
      - screen:
        Closure defining the path builder based on the unwrapped screen object.
      - else:
        Fallback pathbuilder used if the screen cannot be unwrapped.
  */
  static func `if`<S: Screen>(
    screen pathBuilder: @escaping (S) -> PathBuilder?,
    else: PathBuilder? = nil
  ) -> PathBuilder {
    PathBuilder(
      buildPath: { path in
        guard let unwrappedScreen: S = path.first?.content.unwrap() else {
          return `else`?.build(path: path)
        }

        return pathBuilder(unwrappedScreen)?.build(path: path)
      }
    )
  }
}
