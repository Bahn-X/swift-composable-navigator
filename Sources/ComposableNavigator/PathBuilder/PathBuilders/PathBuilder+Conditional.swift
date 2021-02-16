import SwiftUI

public extension PathBuilders {
  /// The conditional `PathBuilder` controls which `PathBuilder` is reponsible for building the routing path based on condition.
  /// In some cases, you want to make sure that the user will never be able to reach certain parts of your application. For example, you might want to show a login screen as long the user hasn't logged in. For these cases, you can use a conditional `PathBuilder`s.
  ///
  /// # Example
  /// ```swift
  ///   .conditional(
  ///     either: HomeScreen.builder(store: homeStore),
  ///     or: LoginScreen.builder(store: loginStore),
  ///     basedOn: { user.isLoggedIn }
  ///   )
  /// ```
  ///
  /// The example here would never built routing paths using the HomeScreen.nuilder if the user isn't logged in. The condition is checked on each change of the routing path.
  ///
  /// - Parameters:
  ///   - either:
  ///     PathBuilder used to build the routing path, if the condition is true.
  ///   - or:
  ///     PathBuilder used to build the routing path, if the condition is false.
  ///   - basedOn:
  ///     Condition evaluated every time the routing path is built.
  static func conditional<
    If: PathBuilder,
    Else: PathBuilder
  >(
    either: If,
    or: Else,
    basedOn condition: @escaping () -> Bool
  ) -> some PathBuilder {
    PathBuilders.if(
      condition,
      then: either,
      else: or
    )
  }

  ///  The if `PathBuilder` controls which `PathBuilder` is reponsible for building the routing path based on condition.
  ///
  ///  In some cases, you want to make sure that the user will never be able to reach certain parts of your application. For example, you might want to show a login screen as long the user hasn't logged in. For these cases, you can use a conditional `PathBuilder`s.
  ///
  ///  # Example
  ///  ```swift
  ///  .if(
  ///   { user.isLoggedIn },
  ///   then: HomeScreen.builder(store: homeStore)
  ///  )
  ///  ```
  ///
  ///  The example here would never built routing paths using the HomeScreen.nuilder if the user isn't logged in. The condition is checked on each change of the routing path.
  ///
  ///  - Parameters:
  ///     - condition:
  ///       Condition evaluated every time the routing path is built.
  ///     - then:
  ///       PathBuilder used to build the routing path, if the condition is true.
  static func `if`<If: PathBuilder>(
    _ condition: @escaping () -> Bool,
    then builder: If
  ) -> some PathBuilder {
    _PathBuilder<If.Content>(
      buildPath: { path -> If.Content? in
        if condition() {
          return builder.build(path: path)
        } else {
          return nil
        }
      }
    )
  }

  ///  The if `PathBuilder` controls which `PathBuilder` is reponsible for building the routing path based on condition.
  ///
  ///  In some cases, you want to make sure that the user will never be able to reach certain parts of your application. For example, you might want to show a login screen as long the user hasn't logged in. For these cases, you can use a conditional `PathBuilder`s.
  ///
  ///  # Example
  ///  ```swift
  ///  .if(
  ///   { user.isLoggedIn },
  ///   then: HomeScreen.builder(store: homeStore),
  ///   else: LoginScreen.builder(store: loginStore)
  ///  )
  ///  ```
  ///
  ///  The example here would never built routing paths using the HomeScreen.nuilder if the user isn't logged in. The condition is checked on each change of the routing path.
  ///
  ///  - Parameters:
  ///     - condition:
  ///       Condition evaluated every time the routing path is built.
  ///     - then:
  ///       PathBuilder used to build the routing path, if the condition is true.
  ///     - else:
  ///       PathBuilder used to build the routing path, if the condition is false.
  static func `if`<If: PathBuilder, Else: PathBuilder>(
    _ condition: @escaping () -> Bool,
    then thenBuilder: If,
    else elseBuilder: Else
  ) -> _PathBuilder<EitherAB<If.Content, Else.Content>> {
    _PathBuilder<EitherAB<If.Content, Else.Content>>(
      buildPath: { path -> EitherAB<If.Content, Else.Content>? in
        if condition() {
          _ = elseBuilder.build(path: [])
          return thenBuilder.build(path: path).map(EitherAB.a)
        } else {
          _ = thenBuilder.build(path: [])
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
  ///       DetailScreen.builder(store: detailStore)
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
          _ = `else`.build(path: [])
          return then(letContent).build(path: path).map(EitherAB.a)
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
  ///     DetailScreen.builder(store.detailStore(for: screen.id))
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
        if let unwrappedScreen: S = path.first?.content.unwrap() {
          _ = `else`.build(path: [])
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
  ///     DetailScreen.builder(store.detailStore(for: screen.id))
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
