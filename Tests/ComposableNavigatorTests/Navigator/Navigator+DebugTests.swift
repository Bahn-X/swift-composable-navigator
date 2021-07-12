@testable import ComposableNavigator
import XCTest

final class Navigator_DebugTests: XCTestCase {
  let previous = [ActiveNavigationTreeElement]()
  let current = [ActiveNavigationTreeElement]()

  func test_path_returns_underlying_path() {
    let underlyingNavigator = Navigator.mock(
      path: { NavigationTreeUpdate(previous: self.previous, current: self.current) }
    )

    let sut = underlyingNavigator.debug()

    XCTAssertEqual(sut.navigationTree(), underlyingNavigator.navigationTree())
  }

  // MARK: - goTo
  func test_goTo_screen_on_id() {
    let expectedScreen = TestScreen(identifier: "0", presentationStyle: .push).eraseToAnyScreen()
    let expectedID = ScreenID()
    let forceNavigation = true

    let expectedInvocations = [
      Navigator.GoToInvocation(
        screen: expectedScreen,
        on: .id(expectedID),
        forceNavigation: forceNavigation
      )
    ]
    var invocations = [Navigator.GoToInvocation]()

    let underlyingNavigator = Navigator.mock(
      path: { NavigationTreeUpdate(previous: self.previous, current: self.current) },
      goToInvoked: { invocation in invocations.append(invocation) }
    )

    var loggedMessages = [String]()
    var dumpedPaths = [NavigationTreeUpdate]()

    let expectedLoggedMessages = [
      "Sent go(to: \(expectedScreen), on: \(expectedID), forceNavigation: \(forceNavigation)).\nNew path:"
    ]
    let expectedPaths = [underlyingNavigator.navigationTree()]

    underlyingNavigator
      .debug(
        log: { message in loggedMessages.append(message) },
        dumpNavigationTree: { path in dumpedPaths.append(path) }
      )
      .go(to: expectedScreen, on: expectedID, forceNavigation: forceNavigation)

    XCTAssertEqual(expectedInvocations, invocations)
    XCTAssertEqual(expectedLoggedMessages, loggedMessages)
    XCTAssertEqual(expectedPaths, dumpedPaths)
  }

  func test_goTo_screen_on_screen() {
    let forceNavigation = true
    let expectedScreen = TestScreen(identifier: "0", presentationStyle: .push).eraseToAnyScreen()

    let expectedInvocations = [
      Navigator.GoToInvocation(
        screen: expectedScreen,
        on: .screen(expectedScreen),
        forceNavigation: forceNavigation
      )
    ]
    var invocations = [Navigator.GoToInvocation]()

    let underlyingNavigator = Navigator.mock(
      path: { NavigationTreeUpdate(previous: self.previous, current: self.current) },
      goToInvoked: { invocation in invocations.append(invocation) }
    )

    var loggedMessages = [String]()
    var dumpedPaths = [NavigationTreeUpdate]()

    let expectedLoggedMessages = [
      "Sent go(to: \(expectedScreen), on: \(expectedScreen), forceNavigation: \(forceNavigation)).\nNew path:"
    ]
    let expectedPaths = [underlyingNavigator.navigationTree()]

    underlyingNavigator
      .debug(
        log: { message in loggedMessages.append(message) },
        dumpNavigationTree: { path in dumpedPaths.append(path) }
      )
      .go(to: expectedScreen, on: expectedScreen, forceNavigation: forceNavigation)

    XCTAssertEqual(expectedInvocations, invocations)
    XCTAssertEqual(expectedLoggedMessages, loggedMessages)
    XCTAssertEqual(expectedPaths, dumpedPaths)
  }

  // MARK: - goTo path
  func test_goToPath_on_id() {
    let expectedScreen = TestScreen(identifier: "0", presentationStyle: .push).eraseToAnyScreen()
    let expectedID = ScreenID()

    let expectedInvocations = [
      Navigator.GoToPathInvocation(
        path: [expectedScreen].map(ActiveNavigationPathElement.screen),
        on: .id(expectedID)
      )
    ]
    var invocations = [Navigator.GoToPathInvocation]()

    let underlyingNavigator = Navigator.mock(
      path: { NavigationTreeUpdate(previous: self.previous, current: self.current) },
      goToPathInvoked: { invocation in invocations.append(invocation) }
    )

    var loggedMessages = [String]()
    var dumpedPaths = [NavigationTreeUpdate]()

    let expectedLoggedMessages = [
      "Sent go(to path: \([expectedScreen].map(ActiveNavigationPathElement.screen)), on: \(expectedID)).\nNew path:"
    ]
    let expectedPaths = [underlyingNavigator.navigationTree()]

    underlyingNavigator
      .debug(
        log: { message in loggedMessages.append(message) },
        dumpNavigationTree: { path in dumpedPaths.append(path) }
      )
      .go(
        to: [expectedScreen].map(ActiveNavigationPathElement.screen),
        on: expectedID
      )


    XCTAssertEqual(expectedInvocations, invocations)
    XCTAssertEqual(expectedLoggedMessages, loggedMessages)
    XCTAssertEqual(expectedPaths, dumpedPaths)
  }

