import ComposableArchitecture

public extension Store where State == NavigatorState, Action == NavigatorAction {
    convenience init<Root: Screen>(root: Root) {
        self.init(
            initialState: NavigatorState(root: root),
            reducer: navigatorReducer,
            environment: NavigatorEnvironment(screenID: ScreenID.init)
        )
    }
}
