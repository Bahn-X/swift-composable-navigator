import SwiftUI

extension NavigationTree {
  public func Screen<
    S: Screen,
    Content: View,
    Successor: PathBuilder
  >(
    onAppear: @escaping (Bool) -> Void = { _ in },
    @ViewBuilder content build: @escaping (S) -> Content,
    @NavigationTreeBuilder nesting: () -> Successor
  ) -> _PathBuilder<NavigationNode<Content, Successor.Content>>{
    PathBuilders.screen(
      onAppear: onAppear,
      content: build,
      nesting: nesting()
    )
  }

  public func Screen<S: Screen, Content: View>(
    onAppear: @escaping (Bool) -> Void = { _ in },
    @ViewBuilder content build: @escaping (S) -> Content
  ) -> _PathBuilder<NavigationNode<Content, Never>> {
    Screen(
      onAppear: onAppear,
      content: build,
      nesting: { PathBuilders.empty }
    )
  }

  public func Screen<
    S: Screen,
    Content: View,
    Successor: PathBuilder
  >(
    _ type: S.Type,
    onAppear: @escaping (Bool) -> Void = { _ in },
    @ViewBuilder content build: @escaping () -> Content,
    @NavigationTreeBuilder nesting: () -> Successor
  ) -> _PathBuilder<NavigationNode<Content, Successor.Content>> {
    PathBuilders.screen(
      type,
      onAppear: onAppear,
      content: build,
      nesting: nesting()
    )
  }

  public func Screen<S: Screen, Content: View>(
    _ type: S.Type,
    onAppear: @escaping (Bool) -> Void = { _ in },
    @ViewBuilder content build: @escaping () -> Content
  ) -> _PathBuilder<NavigationNode<Content, Never>> {
    Screen(
      type,
      onAppear: onAppear,
      content: build,
      nesting: { PathBuilders.empty }
    )
  }
}
