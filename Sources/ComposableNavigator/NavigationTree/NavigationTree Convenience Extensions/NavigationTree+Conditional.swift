import SwiftUI

extension NavigationTree {
  /// Convenience wrapper around PathBuilders.if
  public func If<S: Screen, IfBuilder: PathBuilder, Else: PathBuilder>(
    @NavigationTreeBuilder screen pathBuilder: @escaping (S) -> IfBuilder,
    @NavigationTreeBuilder else: () -> Else
  ) -> _PathBuilder<EitherAB<IfBuilder.Content, Else.Content>> {
    PathBuilders.if(screen: pathBuilder, else: `else`())
  }

  /// Convenience wrapper around PathBuilders.if
  public func If<S: Screen, IfBuilder: PathBuilder>(
    @NavigationTreeBuilder screen pathBuilder: @escaping (S) -> IfBuilder
  ) -> _PathBuilder<EitherAB<IfBuilder.Content, Never>> {
    If(screen: pathBuilder, else: { PathBuilders.empty })
  }
}
