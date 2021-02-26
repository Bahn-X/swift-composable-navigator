@testable import ComposableNavigator
import XCTest

final class Navigator_DebugTests: XCTestCase {
  func test_path_returns_underlying_path() {
    let underlyingNavigator = Navigator.mock(
      path: { PathUpdate(previous: [], current: []) }
    )

    let sut = underlyingNavigator.debug()

    XCTAssertEqual(sut.path(), underlyingNavigator.path())
  }

  // MARK: - goTo
  func test_goTo_screen_on_id() {
    let expectedScreen = TestScreen(identifier: "0", presentationStyle: .push).eraseToAnyScreen()
    let expectedID = ScreenID()

    let expectedInvocations = [
      Navigator.GoToInvocation(screen: expectedScreen, on: .id(expectedID))
    ]
    var invocations = [Navigator.GoToInvocation]()

    let underlyingNavigator = Navigator.mock(
      path: { PathUpdate(previous: [], current: []) },
      goToInvoked: { invocation in invocations.append(invocation) }
    )

    var loggedMessages = [String]()
    var dumpedPaths = [PathUpdate]()

    let expectedLoggedMessages = [
      "Sent go(to: \(expectedScreen), on: \(expectedID)).\nNew path:"
    ]
    let expectedPaths = [underlyingNavigator.path()]

    underlyingNavigator
      .debug(
        log: { message in loggedMessages.append(message) },
        dumpPath: { path in dumpedPaths.append(path) }
      )
      .go(to: expectedScreen, on: expectedID)

    XCTAssertEqual(expectedInvocations, invocations)
    XCTAssertEqual(expectedLoggedMessages, loggedMessages)
    XCTAssertEqual(expectedPaths, dumpedPaths)
  }

  func test_goTo_screen_on_screen() {
    let expectedScreen = TestScreen(identifier: "0", presentationStyle: .push).eraseToAnyScreen()

    let expectedInvocations = [
      Navigator.GoToInvocation(screen: expectedScreen, on: .screen(expectedScreen))
    ]
    var invocations = [Navigator.GoToInvocation]()

    let underlyingNavigator = Navigator.mock(
      path: { PathUpdate(previous: [], current: []) },
      goToInvoked: { invocation in invocations.append(invocation) }
    )

    var loggedMessages = [String]()
    var dumpedPaths = [PathUpdate]()

    let expectedLoggedMessages = [
      "Sent go(to: \(expectedScreen), on: \(expectedScreen)).\nNew path:"
    ]
    let expectedPaths = [underlyingNavigator.path()]

    underlyingNavigator
      .debug(
        log: { message in loggedMessages.append(message) },
        dumpPath: { path in dumpedPaths.append(path) }
      )
      .go(to: expectedScreen, on: expectedScreen)

    XCTAssertEqual(expectedInvocations, invocations)
    XCTAssertEqual(expectedLoggedMessages, loggedMessages)
    XCTAssertEqual(expectedPaths, dumpedPaths)
  }

  // MARK: - goTo path
  func test_goToPath_on_id() {
    let expectedScreen = TestScreen(identifier: "0", presentationStyle: .push).eraseToAnyScreen()
    let expectedID = ScreenID()

    let expectedInvocations = [
      Navigator.GoToPathInvocation(path: [expectedScreen], on: .id(expectedID))
    ]
    var invocations = [Navigator.GoToPathInvocation]()

    let underlyingNavigator = Navigator.mock(
      path: { PathUpdate(previous: [], current: []) },
      goToPathInvoked: { invocation in invocations.append(invocation) }
    )

    var loggedMessages = [String]()
    var dumpedPaths = [PathUpdate]()

    let expectedLoggedMessages = [
      "Sent go(to path: \([expectedScreen]), on: \(expectedID)).\nNew path:"
    ]
    let expectedPaths = [underlyingNavigator.path()]

    underlyingNavigator
      .debug(
        log: { message in loggedMessages.append(message) },
        dumpPath: { path in dumpedPaths.append(path) }
      )
      .go(to: [expectedScreen], on: expectedID)

    XCTAssertEqual(expectedInvocations, invocations)
    XCTAssertEqual(expectedLoggedMessages, loggedMessages)
    XCTAssertEqual(expectedPaths, dumpedPaths)
  }

