import ComposableDeeplinking

extension DeeplinkParser {
  /// example://home/settings
  static let homeSettings = DeeplinkParser(
    parse: { deeplink in
      guard deeplink.components.count == 2,
            deeplink.components[0].name == "home",
            deeplink.components[1].name == "settings"
      else {
        return nil
      }

      return [
        .screen(HomeScreen().eraseToAnyScreen()),
        .screen(SettingsScreen().eraseToAnyScreen())
      ]
    }
  )
}
