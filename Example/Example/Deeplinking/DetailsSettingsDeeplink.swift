import ComposableDeeplinking

extension DeeplinkParser {
  /// example://detail?id={id}/settings
  static let detailSettings = DeeplinkParser(
    parse: { deeplink in
      guard deeplink.components.count == 2,
            deeplink.components[0].name == "detail",
            case let .value(id) = deeplink.components[0].arguments?["id"],
            deeplink.components[1].name == "settings"
      else {
        return nil
      }

      return [
        .screen(HomeScreen().eraseToAnyScreen()),
        .screen(DetailScreen(detailID: id).eraseToAnyScreen()),
        .screen(SettingsScreen().eraseToAnyScreen())
      ]
    }
  )
}