  func test_goToPath_on_screen() {
    let expectedScreen = TestScreen(identifier: "0", presentationStyle: .push).eraseToAnyScreen()

    let expectedInvocations = [
      Navigator.GoToPathInvocation(path: [expectedScreen], on: .screen(expectedScreen))
    ]
    var invocations = [Navigator.GoToPathInvocation]()

    let underlyingNavigator = Navigator.mock(
      path: { PathUpdate(previous: [], current: []) },
      goToPathInvoked: { invocation in invocations.append(invocation) }
    )

    var loggedMessages = [String]()
    var dumpedPaths = [PathUpdate]()

    let expectedLoggedMessages = [
      "Sent go(to path: \([expectedScreen]), on: \(expectedScreen)).\nNew path:"
    ]
    let expectedPaths = [underlyingNavigator.path()]

    underlyingNavigator
      .debug(
        log: { message in loggedMessages.append(message) },
        dumpPath: { path in dumpedPaths.append(path) }
      )
      .go(to: [expectedScreen], on: expectedScreen)

    XCTAssertEqual(expectedInvocations, invocations)
    XCTAssertEqual(expectedLoggedMessages, loggedMessages)
    XCTAssertEqual(expectedPaths, dumpedPaths)
  }

  // MARK: - goBack
  func test_goBack_to_id() {
    let expectedID = ScreenID()

    let expectedInvocations = [
      Navigator.GoBackToInvocation(to: .id(expectedID))
    ]
    var invocations = [Navigator.GoBackToInvocation]()

    let underlyingNavigator = Navigator.mock(
      path: { PathUpdate(previous: [], current: []) },
      goBackToInvoked: { invocation in invocations.append(invocation) }
    )

    var loggedMessages = [String]()
    var dumpedPaths = [PathUpdate]()

    let expectedLoggedMessages = [
      "Sent goBack(to: \(expectedID)).\nNew path:"
    ]
    let expectedPaths = [underlyingNavigator.path()]

    underlyingNavigator
      .debug(
        log: { message in loggedMessages.append(message) },
        dumpPath: { path in dumpedPaths.append(path) }
      )
      .goBack(to: expectedID)

    XCTAssertEqual(expectedInvocations, invocations)
    XCTAssertEqual(expectedLoggedMessages, loggedMessages)
    XCTAssertEqual(expectedPaths, dumpedPaths)
  }

  func test_goBack_to_screen() {
    let expectedScreen = TestScreen(identifier: "0", presentationStyle: .push).eraseToAnyScreen()

    let expectedInvocations = [
      Navigator.GoBackToInvocation(to: .screen(expectedScreen))
    ]
    var invocations = [Navigator.GoBackToInvocation]()

    let underlyingNavigator = Navigator.mock(
      path: { PathUpdate(previous: [], current: []) },
      goBackToInvoked: { invocation in invocations.append(invocation) }
    )

    var loggedMessages = [String]()
    var dumpedPaths = [PathUpdate]()

    let expectedLoggedMessages = [
      "Sent goBack(to: \(expectedScreen)).\nNew path:"
    ]
    let expectedPaths = [underlyingNavigator.path()]

    underlyingNavigator
      .debug(
        log: { message in loggedMessages.append(message) },
        dumpPath: { path in dumpedPaths.append(path) }
      )
      .goBack(to: expectedScreen)

    XCTAssertEqual(expectedInvocations, invocations)
    XCTAssertEqual(expectedLoggedMessages, loggedMessages)
    XCTAssertEqual(expectedPaths, dumpedPaths)
  }

  // MARK: - Replace path
  func test_replacePath() {
    let expectedScreen = TestScreen(identifier: "0", presentationStyle: .push).eraseToAnyScreen()

    let expectedInvocations = [
      Navigator.ReplacePathInvocation(path: [expectedScreen])
    ]
    var invocations = [Navigator.ReplacePathInvocation]()

    let underlyingNavigator = Navigator.mock(
      path: { PathUpdate(previous: [], current: []) },
      replacePathInvoked: { invocation in invocations.append(invocation) }
    )

    var loggedMessages = [String]()
    var dumpedPaths = [PathUpdate]()

    let expectedLoggedMessages = [
      "Sent replace(path: \([expectedScreen])).\nNew path:"
    ]
    let expectedPaths = [underlyingNavigator.path()]

    underlyingNavigator
      .debug(
        log: { message in loggedMessages.append(message) },
        dumpPath: { path in dumpedPaths.append(path) }
      )
      .replace(path: [expectedScreen])

    XCTAssertEqual(expectedInvocations, invocations)
    XCTAssertEqual(expectedLoggedMessages, loggedMessages)
    XCTAssertEqual(expectedPaths, dumpedPaths)
  }

