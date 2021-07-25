import ComposableDeeplinking
@testable import ComposableNavigator
import XCTest

final class DeeplinkHandlerTests: XCTestCase {
  func test_handle_deeplink_replaces_path_if_deeplink_resolves() {
    let resolvedPath: ActiveNavigationPath = [
      .screen(TestScreen(identifier: "first", presentationStyle: .push).eraseToAnyScreen())
    ]

    var replacePathInvocations = [Navigator.ReplacePathInvocation]()
    let expectedInvocations = [
      Navigator.ReplacePathInvocation(path: resolvedPath)
    ]

    let sut = DeeplinkHandler(
      navigator: Navigator.mock(
        replacePathInvoked: { invocation in
          replacePathInvocations.append(invocation)
        }
      ),
      parser: DeeplinkParser(parse: { _ in resolvedPath })
    )

    sut.handle(deeplink: Deeplink.Stub.deeplink)

    XCTAssertEqual(expectedInvocations, replacePathInvocations)
  }

  func test_handle_deeplink_does_not_replace_path_if_deeplink_does_not_resolves() {
    var replacePathInvocations = [Navigator.ReplacePathInvocation]()
    let expectedInvocations = [Navigator.ReplacePathInvocation]()

    let sut = DeeplinkHandler(
      navigator: Navigator.mock(
        replacePathInvoked: { invocation in
          replacePathInvocations.append(invocation)
        }
      ),
      parser: DeeplinkParser(parse: { _ in nil })
    )

    sut.handle(deeplink: Deeplink.Stub.deeplink)

    XCTAssertEqual(expectedInvocations, replacePathInvocations)
  }
}
