import SwiftUI

public struct TabbedNodeItem<Builder: PathBuilder, TabItem: View> {
  public let tag: AnyActivatable

  public let contentBuilder: Builder
  public let tabItem: TabItem

  public let defaultContent: ActiveNavigationPathElement

  public init<Tag: Activatable>(
    tag: Tag,
    @NavigationTreeBuilder contentBuilder: () -> Builder,
    @ViewBuilder tabItem: () -> TabItem,
    defaultContent: ActiveNavigationPathElement
  ) {
    self.tag = tag.eraseToAnyActivatable()
    self.contentBuilder = contentBuilder()
    self.tabItem = tabItem()
    self.defaultContent = defaultContent
  }
}