  func test_goToPath_on_screen() {
    let expectedScreen = TestScreen(identifier: "0", presentationStyle: .push).eraseToAnyScreen()

    let expectedInvocations = [
      Navigator.GoToPathInvocation(
        path: [expectedScreen].map(ActiveNavigationPathElement.screen),
        on: .screen(expectedScreen)
      )
    ]
    var invocations = [Navigator.GoToPathInvocation]()

    let underlyingNavigator = Navigator.mock(
      path: { NavigationTreeUpdate(previous: self.previous, current: self.current) },
      goToPathInvoked: { invocation in invocations.append(invocation) }
    )

    var loggedMessages = [String]()
    var dumpedPaths = [NavigationTreeUpdate]()

    let expectedLoggedMessages = [
      "Sent go(to path: \([expectedScreen].map(ActiveNavigationPathElement.screen)), on: \(expectedScreen)).\nNew path:"
    ]
    let expectedPaths = [underlyingNavigator.navigationTree()]

    underlyingNavigator
      .debug(
        log: { message in loggedMessages.append(message) },
        dumpNavigationTree: { path in dumpedPaths.append(path) }
      )
      .go(
        to: [expectedScreen].map(ActiveNavigationPathElement.screen),
        on: expectedScreen
      )

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
      path: { NavigationTreeUpdate(previous: self.previous, current: self.current) },
      goBackToInvoked: { invocation in invocations.append(invocation) }
    )

    var loggedMessages = [String]()
    var dumpedPaths = [NavigationTreeUpdate]()

    let expectedLoggedMessages = [
      "Sent goBack(to: \(expectedID)).\nNew path:"
    ]
    let expectedPaths = [underlyingNavigator.navigationTree()]

    underlyingNavigator
      .debug(
        log: { message in loggedMessages.append(message) },
        dumpNavigationTree: { path in dumpedPaths.append(path) }
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
      path: { NavigationTreeUpdate(previous: self.previous, current: self.current) },
      goBackToInvoked: { invocation in invocations.append(invocation) }
    )

    var loggedMessages = [String]()
    var dumpedPaths = [NavigationTreeUpdate]()

    let expectedLoggedMessages = [
      "Sent goBack(to: \(expectedScreen)).\nNew path:"
    ]
    let expectedPaths = [underlyingNavigator.navigationTree()]

    underlyingNavigator
      .debug(
        log: { message in loggedMessages.append(message) },
        dumpNavigationTree: { path in dumpedPaths.append(path) }
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
      Navigator.ReplacePathInvocation(
        path: [expectedScreen].map(ActiveNavigationPathElement.screen)
      )
    ]
    var invocations = [Navigator.ReplacePathInvocation]()

    let underlyingNavigator = Navigator.mock(
      path: { NavigationTreeUpdate(previous: self.previous, current: self.current) },
      replacePathInvoked: { invocation in invocations.append(invocation) }
    )

    var loggedMessages = [String]()
    var dumpedPaths = [NavigationTreeUpdate]()

    let expectedLoggedMessages = [
      "Sent replace(path: \([expectedScreen].map(ActiveNavigationPathElement.screen))).\nNew path:"
    ]
    let expectedPaths = [underlyingNavigator.navigationTree()]

