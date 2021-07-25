import ComposableNavigator

/// `DeeplinkParser`s parse navigation paths from `Deeplink`s.
///
/// `DeeplinkParser`s are wrapper structs around a pure `(Deeplink) -> [AnyScreen]?` function and support composition.
///
/// # Returns
///  If a deeplink parser handles the input `Deeplink`, it returns a `navigation path` in the form of an `AnyScreen` array.
///  If the deeplink parser is not responsible for parsing the deeplink, it returns nil.
public struct DeeplinkParser {
    private let _parse: (Deeplink) -> ActiveNavigationPath?

    public init(parse: @escaping (Deeplink) -> ActiveNavigationPath?) {
        _parse = parse
    }

    /// Parses a Deeplink to a navigation path
    ///
    /// - Returns: If the DeepLinkParser is responsible for the passed deeplink, it returns the built navigation path. Else nil.
    public func parse(_ deeplink: Deeplink) -> ActiveNavigationPath? {
        _parse(deeplink)
    }
}
