import ComposableArchitecture
import ComposableNavigator
import SwiftUI

public extension PathBuilders {
  static func ifLetStore<
    State: Equatable,
    Action,
    If: View,
    Else: View
  >(
    store: Store<State?, Action>,
    then: @escaping (Store<State, Action>) -> _PathBuilder<If>,
    else: _PathBuilder<Else>
  ) -> _PathBuilder<EitherAB<If, Else>> {
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
    If: View
  >(
    store: Store<State?, Action>,
    then: @escaping (Store<State, Action>) -> _PathBuilder<If>
  ) -> _PathBuilder<If> {
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
