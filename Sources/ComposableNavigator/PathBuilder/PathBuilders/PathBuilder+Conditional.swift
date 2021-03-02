import SwiftUI

public extension PathBuilders {
  ///  The if `PathBuilder` controls which `PathBuilder` is reponsible for building the navigation path based on condition.
  ///
  ///  In some cases, you want to make sure that the user will never be able to reach certain parts of your application. For example, you might want to show a login screen as long the user hasn't logged in. For these cases, you can use a conditional `PathBuilder`s.
  ///
  ///  # Example
  ///  ```swift
  ///  .if(
  ///   { user.isLoggedIn },
  ///   then: HomeScreen.Builder(store: homeStore)
  ///  )
  ///  ```
  ///
  ///  The example here would never built navigation paths using the HomeScreen.Builder if the user isn't logged in. The condition is checked on each change of the navigation path.
  ///
  ///  - Parameters:
  ///     - condition:
  ///       Condition evaluated every time the navigation path is built.
  ///     - then:
  ///       PathBuilder used to build the navigation path, if the condition is true.
  static func `if`<If: PathBuilder>(
    _ condition: @escaping () -> Bool,
    then builder: If
  ) -> _PathBuilder<EitherAB<If.Content, Never>> {
    `if`(condition, then: builder, else: PathBuilders.empty)
  }

  ///  The if `PathBuilder` controls which `PathBuilder` is reponsible for building the navigation path based on condition.
  ///
  ///  In some cases, you want to make sure that the user will never be able to reach certain parts of your application. For example, you might want to show a login screen as long the user hasn't logged in. For these cases, you can use a conditional `PathBuilder`s.
  ///
  ///  # Example
  ///  ```swift
  ///  .if(
  ///   { user.isLoggedIn },
  ///   then: HomeScreen.Builder(store: homeStore),
  ///   else: LoginScreen.Builder(store: loginStore)
  ///  )
  ///  ```
  ///
  ///  The example here would never built navigation paths using the HomeScreen.Builder if the user isn't logged in. The condition is checked on each change of the navigation path.
  ///
  ///  - Parameters:
  ///     - condition:
  ///       Condition evaluated every time the navigation path is built.
  ///     - then:
  ///       PathBuilder used to build the navigation path, if the condition is true.
  ///     - else:
  ///       PathBuilder used to build the navigation path, if the condition is false.
  static func `if`<If: PathBuilder, Else: PathBuilder>(
    _ condition: @escaping () -> Bool,
    then thenBuilder: If,
    else elseBuilder: Else
  ) -> _PathBuilder<EitherAB<If.Content, Else.Content>> {
    _PathBuilder<EitherAB<If.Content, Else.Content>>(
      buildPath: { path -> EitherAB<If.Content, Else.Content>? in
        if condition() {
          return thenBuilder.build(path: path).map(EitherAB.a)
        } else {
          return elseBuilder.build(path: path).map(EitherAB.b)
        }
      }
    )
  }

  /// The ifLet `PathBuilder` unwraps an optional value and provides it to the `PathBuilder` defining closure.
  ///
  ///  # Example
  ///  ```swift
  ///  .if(
  ///     let: { store.detailStore },
  ///     then: { detailStore in
  ///       DetailScreen.Builder(store: detailStore)
  ///     },
  ///      else: // fallback if the value is not set.
  ///  )
  ///  ```
  /// - Parameters:
  ///   - let:
  ///     Closure unwrapping a value.
  ///   - then:
  ///     Closure defining the `PathBuilder` based on the unwrapped screen object.
  ///   - else:
  ///     Fallback pathbuilder used if the screen cannot be unwrapped.
  static func `if`<LetContent, If: PathBuilder, Else: PathBuilder>(
    `let`: @escaping () -> LetContent?,
    then: @escaping (LetContent) -> If,
    else: Else
  ) -> _PathBuilder<EitherAB<If.Content, Else.Content>> {
    _PathBuilder<EitherAB<If.Content, Else.Content>>(
      buildPath: { path -> EitherAB<If.Content, Else.Content>? in
        if let letContent = `let`() {
          return then(letContent).build(path: path).map(EitherAB.a)
        } else {
          return `else`.build(path: path).map(EitherAB.b)
        }
      }
    )
  }

  /// The ifLet `PathBuilder` unwraps an optional value and provides it to the `PathBuilder` defining closure.
  ///
  ///  # Example
  ///  ```swift
  ///  .if(
  ///     let: { store.detailStore },
  ///     then: { detailStore in
  ///       DetailScreen.Builder(store: detailStore)
  ///     },
  ///      else: // fallback if the value is not set.
  ///  )
  ///  ```
  /// - Parameters:
  ///   - let:
  ///     Closure unwrapping a value.
  ///   - then:
  ///     Closure defining the `PathBuilder` based on the unwrapped screen object.
  static func `if`<LetContent, If: PathBuilder>(
    `let`: @escaping () -> LetContent?,
    then: @escaping (LetContent) -> If
  ) -> _PathBuilder<EitherAB<If.Content, Never>> {
    `if`(let: `let`, then: then, else: PathBuilders.empty)
  }

  ///  The if screen `PathBuilder` unwraps a screen, if the path element matches the screen type, and provides it to the `PathBuilder` defining closure.
  ///
  ///  ```swift
  ///  .if(
  ///   screen: { (screen: DetailScreen) in
  ///     DetailScreen.Builder(store.detailStore(for: screen.id))
  ///   },
  ///   else: // fallback
  ///  )
  ///  ```
  ///
  ///  - Parameters:
  ///     - screen:
  ///       Closure defining the `PathBuilder` based on the unwrapped screen object.
  ///     - else:
  ///       Fallback pathbuilder used if the screen cannot be unwrapped.
  static func `if`<S: Screen, If: PathBuilder, Else: PathBuilder>(
    screen pathBuilder: @escaping (S) -> If,
    else: Else
  ) -> _PathBuilder<EitherAB<If.Content, Else.Content>> {
    _PathBuilder<EitherAB<If.Content, Else.Content>>(
      buildPath: { path -> EitherAB<If.Content, Else.Content>? in
        if let unwrappedScreen: S = path.current?.content.unwrap() {
          return pathBuilder(unwrappedScreen).build(path: path).map(EitherAB.a)
        } else {
          return `else`.build(path: path).map(EitherAB.b)
        }
      }
    )
  }

  ///  The if screen `PathBuilder` unwraps a screen, if the path element matches the screen type, and provides it to the `PathBuilder` defining closure.
  ///
  ///  ```swift
  ///  .if(
  ///   screen: { (screen: DetailScreen) in
  ///     DetailScreen.Builder(store.detailStore(for: screen.id))
  ///   }
  ///  )
  ///  ```
  ///
  ///  - Parameters:
  ///    - screen:
  ///      Closure defining the `PathBuilder` based on the unwrapped screen object.
  static func `if`<S: Screen, If: PathBuilder>(
    screen pathBuilder: @escaping (S) -> If
  ) -> _PathBuilder<EitherAB<If.Content, Never>> {
    PathBuilders.if(
      screen: pathBuilder,
      else: PathBuilders.empty
    )
  }
}
