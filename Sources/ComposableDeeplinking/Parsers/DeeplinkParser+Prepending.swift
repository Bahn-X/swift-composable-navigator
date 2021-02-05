import ComposableNavigator

public extension DeeplinkParser {
  /// Allows you to prepend a routing path to the feature's entrypoint, given the underlying parses succeeds in parsing the deeplink
  ///
  /// In bigger, modularly designed applications, features often have entrypoints. This Deeplink Parses allows you to navigate to the feature's entrypoint before the performing the navigation defined in the deeplink.
  static func prepending(
    path pathToEntrypoint: [AnyScreen],
    to parser: DeeplinkParser
  ) -> DeeplinkParser {
    DeeplinkParser(
      parse: { deeplink in
        parser.parse(deeplink).flatMap { parsedPath in
          pathToEntrypoint + parsedPath
        }
      }
    )
  }
}
