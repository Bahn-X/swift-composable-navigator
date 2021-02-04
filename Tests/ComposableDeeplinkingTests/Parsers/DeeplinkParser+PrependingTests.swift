@testable import ComposableDeeplinking
import XCTest

final class DeeplinkParser_PrependingTests: XCTestCase {
  private let prepended = TestScreen(
    identifier: "prepended",
    presentationStyle: .push
  )

  private let parsingSuccess = TestScreen(
    identifier: "parsingSuccess",
    presentationStyle: .push
  )

  func test_prepends_path_if_parsing_succeeds() {
    let succeedingParser = DeeplinkParser(
      parse: { _ in
        [ self.parsingSuccess.eraseToAnyScreen() ]
      }
    )

    let expectedPath = [
      prepended.eraseToAnyScreen(),
      parsingSuccess.eraseToAnyScreen()
    ]

    let sut = DeeplinkParser.prepending(
      path: [
        prepended.eraseToAnyScreen()
      ],
      to: succeedingParser
    )

    let parsedPath = sut.parse(
      Deeplink(components: [])
    )

    XCTAssertEqual(parsedPath, expectedPath)
  }

  func test_returns_nil_if_parser_does_not_resolve() {
    let succeedingParser = DeeplinkParser(
      parse: { _ in nil }
    )

    let sut = DeeplinkParser.prepending(
      path: [
        prepended.eraseToAnyScreen()
      ],
      to: succeedingParser
    )

    let parsedPath = sut.parse(
      Deeplink(components: [])
    )

    XCTAssertNil(parsedPath)
  }
}
