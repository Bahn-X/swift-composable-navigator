import SwiftUI

public struct Provider<Dependency, Content: View>: View {
  @Environment(\.currentScreenID) private var currentScreenID
  @EnvironmentObject private var dataSource: Navigator.Datasource

  private let initialize: () -> Dependency
  private let dependencyStore: DependencyStore
  private let content: (Dependency) -> Content

  public init(
    initialize: @escaping () -> Dependency,
    dependencyStore: DependencyStore = DependencyStore.shared,
    @ViewBuilder content: @escaping (Dependency) -> Content
  ) {
    self.initialize = initialize
    self.dependencyStore = dependencyStore
    self.content = content
  }

  private var screenScope: String {
    currentScreenID.uuidString
  }

  private var dependency: Dependency {
    if let initializedDependency = dependencyStore.get(dependency: Dependency.self, in: screenScope) {
      return initializedDependency
    } else {
      let initializedDependency = initialize()
      dependencyStore.register(dependency: initializedDependency, in: screenScope)
      return initializedDependency
    }
  }

  public var body: some View {
    content(dependency)
      .onReceive(
        dataSource.$path,
        perform: { path in
          if path.component(for: currentScreenID).current == nil {
            dependencyStore.unregister(dependency: Dependency.self, in: screenScope)
          }
        }
      )
  }
}

// MARK: - ObservableObject support
public struct ObservationWrapper<Dependency: ObservableObject, Content: View>: View {
  @ObservedObject var dependency: Dependency
  let content: (Dependency) -> Content

  public var body: some View {
    content(dependency)
  }
}

extension Provider {
  public init<WrappedContent: View>(
    observing: @escaping () -> Dependency,
    dependencyStore: DependencyStore = DependencyStore.shared,
    @ViewBuilder content: @escaping (Dependency) -> WrappedContent
  ) where Dependency: ObservableObject, Content == ObservationWrapper<Dependency, WrappedContent> {
    self.initialize = observing
    self.dependencyStore = dependencyStore
    self.content = { dependency in
      ObservationWrapper(
        dependency: dependency,
        content: content
      )
    }
  }
}
