import SwiftUI

/// An erased path builder that erases the underlying Content to AnyView
public struct AnyPathBuilder: PathBuilder {
  private let buildPathElement: (ActiveNavigationTreeElement) -> AnyView?

  /// Erases the passed PathBuilder's Content to AnyView, if it builds the passed PathElement
  public init<Erased: PathBuilder>(erasing: Erased) {
    buildPathElement = { pathElement in
      erasing
        .build(pathElement: pathElement)
        .flatMap(AnyView.init)
    }
  }

  public func build(pathElement: ActiveNavigationTreeElement) -> AnyView? {
    buildPathElement(pathElement)
  }
}

extension PathBuilder {
  /// Erases circular navigation paths
  ///
  /// NavigationTrees define a `PathBuilder<Content: View>` via their builder computed variable.
  /// The `Screen` PathBuilder adds `NavigationNode<ScreenView, Successor>`s to the NavigationTree.
  ///
  /// One the one hand, this makes sure that all valid navigation paths are known at build time.
  /// On the other hand, this leads to problems if the NavigationTree contains a circular path.
  ///
  /// The following NavigationTree leads to a circular path:
  ///
  /// ```swift
  /// struct HomeScreen {
  ///   let presentationStyle = ScreenPresentationStyle.push
  ///
  ///   struct Builder: NavigationTree {
  ///     var builder: _PathBuilder<
  ///       NavigationNode<HomeView,
  ///           NavigationNode<HomeView, ...> // <- Circular Type
  ///         >
  ///     > {
  ///       Screen(
  ///         HomeScreen.self,
  ///         content: HomeView.init,
  ///         nesting: {
  ///           HomeScreen.Builder()
  ///         }
  ///       )
  ///     }
  ///   }
  /// }
  /// ```
  ///
  /// Whenever a `Screen` Builder is contained multiple times in a navigation tree,
  /// the `Screen` and its successors are contained recursively in the NavigationTrees content type.
  ///
  /// Unfortunately, the compiler is not able to resolve recursive, generic types.
  /// To solve this, we can erase PathBuilders that lead to circular paths.
  ///
  /// ```swift
  /// struct HomeScreen {
  ///   let presentationStyle = ScreenPresentationStyle.push
  ///
  ///   struct Builder: NavigationTree {
  ///     var builder: _PathBuilder<
  ///       NavigationNode<HomeView, AnyView> // <- No longer circular
  ///     > {
  ///       Screen(
  ///         HomeScreen.self,
  ///         content: HomeView.init,
  ///         nesting: {
  ///           HomeScreen
  ///             .Builder()
  ///             .eraseCircularNavigationPath()
  ///         }
  ///       )
  ///     }
  ///   }
  /// }
  /// ```
  public func eraseCircularNavigationPath() -> AnyPathBuilder {
    AnyPathBuilder(erasing: self)
  }
}
