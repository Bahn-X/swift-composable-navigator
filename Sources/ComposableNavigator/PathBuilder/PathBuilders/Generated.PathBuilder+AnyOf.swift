// AUTO-GENERATED: Do not edit
import SwiftUI

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
  /***
   ```swift
   .screen(
   //  ...
       nesting: .anyOf(
           SettingsScreen.builder(store: settingsStore),
           DetailScreen.builder(store: detailStore)
       )
   )
   ...
   ```

   If a screen can have more than one possible successor, the AnyOf path builder allows to branch out. In the example, the Home Screen can either route to the Settings or the Detail screen. We express these two possible routing paths by passing an anyOf path builder as a `nesting` argument.

   Read AnyOf path builders as "any of the listed path builder builds the path". Given our example, the settings and the detail screen can follow after the home screen. AnyOf allows us to branch out in this case. The resulting app routing tree would be:
   ```
           -- Settings
   Home ---
           -- Detail
   ```

   Keep in mind, that the order of the listed path builders matters. The first path builders that can handle the path will build it.

   ⚠️ The anyOf PathBuilder is limited to 10 elements, stack .anyOf path builders if a screen can be followed up by more than ten screens ⚠️
   ```swift
   .screen(
   //  ...
       nesting: .anyOf(
           .anyOf(
             // ... 10 pathBuilders here
           ),
           .anyOf(
             // ... the other path builders
           )
       )
   )
   ...
   ```
  */
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
  /***
   ```swift
   .screen(
   //  ...
       nesting: .anyOf(
           SettingsScreen.builder(store: settingsStore),
           DetailScreen.builder(store: detailStore)
       )
   )
   ...
   ```

   If a screen can have more than one possible successor, the AnyOf path builder allows to branch out. In the example, the Home Screen can either route to the Settings or the Detail screen. We express these two possible routing paths by passing an anyOf path builder as a `nesting` argument.

   Read AnyOf path builders as "any of the listed path builder builds the path". Given our example, the settings and the detail screen can follow after the home screen. AnyOf allows us to branch out in this case. The resulting app routing tree would be:
   ```
           -- Settings
   Home ---
           -- Detail
   ```

   Keep in mind, that the order of the listed path builders matters. The first path builders that can handle the path will build it.

   ⚠️ The anyOf PathBuilder is limited to 10 elements, stack .anyOf path builders if a screen can be followed up by more than ten screens ⚠️
   ```swift
   .screen(
   //  ...
       nesting: .anyOf(
           .anyOf(
             // ... 10 pathBuilders here
           ),
           .anyOf(
             // ... the other path builders
           )
       )
   )
   ...
   ```
  */
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
          return .a(aContent)
        }
        else if let bContent = b.build(path: path) {
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
  /***
   ```swift
   .screen(
   //  ...
       nesting: .anyOf(
           SettingsScreen.builder(store: settingsStore),
           DetailScreen.builder(store: detailStore)
       )
   )
   ...
   ```

   If a screen can have more than one possible successor, the AnyOf path builder allows to branch out. In the example, the Home Screen can either route to the Settings or the Detail screen. We express these two possible routing paths by passing an anyOf path builder as a `nesting` argument.

   Read AnyOf path builders as "any of the listed path builder builds the path". Given our example, the settings and the detail screen can follow after the home screen. AnyOf allows us to branch out in this case. The resulting app routing tree would be:
   ```
           -- Settings
   Home ---
           -- Detail
   ```

   Keep in mind, that the order of the listed path builders matters. The first path builders that can handle the path will build it.

   ⚠️ The anyOf PathBuilder is limited to 10 elements, stack .anyOf path builders if a screen can be followed up by more than ten screens ⚠️
   ```swift
   .screen(
   //  ...
       nesting: .anyOf(
           .anyOf(
             // ... 10 pathBuilders here
           ),
           .anyOf(
             // ... the other path builders
           )
       )
   )
   ...
   ```
  */
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
          return .a(aContent)
        }
        else if let bContent = b.build(path: path) {
          return .b(bContent)
        }
        else if let cContent = c.build(path: path) {
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
  /***
   ```swift
   .screen(
   //  ...
       nesting: .anyOf(
           SettingsScreen.builder(store: settingsStore),
           DetailScreen.builder(store: detailStore)
       )
   )
   ...
   ```

   If a screen can have more than one possible successor, the AnyOf path builder allows to branch out. In the example, the Home Screen can either route to the Settings or the Detail screen. We express these two possible routing paths by passing an anyOf path builder as a `nesting` argument.

   Read AnyOf path builders as "any of the listed path builder builds the path". Given our example, the settings and the detail screen can follow after the home screen. AnyOf allows us to branch out in this case. The resulting app routing tree would be:
   ```
           -- Settings
   Home ---
           -- Detail
   ```

   Keep in mind, that the order of the listed path builders matters. The first path builders that can handle the path will build it.

   ⚠️ The anyOf PathBuilder is limited to 10 elements, stack .anyOf path builders if a screen can be followed up by more than ten screens ⚠️
   ```swift
   .screen(
   //  ...
       nesting: .anyOf(
           .anyOf(
             // ... 10 pathBuilders here
           ),
           .anyOf(
             // ... the other path builders
           )
       )
   )
   ...
   ```
  */
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
          return .a(aContent)
        }
        else if let bContent = b.build(path: path) {
          return .b(bContent)
        }
        else if let cContent = c.build(path: path) {
          return .c(cContent)
        }
        else if let dContent = d.build(path: path) {
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
  /***
   ```swift
   .screen(
   //  ...
       nesting: .anyOf(
           SettingsScreen.builder(store: settingsStore),
           DetailScreen.builder(store: detailStore)
       )
   )
   ...
   ```

   If a screen can have more than one possible successor, the AnyOf path builder allows to branch out. In the example, the Home Screen can either route to the Settings or the Detail screen. We express these two possible routing paths by passing an anyOf path builder as a `nesting` argument.

   Read AnyOf path builders as "any of the listed path builder builds the path". Given our example, the settings and the detail screen can follow after the home screen. AnyOf allows us to branch out in this case. The resulting app routing tree would be:
   ```
           -- Settings
   Home ---
           -- Detail
   ```

   Keep in mind, that the order of the listed path builders matters. The first path builders that can handle the path will build it.

   ⚠️ The anyOf PathBuilder is limited to 10 elements, stack .anyOf path builders if a screen can be followed up by more than ten screens ⚠️
   ```swift
   .screen(
   //  ...
       nesting: .anyOf(
           .anyOf(
             // ... 10 pathBuilders here
           ),
           .anyOf(
             // ... the other path builders
           )
       )
   )
   ...
   ```
  */
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
          return .a(aContent)
        }
        else if let bContent = b.build(path: path) {
          return .b(bContent)
        }
        else if let cContent = c.build(path: path) {
          return .c(cContent)
        }
        else if let dContent = d.build(path: path) {
          return .d(dContent)
        }
        else if let eContent = e.build(path: path) {
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
  /***
   ```swift
   .screen(
   //  ...
       nesting: .anyOf(
           SettingsScreen.builder(store: settingsStore),
           DetailScreen.builder(store: detailStore)
       )
   )
   ...
   ```

   If a screen can have more than one possible successor, the AnyOf path builder allows to branch out. In the example, the Home Screen can either route to the Settings or the Detail screen. We express these two possible routing paths by passing an anyOf path builder as a `nesting` argument.

   Read AnyOf path builders as "any of the listed path builder builds the path". Given our example, the settings and the detail screen can follow after the home screen. AnyOf allows us to branch out in this case. The resulting app routing tree would be:
   ```
           -- Settings
   Home ---
           -- Detail
   ```

   Keep in mind, that the order of the listed path builders matters. The first path builders that can handle the path will build it.

   ⚠️ The anyOf PathBuilder is limited to 10 elements, stack .anyOf path builders if a screen can be followed up by more than ten screens ⚠️
   ```swift
   .screen(
   //  ...
       nesting: .anyOf(
           .anyOf(
             // ... 10 pathBuilders here
           ),
           .anyOf(
             // ... the other path builders
           )
       )
   )
   ...
   ```
  */
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
          return .a(aContent)
        }
        else if let bContent = b.build(path: path) {
          return .b(bContent)
        }
        else if let cContent = c.build(path: path) {
          return .c(cContent)
        }
        else if let dContent = d.build(path: path) {
          return .d(dContent)
        }
        else if let eContent = e.build(path: path) {
          return .e(eContent)
        }
        else if let fContent = f.build(path: path) {
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
  /***
   ```swift
   .screen(
   //  ...
       nesting: .anyOf(
           SettingsScreen.builder(store: settingsStore),
           DetailScreen.builder(store: detailStore)
       )
   )
   ...
   ```

   If a screen can have more than one possible successor, the AnyOf path builder allows to branch out. In the example, the Home Screen can either route to the Settings or the Detail screen. We express these two possible routing paths by passing an anyOf path builder as a `nesting` argument.

   Read AnyOf path builders as "any of the listed path builder builds the path". Given our example, the settings and the detail screen can follow after the home screen. AnyOf allows us to branch out in this case. The resulting app routing tree would be:
   ```
           -- Settings
   Home ---
           -- Detail
   ```

   Keep in mind, that the order of the listed path builders matters. The first path builders that can handle the path will build it.

   ⚠️ The anyOf PathBuilder is limited to 10 elements, stack .anyOf path builders if a screen can be followed up by more than ten screens ⚠️
   ```swift
   .screen(
   //  ...
       nesting: .anyOf(
           .anyOf(
             // ... 10 pathBuilders here
           ),
           .anyOf(
             // ... the other path builders
           )
       )
   )
   ...
   ```
  */
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
          return .a(aContent)
        }
        else if let bContent = b.build(path: path) {
          return .b(bContent)
        }
        else if let cContent = c.build(path: path) {
          return .c(cContent)
        }
        else if let dContent = d.build(path: path) {
          return .d(dContent)
        }
        else if let eContent = e.build(path: path) {
          return .e(eContent)
        }
        else if let fContent = f.build(path: path) {
          return .f(fContent)
        }
        else if let gContent = g.build(path: path) {
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
  /***
   ```swift
   .screen(
   //  ...
       nesting: .anyOf(
           SettingsScreen.builder(store: settingsStore),
           DetailScreen.builder(store: detailStore)
       )
   )
   ...
   ```

   If a screen can have more than one possible successor, the AnyOf path builder allows to branch out. In the example, the Home Screen can either route to the Settings or the Detail screen. We express these two possible routing paths by passing an anyOf path builder as a `nesting` argument.

   Read AnyOf path builders as "any of the listed path builder builds the path". Given our example, the settings and the detail screen can follow after the home screen. AnyOf allows us to branch out in this case. The resulting app routing tree would be:
   ```
           -- Settings
   Home ---
           -- Detail
   ```

   Keep in mind, that the order of the listed path builders matters. The first path builders that can handle the path will build it.

   ⚠️ The anyOf PathBuilder is limited to 10 elements, stack .anyOf path builders if a screen can be followed up by more than ten screens ⚠️
   ```swift
   .screen(
   //  ...
       nesting: .anyOf(
           .anyOf(
             // ... 10 pathBuilders here
           ),
           .anyOf(
             // ... the other path builders
           )
       )
   )
   ...
   ```
  */
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
          return .a(aContent)
        }
        else if let bContent = b.build(path: path) {
          return .b(bContent)
        }
        else if let cContent = c.build(path: path) {
          return .c(cContent)
        }
        else if let dContent = d.build(path: path) {
          return .d(dContent)
        }
        else if let eContent = e.build(path: path) {
          return .e(eContent)
        }
        else if let fContent = f.build(path: path) {
          return .f(fContent)
        }
        else if let gContent = g.build(path: path) {
          return .g(gContent)
        }
        else if let hContent = h.build(path: path) {
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
  /***
   ```swift
   .screen(
   //  ...
       nesting: .anyOf(
           SettingsScreen.builder(store: settingsStore),
           DetailScreen.builder(store: detailStore)
       )
   )
   ...
   ```

   If a screen can have more than one possible successor, the AnyOf path builder allows to branch out. In the example, the Home Screen can either route to the Settings or the Detail screen. We express these two possible routing paths by passing an anyOf path builder as a `nesting` argument.

   Read AnyOf path builders as "any of the listed path builder builds the path". Given our example, the settings and the detail screen can follow after the home screen. AnyOf allows us to branch out in this case. The resulting app routing tree would be:
   ```
           -- Settings
   Home ---
           -- Detail
   ```

   Keep in mind, that the order of the listed path builders matters. The first path builders that can handle the path will build it.

   ⚠️ The anyOf PathBuilder is limited to 10 elements, stack .anyOf path builders if a screen can be followed up by more than ten screens ⚠️
   ```swift
   .screen(
   //  ...
       nesting: .anyOf(
           .anyOf(
             // ... 10 pathBuilders here
           ),
           .anyOf(
             // ... the other path builders
           )
       )
   )
   ...
   ```
  */
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
          return .a(aContent)
        }
        else if let bContent = b.build(path: path) {
          return .b(bContent)
        }
        else if let cContent = c.build(path: path) {
          return .c(cContent)
        }
        else if let dContent = d.build(path: path) {
          return .d(dContent)
        }
        else if let eContent = e.build(path: path) {
          return .e(eContent)
        }
        else if let fContent = f.build(path: path) {
          return .f(fContent)
        }
        else if let gContent = g.build(path: path) {
          return .g(gContent)
        }
        else if let hContent = h.build(path: path) {
          return .h(hContent)
        }
        else if let iContent = i.build(path: path) {
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
