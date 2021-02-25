import ComposableArchitecture
import ComposableNavigator
import SwiftUI

struct NavigationShortcutsState: Equatable {}

enum NavigationShortcutsAction: Equatable {
  case viewAppeared
}

struct NavigationShortcutsEnvironment {
  let navigator: Navigator
}

struct NavigationShortcutsScreen: Screen {
  let presentationStyle: ScreenPresentationStyle

  struct Builder: NavigationTree {
    let store: Store<NavigationShortcutsState, NavigationShortcutsAction>

    var builder: some PathBuilder {
      Screen(
        NavigationShortcutsScreen.self,
        content: {
          NavigationShortcutsView(store: store)
        }
      )
    }
  }
}

let navigationShortcutsReducer = Reducer<
  NavigationShortcutsState,
  NavigationShortcutsAction,
  NavigationShortcutsEnvironment
>.empty

struct NavigationShortcutsView: View {
  @Environment(\.navigator) var navigator
  let store: Store<NavigationShortcutsState, NavigationShortcutsAction>

  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 16) {
        NavigationShortcuts(
          accessibilityIdentifiers: AccessibilityIdentifier.NavigationShortcuts(prefix: "shortcuts")
        )
        Spacer()
      }
      Spacer()
    }
    .padding(16)
    .navigationTitle(Text("Navigation Shortcuts"))
  }
}

struct NavigationShortcutsView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationShortcutsView(
      store: Store(
        initialState: NavigationShortcutsState(),
        reducer: .empty,
        environment: ()
      )
    )
  }
}
