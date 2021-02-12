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

  static func builder(
    store: Store<SettingsState, SettingsAction>
  ) -> some PathBuilder {
    PathBuilders.screen( // settings
      content: { (screen: SettingsScreen) in
        SettingsView(store: store)
      },
      nesting: NavigationShortcutsScreen.builder(
        store: store.scope(
          state: \.navigationShortcuts,
          action: SettingsAction.navigationShortcuts
        )
      )
    )
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

        NavigationShortcuts()

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
      )
    )
  }
}
