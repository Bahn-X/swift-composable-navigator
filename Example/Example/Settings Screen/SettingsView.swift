import ComposableArchitecture
import ComposableNavigator
import SwiftUI

struct SettingsState: Equatable {
  var navigationShortcuts = NavigationShortcutsState()
}

enum SettingsAction: Equatable {
  case viewAppeared

  case navigationShortcuts(NavigationShortcutsAction)
}

struct SettingsEnvironment {
  let navigator: Navigator

  var navigationShortcuts: NavigationShortcutsEnvironment {
    NavigationShortcutsEnvironment(navigator: navigator)
  }
}

struct SettingsScreen: Screen {
  let presentationStyle: ScreenPresentationStyle = .sheet(allowsPush: true)

  struct Builder: NavigationTree {
    let store: Store<SettingsState, SettingsAction>
    let entrypoint: String

    var builder: some PathBuilder {
      Screen( // settings
        SettingsScreen.self,
        content: {
          SettingsView(
            store: store,
            accessibilityIdentifiers: AccessibilityIdentifier.SettingsScreen(prefix: entrypoint)
          )
        },
        nesting: {
          NavigationShortcutsScreen.Builder(
            store: store.scope(
              state: \.navigationShortcuts,
              action: SettingsAction.navigationShortcuts
            )
          )
        }
      )
    }
  }
}

let settingsReducer = Reducer<
  SettingsState,
  SettingsAction,
  SettingsEnvironment
>.combine(
  .empty,
  navigationShortcutsReducer.pullback(
    state: \.navigationShortcuts,
    action: /SettingsAction.navigationShortcuts,
    environment: \.navigationShortcuts
  )
)

struct SettingsView: View {
  @Environment(\.navigator) var navigator
  @Environment(\.currentScreenID) var id
  let store: Store<SettingsState, SettingsAction>
  let accessibilityIdentifiers: AccessibilityIdentifier.SettingsScreen

  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 16) {
        Button(
          action: {
            navigator.go(
              to: NavigationShortcutsScreen(
                presentationStyle: .push
              ),
              on: id
            )
          },
          label: { Text("Go to [./shortcuts?style=push]") }
        )
        .accessibility(identifier: accessibilityIdentifiers.shortcutsPush)

        Button(
          action: {
            navigator.go(
              to: NavigationShortcutsScreen(
                presentationStyle: .sheet(allowsPush: true)
              ),
              on: id
            )
          },
          label: { Text("Go to [./shortcuts?style=sheet]") }
        )
        .accessibility(identifier: accessibilityIdentifiers.shortcutsSheet)

        NavigationShortcuts(
          accessibilityIdentifiers: AccessibilityIdentifier.NavigationShortcuts(prefix: "settings")
        )

        Spacer()
      }
      Spacer()
    }
    .padding(16)
    .navigationTitle(Text("Settings"))
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView(
      store: Store(
        initialState: SettingsState(),
        reducer: .empty,
        environment: ()
      ),
      accessibilityIdentifiers: AccessibilityIdentifier.SettingsScreen(prefix: "settings")
    )
  }
}
