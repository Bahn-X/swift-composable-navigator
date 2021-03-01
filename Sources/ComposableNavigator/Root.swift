import SwiftUI

///  Root View of any ComposableNavigator driven application
///
///  Embeds the content in a `NavigationView` and builds the navigation path, whenever it changes.
///  ## Usage
///  ```swift
///  import ComposableNavigator
///  import SwiftUI
///
///  struct AppNavigationTree: NavigationTree {
///    let homeViewModel: HomeViewModel
///    let detailViewModel: DetailViewModel
///    let settingsViewModel: SettingsViewModel
///
///    var builder: some PathBuilder {
///      Screen(
///        HomeScreen.self,
///        content: {
///          HomeView(viewModel: homeViewModel)
///        },
///        nesting: {
///          DetailScreen.Builder(viewModel: detailViewModel),
///          SettingsScreen.Builder(viewModel: settingsViewModel)
///        }
///      )
///    }
///  }
///
///  @main
///  struct ExampleApp: App {
///    let dataSource = Navigator.Datasource(root: HomeScreen())
///
///    var body: some Scene {
///      WindowGroup {
///        Root(
///         dataSource: dataSource,
///         pathBuilder: AppNavigationTree(...)
///       )
///      }
///    }
///  }
///  ```
public struct Root<Builder: PathBuilder>: View {
    @ObservedObject private var dataSource: Navigator.Datasource
    private let navigator: Navigator
    private let pathBuilder: Builder

    private var rootID: ScreenID {
        return dataSource.path.current.first?.id ?? .root
    }

    private var rootScreen: AnyScreen {
        return dataSource.path.current.first?.content ?? CurrentScreenKey.defaultValue
    }

    public init(
        dataSource: Navigator.Datasource,
        navigator: Navigator,
        pathBuilder: Builder
    ) {
        self.dataSource = dataSource
        self.navigator = navigator
        self.pathBuilder = pathBuilder
    }

    public var body: some View {
        NavigationView {
            pathBuilder.build(
                path: dataSource.path.component(for: rootID)
            )
        }
        .environment(
            \.currentScreenID,
            rootID
        )
        .environment(
            \.currentScreen,
            rootScreen
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
        pathBuilder: Builder
    ) {
        self.init(
            dataSource: dataSource,
            navigator: Navigator(dataSource: dataSource),
            pathBuilder: pathBuilder
        )
    }
    
    /// Enable  logging function calls to the Navigator object and path changes.
    func debug() -> Root {
        Root(
            dataSource: dataSource,
            navigator: navigator.debug(),
            pathBuilder: pathBuilder
        )
    }
}
