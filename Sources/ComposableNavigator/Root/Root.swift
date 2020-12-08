import ComposableArchitecture
import SwiftUI

public struct Root: View {
  private let dataSource: Navigator.DataSource
  private let navigator: Navigator

  public init(
    dataSource: Navigator.DataSource,
    navigator: Navigator
  ) {
    self.dataSource = dataSource
    self.navigator = navigator
  }

  public var body: some View {
    WithViewStore(
      dataSource,
      content: { viewStore in
        NavigationView {
          navigator
            .build(dataSource: dataSource, path: viewStore.path)?
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