    underlyingNavigator
      .debug(
        log: { message in loggedMessages.append(message) },
        dumpNavigationTree: { path in dumpedPaths.append(path) }
      )
      .replace(path: [expectedScreen].map(ActiveNavigationPathElement.screen))

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
      path: { NavigationTreeUpdate(previous: self.previous, current: self.current) },
      dismissInvoked: { invocation in invocations.append(invocation) }
    )

    var loggedMessages = [String]()
    var dumpedPaths = [NavigationTreeUpdate]()

    let expectedLoggedMessages = [
      "Sent dismiss(id: \(expectedID)).\nNew path:"
    ]
    let expectedPaths = [underlyingNavigator.navigationTree()]

    underlyingNavigator
      .debug(
        log: { message in loggedMessages.append(message) },
        dumpNavigationTree: { path in dumpedPaths.append(path) }
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
      path: { NavigationTreeUpdate(previous: self.previous, current: self.current) },
      dismissInvoked: { invocation in invocations.append(invocation) }
    )

    var loggedMessages = [String]()
    var dumpedPaths = [NavigationTreeUpdate]()

    let expectedLoggedMessages = [
      "Sent dismiss(screen: \(expectedScreen)).\nNew path:"
    ]
    let expectedPaths = [underlyingNavigator.navigationTree()]

    underlyingNavigator
      .debug(
        log: { message in loggedMessages.append(message) },
        dumpNavigationTree: { path in dumpedPaths.append(path) }
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
      path: { NavigationTreeUpdate(previous: self.previous, current: self.current) },
      dismissSuccessorInvoked: { invocation in invocations.append(invocation) }
    )

    var loggedMessages = [String]()
    var dumpedPaths = [NavigationTreeUpdate]()

    let expectedLoggedMessages = [
      "Sent dismissSuccessor(of: \(expectedID)).\nNew path:"
    ]
    let expectedPaths = [underlyingNavigator.navigationTree()]

    underlyingNavigator
      .debug(
        log: { message in loggedMessages.append(message) },
        dumpNavigationTree: { path in dumpedPaths.append(path) }
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
      path: { NavigationTreeUpdate(previous: self.previous, current: self.current) },
      dismissSuccessorInvoked: { invocation in invocations.append(invocation) }
    )

    var loggedMessages = [String]()
    var dumpedPaths = [NavigationTreeUpdate]()

    let expectedLoggedMessages = [
      "Sent dismissSuccessor(of: \(expectedScreen)).\nNew path:"
    ]
    let expectedPaths = [underlyingNavigator.navigationTree()]

    underlyingNavigator
      .debug(
        log: { message in loggedMessages.append(message) },
        dumpNavigationTree: { path in dumpedPaths.append(path) }
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
      path: { NavigationTreeUpdate(previous: self.previous, current: self.current) },
      replaceContentInvoked: { invocation in invocations.append(invocation) }
    )

    var loggedMessages = [String]()
    var dumpedPaths = [NavigationTreeUpdate]()

    let expectedLoggedMessages = [
      "Sent replaceContent(of: \(expectedID), with: \(expectedScreen)).\nNew path:"
    ]
    let expectedPaths = [underlyingNavigator.navigationTree()]

    underlyingNavigator
      .debug(
        log: { message in loggedMessages.append(message) },
        dumpNavigationTree: { path in dumpedPaths.append(path) }
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
      path: { NavigationTreeUpdate(previous: self.previous, current: self.current) },
      replaceScreenInvoked: { invocation in invocations.append(invocation) }
    )

    var loggedMessages = [String]()
    var dumpedPaths = [NavigationTreeUpdate]()

    let expectedLoggedMessages = [
      "Sent replace(screen: \(expectedScreen), with: \(expectedScreen)).\nNew path:"
    ]
    let expectedPaths = [underlyingNavigator.navigationTree()]

    underlyingNavigator
      .debug(
        log: { message in loggedMessages.append(message) },
        dumpNavigationTree: { path in dumpedPaths.append(path) }
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
      path: { NavigationTreeUpdate(previous: self.previous, current: self.current) },
      didAppearInvoked: { invocation in invocations.append(invocation) }
    )

    var loggedMessages = [String]()
    var dumpedPaths = [NavigationTreeUpdate]()

    let expectedLoggedMessages = [
      "Sent didAppear(id: \(expectedID)).\nNew path:"
    ]
    let expectedPaths = [underlyingNavigator.navigationTree()]

    underlyingNavigator
      .debug(
        log: { message in loggedMessages.append(message) },
        dumpNavigationTree: { path in dumpedPaths.append(path) }
      )
      .didAppear(id: expectedID)

    XCTAssertEqual(expectedInvocations, invocations)
    XCTAssertEqual(expectedLoggedMessages, loggedMessages)
    XCTAssertEqual(expectedPaths, dumpedPaths)
  }

  // MARK: - activate
  func test_activate() {
    struct Tab: Activatable {}

    let expectedActivatable = Tab().eraseToAnyActivatable()

    let expectedInvocations = [
      Navigator.ActivateInvocation(activatable: expectedActivatable)
    ]
    var invocations = [Navigator.ActivateInvocation]()

    let underlyingNavigator = Navigator.mock(
      path: { NavigationTreeUpdate(previous: self.previous, current: self.current) },
      activateInvoked: { invocation in invocations.append(invocation) }
    )

    var loggedMessages = [String]()
    var dumpedPaths = [NavigationTreeUpdate]()

    let expectedLoggedMessages = [
      "Sent activate(_ activatable: \(expectedActivatable)).\nNew path:"
    ]
    let expectedPaths = [underlyingNavigator.navigationTree()]

    underlyingNavigator
      .debug(
        log: { message in loggedMessages.append(message) },
        dumpNavigationTree: { path in dumpedPaths.append(path) }
      )
      .activate(Tab())

    XCTAssertEqual(expectedInvocations, invocations)
    XCTAssertEqual(expectedLoggedMessages, loggedMessages)
    XCTAssertEqual(expectedPaths, dumpedPaths)
  }
}
