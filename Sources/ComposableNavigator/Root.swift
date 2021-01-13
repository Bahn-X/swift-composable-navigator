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

public extension Root where Datasource == Navigator.Datasource {
    init(
        dataSource: Datasource,
        pathBuilder: PathBuilder
    ) {
        self.init(
            dataSource: dataSource,
            navigator: Navigator(dataSource: dataSource),
            pathBuilder: pathBuilder
        )
    }
}
