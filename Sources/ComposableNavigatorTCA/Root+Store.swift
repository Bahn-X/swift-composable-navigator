import ComposableArchitecture
import ComposableNavigator

public extension Root {
  init(
    store: Store<NavigatorState, NavigatorAction>,
    pathBuilder: PathBuilder
  ) where Datasource == ViewStore<NavigatorState, NavigatorAction> {
    self.init(
      dataSource: ViewStore(store),
      navigator: Navigator(store: store),
      pathBuilder: pathBuilder
    )
  }
}

extension ViewStore: NavigatorDatasource where State == NavigatorState {
  public var path: [IdentifiedScreen] {
    self.state.path
  }
}
