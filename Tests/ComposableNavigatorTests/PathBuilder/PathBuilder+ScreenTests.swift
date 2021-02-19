@testable import ComposableNavigator
import SwiftUI
import XCTest

final class PathBuilder_ScreenTests: XCTestCase {
    let testScreen = TestScreen(identifier: "", presentationStyle: .push)

    // MARK: - (Screen) -> View
    func test_closure_based_non_matching_screen_does_not_build_path() {
        struct NonMatching: Screen {
            let presentationStyle: ScreenPresentationStyle = .push
        }

        var nestingPathBuilderInvocations = [[IdentifiedScreen]]()

        let path = [
            IdentifiedScreen(id: .root, content: NonMatching(), hasAppeared: false)
        ]

        let expectedNestingPathBuilderInvocations = [
            [IdentifiedScreen]()
        ]

        let sut = PathBuilders.screen(
            content: { (screen: TestScreen) in EmptyView() },
            nesting: _PathBuilder(
                buildPath: { path -> EmptyView? in
                    nestingPathBuilderInvocations.append(path)
                    return EmptyView()
                }
            )
        )

        XCTAssertNil(sut.build(path: path))
        XCTAssertEqual(expectedNestingPathBuilderInvocations, nestingPathBuilderInvocations)
    }

    func test_closure_based_matching_screen_buildsPath() {
        let path = [
            IdentifiedScreen(
                id: .root,
                content: TestScreen(identifier: "0", presentationStyle: .push),
                hasAppeared: false
            )
        ]

        let sut = PathBuilders.screen(
            content: { (screen: TestScreen) in EmptyView() }
        )

        XCTAssertNotNil(sut.build(path: path))
    }

    func test_closure_based_onAppear_in_built_view_calls_passed_action() {
        let path = [
            IdentifiedScreen(
                id: .root,
                content: TestScreen(identifier: "0", presentationStyle: .push),
                hasAppeared: false
            )
        ]

        var onAppearInvocations = [Bool]()
        let expectedOnAppearInvocations = [
            true,
            false
        ]

        let sut = PathBuilders.screen(
            onAppear: { initialAppear in
                onAppearInvocations.append(initialAppear)
            },
            content: { (screen: TestScreen) in EmptyView() }
        )

        let builtView = sut.build(path: path)
        builtView?.onAppear(true)
        builtView?.onAppear(false)

        XCTAssertEqual(expectedOnAppearInvocations, onAppearInvocations)
    }

    func test_closure_based_next_in_built_view_calls_nesting_path_builder() {
        let path = [
            IdentifiedScreen(
                id: .root,
                content: TestScreen(identifier: "0", presentationStyle: .push),
                hasAppeared: false
            )
        ]

        var nextInvocations = [[IdentifiedScreen]]()
        let expectedNextInvocations = [
            path
        ]

        let sut = PathBuilders.screen(
            content: { (screen: TestScreen) in EmptyView() },
            nesting: _PathBuilder(
                buildPath: { path -> EmptyView? in
                    nextInvocations.append(path)
                    return nil
                }
            )
        )

        let builtView = sut.build(path: path)
        _ = builtView?.next(path)

        XCTAssertEqual(expectedNextInvocations, nextInvocations)
    }

    // MARK: - Screen.Type, () -> View
    func test_type_based_non_matching_screen_does_not_build_path() {
        struct NonMatching: Screen {
            let presentationStyle: ScreenPresentationStyle = .push
        }

        var nestingPathBuilderInvocations = [[IdentifiedScreen]]()

        let path = [
            IdentifiedScreen(id: .root, content: NonMatching(), hasAppeared: false)
        ]

        let expectedNestingPathBuilderInvocations = [
            [IdentifiedScreen]()
        ]

        let sut = PathBuilders.screen(
            TestScreen.self,
            content: { EmptyView() },
            nesting: _PathBuilder(
                buildPath: { path -> EmptyView? in
                    nestingPathBuilderInvocations.append(path)
                    return EmptyView()
                }
            )
        )

        XCTAssertNil(sut.build(path: path))
        XCTAssertEqual(expectedNestingPathBuilderInvocations, nestingPathBuilderInvocations)
    }

    func test_type_based_matching_screen_buildsPath() {
        let path = [
            IdentifiedScreen(
                id: .root,
                content: TestScreen(identifier: "0", presentationStyle: .push),
                hasAppeared: false
            )
        ]

        let sut = PathBuilders.screen(
            TestScreen.self,
            content: { EmptyView() }
        )

        let builtView = sut.build(path: path)

        XCTAssertNotNil(builtView)
    }

    func test_type_based_onAppear_in_built_view_calls_passed_action() {
        let path = [
            IdentifiedScreen(
                id: .root,
                content: TestScreen(identifier: "0", presentationStyle: .push),
                hasAppeared: false
            )
        ]

        var onAppearInvocations = [Bool]()
        let expectedOnAppearInvocations = [
            true,
            false
        ]

        let sut = PathBuilders.screen(
            TestScreen.self,
            onAppear: { initialAppear in
                onAppearInvocations.append(initialAppear)
            },
            content: { EmptyView() }
        )

        let builtView = sut.build(path: path)
        builtView?.onAppear(true)
        builtView?.onAppear(false)

        XCTAssertEqual(expectedOnAppearInvocations, onAppearInvocations)
    }

    func test_type_based_next_in_built_view_calls_nesting_path_builder() {
        let path = [
            IdentifiedScreen(
                id: .root,
                content: TestScreen(identifier: "0", presentationStyle: .push),
                hasAppeared: false
            )
        ]

        var nextInvocations = [[IdentifiedScreen]]()
        let expectedNextInvocations = [
            path
        ]

        let sut = PathBuilders.screen(
            TestScreen.self,
            content: { EmptyView() },
            nesting: _PathBuilder(
                buildPath: { path -> EmptyView? in
                    nextInvocations.append(path)
                    return nil
                }
            )
        )

        let builtView = sut.build(path: path)
        _ = builtView?.next(path)

        XCTAssertEqual(expectedNextInvocations, nextInvocations)
    }
}