@testable import ComposableDeeplinking
import XCTest

final class DeeplinkComponentTests: XCTestCase {
  func test_init_fails_if_URL_has_no_host() {
    var components = URLComponents()
    components.scheme = "app"
    components.path = "somePathWithoutHost"

    let url = components.url!

    XCTAssertNil(DeeplinkComponent(url: url))
  }

  func test_array_extension_init_from_url() {
    let expectedComponents = [
      DeeplinkComponent(
        name: "first",
        arguments: nil
      ),
      DeeplinkComponent(
        name: "second",
        arguments: nil
      )
    ]

    var components = URLComponents()
    components.host = "first"
    components.path = "/second"

    let url = components.url!

    XCTAssertEqual(expectedComponents, [DeeplinkComponent](url: url))
  }

  func test_init_DeeplinkComponent_fromURL() {
    let expectedPathElement = DeeplinkComponent(
      name: "test",
      arguments: [
        "id": .value("1"),
        "message": .value("Hello World"),
        "flag": .flag
      ]
    )

    let url = URL(string: "app://test?id=1&message=Hello%20World&flag")!

    XCTAssertEqual(DeeplinkComponent(url: url), expectedPathElement)
  }

  func test_DeeplinkComponents_from_url() {
    let url = URL(string: "app://first?id=0&flag/second?flag&id=1")!
    let expectedPathElements = [
      DeeplinkComponent(
        name: "first",
        arguments: [
          "id": .value("0"),
          "flag": .flag
        ]
      ),
      DeeplinkComponent(
        name: "second",
        arguments: [
          "id": .value("1"),
          "flag": .flag
        ]
      )
    ]

    XCTAssertEqual([DeeplinkComponent](url: url), expectedPathElements)
  }
}
