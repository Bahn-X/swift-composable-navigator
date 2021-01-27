import SwiftUI

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
  static func conditional<If: View, Else: View>(
    either: PathBuilder<If>,
    or: PathBuilder<Else>,
    basedOn condition: @escaping () -> Bool
  ) -> PathBuilder<EitherAB<If, Else>> {
    .if(condition, then: either, else: or)
  }

  /**
   The if path builder controls which path builder is reponsible for building the routing path based on condition.

   In some cases, you want to make sure that the user will never be able to reach certain parts of your application. For example, you might want to show a login screen as long the user hasn't logged in. For these cases, you can use a conditional path builders.

   # Example
   ```swift
   .if(
    { user.isLoggedIn },
    then: HomeScreen.builder(store: homeStore)
   )
   ```

   The example here would never built routing paths using the HomeScreen.nuilder if the user isn't logged in. The condition is checked on each change of the routing path.

   - Parameters:
      - condition:
        Condition evaluated every time the routing path is built.
      - then:
        PathBuilder used to build the routing path, if the condition is true.
   */
  static func `if`<If: View>(
    _ condition: @escaping () -> Bool,
    then builder: PathBuilder<If>
  ) -> PathBuilder<If> {
    PathBuilder<If>(
      buildPath: { path -> If? in
        if condition() {
          return builder.build(path: path)
        } else {
          return nil
        }
      }
    )
  }

  /**
   The if path builder controls which path builder is reponsible for building the routing path based on condition.

   In some cases, you want to make sure that the user will never be able to reach certain parts of your application. For example, you might want to show a login screen as long the user hasn't logged in. For these cases, you can use a conditional path builders.

   # Example
   ```swift
   .if(
    { user.isLoggedIn },
    then: HomeScreen.builder(store: homeStore),
    else: LoginScreen.builder(store: loginStore)
   )
   ```

   The example here would never built routing paths using the HomeScreen.nuilder if the user isn't logged in. The condition is checked on each change of the routing path.

   - Parameters:
      - condition:
        Condition evaluated every time the routing path is built.
      - then:
        PathBuilder used to build the routing path, if the condition is true.
      - else:
        PathBuilder used to build the routing path, if the condition is false.
   */
  static func `if`<If: View, Else: View>(
    _ condition: @escaping () -> Bool,
    then thenBuilder: PathBuilder<If>,
    else elseBuilder: PathBuilder<Else>
  ) -> PathBuilder<EitherAB<If, Else>> {
    PathBuilder<EitherAB<If, Else>>(
      buildPath: { path -> EitherAB<If, Else>? in
        if condition(), let this = thenBuilder.build(path: path) {
          return .a(this)
        } else if let that = elseBuilder.build(path: path) {
          return .b(that)
        } else {
          return nil
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
      },
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
  static func `if`<LetContent, If: View, Else: View>(
    `let`: @escaping () -> LetContent?,
    then: @escaping (LetContent) -> PathBuilder<If>,
    else: PathBuilder<Else>
  ) -> PathBuilder<EitherAB<If, Else>> {
    PathBuilder<EitherAB<If, Else>>(
      buildPath: { path -> EitherAB<If, Else>? in
        guard let letContent = `let`() else {
          return `else`.build(path: path).flatMap(EitherAB.b)
        }
        return then(letContent).build(path: path).flatMap(EitherAB.a)
      }
    )
  }

  /**
   The if screen path builder unwraps a screen, if the path element matches the screen type, and provides it to the path builder defining closure.

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
  static func `if`<S: Screen, If: View, Else: View>(
    screen pathBuilder: @escaping (S) -> PathBuilder<If>?,
    else: PathBuilder<Else>
  ) -> PathBuilder<EitherAB<If, Else>> {
    PathBuilder<EitherAB<If, Else>>(
      buildPath: { path -> EitherAB<If, Else>? in
        guard let unwrappedScreen: S = path.first?.content.unwrap() else {
          return `else`.build(path: path).flatMap(EitherAB.b)
        }

        return pathBuilder(unwrappedScreen)?.build(path: path).flatMap(EitherAB.a)
      }
    )
  }

  /**
   The if screen path builder unwraps a screen, if the path element matches the screen type, and provides it to the path builder defining closure.

   ```swift
   .if(
    screen: { (screen: DetailScreen) in
      DetailScreen.builder(store.detailStore(for: screen.id))
    }
   )
   ```

   - Parameters:
      - screen:
        Closure defining the path builder based on the unwrapped screen object.
   */
  static func `if`<S: Screen, If: View>(
    screen pathBuilder: @escaping (S) -> PathBuilder<If>?
  ) -> PathBuilder<EitherAB<If, Never>> {
    .if(screen: pathBuilder, else: .empty)
  }
}