  // MARK: - Dismiss
  func test_dismiss_id() {
    let expectedID = ScreenID()

    let expectedInvocations = [
      Navigator.DismissInvocation(identifier: .id(expectedID))
    ]
    var invocations = [Navigator.DismissInvocation]()

    let underlyingNavigator = Navigator.mock(
      path: { PathUpdate(previous: [], current: []) },
      dismissInvoked: { invocation in invocations.append(invocation) }
    )

    var loggedMessages = [String]()
    var dumpedPaths = [PathUpdate]()

    let expectedLoggedMessages = [
      "Sent dismiss(id: \(expectedID)).\nNew path:"
    ]
    let expectedPaths = [underlyingNavigator.path()]

    underlyingNavigator
      .debug(
        log: { message in loggedMessages.append(message) },
        dumpPath: { path in dumpedPaths.append(path) }
      )
      .dismiss(id: expectedID)

    XCTAssertEqual(expectedInvocations, invocations)
    XCTAssertEqual(expectedLoggedMessages, loggedMessages)
    XCTAssertEqual(expectedPaths, dumpedPaths)
  }

  func test_dismiss_screen() {
    let expectedScreen = TestScreen(identifier: "0", presentationStyle: .push).eraseToAnyScreen()

    let expectedInvocations = [
      Navigator.DismissInvocation(identifier: .screen(expectedScreen))
    ]
    var invocations = [Navigator.DismissInvocation]()

    let underlyingNavigator = Navigator.mock(
      path: { PathUpdate(previous: [], current: []) },
      dismissInvoked: { invocation in invocations.append(invocation) }
    )

    var loggedMessages = [String]()
    var dumpedPaths = [PathUpdate]()

    let expectedLoggedMessages = [
      "Sent dismiss(screen: \(expectedScreen)).\nNew path:"
    ]
    let expectedPaths = [underlyingNavigator.path()]

    underlyingNavigator
      .debug(
        log: { message in loggedMessages.append(message) },
        dumpPath: { path in dumpedPaths.append(path) }
      )
      .dismiss(screen: expectedScreen)

    XCTAssertEqual(expectedInvocations, invocations)
    XCTAssertEqual(expectedLoggedMessages, loggedMessages)
    XCTAssertEqual(expectedPaths, dumpedPaths)
  }

  // MARK: dismissSuccessor
  func test_dismiss_successor_of_id() {
    let expectedID = ScreenID()

    let expectedInvocations = [
      Navigator.DismissSuccessorInvocation(identifier: .id(expectedID))
    ]
    var invocations = [Navigator.DismissSuccessorInvocation]()

    let underlyingNavigator = Navigator.mock(
      path: { PathUpdate(previous: [], current: []) },
      dismissSuccessorInvoked: { invocation in invocations.append(invocation) }
    )

    var loggedMessages = [String]()
    var dumpedPaths = [PathUpdate]()

    let expectedLoggedMessages = [
      "Sent dismissSuccessor(of: \(expectedID)).\nNew path:"
    ]
    let expectedPaths = [underlyingNavigator.path()]

    underlyingNavigator
      .debug(
        log: { message in loggedMessages.append(message) },
        dumpPath: { path in dumpedPaths.append(path) }
      )
      .dismissSuccessor(of: expectedID)

    XCTAssertEqual(expectedInvocations, invocations)
    XCTAssertEqual(expectedLoggedMessages, loggedMessages)
    XCTAssertEqual(expectedPaths, dumpedPaths)
  }

