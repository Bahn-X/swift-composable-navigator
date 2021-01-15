public extension DeeplinkParser {
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
