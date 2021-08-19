// AUTO-GENERATED: Do not edit
import SwiftUI

public struct TabbedNodeA<ABuilder: PathBuilder, AItem: View>: View {
  @Environment(\.currentScreenID) private var screenID
  @EnvironmentObject private var dataSource: Navigator.Datasource
  @Environment(\.navigator) private var navigator

  let nodeItemA: TabbedNodeItem<ABuilder, AItem>

  public var body: some View {
    TabView(selection: selection) {
      NavigationView {
        if let tabContent = screen?.path(for: nodeItemA.tag)?.first, let content = nodeItemA.contentBuilder.build(
          pathElement: tabContent
        ) {
          content
            .environment(\.currentScreenID, tabContent.id)
            .environment(\.parentScreenID, screenID)
        }
      }
      .navigationViewStyle(StackNavigationViewStyle())
      .environment(\.isInActiveTab, nodeItemA.tag == screen?.activeTab.id)
      .tabItem { nodeItemA.tabItem }
      .tag(nodeItemA.tag)
      .navigationBarTitle("") // hide the outer navigation bar on the wrapping TabView
      .navigationBarHidden(true)
      .navigationBarBackButtonHidden(true)
    }
    .onReceive(
      dataSource.$navigationTree,
      perform: { path in
        guard case let .tabbed(screen) = dataSource.navigationTree.component(for: screenID).current else {
          return
        }

        // check if initialised, inactive tabs count should be (total tab count - 1)
        guard screen.inactiveTabs.count != 0 else {
          // Tab screen is correctly initialized
          return
        }

        func isPresent(tag: AnyActivatable) -> Bool {
          screen.activeTab.id == tag || screen.inactiveTabs.map(\.id).contains(tag)
        }

        let matchesAtLeastOneTabID = [
          isPresent(
            tag: nodeItemA.tag
          )
        ].filter { $0 }.count >= 1

        guard matchesAtLeastOneTabID else {
          // TabScreen does not match any of the provided IDs.
          // Probably a different tab screen, therefore initialisation is skipped
          return
        }

        // if the tag is not present, initialise the tab with the default content
        let defaultContents = [
          isPresent(tag: nodeItemA.tag)
          ? nil
          : DefaultTabContent(
            tag: nodeItemA.tag,
            content: nodeItemA.defaultContent
          )
        ].compactMap { $0 }

        dataSource.initializeDefaultContents(for: screenID, contents: defaultContents)
      }
    )
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
      NavigationView {
        if let tabContent = screen?.path(for: nodeItemA.tag)?.first, let content = nodeItemA.contentBuilder.build(
          pathElement: tabContent
        ) {
          content
            .environment(\.currentScreenID, tabContent.id)
            .environment(\.parentScreenID, screenID)
        }
      }
      .navigationViewStyle(StackNavigationViewStyle())
      .environment(\.isInActiveTab, nodeItemA.tag == screen?.activeTab.id)
      .tabItem { nodeItemA.tabItem }
      .tag(nodeItemA.tag)
      .navigationBarTitle("") // hide the outer navigation bar on the wrapping TabView
      .navigationBarHidden(true)
      .navigationBarBackButtonHidden(true)

      NavigationView {
        if let tabContent = screen?.path(for: nodeItemB.tag)?.first, let content = nodeItemB.contentBuilder.build(
          pathElement: tabContent
        ) {
          content
            .environment(\.currentScreenID, tabContent.id)
            .environment(\.parentScreenID, screenID)
        }
      }
      .navigationViewStyle(StackNavigationViewStyle())
      .environment(\.isInActiveTab, nodeItemB.tag == screen?.activeTab.id)
      .tabItem { nodeItemB.tabItem }
      .tag(nodeItemB.tag)
      .navigationBarTitle("") // hide the outer navigation bar on the wrapping TabView
      .navigationBarHidden(true)
      .navigationBarBackButtonHidden(true)
    }
    .onReceive(
      dataSource.$navigationTree,
      perform: { path in
        guard case let .tabbed(screen) = dataSource.navigationTree.component(for: screenID).current else {
          return
        }

        // check if initialised, inactive tabs count should be (total tab count - 1)
        guard screen.inactiveTabs.count != 1 else {
          // Tab screen is correctly initialized
          return
        }

        func isPresent(tag: AnyActivatable) -> Bool {
          screen.activeTab.id == tag || screen.inactiveTabs.map(\.id).contains(tag)
        }

        let matchesAtLeastOneTabID = [
          isPresent(
            tag: nodeItemA.tag
          ),
          isPresent(
            tag: nodeItemB.tag
          )
        ].filter { $0 }.count >= 1

        guard matchesAtLeastOneTabID else {
          // TabScreen does not match any of the provided IDs.
          // Probably a different tab screen, therefore initialisation is skipped
          return
        }

        // if the tag is not present, initialise the tab with the default content
        let defaultContents = [
          isPresent(tag: nodeItemA.tag)
          ? nil
          : DefaultTabContent(
            tag: nodeItemA.tag,
            content: nodeItemA.defaultContent
          ),
          isPresent(tag: nodeItemB.tag)
          ? nil
          : DefaultTabContent(
            tag: nodeItemB.tag,
            content: nodeItemB.defaultContent
          )
        ].compactMap { $0 }

        dataSource.initializeDefaultContents(for: screenID, contents: defaultContents)
      }
    )
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
      NavigationView {
        if let tabContent = screen?.path(for: nodeItemA.tag)?.first, let content = nodeItemA.contentBuilder.build(
          pathElement: tabContent
        ) {
          content
            .environment(\.currentScreenID, tabContent.id)
            .environment(\.parentScreenID, screenID)
        }
      }
      .navigationViewStyle(StackNavigationViewStyle())
      .environment(\.isInActiveTab, nodeItemA.tag == screen?.activeTab.id)
      .tabItem { nodeItemA.tabItem }
      .tag(nodeItemA.tag)
      .navigationBarTitle("") // hide the outer navigation bar on the wrapping TabView
      .navigationBarHidden(true)
      .navigationBarBackButtonHidden(true)

