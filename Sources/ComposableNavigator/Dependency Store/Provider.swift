import SwiftUI

/// A view providing a dependency to its content
public struct Provider<Dependency, Content: View>: View {
  /// A function initialising the dependency given the `Navigator` and the current `ScreenID`
  public typealias DependencyInitialiser = (Navigator, ScreenID) -> Dependency

  @Environment(\.navigator) private var navigator
  @Environment(\.currentScreenID) private var currentScreenID
  @EnvironmentObject private var dataSource: Navigator.Datasource

  private let initialize: DependencyInitialiser
  private let dependencyStore: DependencyStore
  private let content: (Dependency) -> Content

  /// Provider initialises and retains a dependency as long as the view is 'alive', i.e. part of the navigation path.
  ///
  /// - Parameters:
  ///   - initialize: Closure used to initialize the dependency **once**
  ///   - dependencyStore: The dependency store in which the dependency is retained
  ///   - content: Closure building the view's content based on the initialized dependency
  public init(
    initialize: @escaping DependencyInitialiser,
    dependencyStore: DependencyStore = DependencyStore.shared,
    @ViewBuilder content: @escaping (Dependency) -> Content
  ) {
    self.initialize = initialize
    self.dependencyStore = dependencyStore
    self.content = content
  }

  private var screenScope: DependencyStore.Scope {
    DependencyStore.Scope(currentScreenID.uuidString)
  }

  private var dependency: Dependency {
    if let initializedDependency = dependencyStore.get(dependency: Dependency.self, in: screenScope) {
      return initializedDependency
    } else {
      let initializedDependency = initialize(navigator, currentScreenID)
      dependencyStore.register(
        dependency: initializedDependency,
        representing: Dependency.self,
        in: screenScope
      )
      return initializedDependency
    }
  }

  public var body: some View {
    content(dependency)
      .onReceive(
        dataSource.$path,
        perform: { path in
          let component = path.component(for: currentScreenID)

          if let previous = component.previous?.content, previous != component.current?.content {
            dependencyStore.unregister(dependency: Dependency.self, in: screenScope)
          }
        }
      )
  }
}

// MARK: - ObservableObject support
/// A view that observes an observable dependency and updates its `Content` whenever the dependency emits a change
public struct ObservationWrapper<Dependency: ObservableObject, Content: View>: View {
  @ObservedObject var dependency: Dependency
  let content: (Dependency) -> Content

  public var body: some View {
    content(dependency)
  }
}

extension Provider {
  /// Convenience initialiser allowing to automatically update the content whenever the observable dependency emits a change
  ///
  /// - Parameters:
  ///   - observing: Closure used to initialize the dependency **once**
  ///   - dependencyStore: The dependency store in which the dependency is retained
  ///   - content: Closure building the view's content based on the initialized dependency
  public init<WrappedContent: View>(
    observing: @escaping DependencyInitialiser,
    dependencyStore: DependencyStore = DependencyStore.shared,
    @ViewBuilder content: @escaping (Dependency) -> WrappedContent
  ) where Dependency: ObservableObject, Content == ObservationWrapper<Dependency, WrappedContent> {
    self.init(
      initialize: observing,
      dependencyStore: dependencyStore,
      content: { dependency in
        ObservationWrapper(
          dependency: dependency,
          content: content
        )
      }
    )
  }
}
