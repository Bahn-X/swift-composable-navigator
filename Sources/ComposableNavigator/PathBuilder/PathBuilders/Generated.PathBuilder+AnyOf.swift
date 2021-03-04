// AUTO-GENERATED: Do not edit
import SwiftUI

/// An either type, representing up to 2 different view types
public enum EitherAB<A: View, B: View>: View {
  case a(A) 
  case b(B) 

  public var body: some View {
    switch self {
    case let .a(A):
      A
    case let .b(B):
      B
    }
  }
}

/// An either type, representing up to 3 different view types
public enum EitherABC<A: View, B: View, C: View>: View {
  case a(A) 
  case b(B) 
  case c(C) 

  public var body: some View {
    switch self {
    case let .a(A):
      A
    case let .b(B):
      B
    case let .c(C):
      C
    }
  }
}

/// An either type, representing up to 4 different view types
public enum EitherABCD<A: View, B: View, C: View, D: View>: View {
  case a(A) 
  case b(B) 
  case c(C) 
  case d(D) 

  public var body: some View {
    switch self {
    case let .a(A):
      A
    case let .b(B):
      B
    case let .c(C):
      C
    case let .d(D):
      D
    }
  }
}

/// An either type, representing up to 5 different view types
public enum EitherABCDE<A: View, B: View, C: View, D: View, E: View>: View {
  case a(A) 
  case b(B) 
  case c(C) 
  case d(D) 
  case e(E) 

  public var body: some View {
    switch self {
    case let .a(A):
      A
    case let .b(B):
      B
    case let .c(C):
      C
    case let .d(D):
      D
    case let .e(E):
      E
    }
  }
}

/// An either type, representing up to 6 different view types
public enum EitherABCDEF<A: View, B: View, C: View, D: View, E: View, F: View>: View {
  case a(A) 
  case b(B) 
  case c(C) 
  case d(D) 
  case e(E) 
  case f(F) 

  public var body: some View {
    switch self {
    case let .a(A):
      A
    case let .b(B):
      B
    case let .c(C):
      C
    case let .d(D):
      D
    case let .e(E):
      E
    case let .f(F):
      F
    }
  }
}

/// An either type, representing up to 7 different view types
public enum EitherABCDEFG<A: View, B: View, C: View, D: View, E: View, F: View, G: View>: View {
  case a(A) 
  case b(B) 
  case c(C) 
  case d(D) 
  case e(E) 
  case f(F) 
  case g(G) 

  public var body: some View {
    switch self {
    case let .a(A):
      A
    case let .b(B):
      B
    case let .c(C):
      C
    case let .d(D):
      D
    case let .e(E):
      E
    case let .f(F):
      F
    case let .g(G):
      G
    }
  }
}

/// An either type, representing up to 8 different view types
public enum EitherABCDEFGH<A: View, B: View, C: View, D: View, E: View, F: View, G: View, H: View>: View {
  case a(A) 
  case b(B) 
  case c(C) 
  case d(D) 
  case e(E) 
  case f(F) 
  case g(G) 
  case h(H) 

  public var body: some View {
    switch self {
    case let .a(A):
      A
    case let .b(B):
      B
    case let .c(C):
      C
    case let .d(D):
      D
    case let .e(E):
      E
    case let .f(F):
      F
    case let .g(G):
      G
    case let .h(H):
      H
    }
  }
}

/// An either type, representing up to 9 different view types
public enum EitherABCDEFGHI<A: View, B: View, C: View, D: View, E: View, F: View, G: View, H: View, I: View>: View {
  case a(A) 
  case b(B) 
  case c(C) 
  case d(D) 
  case e(E) 
  case f(F) 
  case g(G) 
  case h(H) 
  case i(I) 

  public var body: some View {
    switch self {
    case let .a(A):
      A
    case let .b(B):
      B
    case let .c(C):
      C
    case let .d(D):
      D
    case let .e(E):
      E
    case let .f(F):
      F
    case let .g(G):
      G
    case let .h(H):
      H
    case let .i(I):
      I
    }
  }
}

/// An either type, representing up to 10 different view types
public enum EitherABCDEFGHIJ<A: View, B: View, C: View, D: View, E: View, F: View, G: View, H: View, I: View, J: View>: View {
  case a(A) 
  case b(B) 
  case c(C) 
  case d(D) 
  case e(E) 
  case f(F) 
  case g(G) 
  case h(H) 
  case i(I) 
  case j(J) 

