public extension PathBuilder {
  /// `onDismiss` allows to perform an action whenever the `AnyScreen` object built by the wrapped `PathBuilder` changes
  ///
  /// `onDismiss` keeps track of the last built `AnyScreen` and performs the defined action whenever a screen is no longer built.
  ///  If your `PathBuilder` is wrapped in a conditional path builder, make sure to attach `onDismiss` to the outer-most conditional `PathBuilder`.
  ///
  /// # Example
  /// ```swift
  /// PathBuilders.anyOf(
  ///   DetailScreen.builder,
  ///   SettingsScreen.builder
  /// )
  /// .onDismiss { (screen: AnyScreen) in
  ///   print("Dismissed \(screen)")
  /// }
  /// ```
  ///
  /// - Parameters:
  ///     - perform: Block to perform when the wrapped `PathBuilder` builds a new `AnyScreen` object. Called with the previously built `AnyScreen` instance.
  func onDismiss(
    perform: @escaping (AnyScreen) -> Void
  ) -> _PathBuilder<Content> {
    var lastBuiltScreen: AnyScreen?

    return _PathBuilder<Content>(
      buildPath: { path in
        let built = self.build(path: path)
        let builtScreen = built != nil ? path.first?.content: nil

        if (builtScreen != lastBuiltScreen || built == nil), let last = lastBuiltScreen {
          perform(last)
        }

        lastBuiltScreen = builtScreen

        return built
      }
    )
  }

  /// `onDismiss` allows to perform an action whenever a`Screen` is dismissed
  ///
  /// `onDismiss` keeps track of the last built `Screen` and performs the defined action whenever a screen is no longer built.
  ///
  ///  # ⚠️ Warning ⚠️
  ///  If your `PathBuilder` is wrapped in a lazy conditional path builder (such as ifLet, ifLetStore or ifScreen), make sure to attach `onDismiss` to the outer-most conditional `PathBuilder`. If you replace the path and the lazy path builder is no longer used / captured by a view, inner .onDismiss closures will not be called.
  ///
  /// # Example
  /// ```swift
  ///  PathBuilders.if(
  ///    screen: { (screen: DetailScreen) in
  ///      PathBuilders.screen(
  ///        DetailScreen.self,
  ///        content: {
  ///          DetailView(mainStore.detailStore)
  ///        },
  ///        nesting: SettingsScreen.builder.onDismiss(of: SettingsScreen.self) {
  ///          // only called if DetailScreen is contained in the current routing path
  ///          print("Dismissed settings screen")
  ///        }
  ///      )
  ///      .beforeBuild {
  ///        mainStore.selectedDetail = screen.detailID
  ///      }
  ///    }
  ///  )
  ///  .onDismiss { (screen: DetailScreen) in
  ///    mainStore.selectedDetail = nil
  ///  }
  /// ```
  ///
  /// - Parameters:
  ///     - perform: Block to perform when the wrapped `PathBuilder` no longer builds the defined `Dismissed: Screen` type. Called with the previously built `Dismissed` instance.
  func onDismiss<Dismissed: Screen>(
    perform: @escaping (Dismissed) -> Void
  ) -> _PathBuilder<Content> {
    onDismiss(
      perform: { (screen: AnyScreen) in
        guard let unwrapped: Dismissed = screen.unwrap() else { return }
        perform(unwrapped)
      }
    )
  }

  /// `onDismiss` allows to perform an action whenever a`Screen` is dismissed
  ///
  /// `onDismiss` keeps track of the last built `Screen` and performs the defined action whenever a screen is no longer built.
  ///
  ///  # ⚠️ Warning ⚠️
  ///  If your `PathBuilder` is wrapped in a lazy conditional path builder (such as ifLet, ifLetStore or ifScreen), make sure to attach `onDismiss` to the outer-most conditional `PathBuilder`. If you replace the path and the lazy path builder is no longer captured by a view, inner .onDismiss closures will not be called.
  ///
  /// # Example
  /// ```swift
  ///  PathBuilders.if(
  ///    screen: { (screen: DetailScreen) in
  ///      PathBuilders.screen(
  ///        DetailScreen.self,
  ///        content: {
  ///          DetailView(mainStore.detailStore)
  ///        },
  ///        nesting: SettingsScreen.builder.onDismiss(of: SettingsScreen.self) {
  ///          // only called if DetailScreen is contained in the current routing path
  ///          print("Dismissed settings screen")
  ///        }
  ///      )
  ///      .beforeBuild {
  ///        mainStore.selectedDetail = screen.detailID
  ///      }
  ///    }
  ///  )
  ///  .onDismiss(of: DetailScreen.self) {
  ///    mainStore.selectedDetail = nil
  ///  }
  /// ```
  ///
  /// - Parameters:
  ///     - of: defines the `Dismissed: Screen` type
  ///     - perform: Block to perform when the wrapped `PathBuilder` no longer builds the defined `Dismissed: Screen` type.
  func onDismiss<Dismissed: Screen>(
    of: Dismissed.Type,
    perform: @escaping () -> Void
  ) -> _PathBuilder<Content> {
    onDismiss(
      perform: { (screen: AnyScreen) in
        guard screen.is(Dismissed.self) else { return }
        perform()
      }
    )
  }
}
