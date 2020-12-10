import ComposableArchitecture
import SwiftUI

public extension Navigator {
  static func root(
    dataSource: Navigator.DataSource,
    navigator: Navigator
  ) -> Navigator {
    let route = { (action: NavigatorAction) in
      ViewStore(dataSource).send(action)
    }

    let initializedNavigator = navigator.lateInit(dataSource: dataSource)

    return Navigator(
      route: route,
      content: Root(dataSource: dataSource, navigator: initializedNavigator)
    )
  }
}

struct Root: View {
  private let dataSource: Navigator.DataSource
  private let navigator: Navigator

  init(
    dataSource: Navigator.DataSource,
    navigator: Navigator
  ) {
    self.dataSource = dataSource
    self.navigator = navigator
  }

  var body: some View {
    WithViewStore(
      dataSource,
      content: { viewStore in
        NavigationView {
          navigator
            .build(path: viewStore.path)?
            .environment(
              \.currentScreenID,
              viewStore.path.first?.id ?? .root
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
      }
    )
  }
}
