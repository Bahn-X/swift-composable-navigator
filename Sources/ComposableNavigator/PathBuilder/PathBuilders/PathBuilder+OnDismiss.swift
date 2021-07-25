import SwiftUI

public struct OnDismissView<Content: View>: View {
  @EnvironmentObject var datasource: Navigator.Datasource
  @Environment(\.parentScreenID) var parentScreenID

  let build: (ActiveNavigationTreeElement) -> Content?
  let content: Content
  let perform: (AnyScreen) -> Void

  public var body: some View {
    content
      .onReceive(
        datasource.$navigationTree,
        perform: { path in
          guard let parentScreenID = parentScreenID, path.component(for: parentScreenID).current != nil else {
            return
          }

          let update = path.successor(of: parentScreenID)
          let built = update.current.flatMap(build)
          let previouslyBuiltScreen = update.previous?.content
          let builtScreen = built != nil ? update.current?.content : nil

          if builtScreen != previouslyBuiltScreen || built == nil, let last = previouslyBuiltScreen {
            perform(last)
          }
        }
      )
  }
}

public extension PathBuilder {
  /// `onDismiss` allows to perform an action whenever the `AnyScreen` object built by the wrapped `PathBuilder` changes
  ///
  /// `onDismiss` keeps track of the last built `AnyScreen` and performs the defined action whenever a screen is no longer built.
  ///  If your `PathBuilder` is wrapped in a conditional path builder, make sure to attach `onDismiss` to the outer-most conditional `PathBuilder`.
  ///
  /// # Example
  /// ```swift
  /// PathBuilders.anyOf(
  ///   DetailScreen.Builder(),
  ///   SettingsScreen.Builder()
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
  ) -> _PathBuilder<OnDismissView<Content>> {
    _PathBuilder { pathElement in
      build(pathElement: pathElement).flatMap { content in
        OnDismissView(
            build: self.build(pathElement:),
            content: content,
            perform: perform
        )
      }
    }
  }

  /// `onDismiss` allows to perform an action whenever a`Screen` is dismissed
  ///
  /// `onDismiss` keeps track of the last built `Screen` and performs the defined action whenever a screen is no longer built.
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
  ///  .onDismiss { (screen: DetailScreen) in
  ///    mainStore.selectedDetail = nil
  ///  }
  /// ```
  ///
  /// - Parameters:
  ///     - perform: Block to perform when the wrapped `PathBuilder` no longer builds the defined `Dismissed: Screen` type. Called with the previously built `Dismissed` instance.
  func onDismiss<Dismissed: Screen>(
    perform: @escaping (Dismissed) -> Void
  ) -> _PathBuilder<OnDismissView<Content>> {
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
  /// # Example
  /// ```swift
  ///  PathBuilders.if(
  ///    screen: { (screen: DetailScreen) in
  ///      PathBuilders.screen(
  ///        DetailScreen.self,
  ///        content: {
  ///          DetailView(mainStore.detailStore)
  ///        },
  ///        nesting: SettingsScreen.Builder.onDismiss(of: SettingsScreen.self) {
  ///          // only called if DetailScreen is contained in the current navigation path
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
  ) -> _PathBuilder<OnDismissView<Content>> {
    onDismiss(
      perform: { (screen: AnyScreen) in
        guard screen.is(Dismissed.self) else { return }
        perform()
      }
    )
  }
}