      NavigationView {
        if let tabContent = screen?.path(for: nodeItemB.tag)?.first, let content = nodeItemB.contentBuilder.build(
          pathElement: tabContent
        ) {
          content
            .environment(\.currentScreenID, tabContent.id)
            .environment(\.parentScreenID, screenID)
        }
      }
      .navigationViewStyle(StackNavigationViewStyle())
      .environment(\.isInActiveTab, nodeItemB.tag == screen?.activeTab.id)
      .tabItem { nodeItemB.tabItem }
      .tag(nodeItemB.tag)
      .navigationBarTitle("") // hide the outer navigation bar on the wrapping TabView
      .navigationBarHidden(true)
      .navigationBarBackButtonHidden(true)

      NavigationView {
        if let tabContent = screen?.path(for: nodeItemC.tag)?.first, let content = nodeItemC.contentBuilder.build(
          pathElement: tabContent
        ) {
          content
            .environment(\.currentScreenID, tabContent.id)
            .environment(\.parentScreenID, screenID)
        }
      }
      .navigationViewStyle(StackNavigationViewStyle())
      .environment(\.isInActiveTab, nodeItemC.tag == screen?.activeTab.id)
      .tabItem { nodeItemC.tabItem }
      .tag(nodeItemC.tag)
      .navigationBarTitle("") // hide the outer navigation bar on the wrapping TabView
      .navigationBarHidden(true)
      .navigationBarBackButtonHidden(true)
    }
    .onReceive(
      dataSource.$navigationTree,
      perform: { path in
        guard case let .tabbed(screen) = dataSource.navigationTree.component(for: screenID).current else {
          return
        }

        // check if initialised, inactive tabs count should be (total tab count - 1)
        guard screen.inactiveTabs.count != 2 else {
          // Tab screen is correctly initialized
          return
        }

        func isPresent(tag: AnyActivatable) -> Bool {
          screen.activeTab.id == tag || screen.inactiveTabs.map(\.id).contains(tag)
        }

        let matchesAtLeastOneTabID = [
          isPresent(
            tag: nodeItemA.tag
          ),
          isPresent(
            tag: nodeItemB.tag
          ),
          isPresent(
            tag: nodeItemC.tag
          )
        ].filter { $0 }.count >= 1

        guard matchesAtLeastOneTabID else {
          // TabScreen does not match any of the provided IDs.
          // Probably a different tab screen, therefore initialisation is skipped
          return
        }

        // if the tag is not present, initialise the tab with the default content
        let defaultContents = [
          isPresent(tag: nodeItemA.tag)
          ? nil
          : DefaultTabContent(
            tag: nodeItemA.tag,
            content: nodeItemA.defaultContent
          ),
          isPresent(tag: nodeItemB.tag)
          ? nil
          : DefaultTabContent(
            tag: nodeItemB.tag,
            content: nodeItemB.defaultContent
          ),
          isPresent(tag: nodeItemC.tag)
          ? nil
          : DefaultTabContent(
            tag: nodeItemC.tag,
            content: nodeItemC.defaultContent
          )
        ].compactMap { $0 }

        dataSource.initializeDefaultContents(for: screenID, contents: defaultContents)
      }
    )
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
      NavigationView {
        if let tabContent = screen?.path(for: nodeItemA.tag)?.first, let content = nodeItemA.contentBuilder.build(
          pathElement: tabContent
        ) {
          content
            .environment(\.currentScreenID, tabContent.id)
            .environment(\.parentScreenID, screenID)
        }
      }
      .navigationViewStyle(StackNavigationViewStyle())
      .environment(\.isInActiveTab, nodeItemA.tag == screen?.activeTab.id)
      .tabItem { nodeItemA.tabItem }
      .tag(nodeItemA.tag)
      .navigationBarTitle("") // hide the outer navigation bar on the wrapping TabView
      .navigationBarHidden(true)
      .navigationBarBackButtonHidden(true)

      NavigationView {
        if let tabContent = screen?.path(for: nodeItemB.tag)?.first, let content = nodeItemB.contentBuilder.build(
          pathElement: tabContent
        ) {
          content
            .environment(\.currentScreenID, tabContent.id)
            .environment(\.parentScreenID, screenID)
        }
      }
      .navigationViewStyle(StackNavigationViewStyle())
      .environment(\.isInActiveTab, nodeItemB.tag == screen?.activeTab.id)
      .tabItem { nodeItemB.tabItem }
      .tag(nodeItemB.tag)
      .navigationBarTitle("") // hide the outer navigation bar on the wrapping TabView
      .navigationBarHidden(true)
      .navigationBarBackButtonHidden(true)

      NavigationView {
        if let tabContent = screen?.path(for: nodeItemC.tag)?.first, let content = nodeItemC.contentBuilder.build(
          pathElement: tabContent
        ) {
          content
            .environment(\.currentScreenID, tabContent.id)
            .environment(\.parentScreenID, screenID)
        }
      }
      .navigationViewStyle(StackNavigationViewStyle())
      .environment(\.isInActiveTab, nodeItemC.tag == screen?.activeTab.id)
      .tabItem { nodeItemC.tabItem }
      .tag(nodeItemC.tag)
      .navigationBarTitle("") // hide the outer navigation bar on the wrapping TabView
      .navigationBarHidden(true)
      .navigationBarBackButtonHidden(true)

      NavigationView {
        if let tabContent = screen?.path(for: nodeItemD.tag)?.first, let content = nodeItemD.contentBuilder.build(
          pathElement: tabContent
        ) {
          content
            .environment(\.currentScreenID, tabContent.id)
            .environment(\.parentScreenID, screenID)
        }
      }
      .navigationViewStyle(StackNavigationViewStyle())
      .environment(\.isInActiveTab, nodeItemD.tag == screen?.activeTab.id)
      .tabItem { nodeItemD.tabItem }
      .tag(nodeItemD.tag)
      .navigationBarTitle("") // hide the outer navigation bar on the wrapping TabView
      .navigationBarHidden(true)
      .navigationBarBackButtonHidden(true)
    }
    .onReceive(
      dataSource.$navigationTree,
      perform: { path in
        guard case let .tabbed(screen) = dataSource.navigationTree.component(for: screenID).current else {
          return
        }

        // check if initialised, inactive tabs count should be (total tab count - 1)
        guard screen.inactiveTabs.count != 3 else {
          // Tab screen is correctly initialized
          return
        }

        func isPresent(tag: AnyActivatable) -> Bool {
          screen.activeTab.id == tag || screen.inactiveTabs.map(\.id).contains(tag)
        }

        let matchesAtLeastOneTabID = [
          isPresent(
            tag: nodeItemA.tag
          ),
          isPresent(
            tag: nodeItemB.tag
          ),
          isPresent(
            tag: nodeItemC.tag
          ),
          isPresent(
            tag: nodeItemD.tag
          )
        ].filter { $0 }.count >= 1

        guard matchesAtLeastOneTabID else {
          // TabScreen does not match any of the provided IDs.
          // Probably a different tab screen, therefore initialisation is skipped
          return
        }

        // if the tag is not present, initialise the tab with the default content
        let defaultContents = [
          isPresent(tag: nodeItemA.tag)
          ? nil
          : DefaultTabContent(
            tag: nodeItemA.tag,
            content: nodeItemA.defaultContent
          ),
          isPresent(tag: nodeItemB.tag)
          ? nil
          : DefaultTabContent(
            tag: nodeItemB.tag,
            content: nodeItemB.defaultContent
          ),
          isPresent(tag: nodeItemC.tag)
          ? nil
          : DefaultTabContent(
            tag: nodeItemC.tag,
            content: nodeItemC.defaultContent
          ),
          isPresent(tag: nodeItemD.tag)
          ? nil
          : DefaultTabContent(
            tag: nodeItemD.tag,
            content: nodeItemD.defaultContent
          )
        ].compactMap { $0 }

        dataSource.initializeDefaultContents(for: screenID, contents: defaultContents)
      }
    )
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
      NavigationView {
        if let tabContent = screen?.path(for: nodeItemA.tag)?.first, let content = nodeItemA.contentBuilder.build(
          pathElement: tabContent
        ) {
          content
            .environment(\.currentScreenID, tabContent.id)
            .environment(\.parentScreenID, screenID)
        }
      }
      .navigationViewStyle(StackNavigationViewStyle())
      .environment(\.isInActiveTab, nodeItemA.tag == screen?.activeTab.id)
      .tabItem { nodeItemA.tabItem }
      .tag(nodeItemA.tag)
      .navigationBarTitle("") // hide the outer navigation bar on the wrapping TabView
      .navigationBarHidden(true)
      .navigationBarBackButtonHidden(true)

      NavigationView {
        if let tabContent = screen?.path(for: nodeItemB.tag)?.first, let content = nodeItemB.contentBuilder.build(
          pathElement: tabContent
        ) {
          content
            .environment(\.currentScreenID, tabContent.id)
            .environment(\.parentScreenID, screenID)
        }
      }
      .navigationViewStyle(StackNavigationViewStyle())
      .environment(\.isInActiveTab, nodeItemB.tag == screen?.activeTab.id)
      .tabItem { nodeItemB.tabItem }
      .tag(nodeItemB.tag)
      .navigationBarTitle("") // hide the outer navigation bar on the wrapping TabView
      .navigationBarHidden(true)
      .navigationBarBackButtonHidden(true)

      NavigationView {
        if let tabContent = screen?.path(for: nodeItemC.tag)?.first, let content = nodeItemC.contentBuilder.build(
          pathElement: tabContent
        ) {
          content
            .environment(\.currentScreenID, tabContent.id)
            .environment(\.parentScreenID, screenID)
        }
      }
      .navigationViewStyle(StackNavigationViewStyle())
      .environment(\.isInActiveTab, nodeItemC.tag == screen?.activeTab.id)
      .tabItem { nodeItemC.tabItem }
      .tag(nodeItemC.tag)
      .navigationBarTitle("") // hide the outer navigation bar on the wrapping TabView
      .navigationBarHidden(true)
      .navigationBarBackButtonHidden(true)

      NavigationView {
        if let tabContent = screen?.path(for: nodeItemD.tag)?.first, let content = nodeItemD.contentBuilder.build(
          pathElement: tabContent
        ) {
          content
            .environment(\.currentScreenID, tabContent.id)
            .environment(\.parentScreenID, screenID)
        }
      }
      .navigationViewStyle(StackNavigationViewStyle())
      .environment(\.isInActiveTab, nodeItemD.tag == screen?.activeTab.id)
      .tabItem { nodeItemD.tabItem }
      .tag(nodeItemD.tag)
      .navigationBarTitle("") // hide the outer navigation bar on the wrapping TabView
      .navigationBarHidden(true)
      .navigationBarBackButtonHidden(true)

      NavigationView {
        if let tabContent = screen?.path(for: nodeItemE.tag)?.first, let content = nodeItemE.contentBuilder.build(
          pathElement: tabContent
        ) {
          content
            .environment(\.currentScreenID, tabContent.id)
            .environment(\.parentScreenID, screenID)
        }
      }
      .navigationViewStyle(StackNavigationViewStyle())
      .environment(\.isInActiveTab, nodeItemE.tag == screen?.activeTab.id)
      .tabItem { nodeItemE.tabItem }
      .tag(nodeItemE.tag)
      .navigationBarTitle("") // hide the outer navigation bar on the wrapping TabView
      .navigationBarHidden(true)
      .navigationBarBackButtonHidden(true)
    }
    .onReceive(
      dataSource.$navigationTree,
      perform: { path in
        guard case let .tabbed(screen) = dataSource.navigationTree.component(for: screenID).current else {
          return
        }

        // check if initialised, inactive tabs count should be (total tab count - 1)
        guard screen.inactiveTabs.count != 4 else {
          // Tab screen is correctly initialized
          return
        }

        func isPresent(tag: AnyActivatable) -> Bool {
          screen.activeTab.id == tag || screen.inactiveTabs.map(\.id).contains(tag)
        }

        let matchesAtLeastOneTabID = [
          isPresent(
            tag: nodeItemA.tag
          ),
          isPresent(
            tag: nodeItemB.tag
          ),
          isPresent(
            tag: nodeItemC.tag
          ),
          isPresent(
            tag: nodeItemD.tag
          ),
          isPresent(
            tag: nodeItemE.tag
          )
        ].filter { $0 }.count >= 1

        guard matchesAtLeastOneTabID else {
          // TabScreen does not match any of the provided IDs.
          // Probably a different tab screen, therefore initialisation is skipped
          return
        }

        // if the tag is not present, initialise the tab with the default content
        let defaultContents = [
          isPresent(tag: nodeItemA.tag)
          ? nil
          : DefaultTabContent(
            tag: nodeItemA.tag,
            content: nodeItemA.defaultContent
          ),
          isPresent(tag: nodeItemB.tag)
          ? nil
          : DefaultTabContent(
            tag: nodeItemB.tag,
            content: nodeItemB.defaultContent
          ),
          isPresent(tag: nodeItemC.tag)
          ? nil
          : DefaultTabContent(
            tag: nodeItemC.tag,
            content: nodeItemC.defaultContent
          ),
          isPresent(tag: nodeItemD.tag)
          ? nil
          : DefaultTabContent(
            tag: nodeItemD.tag,
            content: nodeItemD.defaultContent
          ),
          isPresent(tag: nodeItemE.tag)
          ? nil
          : DefaultTabContent(
            tag: nodeItemE.tag,
            content: nodeItemE.defaultContent
          )
        ].compactMap { $0 }

        dataSource.initializeDefaultContents(for: screenID, contents: defaultContents)
      }
    )
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
