import ComposableArchitecture
import ComposableNavigator
import SwiftUI

public extension PathBuilder {
  static func ifLetStore<
    State: Equatable,
    Action,
    If: View,
    Else: View
  >(
    store: Store<State?, Action>,
    then: @escaping (Store<State, Action>) -> PathBuilder<If>,
    else: PathBuilder<Else>
  ) -> PathBuilder<EitherAB<If, Else>> {
    PathBuilder<EitherAB<If, Else>>(
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
    then: @escaping (Store<State, Action>) -> PathBuilder<If>
  ) -> PathBuilder<If> {
    PathBuilder<If>(
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
