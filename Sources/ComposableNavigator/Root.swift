import SwiftUI

public struct Root: View {
  @ObservedObject private var dataSource: Navigator.Datasource
  private let navigator: Navigator
  private let pathBuilder: PathBuilder

  public init(
    dataSource: Navigator.Datasource,
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
    }
    .environment(
      \.currentScreenID,
      dataSource.path.first?.id ?? .root
    )
    .environment(
      \.navigator,
      navigator
    )
    .environmentObject(dataSource)
    .navigationViewStyle(StackNavigationViewStyle())
  }
}

public extension Root {
  init(
    dataSource: Navigator.Datasource,
    pathBuilder: PathBuilder
  ) {
    self.init(
      dataSource: dataSource,
      navigator: Navigator(dataSource: dataSource),
      pathBuilder: pathBuilder
    )
  }

  func debug() -> Root {
    Root(
      dataSource: dataSource,
      navigator: navigator.debug(),
      pathBuilder: pathBuilder
    )
  }
}
