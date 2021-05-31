@testable import ComposableNavigator
import XCTest

final class NavigationPathElement_Tests: XCTestCase {
  let screenID = ScreenID()
  let content = TestScreen(
    identifier: "",
    presentationStyle: .push
  )

  // MARK: - Screen path element
  func test_screen_id_equals_wrapped_screen_id() {
    let sut = ActiveNavigationTreeElement.screen(
      IdentifiedScreen(
        id: screenID,
        content: content,
        hasAppeared: false
      )
    )

    XCTAssertEqual(screenID, sut.id)
  }

  func test_screen_ids_contains_only_screen_id() {
    let expectedIDs = Set<ScreenID>([screenID])

    let sut = ActiveNavigationTreeElement.screen(
      IdentifiedScreen(
        id: screenID,
        content: content,
        hasAppeared: false
      )
    )

    XCTAssertEqual(expectedIDs, sut.ids())
  }

  func test_screen_content_equals_wrapped_content() {
    let expectedContent = content.eraseToAnyScreen()

    let sut = ActiveNavigationTreeElement.screen(
      IdentifiedScreen(
        id: screenID,
        content: content,
        hasAppeared: false
      )
    )

    XCTAssertEqual(expectedContent, sut.content)
  }

  func test_screen_hasAppeared_equals_wrapped_screen() {
    var sut = ActiveNavigationTreeElement.screen(
      IdentifiedScreen(
        id: screenID,
        content: content,
        hasAppeared: false
      )
    )

    XCTAssertFalse(sut.hasAppeared)

    sut = ActiveNavigationTreeElement.screen(
      IdentifiedScreen(
        id: screenID,
        content: content,
        hasAppeared: true
      )
    )

    XCTAssertTrue(sut.hasAppeared)
  }
}
