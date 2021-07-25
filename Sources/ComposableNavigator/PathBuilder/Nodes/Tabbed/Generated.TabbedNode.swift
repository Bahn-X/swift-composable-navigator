// AUTO-GENERATED: Do not edit
import SwiftUI

// TODO: capture case where not all paths are initialized with defaultContent

public struct TabbedNodeA<ABuilder: PathBuilder, AItem: View>: View {
  @Environment(\.currentScreenID) private var screenID
  @EnvironmentObject private var dataSource: Navigator.Datasource
  @Environment(\.navigator) private var navigator

  let nodeItemA: TabbedNodeItem<ABuilder, AItem>

  public var body: some View {
    TabView(selection: selection) {
      if let tabContent = screen?.path(for: nodeItemA.tag)?.first, let content = nodeItemA.contentBuilder.build(
        pathElement: tabContent
      ) {
        content
          .tabItem { nodeItemA.tabItem }
          .tag(nodeItemA.tag)
      } else {
        Color.clear
          .tabItem { nodeItemA.tabItem }
          .tag(nodeItemA.tag)
      }
    }
  }

  private var screen: TabScreen? {
    guard case let .tabbed(screen) = dataSource.navigationTree.component(for: screenID).current else {
      return nil
    }

    return screen
  }

  private var selection: Binding<AnyActivatable> {
    Binding(
      get: { screen?.activeTab.id ?? nodeItemA.tag },
      set: { newValue in
        navigator.activate(newValue)
      }
    )
  }
}

public struct TabbedNodeAB<ABuilder: PathBuilder, AItem: View, BBuilder: PathBuilder, BItem: View>: View {
  @Environment(\.currentScreenID) private var screenID
  @EnvironmentObject private var dataSource: Navigator.Datasource
  @Environment(\.navigator) private var navigator

  let nodeItemA: TabbedNodeItem<ABuilder, AItem>
  let nodeItemB: TabbedNodeItem<BBuilder, BItem>

  public var body: some View {
    TabView(selection: selection) {
      if let tabContent = screen?.path(for: nodeItemA.tag)?.first, let content = nodeItemA.contentBuilder.build(
        pathElement: tabContent
      ) {
        content
          .tabItem { nodeItemA.tabItem }
          .tag(nodeItemA.tag)
      } else {
        Color.clear
          .tabItem { nodeItemA.tabItem }
          .tag(nodeItemA.tag)
      }

      if let tabContent = screen?.path(for: nodeItemB.tag)?.first, let content = nodeItemB.contentBuilder.build(
        pathElement: tabContent
      ) {
        content
          .tabItem { nodeItemB.tabItem }
          .tag(nodeItemB.tag)
      } else {
        Color.clear
          .tabItem { nodeItemB.tabItem }
          .tag(nodeItemB.tag)
      }
    }
  }

  private var screen: TabScreen? {
    guard case let .tabbed(screen) = dataSource.navigationTree.component(for: screenID).current else {
      return nil
    }

    return screen
  }

  private var selection: Binding<AnyActivatable> {
    Binding(
      get: { screen?.activeTab.id ?? nodeItemA.tag },
      set: { newValue in
        navigator.activate(newValue)
      }
    )
  }
}

public struct TabbedNodeABC<ABuilder: PathBuilder, AItem: View, BBuilder: PathBuilder, BItem: View, CBuilder: PathBuilder, CItem: View>: View {
  @Environment(\.currentScreenID) private var screenID
  @EnvironmentObject private var dataSource: Navigator.Datasource
  @Environment(\.navigator) private var navigator

  let nodeItemA: TabbedNodeItem<ABuilder, AItem>
  let nodeItemB: TabbedNodeItem<BBuilder, BItem>
  let nodeItemC: TabbedNodeItem<CBuilder, CItem>

  public var body: some View {
    TabView(selection: selection) {
      if let tabContent = screen?.path(for: nodeItemA.tag)?.first, let content = nodeItemA.contentBuilder.build(
        pathElement: tabContent
      ) {
        content
          .tabItem { nodeItemA.tabItem }
          .tag(nodeItemA.tag)
      } else {
        Color.clear
          .tabItem { nodeItemA.tabItem }
          .tag(nodeItemA.tag)
      }

      if let tabContent = screen?.path(for: nodeItemB.tag)?.first, let content = nodeItemB.contentBuilder.build(
        pathElement: tabContent
      ) {
        content
          .tabItem { nodeItemB.tabItem }
          .tag(nodeItemB.tag)
      } else {
        Color.clear
          .tabItem { nodeItemB.tabItem }
          .tag(nodeItemB.tag)
      }

      if let tabContent = screen?.path(for: nodeItemC.tag)?.first, let content = nodeItemC.contentBuilder.build(
        pathElement: tabContent
      ) {
        content
          .tabItem { nodeItemC.tabItem }
          .tag(nodeItemC.tag)
      } else {
        Color.clear
          .tabItem { nodeItemC.tabItem }
          .tag(nodeItemC.tag)
      }
    }
  }

  private var screen: TabScreen? {
    guard case let .tabbed(screen) = dataSource.navigationTree.component(for: screenID).current else {
      return nil
    }

    return screen
  }

  private var selection: Binding<AnyActivatable> {
    Binding(
      get: { screen?.activeTab.id ?? nodeItemA.tag },
      set: { newValue in
        navigator.activate(newValue)
      }
    )
  }
}

public struct TabbedNodeABCD<ABuilder: PathBuilder, AItem: View, BBuilder: PathBuilder, BItem: View, CBuilder: PathBuilder, CItem: View, DBuilder: PathBuilder, DItem: View>: View {
  @Environment(\.currentScreenID) private var screenID
  @EnvironmentObject private var dataSource: Navigator.Datasource
  @Environment(\.navigator) private var navigator

