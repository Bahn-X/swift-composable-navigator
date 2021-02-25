import SwiftUI

extension NavigationTree {
  /// Convenience wrapper around PathBuilders.if
  public func If<IfBuilder: PathBuilder>(
    _ condition: @escaping () -> Bool,
    @NavigationTreeBuilder then builder: () -> IfBuilder
  ) -> _PathBuilder<EitherAB<IfBuilder.Content, Never>> {
    If(condition, then: builder, else: { PathBuilders.empty })
  }

  /// Convenience wrapper around PathBuilders.if
  public func If<IfBuilder: PathBuilder, Else: PathBuilder>(
    _ condition: @escaping () -> Bool,
    @NavigationTreeBuilder then thenBuilder: () -> IfBuilder,
    @NavigationTreeBuilder else elseBuilder: () -> Else
  ) -> _PathBuilder<EitherAB<IfBuilder.Content, Else.Content>> {
    PathBuilders.if(condition, then: thenBuilder(), else: elseBuilder())
  }

  /// Convenience wrapper around PathBuilders.if
  public func IfLet<LetContent, IfBuilder: PathBuilder, Else: PathBuilder>(
    `let`: @escaping () -> LetContent?,
    @NavigationTreeBuilder then: @escaping (LetContent) -> IfBuilder,
    @NavigationTreeBuilder else: () -> Else
  ) -> _PathBuilder<EitherAB<IfBuilder.Content, Else.Content>> {
    PathBuilders.if(let: `let`, then: then, else: `else`())
  }

  /// Convenience wrapper around PathBuilders.if
  public func IfLet<LetContent, IfBuilder: PathBuilder>(
    `let`: @escaping () -> LetContent?,
    @NavigationTreeBuilder then: @escaping (LetContent) -> IfBuilder
  ) -> _PathBuilder<EitherAB<IfBuilder.Content, Never>> {
    IfLet(let: `let`, then: then, else: { PathBuilders.empty })
  }

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
