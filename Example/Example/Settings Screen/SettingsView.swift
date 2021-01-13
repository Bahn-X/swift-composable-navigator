import ComposableArchitecture
import ComposableNavigator
import SwiftUI

struct SettingsState: Equatable {}

enum SettingsAction: Equatable {
  case viewAppeared
}

struct SettingsEnvironment {
  let navigator: Navigator
}

struct SettingsScreen: Screen {
  let presentationStyle: ScreenPresentationStyle = .sheet(allowsPush: true)
}

let settingsReducer = Reducer<
  SettingsState,
  SettingsAction,
  SettingsEnvironment
>.empty

struct SettingsView: View {
  @Environment(\.navigator) var navigator
  let store: Store<SettingsState, SettingsAction>

  var body: some View {
    VStack {
      Text("Settings")
        .navigationBarTitle("Settings", displayMode: .inline)

      Button(
        action: { navigator.goBack(to: HomeScreen()) },
        label: { Text("Go back to home screen") }
      )
    }
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
