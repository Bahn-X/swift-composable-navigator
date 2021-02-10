import ComposableDeeplinking

extension DeeplinkParser {
    /// Parses all supported deeplinks in the example app
    ///
    /// Supported deeplinks:
    /// * example://home/settings
    /// * example://detail?id={id}
    /// * example://detail?id={id}/settings
    static let exampleApp: DeeplinkParser = .anyOf(
        .homeSettings,
        .details,
        .detailSettings
    )
}
