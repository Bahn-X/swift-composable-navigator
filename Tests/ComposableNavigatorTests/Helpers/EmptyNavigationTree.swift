import ComposableNavigator

struct EmptyNavigationTree: NavigationTree {
  var builder: some PathBuilder { Empty() }
}
