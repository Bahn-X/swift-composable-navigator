import ComposableNavigator
import SwiftUI

struct NavigationShortcuts: View {
  @Environment(\.navigator) var navigator
  @Environment(\.currentScreenID) var id

  let accessibilityIdentifiers: AccessibilityIdentifier.NavigationShortcuts

  var body: some View {
    Divider()
    Button(
      action: {
        navigator.replace(
          path: [
            .screen(HomeScreen().eraseToAnyScreen()),
            .screen(DetailScreen(detailID: "0").eraseToAnyScreen()),
            .screen(NavigationShortcutsScreen(presentationStyle: .push).eraseToAnyScreen())
          ]
        )
      },
      label: {
        Text("Go to [home/detail?id=0/shortcuts]")
      }
    )
    .accessibility(identifier: accessibilityIdentifiers.detailShortcuts)

    Divider()
    Button(
      action: {
        navigator.replace(
          path: [
            HomeScreen().eraseToAnyScreen(),
            DetailScreen(detailID: "0").eraseToAnyScreen(),
            SettingsScreen().eraseToAnyScreen()
          ].map(ActiveNavigationPathElement.screen)
        )
      },
      label: { Text("Go to [home/detail?id=0/settings]") }
    )
    .accessibility(identifier: accessibilityIdentifiers.detailSettings)

    Button(
      action: {
        navigator.replace(
          path: [
            HomeScreen().eraseToAnyScreen(),
            DetailScreen(detailID: "0").eraseToAnyScreen(),
            SettingsScreen().eraseToAnyScreen(),
            NavigationShortcutsScreen(presentationStyle: .push).eraseToAnyScreen()
          ].map(ActiveNavigationPathElement.screen)
        )
      },
      label: { Text("Go to [home/detail?id=0/settings/shortcuts?style=push]") }
    )
    .accessibility(identifier: accessibilityIdentifiers.detailSettingsShortcutsPush)

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
          ].map(ActiveNavigationPathElement.screen)
        )
      },
      label: { Text("Go to [home/detail?id=0/settings/shortcuts?style=sheet]") }
    )
    .accessibility(identifier: accessibilityIdentifiers.detailSettingsShortcutsSheet)

    Divider()
    Button(
      action: {
        navigator.replace(
          path: [
            HomeScreen().eraseToAnyScreen(),
            SettingsScreen().eraseToAnyScreen()
          ].map(ActiveNavigationPathElement.screen)
        )
      },
      label: { Text("Go to [home/settings]") }
    )
    .accessibility(identifier: accessibilityIdentifiers.homeSettings)

    Button(
      action: { navigator.goBack(to: HomeScreen()) },
      label: { Text("Go back to [home]") }
    )
    .accessibility(identifier: accessibilityIdentifiers.home)
  }
}
