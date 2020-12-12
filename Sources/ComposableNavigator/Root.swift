import SwiftUI

public struct Root<Datasource: NavigatorDatasource>: View {
  @ObservedObject private var dataSource: Datasource
  private let navigator: Navigator
  private let pathBuilder: PathBuilder

  public init(
    dataSource: Datasource,
    navigator: Navigator,
    pathBuilder: PathBuilder
  ) {
    self.dataSource = dataSource
    self.navigator = navigator
    self.pathBuilder = pathBuilder
  }

  public var body: some View {
    NavigationView {
      pathBuilder.build(path: dataSource.path)
        .environment(
          \.currentScreenID,
          dataSource.path.first?.id ?? .root
        )
    }
    .environment(\.navigator, navigator)
    .navigationViewStyle(StackNavigationViewStyle())
  }
}

import ComposableArchitecture
public extension Root {
  init<Action>(
    store: Store<NavigatorState, Action>,
    navigator: Navigator,
    pathBuilder: PathBuilder
  ) where Datasource == ViewStore<NavigatorState, Action> {
    self.init(
      dataSource: ViewStore(store),
      navigator: navigator,
      pathBuilder: pathBuilder
    )
  }
}

extension ViewStore: NavigatorDatasource where State == NavigatorState {
  public var path: [IdentifiedScreen] {
    self.state.path
  }
}
