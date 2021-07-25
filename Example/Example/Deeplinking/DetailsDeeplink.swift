import ComposableDeeplinking

extension DeeplinkParser {
  /// example://detail?id={id}
  static let details = DeeplinkParser(
    parse: { deeplink in
      guard deeplink.components.count == 1,
            deeplink.components[0].name == "detail",
            case let .value(id) = deeplink.components[0].arguments?["id"]
      else {
        return nil
      }

      return [
        .screen(HomeScreen().eraseToAnyScreen()),
        .screen(DetailScreen(detailID: id).eraseToAnyScreen())
      ]
    }
  )
}
