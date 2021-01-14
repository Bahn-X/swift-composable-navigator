extension DeeplinkParser {
  static func anyOf(
    _ parsers: [DeeplinkParser]
  ) -> DeeplinkParser {
    DeeplinkParser(
      parse: { deeplink in
        for parser in parsers {
          if let path = parser.parse(deeplink) {
            return path
          }
        }
        return nil
      }
    )
  }

  static func anyOf(
    _ parsers: DeeplinkParser...
  ) -> DeeplinkParser {
    Self.anyOf(parsers)
  }
}
