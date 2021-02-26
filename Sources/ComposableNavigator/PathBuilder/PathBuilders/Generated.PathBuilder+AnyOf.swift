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
  ///     SettingsScreen.builder(store: settingsStore),
  ///     DetailScreen.builder(store: detailStore)
  ///   )
  /// )
  /// ...
  /// ```
  ///
  /// If a screen can have more than one possible successor, the AnyOf `PathBuilder` allows to branch out. In the example, the Home Screen can either route to the Settings or the Detail screen. We express these two possible routing paths by passing an anyOf `PathBuilder` as a `nesting` argument.
  ///
  /// Read AnyOf `PathBuilder`s as "any of the listed `PathBuilder` builds the path". Given our example, the settings and the detail screen can follow after the home screen. AnyOf allows us to branch out in this case. The resulting app routing tree would be:
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
    A,
    B,
    ABuilder: PathBuilder,
    BBuilder: PathBuilder
  >(
    _ a: ABuilder,
    _ b: BBuilder
  ) -> _PathBuilder<EitherAB<A, B>>
  where ABuilder.Content == A,
        BBuilder.Content == B
  {
    _PathBuilder<EitherAB<A, B>>(
      buildPath: { path -> EitherAB<A, B>? in 
        if let aContent = a.build(path: path) {
          _ = b.build(path: path.ignoringCurrent)
          return .a(aContent)
        }
        else if let bContent = b.build(path: path) {
          return .b(bContent)
        }
        else {
          return nil
        }
      }
    )
  }

  /// ```swift
  /// .screen(
  /// //  ...
  ///   nesting: PathBuilders.anyOf(
  ///     SettingsScreen.builder(store: settingsStore),
  ///     DetailScreen.builder(store: detailStore)
  ///   )
  /// )
  /// ...
  /// ```
  ///
  /// If a screen can have more than one possible successor, the AnyOf `PathBuilder` allows to branch out. In the example, the Home Screen can either route to the Settings or the Detail screen. We express these two possible routing paths by passing an anyOf `PathBuilder` as a `nesting` argument.
  ///
  /// Read AnyOf `PathBuilder`s as "any of the listed `PathBuilder` builds the path". Given our example, the settings and the detail screen can follow after the home screen. AnyOf allows us to branch out in this case. The resulting app routing tree would be:
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
    A,
    B,
    C,
    ABuilder: PathBuilder,
    BBuilder: PathBuilder,
    CBuilder: PathBuilder
  >(
    _ a: ABuilder,
    _ b: BBuilder,
    _ c: CBuilder
  ) -> _PathBuilder<EitherABC<A, B, C>>
  where ABuilder.Content == A,
        BBuilder.Content == B,
        CBuilder.Content == C
  {
    _PathBuilder<EitherABC<A, B, C>>(
      buildPath: { path -> EitherABC<A, B, C>? in 
        if let aContent = a.build(path: path) {
          _ = b.build(path: path.ignoringCurrent)
          _ = c.build(path: path.ignoringCurrent)
          return .a(aContent)
        }
        else if let bContent = b.build(path: path) {
          _ = c.build(path: path.ignoringCurrent)
          return .b(bContent)
        }
        else if let cContent = c.build(path: path) {
          return .c(cContent)
        }
        else {
          return nil
        }
      }
    )
  }

  /// ```swift
  /// .screen(
  /// //  ...
  ///   nesting: PathBuilders.anyOf(
  ///     SettingsScreen.builder(store: settingsStore),
  ///     DetailScreen.builder(store: detailStore)
  ///   )
  /// )
  /// ...
  /// ```
  ///
  /// If a screen can have more than one possible successor, the AnyOf `PathBuilder` allows to branch out. In the example, the Home Screen can either route to the Settings or the Detail screen. We express these two possible routing paths by passing an anyOf `PathBuilder` as a `nesting` argument.
  ///
  /// Read AnyOf `PathBuilder`s as "any of the listed `PathBuilder` builds the path". Given our example, the settings and the detail screen can follow after the home screen. AnyOf allows us to branch out in this case. The resulting app routing tree would be:
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
    A,
    B,
    C,
    D,
    ABuilder: PathBuilder,
    BBuilder: PathBuilder,
    CBuilder: PathBuilder,
    DBuilder: PathBuilder
  >(
    _ a: ABuilder,
    _ b: BBuilder,
    _ c: CBuilder,
    _ d: DBuilder
  ) -> _PathBuilder<EitherABCD<A, B, C, D>>
  where ABuilder.Content == A,
        BBuilder.Content == B,
        CBuilder.Content == C,
        DBuilder.Content == D
  {
    _PathBuilder<EitherABCD<A, B, C, D>>(
      buildPath: { path -> EitherABCD<A, B, C, D>? in 
        if let aContent = a.build(path: path) {
          _ = b.build(path: path.ignoringCurrent)
          _ = c.build(path: path.ignoringCurrent)
          _ = d.build(path: path.ignoringCurrent)
          return .a(aContent)
        }
        else if let bContent = b.build(path: path) {
          _ = c.build(path: path.ignoringCurrent)
          _ = d.build(path: path.ignoringCurrent)
          return .b(bContent)
        }
        else if let cContent = c.build(path: path) {
          _ = d.build(path: path.ignoringCurrent)
          return .c(cContent)
        }
        else if let dContent = d.build(path: path) {
          return .d(dContent)
        }
        else {
          return nil
        }
      }
    )
  }

  /// ```swift
  /// .screen(
  /// //  ...
  ///   nesting: PathBuilders.anyOf(
  ///     SettingsScreen.builder(store: settingsStore),
  ///     DetailScreen.builder(store: detailStore)
  ///   )
  /// )
  /// ...
  /// ```
  ///
  /// If a screen can have more than one possible successor, the AnyOf `PathBuilder` allows to branch out. In the example, the Home Screen can either route to the Settings or the Detail screen. We express these two possible routing paths by passing an anyOf `PathBuilder` as a `nesting` argument.
  ///
  /// Read AnyOf `PathBuilder`s as "any of the listed `PathBuilder` builds the path". Given our example, the settings and the detail screen can follow after the home screen. AnyOf allows us to branch out in this case. The resulting app routing tree would be:
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
    A,
    B,
    C,
    D,
    E,
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
  ) -> _PathBuilder<EitherABCDE<A, B, C, D, E>>
  where ABuilder.Content == A,
        BBuilder.Content == B,
        CBuilder.Content == C,
        DBuilder.Content == D,
        EBuilder.Content == E
  {
    _PathBuilder<EitherABCDE<A, B, C, D, E>>(
      buildPath: { path -> EitherABCDE<A, B, C, D, E>? in 
        if let aContent = a.build(path: path) {
          _ = b.build(path: path.ignoringCurrent)
          _ = c.build(path: path.ignoringCurrent)
          _ = d.build(path: path.ignoringCurrent)
          _ = e.build(path: path.ignoringCurrent)
          return .a(aContent)
        }
        else if let bContent = b.build(path: path) {
          _ = c.build(path: path.ignoringCurrent)
          _ = d.build(path: path.ignoringCurrent)
          _ = e.build(path: path.ignoringCurrent)
          return .b(bContent)
        }
        else if let cContent = c.build(path: path) {
          _ = d.build(path: path.ignoringCurrent)
          _ = e.build(path: path.ignoringCurrent)
          return .c(cContent)
        }
        else if let dContent = d.build(path: path) {
          _ = e.build(path: path.ignoringCurrent)
          return .d(dContent)
        }
        else if let eContent = e.build(path: path) {
          return .e(eContent)
        }
        else {
          return nil
        }
      }
    )
  }

  /// ```swift
  /// .screen(
  /// //  ...
  ///   nesting: PathBuilders.anyOf(
  ///     SettingsScreen.builder(store: settingsStore),
  ///     DetailScreen.builder(store: detailStore)
  ///   )
  /// )
  /// ...
  /// ```
  ///
  /// If a screen can have more than one possible successor, the AnyOf `PathBuilder` allows to branch out. In the example, the Home Screen can either route to the Settings or the Detail screen. We express these two possible routing paths by passing an anyOf `PathBuilder` as a `nesting` argument.
  ///
  /// Read AnyOf `PathBuilder`s as "any of the listed `PathBuilder` builds the path". Given our example, the settings and the detail screen can follow after the home screen. AnyOf allows us to branch out in this case. The resulting app routing tree would be:
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
    A,
    B,
    C,
    D,
    E,
    F,
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
  ) -> _PathBuilder<EitherABCDEF<A, B, C, D, E, F>>
  where ABuilder.Content == A,
        BBuilder.Content == B,
        CBuilder.Content == C,
        DBuilder.Content == D,
        EBuilder.Content == E,
        FBuilder.Content == F
  {
    _PathBuilder<EitherABCDEF<A, B, C, D, E, F>>(
      buildPath: { path -> EitherABCDEF<A, B, C, D, E, F>? in 
        if let aContent = a.build(path: path) {
          _ = b.build(path: path.ignoringCurrent)
          _ = c.build(path: path.ignoringCurrent)
          _ = d.build(path: path.ignoringCurrent)
          _ = e.build(path: path.ignoringCurrent)
          _ = f.build(path: path.ignoringCurrent)
          return .a(aContent)
        }
        else if let bContent = b.build(path: path) {
          _ = c.build(path: path.ignoringCurrent)
          _ = d.build(path: path.ignoringCurrent)
          _ = e.build(path: path.ignoringCurrent)
          _ = f.build(path: path.ignoringCurrent)
          return .b(bContent)
        }
        else if let cContent = c.build(path: path) {
          _ = d.build(path: path.ignoringCurrent)
          _ = e.build(path: path.ignoringCurrent)
          _ = f.build(path: path.ignoringCurrent)
          return .c(cContent)
        }
        else if let dContent = d.build(path: path) {
          _ = e.build(path: path.ignoringCurrent)
          _ = f.build(path: path.ignoringCurrent)
          return .d(dContent)
        }
        else if let eContent = e.build(path: path) {
          _ = f.build(path: path.ignoringCurrent)
          return .e(eContent)
        }
        else if let fContent = f.build(path: path) {
          return .f(fContent)
        }
        else {
          return nil
        }
      }
    )
  }

  /// ```swift
  /// .screen(
  /// //  ...
  ///   nesting: PathBuilders.anyOf(
  ///     SettingsScreen.builder(store: settingsStore),
  ///     DetailScreen.builder(store: detailStore)
  ///   )
  /// )
  /// ...
  /// ```
  ///
  /// If a screen can have more than one possible successor, the AnyOf `PathBuilder` allows to branch out. In the example, the Home Screen can either route to the Settings or the Detail screen. We express these two possible routing paths by passing an anyOf `PathBuilder` as a `nesting` argument.
  ///
  /// Read AnyOf `PathBuilder`s as "any of the listed `PathBuilder` builds the path". Given our example, the settings and the detail screen can follow after the home screen. AnyOf allows us to branch out in this case. The resulting app routing tree would be:
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
    A,
    B,
    C,
    D,
    E,
    F,
    G,
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
  ) -> _PathBuilder<EitherABCDEFG<A, B, C, D, E, F, G>>
  where ABuilder.Content == A,
        BBuilder.Content == B,
        CBuilder.Content == C,
        DBuilder.Content == D,
        EBuilder.Content == E,
        FBuilder.Content == F,
        GBuilder.Content == G
  {
    _PathBuilder<EitherABCDEFG<A, B, C, D, E, F, G>>(
      buildPath: { path -> EitherABCDEFG<A, B, C, D, E, F, G>? in 
        if let aContent = a.build(path: path) {
          _ = b.build(path: path.ignoringCurrent)
          _ = c.build(path: path.ignoringCurrent)
          _ = d.build(path: path.ignoringCurrent)
          _ = e.build(path: path.ignoringCurrent)
          _ = f.build(path: path.ignoringCurrent)
          _ = g.build(path: path.ignoringCurrent)
          return .a(aContent)
        }
        else if let bContent = b.build(path: path) {
          _ = c.build(path: path.ignoringCurrent)
          _ = d.build(path: path.ignoringCurrent)
          _ = e.build(path: path.ignoringCurrent)
          _ = f.build(path: path.ignoringCurrent)
          _ = g.build(path: path.ignoringCurrent)
          return .b(bContent)
        }
        else if let cContent = c.build(path: path) {
          _ = d.build(path: path.ignoringCurrent)
          _ = e.build(path: path.ignoringCurrent)
          _ = f.build(path: path.ignoringCurrent)
          _ = g.build(path: path.ignoringCurrent)
          return .c(cContent)
        }
        else if let dContent = d.build(path: path) {
          _ = e.build(path: path.ignoringCurrent)
          _ = f.build(path: path.ignoringCurrent)
          _ = g.build(path: path.ignoringCurrent)
          return .d(dContent)
        }
        else if let eContent = e.build(path: path) {
          _ = f.build(path: path.ignoringCurrent)
          _ = g.build(path: path.ignoringCurrent)
          return .e(eContent)
        }
        else if let fContent = f.build(path: path) {
          _ = g.build(path: path.ignoringCurrent)
          return .f(fContent)
        }
        else if let gContent = g.build(path: path) {
          return .g(gContent)
        }
        else {
          return nil
        }
      }
    )
  }

  /// ```swift
  /// .screen(
  /// //  ...
  ///   nesting: PathBuilders.anyOf(
  ///     SettingsScreen.builder(store: settingsStore),
  ///     DetailScreen.builder(store: detailStore)
  ///   )
  /// )
  /// ...
  /// ```
  ///
  /// If a screen can have more than one possible successor, the AnyOf `PathBuilder` allows to branch out. In the example, the Home Screen can either route to the Settings or the Detail screen. We express these two possible routing paths by passing an anyOf `PathBuilder` as a `nesting` argument.
  ///
  /// Read AnyOf `PathBuilder`s as "any of the listed `PathBuilder` builds the path". Given our example, the settings and the detail screen can follow after the home screen. AnyOf allows us to branch out in this case. The resulting app routing tree would be:
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
    A,
    B,
    C,
    D,
    E,
    F,
    G,
    H,
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
  ) -> _PathBuilder<EitherABCDEFGH<A, B, C, D, E, F, G, H>>
  where ABuilder.Content == A,
        BBuilder.Content == B,
        CBuilder.Content == C,
        DBuilder.Content == D,
        EBuilder.Content == E,
        FBuilder.Content == F,
        GBuilder.Content == G,
        HBuilder.Content == H
  {
    _PathBuilder<EitherABCDEFGH<A, B, C, D, E, F, G, H>>(
      buildPath: { path -> EitherABCDEFGH<A, B, C, D, E, F, G, H>? in 
        if let aContent = a.build(path: path) {
          _ = b.build(path: path.ignoringCurrent)
          _ = c.build(path: path.ignoringCurrent)
          _ = d.build(path: path.ignoringCurrent)
          _ = e.build(path: path.ignoringCurrent)
          _ = f.build(path: path.ignoringCurrent)
          _ = g.build(path: path.ignoringCurrent)
          _ = h.build(path: path.ignoringCurrent)
          return .a(aContent)
        }
        else if let bContent = b.build(path: path) {
          _ = c.build(path: path.ignoringCurrent)
          _ = d.build(path: path.ignoringCurrent)
          _ = e.build(path: path.ignoringCurrent)
          _ = f.build(path: path.ignoringCurrent)
          _ = g.build(path: path.ignoringCurrent)
          _ = h.build(path: path.ignoringCurrent)
          return .b(bContent)
        }
        else if let cContent = c.build(path: path) {
          _ = d.build(path: path.ignoringCurrent)
          _ = e.build(path: path.ignoringCurrent)
          _ = f.build(path: path.ignoringCurrent)
          _ = g.build(path: path.ignoringCurrent)
          _ = h.build(path: path.ignoringCurrent)
          return .c(cContent)
        }
        else if let dContent = d.build(path: path) {
          _ = e.build(path: path.ignoringCurrent)
          _ = f.build(path: path.ignoringCurrent)
          _ = g.build(path: path.ignoringCurrent)
          _ = h.build(path: path.ignoringCurrent)
          return .d(dContent)
        }
        else if let eContent = e.build(path: path) {
          _ = f.build(path: path.ignoringCurrent)
          _ = g.build(path: path.ignoringCurrent)
          _ = h.build(path: path.ignoringCurrent)
          return .e(eContent)
        }
        else if let fContent = f.build(path: path) {
          _ = g.build(path: path.ignoringCurrent)
          _ = h.build(path: path.ignoringCurrent)
          return .f(fContent)
        }
        else if let gContent = g.build(path: path) {
          _ = h.build(path: path.ignoringCurrent)
          return .g(gContent)
        }
        else if let hContent = h.build(path: path) {
          return .h(hContent)
        }
        else {
          return nil
        }
      }
    )
  }

  /// ```swift
  /// .screen(
  /// //  ...
  ///   nesting: PathBuilders.anyOf(
  ///     SettingsScreen.builder(store: settingsStore),
  ///     DetailScreen.builder(store: detailStore)
  ///   )
  /// )
  /// ...
  /// ```
  ///
  /// If a screen can have more than one possible successor, the AnyOf `PathBuilder` allows to branch out. In the example, the Home Screen can either route to the Settings or the Detail screen. We express these two possible routing paths by passing an anyOf `PathBuilder` as a `nesting` argument.
  ///
  /// Read AnyOf `PathBuilder`s as "any of the listed `PathBuilder` builds the path". Given our example, the settings and the detail screen can follow after the home screen. AnyOf allows us to branch out in this case. The resulting app routing tree would be:
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
    A,
    B,
    C,
    D,
    E,
    F,
    G,
    H,
    I,
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
  ) -> _PathBuilder<EitherABCDEFGHI<A, B, C, D, E, F, G, H, I>>
  where ABuilder.Content == A,
        BBuilder.Content == B,
        CBuilder.Content == C,
        DBuilder.Content == D,
        EBuilder.Content == E,
        FBuilder.Content == F,
        GBuilder.Content == G,
        HBuilder.Content == H,
        IBuilder.Content == I
  {
    _PathBuilder<EitherABCDEFGHI<A, B, C, D, E, F, G, H, I>>(
      buildPath: { path -> EitherABCDEFGHI<A, B, C, D, E, F, G, H, I>? in 
        if let aContent = a.build(path: path) {
          _ = b.build(path: path.ignoringCurrent)
          _ = c.build(path: path.ignoringCurrent)
          _ = d.build(path: path.ignoringCurrent)
          _ = e.build(path: path.ignoringCurrent)
          _ = f.build(path: path.ignoringCurrent)
          _ = g.build(path: path.ignoringCurrent)
          _ = h.build(path: path.ignoringCurrent)
          _ = i.build(path: path.ignoringCurrent)
          return .a(aContent)
        }
        else if let bContent = b.build(path: path) {
          _ = c.build(path: path.ignoringCurrent)
          _ = d.build(path: path.ignoringCurrent)
          _ = e.build(path: path.ignoringCurrent)
          _ = f.build(path: path.ignoringCurrent)
          _ = g.build(path: path.ignoringCurrent)
          _ = h.build(path: path.ignoringCurrent)
          _ = i.build(path: path.ignoringCurrent)
          return .b(bContent)
        }
        else if let cContent = c.build(path: path) {
          _ = d.build(path: path.ignoringCurrent)
          _ = e.build(path: path.ignoringCurrent)
          _ = f.build(path: path.ignoringCurrent)
          _ = g.build(path: path.ignoringCurrent)
          _ = h.build(path: path.ignoringCurrent)
          _ = i.build(path: path.ignoringCurrent)
          return .c(cContent)
        }
        else if let dContent = d.build(path: path) {
          _ = e.build(path: path.ignoringCurrent)
          _ = f.build(path: path.ignoringCurrent)
          _ = g.build(path: path.ignoringCurrent)
          _ = h.build(path: path.ignoringCurrent)
          _ = i.build(path: path.ignoringCurrent)
          return .d(dContent)
        }
        else if let eContent = e.build(path: path) {
          _ = f.build(path: path.ignoringCurrent)
          _ = g.build(path: path.ignoringCurrent)
          _ = h.build(path: path.ignoringCurrent)
          _ = i.build(path: path.ignoringCurrent)
          return .e(eContent)
        }
        else if let fContent = f.build(path: path) {
          _ = g.build(path: path.ignoringCurrent)
          _ = h.build(path: path.ignoringCurrent)
          _ = i.build(path: path.ignoringCurrent)
          return .f(fContent)
        }
        else if let gContent = g.build(path: path) {
          _ = h.build(path: path.ignoringCurrent)
          _ = i.build(path: path.ignoringCurrent)
          return .g(gContent)
        }
        else if let hContent = h.build(path: path) {
          _ = i.build(path: path.ignoringCurrent)
          return .h(hContent)
        }
        else if let iContent = i.build(path: path) {
          return .i(iContent)
        }
        else {
          return nil
        }
      }
    )
  }

  /// ```swift
  /// .screen(
  /// //  ...
  ///   nesting: PathBuilders.anyOf(
  ///     SettingsScreen.builder(store: settingsStore),
  ///     DetailScreen.builder(store: detailStore)
  ///   )
  /// )
  /// ...
  /// ```
  ///
  /// If a screen can have more than one possible successor, the AnyOf `PathBuilder` allows to branch out. In the example, the Home Screen can either route to the Settings or the Detail screen. We express these two possible routing paths by passing an anyOf `PathBuilder` as a `nesting` argument.
  ///
  /// Read AnyOf `PathBuilder`s as "any of the listed `PathBuilder` builds the path". Given our example, the settings and the detail screen can follow after the home screen. AnyOf allows us to branch out in this case. The resulting app routing tree would be:
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
    A,
    B,
    C,
    D,
    E,
    F,
    G,
    H,
    I,
    J,
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
  ) -> _PathBuilder<EitherABCDEFGHIJ<A, B, C, D, E, F, G, H, I, J>>
  where ABuilder.Content == A,
        BBuilder.Content == B,
        CBuilder.Content == C,
        DBuilder.Content == D,
        EBuilder.Content == E,
        FBuilder.Content == F,
        GBuilder.Content == G,
        HBuilder.Content == H,
        IBuilder.Content == I,
        JBuilder.Content == J
  {
    _PathBuilder<EitherABCDEFGHIJ<A, B, C, D, E, F, G, H, I, J>>(
      buildPath: { path -> EitherABCDEFGHIJ<A, B, C, D, E, F, G, H, I, J>? in 
        if let aContent = a.build(path: path) {
          _ = b.build(path: path.ignoringCurrent)
          _ = c.build(path: path.ignoringCurrent)
          _ = d.build(path: path.ignoringCurrent)
          _ = e.build(path: path.ignoringCurrent)
          _ = f.build(path: path.ignoringCurrent)
          _ = g.build(path: path.ignoringCurrent)
          _ = h.build(path: path.ignoringCurrent)
          _ = i.build(path: path.ignoringCurrent)
          _ = j.build(path: path.ignoringCurrent)
          return .a(aContent)
        }
        else if let bContent = b.build(path: path) {
          _ = c.build(path: path.ignoringCurrent)
          _ = d.build(path: path.ignoringCurrent)
          _ = e.build(path: path.ignoringCurrent)
          _ = f.build(path: path.ignoringCurrent)
          _ = g.build(path: path.ignoringCurrent)
          _ = h.build(path: path.ignoringCurrent)
          _ = i.build(path: path.ignoringCurrent)
          _ = j.build(path: path.ignoringCurrent)
          return .b(bContent)
        }
        else if let cContent = c.build(path: path) {
          _ = d.build(path: path.ignoringCurrent)
          _ = e.build(path: path.ignoringCurrent)
          _ = f.build(path: path.ignoringCurrent)
          _ = g.build(path: path.ignoringCurrent)
          _ = h.build(path: path.ignoringCurrent)
          _ = i.build(path: path.ignoringCurrent)
          _ = j.build(path: path.ignoringCurrent)
          return .c(cContent)
        }
        else if let dContent = d.build(path: path) {
          _ = e.build(path: path.ignoringCurrent)
          _ = f.build(path: path.ignoringCurrent)
          _ = g.build(path: path.ignoringCurrent)
          _ = h.build(path: path.ignoringCurrent)
          _ = i.build(path: path.ignoringCurrent)
          _ = j.build(path: path.ignoringCurrent)
          return .d(dContent)
        }
        else if let eContent = e.build(path: path) {
          _ = f.build(path: path.ignoringCurrent)
          _ = g.build(path: path.ignoringCurrent)
          _ = h.build(path: path.ignoringCurrent)
          _ = i.build(path: path.ignoringCurrent)
          _ = j.build(path: path.ignoringCurrent)
          return .e(eContent)
        }
        else if let fContent = f.build(path: path) {
          _ = g.build(path: path.ignoringCurrent)
          _ = h.build(path: path.ignoringCurrent)
          _ = i.build(path: path.ignoringCurrent)
          _ = j.build(path: path.ignoringCurrent)
          return .f(fContent)
        }
        else if let gContent = g.build(path: path) {
          _ = h.build(path: path.ignoringCurrent)
          _ = i.build(path: path.ignoringCurrent)
          _ = j.build(path: path.ignoringCurrent)
          return .g(gContent)
        }
        else if let hContent = h.build(path: path) {
          _ = i.build(path: path.ignoringCurrent)
          _ = j.build(path: path.ignoringCurrent)
          return .h(hContent)
        }
        else if let iContent = i.build(path: path) {
          _ = j.build(path: path.ignoringCurrent)
          return .i(iContent)
        }
        else if let jContent = j.build(path: path) {
          return .j(jContent)
        }
        else {
          return nil
        }
      }
    )
  }
}
