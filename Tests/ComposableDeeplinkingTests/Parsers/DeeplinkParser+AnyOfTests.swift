import ComposableNavigator
@testable import ComposableDeeplinking
import XCTest

final class DeeplinkParser_AnyOfTests: XCTestCase {
  func test_anyOf_deeplink_parser_returns_first_built_path() {
    let firstPath: ActiveNavigationPath = [
      .screen(TestScreen(identifier: "first", presentationStyle: .push).eraseToAnyScreen())
    ]
    
    let secondPath: ActiveNavigationPath = [
      .screen(TestScreen(identifier: "second", presentationStyle: .push).eraseToAnyScreen())
    ]
    
    let sut: DeeplinkParser = .anyOf(
      .init(parse: { _ in firstPath }),
      .init(parse: { _ in secondPath })
    )
    
    XCTAssertEqual(firstPath, sut.parse(Deeplink.Stub.deeplink))
  }
  
  func test_anyOf_deeplink_parser_returns_second_built_path_when_first_does_not_match() {
    let secondPath: ActiveNavigationPath = [
      .screen(TestScreen(identifier: "second", presentationStyle: .push).eraseToAnyScreen())
    ]
    
    let sut: DeeplinkParser = .anyOf(
      .init(parse: { _ in nil }),
      .init(parse: { _ in secondPath })
    )
    
    XCTAssertEqual(secondPath, sut.parse(Deeplink.Stub.deeplink))
  }
  
  func test_anyOf_deeplink_parser_returns_nil_when_none_matches() {
    let sut: DeeplinkParser = .anyOf(
      .init(parse: { _ in nil }),
      .init(parse: { _ in nil })
    )
    
    XCTAssertNil(sut.parse(Deeplink.Stub.deeplink))
  }
}
