@testable import ComposableDeeplinking
import XCTest

final class DeeplinkTests: XCTestCase {
  func test_init_Deeplink_fromURL_matching_scheme() {
    let expectedDeeplink = Deeplink(
      components: [
        DeeplinkComponent(
          name: "test",
          arguments: [
            "id": .value("1"),
            "message": .value("Hello World"),
            "flag": .flag
          ]
        )
      ]
    )

    let url = URL(string: "app://test?id=1&message=Hello%20World&flag")!

    XCTAssertEqual(Deeplink(url: url, matching: "app"), expectedDeeplink)
  }

  func test_init_Deeplink_fromURL_non_matching_scheme() {
    let url = URL(string: "app://test?id=1&message=Hello%20World&flag")!

    XCTAssertNil(Deeplink(url: url, matching: "otherScheme"))
  }
}
