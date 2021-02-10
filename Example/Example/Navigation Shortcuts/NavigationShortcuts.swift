import ComposableNavigator
import SwiftUI

struct NavigationShortcuts: View {
  @Environment(\.navigator) var navigator
  @Environment(\.currentScreenID) var id

  var body: some View {
    Divider()
    Button(
      action: {
        navigator.replace(
          path: [
            HomeScreen().eraseToAnyScreen(),
            DetailScreen(detailID: "0").eraseToAnyScreen(),
            NavigationShortcutsScreen(presentationStyle: .push).eraseToAnyScreen()
          ]
        )
      },
      label: {
        Text("Go to [home/detail?id=0/shortcuts]")
      }
    )

    Divider()
    Button(
      action: {
        navigator.replace(
          path: [
            HomeScreen().eraseToAnyScreen(),
            DetailScreen(detailID: "0").eraseToAnyScreen(),
            SettingsScreen().eraseToAnyScreen()
          ]
        )
      },
      label: { Text("Go to [home/detail?id=0/settings]") }
    )

    Button(
      action: {
        navigator.replace(
          path: [
            HomeScreen().eraseToAnyScreen(),
            DetailScreen(detailID: "0").eraseToAnyScreen(),
            SettingsScreen().eraseToAnyScreen(),
            NavigationShortcutsScreen(presentationStyle: .push).eraseToAnyScreen()
          ]
        )
      },
      label: { Text("Go to [home/detail?id=0/settings/shortcuts?style=push]") }
    )

    Button(
      action: {
        navigator.replace(
          path: [
            HomeScreen().eraseToAnyScreen(),
            DetailScreen(detailID: "0").eraseToAnyScreen(),
            SettingsScreen().eraseToAnyScreen(),
            NavigationShortcutsScreen(
              presentationStyle: .sheet(allowsPush: true)
            ).eraseToAnyScreen()
          ]
        )
      },
      label: { Text("Go to [home/detail?id=0/settings/shortcuts?style=sheet]") }
    )

    Divider()
    Button(
      action: {
        navigator.replace(
          path: [
            HomeScreen().eraseToAnyScreen(),
            SettingsScreen().eraseToAnyScreen()
          ]
        )
      },
      label: { Text("Go to [home/settings]") }
    )

    Button(
      action: { navigator.goBack(to: HomeScreen()) },
      label: { Text("Go back to [home]") }
    )
  }
}
