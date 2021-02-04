public extension DeeplinkParser {
  static let empty = DeeplinkParser(
    parse: { _ in nil }
  )
}
