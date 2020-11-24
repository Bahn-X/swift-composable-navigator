@testable import ComposableNavigator
import XCTest

final class DeeplinkComponentTests: XCTestCase {
  func test_init_DeeplinkComponent_fromURL() {
    let expectedPathElement = DeeplinkComponent(
      name: "test",
      queryItems: [
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
        queryItems: [
          "id": .value("0"),
          "flag": .flag
        ]
      ),
      DeeplinkComponent(
        name: "second",
        queryItems: [
          "id": .value("1"),
          "flag": .flag
        ]
      )
    ]

    XCTAssertEqual([DeeplinkComponent](url: url), expectedPathElements)
  }
}
