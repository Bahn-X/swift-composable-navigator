import ComposableArchitecture
import ComposableNavigator

extension PathBuilder {
  /// `onDismiss` allows to perform an action whenever the `AnyScreen` object built by the wrapped `PathBuilder` changes
  ///
  /// `onDismiss` keeps track of the last built `AnyScreen` and performs the defined action whenever a screen is no longer built.
  ///  If your `PathBuilder` is wrapped in a conditional path builder, make sure to attach `onDismiss` to the outer-most conditional `PathBuilder`.
  ///
  /// # Example
  /// ```swift
  /// PathBuilders.anyOf(
  ///   DetailScreen.Builder,
  ///   SettingsScreen.Builder
  /// )
  /// .onDismiss(
  ///   send: { screen in MainAction.dismissedScreen(screen) },
  ///   into: mainStore
  /// )
  /// ```
  ///
  /// - Parameters:
  ///     - action: Action sent on dismiss.
  ///     - store: Store the action is sent into.
  public func onDismiss<State: Equatable, Action: Equatable>(
    send action: @escaping (AnyScreen) -> Action,
    into store: Store<State, Action>
  ) -> _PathBuilder<Content> {
    onDismiss(
      perform: { (screen: AnyScreen) in
        ViewStore(store).send(action(screen))
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
  ///        nesting: SettingsScreen.Builder().onDismiss(of: SettingsScreen.self) {
  ///          // only called if DetailScreen is contained in the current navigation path
  ///          print("Dismissed settings screen")
  ///        }
  ///      )
  ///      .beforeBuild {
  ///        mainStore.selectedDetail = screen.detailID
  ///      }
  ///    }
  ///  )
  ///  .onDismiss(
  ///    send: { (screen: DetailScreen) in MainAction.dismissDetail(id: screen.id) },
  ///    into: mainStore
  ///  )
  /// ```
  ///
  /// - Parameters:
  ///     - action: Action sent on dismiss.
  ///     - store: Store the action is sent into.
  public func onDismiss<Dismissed: Screen, State: Equatable, Action: Equatable>(
    send action: @escaping (Dismissed) -> Action,
    into store: Store<State, Action>
  ) -> _PathBuilder<Content> {
    onDismiss(
      perform: { (screen: Dismissed) in
        ViewStore(store).send(action(screen))
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
  ///        nesting: SettingsScreen.Builder().onDismiss(of: SettingsScreen.self) {
  ///          // only called if DetailScreen is contained in the current navigation path
  ///          print("Dismissed settings screen")
  ///        }
  ///      )
  ///      .beforeBuild {
  ///        mainStore.selectedDetail = screen.detailID
  ///      }
  ///    }
  ///  )
  ///  .onDismiss(
  ///    of: DetailScreen.self,
  ///    send: MainAction.dismissDetail,
  ///    into: mainStore
  ///  )
  /// ```
  ///
  /// - Parameters:
  ///     - of: defines the `Dismissed: Screen` type.
  ///     - action: Action sent on dismiss.
  ///     - store: Store the action is sent into.
  public func onDismiss<Dismissed: Screen, State: Equatable, Action: Equatable>(
    of screen: Dismissed.Type,
    send action: Action,
    into store: Store<State, Action>
  ) -> _PathBuilder<Content> {
    onDismiss(
      of: screen,
      perform: {
        ViewStore(store).send(action)
      }
    )
  }
}
