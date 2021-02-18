@testable import ComposableDeeplinking
import XCTest

final class DeeplinkParser_EmptyTests: XCTestCase {
  func test_empty_deeplink_parser_always_returns_nil() {
    let sut = DeeplinkParser.empty
    XCTAssertNil(sut.parse(Deeplink.Stub.deeplink))
  }
}
