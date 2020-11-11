import ComposableArchitecture
import ComposableRouter
import SwiftUI

struct SettingsState: Equatable {}

enum SettingsAction: Equatable {
  case viewAppeared
}

struct SettingsEnvironment {
  let router: Router
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
  let store: Store<SettingsState, SettingsAction>

  var body: some View {
    Text("Settings")
      .navigationBarTitle("Settings", displayMode: .inline)
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