  public var body: some View {
    switch self {
    case let .a(A):
      A
    case let .b(B):
      B
    case let .c(C):
      C
    case let .d(D):
      D
    case let .e(E):
      E
    case let .f(F):
      F
    case let .g(G):
      G
    case let .h(H):
      H
    case let .i(I):
      I
    case let .j(J):
      J
    }
  }
}

public extension PathBuilders {
  /// ```swift
  /// .screen(
  /// //  ...
  ///   nesting: PathBuilders.anyOf(
  ///     SettingsScreen.Builder(store: settingsStore),
  ///     DetailScreen.Builder(store: detailStore)
  ///   )
  /// )
  /// ...
  /// ```
  ///
  /// If a screen can have more than one possible successor, the AnyOf `PathBuilder` allows to branch out. In the example, the Home Screen can either route to the Settings or the Detail screen. We express these two possible navigation paths by passing an anyOf `PathBuilder` as a `nesting` argument.
  ///
  /// Read AnyOf `PathBuilder`s as "any of the listed `PathBuilder` builds the path". Given our example, the settings and the detail screen can follow after the home screen. AnyOf allows us to branch out in this case. The resulting app navigation tree would be:
  ///
  /// ```
  ///           -- Settings
  ///   Home ---
  ///           -- Detail
  /// ```
  ///
  /// Keep in mind, that the order of the listed `PathBuilder`s matters. The first `PathBuilder`s that can handle the path will build it.
  ///
  /// ⚠️ The anyOf PathBuilder is limited to 10 elements, stack .anyOf `PathBuilder`s if a screen can be followed up by more than ten screens ⚠️
  /// ```swift
  ///  .screen(
  ///    //  ...
  ///      nesting: .anyOf(
  ///        .anyOf(
  ///        // ... up to 10 `PathBuilder`s here
  ///        ),
  ///        .anyOf(
  ///        // ... the other `PathBuilder`s
  ///        )
  ///      )
  ///  )
  /// ...
  /// ```
  static func anyOf<
    ABuilder: PathBuilder,
    BBuilder: PathBuilder
  >(
    _ a: ABuilder,
    _ b: BBuilder
  ) -> _PathBuilder<
      EitherAB<
        ABuilder.Content,
        BBuilder.Content
      >
    >
  {
    _PathBuilder { pathElement in
        if let aContent = a.build(pathElement: pathElement) {
          return .a(aContent)
        } else if let bContent = b.build(pathElement: pathElement) {
          return .b(bContent)
        }
        
        return nil
    }
  }
  /// ```swift
  /// .screen(
  /// //  ...
  ///   nesting: PathBuilders.anyOf(
  ///     SettingsScreen.Builder(store: settingsStore),
  ///     DetailScreen.Builder(store: detailStore)
  ///   )
  /// )
  /// ...
  /// ```
  ///
  /// If a screen can have more than one possible successor, the AnyOf `PathBuilder` allows to branch out. In the example, the Home Screen can either route to the Settings or the Detail screen. We express these two possible navigation paths by passing an anyOf `PathBuilder` as a `nesting` argument.
  ///
  /// Read AnyOf `PathBuilder`s as "any of the listed `PathBuilder` builds the path". Given our example, the settings and the detail screen can follow after the home screen. AnyOf allows us to branch out in this case. The resulting app navigation tree would be:
  ///
  /// ```
  ///           -- Settings
  ///   Home ---
  ///           -- Detail
  /// ```
  ///
  /// Keep in mind, that the order of the listed `PathBuilder`s matters. The first `PathBuilder`s that can handle the path will build it.
  ///
  /// ⚠️ The anyOf PathBuilder is limited to 10 elements, stack .anyOf `PathBuilder`s if a screen can be followed up by more than ten screens ⚠️
  /// ```swift
  ///  .screen(
  ///    //  ...
  ///      nesting: .anyOf(
  ///        .anyOf(
  ///        // ... up to 10 `PathBuilder`s here
  ///        ),
  ///        .anyOf(
  ///        // ... the other `PathBuilder`s
  ///        )
  ///      )
  ///  )
  /// ...
  /// ```
  static func anyOf<
    ABuilder: PathBuilder,
    BBuilder: PathBuilder,
    CBuilder: PathBuilder
  >(
    _ a: ABuilder,
    _ b: BBuilder,
    _ c: CBuilder
  ) -> _PathBuilder<
      EitherABC<
        ABuilder.Content,
        BBuilder.Content,
        CBuilder.Content
      >
    >
  {
    _PathBuilder { pathElement in
        if let aContent = a.build(pathElement: pathElement) {
          return .a(aContent)
        } else if let bContent = b.build(pathElement: pathElement) {
          return .b(bContent)
        } else if let cContent = c.build(pathElement: pathElement) {
          return .c(cContent)
        }
        
        return nil
    }
  }
  /// ```swift
  /// .screen(
  /// //  ...
  ///   nesting: PathBuilders.anyOf(
  ///     SettingsScreen.Builder(store: settingsStore),
  ///     DetailScreen.Builder(store: detailStore)
  ///   )
  /// )
  /// ...
  /// ```
  ///
  /// If a screen can have more than one possible successor, the AnyOf `PathBuilder` allows to branch out. In the example, the Home Screen can either route to the Settings or the Detail screen. We express these two possible navigation paths by passing an anyOf `PathBuilder` as a `nesting` argument.
  ///
  /// Read AnyOf `PathBuilder`s as "any of the listed `PathBuilder` builds the path". Given our example, the settings and the detail screen can follow after the home screen. AnyOf allows us to branch out in this case. The resulting app navigation tree would be:
  ///
  /// ```
  ///           -- Settings
  ///   Home ---
  ///           -- Detail
  /// ```
  ///
  /// Keep in mind, that the order of the listed `PathBuilder`s matters. The first `PathBuilder`s that can handle the path will build it.
  ///
  /// ⚠️ The anyOf PathBuilder is limited to 10 elements, stack .anyOf `PathBuilder`s if a screen can be followed up by more than ten screens ⚠️
  /// ```swift
  ///  .screen(
  ///    //  ...
  ///      nesting: .anyOf(
  ///        .anyOf(
  ///        // ... up to 10 `PathBuilder`s here
  ///        ),
  ///        .anyOf(
  ///        // ... the other `PathBuilder`s
  ///        )
  ///      )
  ///  )
  /// ...
  /// ```
  static func anyOf<
    ABuilder: PathBuilder,
    BBuilder: PathBuilder,
    CBuilder: PathBuilder,
    DBuilder: PathBuilder
  >(
    _ a: ABuilder,
    _ b: BBuilder,
    _ c: CBuilder,
    _ d: DBuilder
  ) -> _PathBuilder<
      EitherABCD<
        ABuilder.Content,
        BBuilder.Content,
        CBuilder.Content,
        DBuilder.Content
      >
    >
  {
    _PathBuilder { pathElement in
        if let aContent = a.build(pathElement: pathElement) {
          return .a(aContent)
        } else if let bContent = b.build(pathElement: pathElement) {
          return .b(bContent)
        } else if let cContent = c.build(pathElement: pathElement) {
          return .c(cContent)
        } else if let dContent = d.build(pathElement: pathElement) {
          return .d(dContent)
        }
        
        return nil
    }
  }
  /// ```swift
  /// .screen(
  /// //  ...
  ///   nesting: PathBuilders.anyOf(
  ///     SettingsScreen.Builder(store: settingsStore),
  ///     DetailScreen.Builder(store: detailStore)
  ///   )
  /// )
  /// ...
  /// ```
  ///
  /// If a screen can have more than one possible successor, the AnyOf `PathBuilder` allows to branch out. In the example, the Home Screen can either route to the Settings or the Detail screen. We express these two possible navigation paths by passing an anyOf `PathBuilder` as a `nesting` argument.
  ///
  /// Read AnyOf `PathBuilder`s as "any of the listed `PathBuilder` builds the path". Given our example, the settings and the detail screen can follow after the home screen. AnyOf allows us to branch out in this case. The resulting app navigation tree would be:
  ///
  /// ```
  ///           -- Settings
  ///   Home ---
  ///           -- Detail
  /// ```
  ///
  /// Keep in mind, that the order of the listed `PathBuilder`s matters. The first `PathBuilder`s that can handle the path will build it.
  ///
  /// ⚠️ The anyOf PathBuilder is limited to 10 elements, stack .anyOf `PathBuilder`s if a screen can be followed up by more than ten screens ⚠️
  /// ```swift
  ///  .screen(
  ///    //  ...
  ///      nesting: .anyOf(
  ///        .anyOf(
  ///        // ... up to 10 `PathBuilder`s here
  ///        ),
  ///        .anyOf(
  ///        // ... the other `PathBuilder`s
  ///        )
  ///      )
  ///  )
  /// ...
  /// ```
  static func anyOf<
    ABuilder: PathBuilder,
    BBuilder: PathBuilder,
    CBuilder: PathBuilder,
    DBuilder: PathBuilder,
    EBuilder: PathBuilder
  >(
    _ a: ABuilder,
    _ b: BBuilder,
    _ c: CBuilder,
    _ d: DBuilder,
    _ e: EBuilder
  ) -> _PathBuilder<
      EitherABCDE<
        ABuilder.Content,
        BBuilder.Content,
        CBuilder.Content,
        DBuilder.Content,
        EBuilder.Content
      >
    >
  {
    _PathBuilder { pathElement in
        if let aContent = a.build(pathElement: pathElement) {
          return .a(aContent)
        } else if let bContent = b.build(pathElement: pathElement) {
          return .b(bContent)
        } else if let cContent = c.build(pathElement: pathElement) {
          return .c(cContent)
        } else if let dContent = d.build(pathElement: pathElement) {
          return .d(dContent)
        } else if let eContent = e.build(pathElement: pathElement) {
          return .e(eContent)
        }
        
        return nil
    }
  }
  /// ```swift
  /// .screen(
  /// //  ...
  ///   nesting: PathBuilders.anyOf(
  ///     SettingsScreen.Builder(store: settingsStore),
  ///     DetailScreen.Builder(store: detailStore)
  ///   )
  /// )
  /// ...
  /// ```
  ///
  /// If a screen can have more than one possible successor, the AnyOf `PathBuilder` allows to branch out. In the example, the Home Screen can either route to the Settings or the Detail screen. We express these two possible navigation paths by passing an anyOf `PathBuilder` as a `nesting` argument.
  ///
  /// Read AnyOf `PathBuilder`s as "any of the listed `PathBuilder` builds the path". Given our example, the settings and the detail screen can follow after the home screen. AnyOf allows us to branch out in this case. The resulting app navigation tree would be:
  ///
  /// ```
  ///           -- Settings
  ///   Home ---
  ///           -- Detail
  /// ```
  ///
  /// Keep in mind, that the order of the listed `PathBuilder`s matters. The first `PathBuilder`s that can handle the path will build it.
  ///
  /// ⚠️ The anyOf PathBuilder is limited to 10 elements, stack .anyOf `PathBuilder`s if a screen can be followed up by more than ten screens ⚠️
  /// ```swift
  ///  .screen(
  ///    //  ...
  ///      nesting: .anyOf(
  ///        .anyOf(
  ///        // ... up to 10 `PathBuilder`s here
  ///        ),
  ///        .anyOf(
  ///        // ... the other `PathBuilder`s
  ///        )
  ///      )
  ///  )
  /// ...
  /// ```
  static func anyOf<
    ABuilder: PathBuilder,
    BBuilder: PathBuilder,
    CBuilder: PathBuilder,
    DBuilder: PathBuilder,
    EBuilder: PathBuilder,
    FBuilder: PathBuilder
  >(
    _ a: ABuilder,
    _ b: BBuilder,
    _ c: CBuilder,
    _ d: DBuilder,
    _ e: EBuilder,
    _ f: FBuilder
  ) -> _PathBuilder<
      EitherABCDEF<
        ABuilder.Content,
        BBuilder.Content,
        CBuilder.Content,
        DBuilder.Content,
        EBuilder.Content,
        FBuilder.Content
      >
    >
  {
    _PathBuilder { pathElement in
        if let aContent = a.build(pathElement: pathElement) {
          return .a(aContent)
        } else if let bContent = b.build(pathElement: pathElement) {
          return .b(bContent)
        } else if let cContent = c.build(pathElement: pathElement) {
          return .c(cContent)
        } else if let dContent = d.build(pathElement: pathElement) {
          return .d(dContent)
        } else if let eContent = e.build(pathElement: pathElement) {
          return .e(eContent)
        } else if let fContent = f.build(pathElement: pathElement) {
          return .f(fContent)
        }
        
        return nil
    }
  }
  /// ```swift
  /// .screen(
  /// //  ...
  ///   nesting: PathBuilders.anyOf(
  ///     SettingsScreen.Builder(store: settingsStore),
  ///     DetailScreen.Builder(store: detailStore)
  ///   )
  /// )
  /// ...
  /// ```
  ///
  /// If a screen can have more than one possible successor, the AnyOf `PathBuilder` allows to branch out. In the example, the Home Screen can either route to the Settings or the Detail screen. We express these two possible navigation paths by passing an anyOf `PathBuilder` as a `nesting` argument.
  ///
  /// Read AnyOf `PathBuilder`s as "any of the listed `PathBuilder` builds the path". Given our example, the settings and the detail screen can follow after the home screen. AnyOf allows us to branch out in this case. The resulting app navigation tree would be:
  ///
  /// ```
  ///           -- Settings
  ///   Home ---
  ///           -- Detail
  /// ```
  ///
  /// Keep in mind, that the order of the listed `PathBuilder`s matters. The first `PathBuilder`s that can handle the path will build it.
  ///
  /// ⚠️ The anyOf PathBuilder is limited to 10 elements, stack .anyOf `PathBuilder`s if a screen can be followed up by more than ten screens ⚠️
  /// ```swift
  ///  .screen(
  ///    //  ...
  ///      nesting: .anyOf(
  ///        .anyOf(
  ///        // ... up to 10 `PathBuilder`s here
  ///        ),
  ///        .anyOf(
  ///        // ... the other `PathBuilder`s
  ///        )
  ///      )
  ///  )
  /// ...
  /// ```
  static func anyOf<
    ABuilder: PathBuilder,
    BBuilder: PathBuilder,
    CBuilder: PathBuilder,
    DBuilder: PathBuilder,
    EBuilder: PathBuilder,
    FBuilder: PathBuilder,
    GBuilder: PathBuilder
  >(
    _ a: ABuilder,
    _ b: BBuilder,
    _ c: CBuilder,
    _ d: DBuilder,
    _ e: EBuilder,
    _ f: FBuilder,
    _ g: GBuilder
  ) -> _PathBuilder<
      EitherABCDEFG<
        ABuilder.Content,
        BBuilder.Content,
        CBuilder.Content,
        DBuilder.Content,
        EBuilder.Content,
        FBuilder.Content,
        GBuilder.Content
      >
    >
  {
    _PathBuilder { pathElement in
        if let aContent = a.build(pathElement: pathElement) {
          return .a(aContent)
        } else if let bContent = b.build(pathElement: pathElement) {
          return .b(bContent)
        } else if let cContent = c.build(pathElement: pathElement) {
          return .c(cContent)
        } else if let dContent = d.build(pathElement: pathElement) {
          return .d(dContent)
        } else if let eContent = e.build(pathElement: pathElement) {
          return .e(eContent)
        } else if let fContent = f.build(pathElement: pathElement) {
          return .f(fContent)
        } else if let gContent = g.build(pathElement: pathElement) {
          return .g(gContent)
        }
        
        return nil
    }
  }
  /// ```swift
  /// .screen(
  /// //  ...
  ///   nesting: PathBuilders.anyOf(
  ///     SettingsScreen.Builder(store: settingsStore),
  ///     DetailScreen.Builder(store: detailStore)
  ///   )
  /// )
  /// ...
  /// ```
  ///
  /// If a screen can have more than one possible successor, the AnyOf `PathBuilder` allows to branch out. In the example, the Home Screen can either route to the Settings or the Detail screen. We express these two possible navigation paths by passing an anyOf `PathBuilder` as a `nesting` argument.
  ///
  /// Read AnyOf `PathBuilder`s as "any of the listed `PathBuilder` builds the path". Given our example, the settings and the detail screen can follow after the home screen. AnyOf allows us to branch out in this case. The resulting app navigation tree would be:
  ///
  /// ```
  ///           -- Settings
  ///   Home ---
  ///           -- Detail
  /// ```
  ///
  /// Keep in mind, that the order of the listed `PathBuilder`s matters. The first `PathBuilder`s that can handle the path will build it.
  ///
  /// ⚠️ The anyOf PathBuilder is limited to 10 elements, stack .anyOf `PathBuilder`s if a screen can be followed up by more than ten screens ⚠️
  /// ```swift
  ///  .screen(
  ///    //  ...
  ///      nesting: .anyOf(
  ///        .anyOf(
  ///        // ... up to 10 `PathBuilder`s here
  ///        ),
  ///        .anyOf(
  ///        // ... the other `PathBuilder`s
  ///        )
  ///      )
  ///  )
  /// ...
  /// ```
  static func anyOf<
    ABuilder: PathBuilder,
    BBuilder: PathBuilder,
    CBuilder: PathBuilder,
    DBuilder: PathBuilder,
    EBuilder: PathBuilder,
    FBuilder: PathBuilder,
    GBuilder: PathBuilder,
    HBuilder: PathBuilder
  >(
    _ a: ABuilder,
    _ b: BBuilder,
    _ c: CBuilder,
    _ d: DBuilder,
    _ e: EBuilder,
    _ f: FBuilder,
    _ g: GBuilder,
    _ h: HBuilder
  ) -> _PathBuilder<
      EitherABCDEFGH<
        ABuilder.Content,
        BBuilder.Content,
        CBuilder.Content,
        DBuilder.Content,
        EBuilder.Content,
        FBuilder.Content,
        GBuilder.Content,
        HBuilder.Content
      >
    >
  {
    _PathBuilder { pathElement in
        if let aContent = a.build(pathElement: pathElement) {
          return .a(aContent)
        } else if let bContent = b.build(pathElement: pathElement) {
          return .b(bContent)
        } else if let cContent = c.build(pathElement: pathElement) {
          return .c(cContent)
        } else if let dContent = d.build(pathElement: pathElement) {
          return .d(dContent)
        } else if let eContent = e.build(pathElement: pathElement) {
          return .e(eContent)
        } else if let fContent = f.build(pathElement: pathElement) {
          return .f(fContent)
        } else if let gContent = g.build(pathElement: pathElement) {
          return .g(gContent)
        } else if let hContent = h.build(pathElement: pathElement) {
          return .h(hContent)
        }
        
        return nil
    }
  }
  /// ```swift
  /// .screen(
  /// //  ...
  ///   nesting: PathBuilders.anyOf(
  ///     SettingsScreen.Builder(store: settingsStore),
  ///     DetailScreen.Builder(store: detailStore)
  ///   )
  /// )
  /// ...
  /// ```
  ///
  /// If a screen can have more than one possible successor, the AnyOf `PathBuilder` allows to branch out. In the example, the Home Screen can either route to the Settings or the Detail screen. We express these two possible navigation paths by passing an anyOf `PathBuilder` as a `nesting` argument.
  ///
  /// Read AnyOf `PathBuilder`s as "any of the listed `PathBuilder` builds the path". Given our example, the settings and the detail screen can follow after the home screen. AnyOf allows us to branch out in this case. The resulting app navigation tree would be:
  ///
  /// ```
  ///           -- Settings
  ///   Home ---
  ///           -- Detail
  /// ```
  ///
  /// Keep in mind, that the order of the listed `PathBuilder`s matters. The first `PathBuilder`s that can handle the path will build it.
  ///
  /// ⚠️ The anyOf PathBuilder is limited to 10 elements, stack .anyOf `PathBuilder`s if a screen can be followed up by more than ten screens ⚠️
  /// ```swift
  ///  .screen(
  ///    //  ...
  ///      nesting: .anyOf(
  ///        .anyOf(
  ///        // ... up to 10 `PathBuilder`s here
  ///        ),
  ///        .anyOf(
  ///        // ... the other `PathBuilder`s
  ///        )
  ///      )
  ///  )
  /// ...
  /// ```
  static func anyOf<
    ABuilder: PathBuilder,
    BBuilder: PathBuilder,
    CBuilder: PathBuilder,
    DBuilder: PathBuilder,
    EBuilder: PathBuilder,
    FBuilder: PathBuilder,
    GBuilder: PathBuilder,
    HBuilder: PathBuilder,
    IBuilder: PathBuilder
  >(
    _ a: ABuilder,
    _ b: BBuilder,
    _ c: CBuilder,
    _ d: DBuilder,
    _ e: EBuilder,
    _ f: FBuilder,
    _ g: GBuilder,
    _ h: HBuilder,
    _ i: IBuilder
  ) -> _PathBuilder<
      EitherABCDEFGHI<
        ABuilder.Content,
        BBuilder.Content,
        CBuilder.Content,
        DBuilder.Content,
        EBuilder.Content,
        FBuilder.Content,
        GBuilder.Content,
        HBuilder.Content,
        IBuilder.Content
      >
    >
  {
    _PathBuilder { pathElement in
        if let aContent = a.build(pathElement: pathElement) {
          return .a(aContent)
        } else if let bContent = b.build(pathElement: pathElement) {
          return .b(bContent)
        } else if let cContent = c.build(pathElement: pathElement) {
          return .c(cContent)
        } else if let dContent = d.build(pathElement: pathElement) {
          return .d(dContent)
        } else if let eContent = e.build(pathElement: pathElement) {
          return .e(eContent)
        } else if let fContent = f.build(pathElement: pathElement) {
          return .f(fContent)
        } else if let gContent = g.build(pathElement: pathElement) {
          return .g(gContent)
        } else if let hContent = h.build(pathElement: pathElement) {
          return .h(hContent)
        } else if let iContent = i.build(pathElement: pathElement) {
          return .i(iContent)
        }
        
        return nil
    }
  }
  /// ```swift
  /// .screen(
  /// //  ...
  ///   nesting: PathBuilders.anyOf(
  ///     SettingsScreen.Builder(store: settingsStore),
  ///     DetailScreen.Builder(store: detailStore)
  ///   )
  /// )
  /// ...
  /// ```
  ///
  /// If a screen can have more than one possible successor, the AnyOf `PathBuilder` allows to branch out. In the example, the Home Screen can either route to the Settings or the Detail screen. We express these two possible navigation paths by passing an anyOf `PathBuilder` as a `nesting` argument.
  ///
  /// Read AnyOf `PathBuilder`s as "any of the listed `PathBuilder` builds the path". Given our example, the settings and the detail screen can follow after the home screen. AnyOf allows us to branch out in this case. The resulting app navigation tree would be:
  ///
  /// ```
  ///           -- Settings
  ///   Home ---
  ///           -- Detail
  /// ```
  ///
  /// Keep in mind, that the order of the listed `PathBuilder`s matters. The first `PathBuilder`s that can handle the path will build it.
  ///
  /// ⚠️ The anyOf PathBuilder is limited to 10 elements, stack .anyOf `PathBuilder`s if a screen can be followed up by more than ten screens ⚠️
  /// ```swift
  ///  .screen(
  ///    //  ...
  ///      nesting: .anyOf(
  ///        .anyOf(
  ///        // ... up to 10 `PathBuilder`s here
  ///        ),
  ///        .anyOf(
  ///        // ... the other `PathBuilder`s
  ///        )
  ///      )
  ///  )
  /// ...
  /// ```
  static func anyOf<
    ABuilder: PathBuilder,
    BBuilder: PathBuilder,
    CBuilder: PathBuilder,
    DBuilder: PathBuilder,
    EBuilder: PathBuilder,
    FBuilder: PathBuilder,
    GBuilder: PathBuilder,
    HBuilder: PathBuilder,
    IBuilder: PathBuilder,
    JBuilder: PathBuilder
  >(
    _ a: ABuilder,
    _ b: BBuilder,
    _ c: CBuilder,
    _ d: DBuilder,
    _ e: EBuilder,
    _ f: FBuilder,
    _ g: GBuilder,
    _ h: HBuilder,
    _ i: IBuilder,
    _ j: JBuilder
  ) -> _PathBuilder<
      EitherABCDEFGHIJ<
        ABuilder.Content,
        BBuilder.Content,
        CBuilder.Content,
        DBuilder.Content,
        EBuilder.Content,
        FBuilder.Content,
        GBuilder.Content,
        HBuilder.Content,
        IBuilder.Content,
        JBuilder.Content
      >
    >
  {
    _PathBuilder { pathElement in
        if let aContent = a.build(pathElement: pathElement) {
          return .a(aContent)
        } else if let bContent = b.build(pathElement: pathElement) {
          return .b(bContent)
        } else if let cContent = c.build(pathElement: pathElement) {
          return .c(cContent)
        } else if let dContent = d.build(pathElement: pathElement) {
          return .d(dContent)
        } else if let eContent = e.build(pathElement: pathElement) {
          return .e(eContent)
        } else if let fContent = f.build(pathElement: pathElement) {
          return .f(fContent)
        } else if let gContent = g.build(pathElement: pathElement) {
          return .g(gContent)
        } else if let hContent = h.build(pathElement: pathElement) {
          return .h(hContent)
        } else if let iContent = i.build(pathElement: pathElement) {
          return .i(iContent)
        } else if let jContent = j.build(pathElement: pathElement) {
          return .j(jContent)
        }
        
        return nil
    }
  }
}
