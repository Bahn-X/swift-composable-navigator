import ComposableArchitecture
import ComposableNavigator

public extension Navigator {
    init(store: Store<NavigatorState, NavigatorAction>) {
        let viewStore = ViewStore(store)

        self.init(
            go: { screen, id in
                viewStore.send(.go(to: screen, on: id))
            },
            goBack: { screen in
                viewStore.send(.goBack(to: screen))
            },
            replace: { path in
                viewStore.send(.replace(path: path))
            },
            dismiss: { id in
                viewStore.send(.dismiss(id))
            },
            dismissSuccessor: { id in
                viewStore.send(.dismissSuccessor(of: id))
            },
            didAppear: { id in
                viewStore.send(.didAppear(id))
            }
        )
    }
}
