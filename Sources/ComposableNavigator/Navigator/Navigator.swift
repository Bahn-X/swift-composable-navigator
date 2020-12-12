import Foundation

public protocol NavigatorDatasource: ObservableObject {
    var path: [IdentifiedScreen] { get }
}

public struct Navigator {
    private let _go: (AnyScreen, ScreenID) -> Void
    private let _goBack: (AnyScreen) -> Void
    private let _replace: ([AnyScreen]) -> Void
    private let _dismiss: (ScreenID) -> Void
    private let _dismissSuccessor: (ScreenID) -> Void
    private let _didAppear: (ScreenID) -> Void

    public func go<S: Screen>(to screen: S, on id: ScreenID) {
      _go(screen.eraseToAnyScreen(), id)
    }

    public func goBack<S: Screen>(to route: S) {
      _goBack(route.eraseToAnyScreen())
    }

    public func replace(path: AnyScreen...) {
        _replace(path)
    }

    public func dismiss(id: ScreenID) {
        _dismiss(id)
    }

    public func dismissSuccessor(id: ScreenID) {
        _dismissSuccessor(id)
    }

    func didAppear(id: ScreenID) {
        _didAppear(id)
    }
}

import ComposableArchitecture
public extension Navigator {
    init(store: Store<NavigatorState, NavigatorAction>) {
        let viewStore = ViewStore(store)

        self._go = { screen, id in
            viewStore.send(.go(to: screen, on: id))
        }

        self._goBack = { screen in
            viewStore.send(.goBack(to: screen))
        }

        self._replace = { path in
            viewStore.send(.replace(path: path))
        }

        self._dismiss = { id in
            viewStore.send(.dismiss(id))
        }

        self._dismissSuccessor = { id in
            viewStore.send(.dismissSuccessor(of: id))
        }

        self._didAppear = { id in 
            viewStore.send(.didAppear(id))
        }
    }

    static let stub = Navigator(
        _go: { _, _ in fatalError("go(to:) unimplemented in stub") },
        _goBack: { _ in fatalError("goBack(to:) unimplemented in stub") },
        _replace: { _ in fatalError("replace(path:) unimplemented in stub") },
        _dismiss: { _ in fatalError("dismiss(id:) unimplemented in stub") },
        _dismissSuccessor: { _ in fatalError("dismissSuccessor(of:) unimplemented in stub") },
        _didAppear: { _ in fatalError("didAppear(id:) unimplemented in stub") }
    )
}
