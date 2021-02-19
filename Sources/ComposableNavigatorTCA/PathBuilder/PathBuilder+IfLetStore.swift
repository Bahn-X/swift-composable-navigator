import ComposableArchitecture
import ComposableNavigator
import SwiftUI

public extension PathBuilders {
  /// A `PathBuilder` that safely unwraps a store of optional state in order to show one of two views.
  ///
  /// When the underlying state is non-`nil`, the `then` closure will be performed with a `Store` that
  /// holds onto non-optional state to build the routing path, and otherwise the `else` PathBuilder will be used.
  /// ```swift
  /// PathBuilder.ifLetStore(
  ///   store: store.scope(state: \SearchState.results, action: SearchAction.results),
  ///   then: { store in DetailScreen.builder(store: store) },
  ///   else: NotFoundScreen.builder()
  /// )
  /// ```
  ///
  /// - Parameters:
  ///   - store: The store scoping to the optional state
  ///   - then: Closure defining how to build the path building given a non-optional store
  ///   - else: The PathBuilder used, if the scoped state is `nil`
  static func ifLetStore<
    State: Equatable,
    Action,
    If,
    Else,
    IfBuilder: PathBuilder,
    ElseBuilder: PathBuilder
  >(
    store: Store<State?, Action>,
    then: @escaping (Store<State, Action>) -> IfBuilder,
    else: ElseBuilder
  ) -> _PathBuilder<EitherAB<If, Else>> where IfBuilder.Content == If, ElseBuilder.Content == Else {
    _PathBuilder<EitherAB<If, Else>>(
      buildPath: { path -> EitherAB<If, Else>? in
        if let state = ViewStore(store).state {
          _ = `else`.build(path: [])
          return then(store.scope(state: { $0 ?? state })).build(path: path).flatMap(EitherAB.a)
        } else {
          return `else`.build(path: path).flatMap(EitherAB.b)
        }
      }
    )
  }

  /// A `PathBuilder` that safely unwraps a store of optional state in order to show one of two views.
  ///
  /// When the underlying state is non-`nil`, the `then` closure will be performed with a `Store` that
  /// holds onto non-optional state to build the routing path.
  /// ```swift
  /// PathBuilder.ifLetStore(
  ///   store: store.scope(state: \SearchState.results, action: SearchAction.results),
  ///   then: { store in DetailScreen.builder(store: store) }
  /// )
  /// ```
  ///
  /// - Parameters:
  ///   - store: The store scoping to the optional state
  ///   - then: Closure defining how to build the path building given a non-optional store
  static func ifLetStore<
    State: Equatable,
    Action,
    If,
    IfBuilder: PathBuilder
  >(
    store: Store<State?, Action>,
    then: @escaping (Store<State, Action>) -> IfBuilder
  ) -> _PathBuilder<EitherAB<If, Never>> where IfBuilder.Content == If {
    ifLetStore(store: store, then: then, else: PathBuilders.empty)
  }
}
