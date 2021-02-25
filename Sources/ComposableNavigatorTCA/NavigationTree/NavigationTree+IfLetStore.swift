import ComposableArchitecture
import ComposableNavigator

extension NavigationTree {
  /// Convenience wrapper around PathBuilders.ifLetStore
  func IfLetStore<
    State: Equatable,
    Action,
    If,
    Else,
    IfBuilder: PathBuilder,
    ElseBuilder: PathBuilder
  >(
    store: Store<State?, Action>,
    @NavigationTreeBuilder then: @escaping (Store<State, Action>) -> IfBuilder,
    @NavigationTreeBuilder else: () -> ElseBuilder
  ) -> _PathBuilder<EitherAB<If, Else>> where IfBuilder.Content == If, ElseBuilder.Content == Else {
    PathBuilders.ifLetStore(store: store, then: then, else: `else`())
  }

  /// Convenience wrapper around PathBuilders.ifLetStore
  func IfLetStore<
    State: Equatable,
    Action,
    If,
    IfBuilder: PathBuilder
  >(
    store: Store<State?, Action>,
    @NavigationTreeBuilder then: @escaping (Store<State, Action>) -> IfBuilder
  ) -> _PathBuilder<EitherAB<If, Never>> where IfBuilder.Content == If {
    IfLetStore(store: store, then: then, else: { PathBuilders.empty })
  }
}
