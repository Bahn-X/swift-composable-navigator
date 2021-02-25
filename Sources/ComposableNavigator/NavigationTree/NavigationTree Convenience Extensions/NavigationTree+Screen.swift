import SwiftUI

extension NavigationTree {
  /// Convenience wrapper around PathBuilders.screen
  public func Screen<
    S: Screen,
    Content: View,
    Successor: PathBuilder
  >(
    onAppear: @escaping (Bool) -> Void = { _ in },
    @ViewBuilder content build: @escaping (S) -> Content,
    @NavigationTreeBuilder nesting: () -> Successor
  ) -> _PathBuilder<Routed<Content, Successor.Content>>{
    PathBuilders.screen(
      onAppear: onAppear,
      content: build,
      nesting: nesting()
    )
  }

  /// Convenience wrapper around PathBuilders.screen
  public func Screen<S: Screen, Content: View>(
    onAppear: @escaping (Bool) -> Void = { _ in },
    @ViewBuilder content build: @escaping (S) -> Content
  ) -> _PathBuilder<Routed<Content, Never>> {
    Screen(
      onAppear: onAppear,
      content: build,
      nesting: { PathBuilders.empty }
    )
  }

  /// Convenience wrapper around PathBuilders.screen
  public func Screen<
    S: Screen,
    Content: View,
    Successor: PathBuilder
  >(
    _ type: S.Type,
    onAppear: @escaping (Bool) -> Void = { _ in },
    @ViewBuilder content build: @escaping () -> Content,
    @NavigationTreeBuilder nesting: () -> Successor
  ) -> _PathBuilder<Routed<Content, Successor.Content>> {
    PathBuilders.screen(
      type,
      onAppear: onAppear,
      content: build,
      nesting: nesting()
    )
  }

  /// Convenience wrapper around PathBuilders.screen
  public func Screen<S: Screen, Content: View>(
    _ type: S.Type,
    onAppear: @escaping (Bool) -> Void = { _ in },
    @ViewBuilder content build: @escaping () -> Content
  ) -> _PathBuilder<Routed<Content, Never>> {
    Screen(
      type,
      onAppear: onAppear,
      content: build,
      nesting: { PathBuilders.empty }
    )
  }
}
