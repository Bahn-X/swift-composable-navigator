import SwiftUI

/// `NavigationTree`s define all valid navigation paths in an application
///
/// `NavigationTree`s compose `PathBuilder`s into a `NavigationTree`.
/// As `NavigationTree`s are `PathBuilder`s themselves, you can compose multiple `NavigationTree`s into a bigger `NavigationTree`.
///
/// # Example
/// ```swift
/// struct AppNavigationTree: NavigationTree {
///   let homeViewModel: HomeViewModel
///   let detailViewModel: DetailViewModel
///   let settingsViewModel: SettingsViewModel
///
///    var builder: some PathBuilder {
///     Screen(
///       HomeScreen.self,
///       content: { HomeView(viewModel: homeViewModel) },
///       nesting: {
///         DetailScreen.Builder(viewModel: detailViewModel),
///         SettingsScreen.Builder(viewModel: settingsViewModel)
///       }
///     )
///   }
/// }
///
/// struct DetailScreen: Screen {
///   let presentationStyle: ScreenPresentationStyle = .push
///   let viewModel: DetailViewModel
///
///   struct Builder: NavigationTree {
///     var builder: some PathBuilder {
///       Screen(
///         DetailScreen.self,
///         content: { DetailView(viewModel: viewModel) }
///       )
///     }
///   }
/// }
///
/// struct SettingsScreen: Screen {
///   let presentationStyle: ScreenPresentationStyle = .sheet(allowsPush: true)
///   let viewModel: SettingsViewModel
///
///   struct Builder: NavigationTree {
///     var builder: some PathBuilder {
///       Screen(
///         SettingsScreen.self,
///         content: { SettingsView(viewModel: viewModel) }
///       )
///     }
///   }
/// }
/// ```
///
/// # Control flow
/// `NavigationTree` use a `NavigationTreeBuilder` result builder to compose path builders.
///
/// `NavigationTreeBuilder` implements the necessary methods to enable Swift's built-in control flow methods, including if, if let and switch.
///
/// This means, that you can in/exclude parts of a navigation tree based on a condition.
///
///  ```swift
///  struct Tree: NavigationTree {
///    let user: User
///
///    var builder: some PathBuilder {
///       if user.isLoggedIn() {
///         HomeScreen.Builder(store: homeStore)
///       } else {
///         LoginScreen.Builder(store: loginStore)
///       }
///    }
///  }
///  ```
/// # Multiple entrypoints
/// If your NavigationTree has multiple entrypoints, you can list them in the builder.
///
/// A path builder indicates that is responsible of building a path element by returning a valid view hierarchy.
///
/// When a path element is built, the path builders are invoked in the listed order. The view hierarchy built by the first matching path builder is returned. If none of the listed path builders are reponsible of building the path element, the path builder returns `nil`.
///
///  ```swift
///  struct Tree: NavigationTree {
///    let user: User
///
///    var builder: some PathBuilder {
///       EntrypointA.Builder(store: ...)
///       EntrypointB.Builder(store: ...)
///       EntrypointC.Builder(store: ...)
///       // Will never get called, as the first path builder takes care of EntrypointA
///       EntrypointA.Builder(store: ...)
///    }
///  }
///  ```
public protocol NavigationTree: PathBuilder {
  associatedtype Builder: PathBuilder
  @NavigationTreeBuilder var builder: Builder { get }

  /// An empty navigation tree, building no paths.
  func Empty() -> PathBuilders.EmptyBuilder

  // MARK: Screen
  /// `PathBuilder` responsible of building a single screen. Adds a node to the navigation tree.
  ///
  ///  The screen `PathBuilder` describes how a single screen is built.  The content closure is only called if the path element is of type HomeScreen.
  ///
  ///  # Example
  ///  ```swift
  ///  struct Tree: NavigationTree {
  ///    var builder: some PathBuilder {
  ///      Screen(
  ///       onAppear: { initialAppear in ... },
  ///       content: { (screen: HomeScreen) in
  ///         HomeView(...)
  ///       },
  ///       nesting: { ... }
  ///      )
  ///    }
  ///  }
  ///  ```
  ///
  ///  The Home screen builder extracts `HomeScreen` instances from the navigation path and uses it's nesting `PathBuilder` to build the remaining path.
  ///
  ///  - Parameters:
  ///    - onAppear:
  ///      Called whenever the screen appears. The passed bool is true, if it is the screens initial appear.
  ///    - content:
  ///      Closure describing how to build a SwiftUI view given the screen data.
  ///    - nesting:
  ///      Any `PathBuilder` that can follow after this screen
  func Screen<
    S: Screen,
    Content: View,
    Successor: PathBuilder
  >(
    onAppear: @escaping (Bool) -> Void,
    @ViewBuilder content build: @escaping (S) -> Content,
    @NavigationTreeBuilder nesting: () -> Successor
  ) -> _PathBuilder<NavigationNode<Content, Successor.Content>>

