import ComposableArchitecture

public extension Store where State == RouterState, Action == RouterAction {
    convenience init<Root: Screen>(root: Root) {
        self.init(
            initialState: RouterState(root: root),
            reducer: routerReducer,
            environment: RouterEnvironment(screenID: ScreenID.init)
        )
    }
}
