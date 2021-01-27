import ComposableArchitecture
import ComposableNavigator
import SwiftUI

public extension PathBuilders {
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
          return then(store.scope(state: { $0 ?? state })).build(path: path).flatMap(EitherAB.a)
        } else {
          return `else`.build(path: path).flatMap(EitherAB.b)
        }
      }
    )
  }

  static func ifLetStore<
    State: Equatable,
    Action,
    If,
    IfBuilder: PathBuilder
  >(
    store: Store<State?, Action>,
    then: @escaping (Store<State, Action>) -> IfBuilder
  ) -> _PathBuilder<If> where IfBuilder.Content == If {
    _PathBuilder<If>(
      buildPath: { path -> If? in
        if let state = ViewStore(store).state {
          return then(store.scope(state: { $0 ?? state })).build(path: path)
        } else {
          return nil
        }
      }
    )
  }
}