  /// `PathBuilder` responsible of building a single screen. Adds a node to the navigation tree.
  ///
  ///  The screen `PathBuilder` describes how a single screen is built.  The content closure is only called if the path element is of type `HomeScreen`.
  ///
  ///  # Example
  ///  ```swift
  ///  struct Tree: NavigationTree {
  ///    var builder: some PathBuilder {
  ///      Screen(
  ///       onAppear: { initialAppear in ... },
  ///       content: { (screen: HomeScreen) in
  ///         HomeView(...)
  ///       }
  ///      )
  ///    }
  ///  }
  ///  ```
  ///
  ///  The Home screen builder extracts `HomeScreen` instances from the navigation path and uses it's nesting `PathBuilder` to build the remaining path.
  ///
  ///  - Parameters:
  ///    - onAppear:
  ///      Called whenever the screen appears. The passed bool is true, if it is the screens initial appear.
  ///    - content:
  ///      Closure describing how to build a SwiftUI view given the screen data.
  func Screen<S: Screen, Content: View>(
    onAppear: @escaping (Bool) -> Void,
    @ViewBuilder content build: @escaping (S) -> Content
  ) -> _PathBuilder<NavigationNode<Content, Never>>

  /// `PathBuilder` responsible of building a single screen. Adds a node to the navigation tree.
  ///
  /// The screen `PathBuilder` describes how a single screen is built.  The content closure is only called if the path element is of type `HomeScreen`.
  ///
  ///  # Example
  ///  ```swift
  ///  struct Tree: NavigationTree {
  ///    var builder: some PathBuilder {
  ///       Screen(
  ///         HomeScreen.self,
  ///         onAppear: { initialAppear in ... },
  ///         content: { HomeView(...) },
  ///         nesting: { ... }
  ///       )
  ///    }
  ///  }
  ///  ```
  ///
  ///  The Home screen builder extracts `HomeScreen` instances from the navigation path and uses it's nesting `PathBuilder` to build the remaining path.
  ///
  ///  - Parameters:
  ///     - type:
  ///       Defines which screens are handled by the `PathBuilder`.
  ///     - onAppear:
  ///       Called whenever the screen appears. The passed bool is true, if it is the screens initial appear.
  ///     - content:
  ///       Closure describing how to build a SwiftUI view, if the current path element is of the defined screen type.
  ///    - nesting:
  ///      Any `PathBuilder` that can follow after this screen
  func Screen<
    S: Screen,
    Content: View,
    Successor: PathBuilder
  >(
    _ type: S.Type,
    onAppear: @escaping (Bool) -> Void,
    @ViewBuilder content build: @escaping () -> Content,
    @NavigationTreeBuilder nesting: () -> Successor
  ) -> _PathBuilder<NavigationNode<Content, Successor.Content>>

  /// `PathBuilder` responsible of building a single screen. Adds a node to the navigation tree.
  ///
  ///  The screen `PathBuilder` describes how a single screen is built.  The content closure is only called if the path element is of type `HomeScreen`.
  ///
  ///  # Example
  ///  ```swift
  ///  struct Tree: NavigationTree {
  ///    var builder: some PathBuilder {
  ///       PathBuilders.screen(
  ///         HomeScreen.self,
  ///         onAppear: { initialAppear in ... },
  ///         content: { HomeView(...) }
  ///       )
  ///    }
  ///  }
  ///  ```
  ///
  ///  The Home screen builder extracts `HomeScreen` instances from the navigation path and uses it's nesting `PathBuilder` to build the remaining path.
  ///
  ///  - Parameters:
  ///     - type:
  ///       Defines which screens are handled by the `PathBuilder`.
  ///     - onAppear:
  ///       Called whenever the screen appears. The passed bool is true, if it is the screens initial appear.
  ///     - content:
  ///       Closure describing how to build a SwiftUI view, if the current path element is of the defined screen type.
  func Screen<S: Screen, Content: View>(
    _ type: S.Type,
    onAppear: @escaping (Bool) -> Void,
    @ViewBuilder content build: @escaping () -> Content
  ) -> _PathBuilder<NavigationNode<Content, Never>>

