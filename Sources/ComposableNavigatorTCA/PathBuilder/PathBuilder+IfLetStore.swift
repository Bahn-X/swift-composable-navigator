import ComposableArchitecture
import ComposableNavigator

public extension PathBuilder {
  static func ifLetStore<State: Equatable, Action>(
    store: Store<State?, Action>,
    then: @escaping (Store<State, Action>) -> PathBuilder,
    else: PathBuilder?
  ) -> PathBuilder {
    PathBuilder(
      buildPath: { path in
        if let state = ViewStore(store).state {
          return then(store.scope(state: { $0 ?? state })).build(path: path)
        } else {
          return `else`?.build(path: path)
        }
      }
    )
  }
}
