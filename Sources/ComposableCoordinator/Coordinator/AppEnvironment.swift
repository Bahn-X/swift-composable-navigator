import Foundation
import ComposableArchitecture
import SwiftUI

struct AppEnvironment {
    let coordinator: Coordinator
}

struct HomeRoute: Route {
    let presentationStyle: ScreenPresentationStyle = .push
}

struct DetailRoute: Route {
    let presentationStyle: ScreenPresentationStyle = .push
    let id: String
}

extension Coordinator {
    static func home(
        coordinator: Store<CoordinatorState, CoordinatorAction>,
        store: Store<Int, Int>
    ) -> Coordinator {
        .matching(
            store: coordinator,
            parse: { url in HomeRoute() },
            content: { (route: HomeRoute) in Text("Home") }
        )
    }

    static func detail(
        coordinator: Store<CoordinatorState, CoordinatorAction>,
        store: Store<Int, Int>
    ) -> Coordinator {
        .matching(
            store: coordinator,
            parse: { _ in DetailRoute(id: "123") },
            content: { (route: DetailRoute) in Text("Home") }
        )
    }
}

let f = {
    let store = Store<CoordinatorState, CoordinatorAction>(
        initialState: CoordinatorState(
            screens: [:]
        ),
        reducer: .empty,
        environment: ()
    )

    let homeStore = Store<Int, Int>(
        initialState: 1,
        reducer: .empty,
        environment: ()
    )

    _ =
    AppEnvironment(
        coordinator: .combine(
            .home(
                coordinator: store,
                store: homeStore
            ),
            .detail(
                coordinator: store,
                store: homeStore
            )
        )
    )
}