  // MARK: IfScreen
  ///  The if screen `PathBuilder` unwraps a screen, if the path element matches the screen type, and provides it to the `PathBuilder` defining closure.
  ///
  ///  # Example
  ///  ```swift
  ///  struct Tree: NavigationTree {
  ///    var builder: some PathBuilder {
  ///     If { (screen: DetailScreen) in
  ///       DetailScreen.Builder(store.detailStore(for: screen.id))
  ///     }
  ///     else: { ... }
  ///    }
  ///  }
  ///  ```
  ///
  ///  - Parameters:
  ///     - screen:
  ///       Closure defining the `PathBuilder` based on the unwrapped screen object.
  ///     - else:
  ///       Fallback pathbuilder used if the screen cannot be unwrapped.
  func If<S: Screen, IfBuilder: PathBuilder, Else: PathBuilder>(
    @NavigationTreeBuilder screen pathBuilder: @escaping (S) -> IfBuilder,
    @NavigationTreeBuilder else: () -> Else
  ) -> _PathBuilder<EitherAB<IfBuilder.Content, Else.Content>>

  ///  The if screen `PathBuilder` unwraps a screen, if the path element matches the screen type, and provides it to the `PathBuilder` defining closure.
  ///
  ///  # Example
  ///  ```swift
  ///  struct Tree: NavigationTree {
  ///    var builder: some PathBuilder {
  ///     If { (screen: DetailScreen) in
  ///       DetailScreen.Builder(store.detailStore(for: screen.id))
  ///     }
  ///    }
  ///  }
  ///  ```
  ///
  ///  - Parameters:
  ///     - screen:
  ///       Closure defining the `PathBuilder` based on the unwrapped screen object.
  func If<S: Screen, IfBuilder: PathBuilder>(
    @NavigationTreeBuilder screen pathBuilder: @escaping (S) -> IfBuilder
  ) -> _PathBuilder<EitherAB<IfBuilder.Content, Never>>

  // MARK: Wildcard
  ///  Wildcard `PathBuilder`s replace any screen with a predefined one.
  ///
  ///  Based on the example for the conditional `PathBuilder`, you might run into a situation in which your deeplink parser parses a navigation path that can only be handled by the homeScreenBuilder. This would lead to an empty application, which is unfortunate.
  ///
  ///  To mitigate this problem, you can combine a conditional `PathBuilder` with a wildcard `PathBuilder`:
  ///
  ///  ```swift
  ///  struct Tree: NavigationTree {
  ///    let user: User
  ///
  ///    var builder: some PathBuilder {
  ///       if user.isLoggedIn {
  ///         Wildcard(
  ///           screen: HomeScreen(),
  ///           pathBuilder: HomeScreen.Builder(store: homeStore)
  ///         )
  ///       } else {
  ///         Wildcard(
  ///           screen: LoginScreen(),
  ///           pathBuilder: loginScreen(store: loginStore)
  ///         )
  ///       }
  ///    }
  ///  }
  ///  ```
  ///
  ///  This is example basically states: Whatever path I get, the first element should be a defined screen.
  ///
  ///  # ⚠️ Warning ⚠️
  ///  If you use a Wildcard, make sure it is the last one in the list. If it isn't, it will swallow all screens and the `PathBuilder`s listed after the wildcard will be unreachable.
  ///
  ///  - Parameters:
  ///     - screen:
  ///       The screen that replaces the current path element.
  ///     - pathBuilder:
  ///       The `PathBuilder` used to build the altered path.
  func Wildcard<
    S: Screen,
    ContentBuilder: PathBuilder
  >(
    screen: S,
    pathBuilder: ContentBuilder
  ) -> _PathBuilder<PathBuilders.WildcardView<ContentBuilder.Content, S>>

  // MARK: AnyOf
  /// Convenience wrapper around a `NavigationTreeBuilder`. Similar to SwiftUI's `Group: View`.
  ///
  /// If you ever run into the situation, that your `NavigationTree` has more than 10 entrypoints, you can use AnyOf to circumvent the fact that `NavigationTreeBuilder` cannot combine more than 10 PathBuilders.
  ///
  /// # Example
  ///  ```swift
  ///  struct Tree: NavigationTree {
  ///    var builder: some PathBuilder {
  ///       AnyOf {
  ///         Empty()
  ///         ... 9 more path builders
  ///       }
  ///
  ///       AnyOf {
  ///         ... the other path builders
  ///       }
  ///    }
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///     - builder: `NavigationTreeBuilder` composing multiple path builders into one.
  func AnyOf<P: PathBuilder>(@NavigationTreeBuilder _ builder: () -> P) -> P
}

extension NavigationTree {
  public func build(pathElement: ActiveNavigationTreeElement) -> Builder.Content? {
    builder.build(pathElement: pathElement)
  }
}
