// AUTO-GENERATED: Do not edit
extension NavigationTreeBuilder {
  public static func buildBlock<ABuilder: PathBuilder, BBuilder: PathBuilder>(
    _ a: ABuilder, _ b: BBuilder
  ) -> _PathBuilder<EitherAB<ABuilder.Content, BBuilder.Content>> {
    PathBuilders.anyOf(a, b)
  }

  public static func buildBlock<ABuilder: PathBuilder, BBuilder: PathBuilder, CBuilder: PathBuilder>(
    _ a: ABuilder, _ b: BBuilder, _ c: CBuilder
  ) -> _PathBuilder<EitherABC<ABuilder.Content, BBuilder.Content, CBuilder.Content>> {
    PathBuilders.anyOf(a, b, c)
  }

  public static func buildBlock<ABuilder: PathBuilder, BBuilder: PathBuilder, CBuilder: PathBuilder, DBuilder: PathBuilder>(
    _ a: ABuilder, _ b: BBuilder, _ c: CBuilder, _ d: DBuilder
  ) -> _PathBuilder<EitherABCD<ABuilder.Content, BBuilder.Content, CBuilder.Content, DBuilder.Content>> {
    PathBuilders.anyOf(a, b, c, d)
  }

  public static func buildBlock<ABuilder: PathBuilder, BBuilder: PathBuilder, CBuilder: PathBuilder, DBuilder: PathBuilder, EBuilder: PathBuilder>(
    _ a: ABuilder, _ b: BBuilder, _ c: CBuilder, _ d: DBuilder, _ e: EBuilder
  ) -> _PathBuilder<EitherABCDE<ABuilder.Content, BBuilder.Content, CBuilder.Content, DBuilder.Content, EBuilder.Content>> {
    PathBuilders.anyOf(a, b, c, d, e)
  }

  public static func buildBlock<ABuilder: PathBuilder, BBuilder: PathBuilder, CBuilder: PathBuilder, DBuilder: PathBuilder, EBuilder: PathBuilder, FBuilder: PathBuilder>(
    _ a: ABuilder, _ b: BBuilder, _ c: CBuilder, _ d: DBuilder, _ e: EBuilder, _ f: FBuilder
  ) -> _PathBuilder<EitherABCDEF<ABuilder.Content, BBuilder.Content, CBuilder.Content, DBuilder.Content, EBuilder.Content, FBuilder.Content>> {
    PathBuilders.anyOf(a, b, c, d, e, f)
  }

  public static func buildBlock<ABuilder: PathBuilder, BBuilder: PathBuilder, CBuilder: PathBuilder, DBuilder: PathBuilder, EBuilder: PathBuilder, FBuilder: PathBuilder, GBuilder: PathBuilder>(
    _ a: ABuilder, _ b: BBuilder, _ c: CBuilder, _ d: DBuilder, _ e: EBuilder, _ f: FBuilder, _ g: GBuilder
  ) -> _PathBuilder<EitherABCDEFG<ABuilder.Content, BBuilder.Content, CBuilder.Content, DBuilder.Content, EBuilder.Content, FBuilder.Content, GBuilder.Content>> {
    PathBuilders.anyOf(a, b, c, d, e, f, g)
  }

  public static func buildBlock<ABuilder: PathBuilder, BBuilder: PathBuilder, CBuilder: PathBuilder, DBuilder: PathBuilder, EBuilder: PathBuilder, FBuilder: PathBuilder, GBuilder: PathBuilder, HBuilder: PathBuilder>(
    _ a: ABuilder, _ b: BBuilder, _ c: CBuilder, _ d: DBuilder, _ e: EBuilder, _ f: FBuilder, _ g: GBuilder, _ h: HBuilder
  ) -> _PathBuilder<EitherABCDEFGH<ABuilder.Content, BBuilder.Content, CBuilder.Content, DBuilder.Content, EBuilder.Content, FBuilder.Content, GBuilder.Content, HBuilder.Content>> {
    PathBuilders.anyOf(a, b, c, d, e, f, g, h)
  }

  public static func buildBlock<ABuilder: PathBuilder, BBuilder: PathBuilder, CBuilder: PathBuilder, DBuilder: PathBuilder, EBuilder: PathBuilder, FBuilder: PathBuilder, GBuilder: PathBuilder, HBuilder: PathBuilder, IBuilder: PathBuilder>(
    _ a: ABuilder, _ b: BBuilder, _ c: CBuilder, _ d: DBuilder, _ e: EBuilder, _ f: FBuilder, _ g: GBuilder, _ h: HBuilder, _ i: IBuilder
  ) -> _PathBuilder<EitherABCDEFGHI<ABuilder.Content, BBuilder.Content, CBuilder.Content, DBuilder.Content, EBuilder.Content, FBuilder.Content, GBuilder.Content, HBuilder.Content, IBuilder.Content>> {
    PathBuilders.anyOf(a, b, c, d, e, f, g, h, i)
  }

  public static func buildBlock<ABuilder: PathBuilder, BBuilder: PathBuilder, CBuilder: PathBuilder, DBuilder: PathBuilder, EBuilder: PathBuilder, FBuilder: PathBuilder, GBuilder: PathBuilder, HBuilder: PathBuilder, IBuilder: PathBuilder, JBuilder: PathBuilder>(
    _ a: ABuilder, _ b: BBuilder, _ c: CBuilder, _ d: DBuilder, _ e: EBuilder, _ f: FBuilder, _ g: GBuilder, _ h: HBuilder, _ i: IBuilder, _ j: JBuilder
  ) -> _PathBuilder<EitherABCDEFGHIJ<ABuilder.Content, BBuilder.Content, CBuilder.Content, DBuilder.Content, EBuilder.Content, FBuilder.Content, GBuilder.Content, HBuilder.Content, IBuilder.Content, JBuilder.Content>> {
    PathBuilders.anyOf(a, b, c, d, e, f, g, h, i, j)
  }
}