  func test_dismiss_succesor_of_screen() {
    let expectedScreen = TestScreen(identifier: "0", presentationStyle: .push).eraseToAnyScreen()

    let expectedInvocations = [
      Navigator.DismissSuccessorInvocation(identifier: .screen(expectedScreen))
    ]
    var invocations = [Navigator.DismissSuccessorInvocation]()

    let underlyingNavigator = Navigator.mock(
      path: { PathUpdate(previous: [], current: []) },
      dismissSuccessorInvoked: { invocation in invocations.append(invocation) }
    )

    var loggedMessages = [String]()
    var dumpedPaths = [PathUpdate]()

    let expectedLoggedMessages = [
      "Sent dismissSuccessor(of: \(expectedScreen)).\nNew path:"
    ]
    let expectedPaths = [underlyingNavigator.path()]

    underlyingNavigator
      .debug(
        log: { message in loggedMessages.append(message) },
        dumpPath: { path in dumpedPaths.append(path) }
      )
      .dismissSuccessor(of: expectedScreen)

    XCTAssertEqual(expectedInvocations, invocations)
    XCTAssertEqual(expectedLoggedMessages, loggedMessages)
    XCTAssertEqual(expectedPaths, dumpedPaths)
  }

  // MARK: - replace
  func test_replace_content_of_id() {
    let expectedID = ScreenID()
    let expectedScreen = TestScreen(identifier: "0", presentationStyle: .push).eraseToAnyScreen()

    let expectedInvocations = [
      Navigator.ReplaceContentInvocation(id: expectedID, newContent: expectedScreen)
    ]
    var invocations = [Navigator.ReplaceContentInvocation]()

    let underlyingNavigator = Navigator.mock(
      path: { PathUpdate(previous: [], current: []) },
      replaceContentInvoked: { invocation in invocations.append(invocation) }
    )

    var loggedMessages = [String]()
    var dumpedPaths = [PathUpdate]()

    let expectedLoggedMessages = [
      "Sent replaceContent(of: \(expectedID), with: \(expectedScreen)).\nNew path:"
    ]
    let expectedPaths = [underlyingNavigator.path()]

    underlyingNavigator
      .debug(
        log: { message in loggedMessages.append(message) },
        dumpPath: { path in dumpedPaths.append(path) }
      )
      .replaceContent(of: expectedID, with: expectedScreen)

    XCTAssertEqual(expectedInvocations, invocations)
    XCTAssertEqual(expectedLoggedMessages, loggedMessages)
    XCTAssertEqual(expectedPaths, dumpedPaths)
  }

  func test_replace_screen() {
    let expectedScreen = TestScreen(identifier: "0", presentationStyle: .push).eraseToAnyScreen()

    let expectedInvocations = [
      Navigator.ReplaceScreenInvocation(oldContent: expectedScreen, newContent: expectedScreen)
    ]
    var invocations = [Navigator.ReplaceScreenInvocation]()

    let underlyingNavigator = Navigator.mock(
      path: { PathUpdate(previous: [], current: []) },
      replaceScreenInvoked: { invocation in invocations.append(invocation) }
    )

    var loggedMessages = [String]()
    var dumpedPaths = [PathUpdate]()

    let expectedLoggedMessages = [
      "Sent replace(screen: \(expectedScreen), with: \(expectedScreen)).\nNew path:"
    ]
    let expectedPaths = [underlyingNavigator.path()]

    underlyingNavigator
      .debug(
        log: { message in loggedMessages.append(message) },
        dumpPath: { path in dumpedPaths.append(path) }
      )
      .replace(screen: expectedScreen, with: expectedScreen)

    XCTAssertEqual(expectedInvocations, invocations)
    XCTAssertEqual(expectedLoggedMessages, loggedMessages)
    XCTAssertEqual(expectedPaths, dumpedPaths)
  }

  // MARK: - didAppear
  func test_didAppear() {
    let expectedID = ScreenID()

    let expectedInvocations = [
      Navigator.DidAppearInvocation(id: expectedID)
    ]
    var invocations = [Navigator.DidAppearInvocation]()

    let underlyingNavigator = Navigator.mock(
      path: { PathUpdate(previous: [], current: []) },
      didAppearInvoked: { invocation in invocations.append(invocation) }
    )

    var loggedMessages = [String]()
    var dumpedPaths = [PathUpdate]()

    let expectedLoggedMessages = [
      "Sent didAppear(id: \(expectedID)).\nNew path:"
    ]
    let expectedPaths = [underlyingNavigator.path()]

    underlyingNavigator
      .debug(
        log: { message in loggedMessages.append(message) },
        dumpPath: { path in dumpedPaths.append(path) }
      )
      .didAppear(id: expectedID)

    XCTAssertEqual(expectedInvocations, invocations)
    XCTAssertEqual(expectedLoggedMessages, loggedMessages)
    XCTAssertEqual(expectedPaths, dumpedPaths)
  }
}