  let nodeItemA: TabbedNodeItem<ABuilder, AItem>
  let nodeItemB: TabbedNodeItem<BBuilder, BItem>
  let nodeItemC: TabbedNodeItem<CBuilder, CItem>
  let nodeItemD: TabbedNodeItem<DBuilder, DItem>

  public var body: some View {
    TabView(selection: selection) {
      if let tabContent = screen?.path(for: nodeItemA.tag)?.first, let content = nodeItemA.contentBuilder.build(
        pathElement: tabContent
      ) {
        content
          .tabItem { nodeItemA.tabItem }
          .tag(nodeItemA.tag)
      } else {
        Color.clear
          .tabItem { nodeItemA.tabItem }
          .tag(nodeItemA.tag)
      }

      if let tabContent = screen?.path(for: nodeItemB.tag)?.first, let content = nodeItemB.contentBuilder.build(
        pathElement: tabContent
      ) {
        content
          .tabItem { nodeItemB.tabItem }
          .tag(nodeItemB.tag)
      } else {
        Color.clear
          .tabItem { nodeItemB.tabItem }
          .tag(nodeItemB.tag)
      }

      if let tabContent = screen?.path(for: nodeItemC.tag)?.first, let content = nodeItemC.contentBuilder.build(
        pathElement: tabContent
      ) {
        content
          .tabItem { nodeItemC.tabItem }
          .tag(nodeItemC.tag)
      } else {
        Color.clear
          .tabItem { nodeItemC.tabItem }
          .tag(nodeItemC.tag)
      }

      if let tabContent = screen?.path(for: nodeItemD.tag)?.first, let content = nodeItemD.contentBuilder.build(
        pathElement: tabContent
      ) {
        content
          .tabItem { nodeItemD.tabItem }
          .tag(nodeItemD.tag)
      } else {
        Color.clear
          .tabItem { nodeItemD.tabItem }
          .tag(nodeItemD.tag)
      }
    }
  }

  private var screen: TabScreen? {
    guard case let .tabbed(screen) = dataSource.navigationTree.component(for: screenID).current else {
      return nil
    }

    return screen
  }

  private var selection: Binding<AnyActivatable> {
    Binding(
      get: { screen?.activeTab.id ?? nodeItemA.tag },
      set: { newValue in
        navigator.activate(newValue)
      }
    )
  }
}

public struct TabbedNodeABCDE<ABuilder: PathBuilder, AItem: View, BBuilder: PathBuilder, BItem: View, CBuilder: PathBuilder, CItem: View, DBuilder: PathBuilder, DItem: View, EBuilder: PathBuilder, EItem: View>: View {
  @Environment(\.currentScreenID) private var screenID
  @EnvironmentObject private var dataSource: Navigator.Datasource
  @Environment(\.navigator) private var navigator

  let nodeItemA: TabbedNodeItem<ABuilder, AItem>
  let nodeItemB: TabbedNodeItem<BBuilder, BItem>
  let nodeItemC: TabbedNodeItem<CBuilder, CItem>
  let nodeItemD: TabbedNodeItem<DBuilder, DItem>
  let nodeItemE: TabbedNodeItem<EBuilder, EItem>

  public var body: some View {
    TabView(selection: selection) {
      if let tabContent = screen?.path(for: nodeItemA.tag)?.first, let content = nodeItemA.contentBuilder.build(
        pathElement: tabContent
      ) {
        content
          .tabItem { nodeItemA.tabItem }
          .tag(nodeItemA.tag)
      } else {
        Color.clear
          .tabItem { nodeItemA.tabItem }
          .tag(nodeItemA.tag)
      }

      if let tabContent = screen?.path(for: nodeItemB.tag)?.first, let content = nodeItemB.contentBuilder.build(
        pathElement: tabContent
      ) {
        content
          .tabItem { nodeItemB.tabItem }
          .tag(nodeItemB.tag)
      } else {
        Color.clear
          .tabItem { nodeItemB.tabItem }
          .tag(nodeItemB.tag)
      }

      if let tabContent = screen?.path(for: nodeItemC.tag)?.first, let content = nodeItemC.contentBuilder.build(
        pathElement: tabContent
      ) {
        content
          .tabItem { nodeItemC.tabItem }
          .tag(nodeItemC.tag)
      } else {
        Color.clear
          .tabItem { nodeItemC.tabItem }
          .tag(nodeItemC.tag)
      }

      if let tabContent = screen?.path(for: nodeItemD.tag)?.first, let content = nodeItemD.contentBuilder.build(
        pathElement: tabContent
      ) {
        content
          .tabItem { nodeItemD.tabItem }
          .tag(nodeItemD.tag)
      } else {
        Color.clear
          .tabItem { nodeItemD.tabItem }
          .tag(nodeItemD.tag)
      }

      if let tabContent = screen?.path(for: nodeItemE.tag)?.first, let content = nodeItemE.contentBuilder.build(
        pathElement: tabContent
      ) {
        content
          .tabItem { nodeItemE.tabItem }
          .tag(nodeItemE.tag)
      } else {
        Color.clear
          .tabItem { nodeItemE.tabItem }
          .tag(nodeItemE.tag)
      }
    }
  }

  private var screen: TabScreen? {
    guard case let .tabbed(screen) = dataSource.navigationTree.component(for: screenID).current else {
      return nil
    }

    return screen
  }

  private var selection: Binding<AnyActivatable> {
    Binding(
      get: { screen?.activeTab.id ?? nodeItemA.tag },
      set: { newValue in
        navigator.activate(newValue)
      }
    )
  }
}
