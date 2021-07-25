import SwiftUI

public struct TabbedNodeItem<Builder: PathBuilder, TabItem: View> {
  let tag: AnyActivatable

  let contentBuilder: Builder
  let tabItem: TabItem

  let defaultContent: ActiveNavigationPathElement

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
