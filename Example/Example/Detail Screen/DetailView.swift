import ComposableArchitecture
import ComposableRouter
import SwiftUI

struct DetailState: Equatable {
  let id: String
}

enum DetailAction: Equatable {
  case viewAppeared
  case settingsButtonTapped
}

struct DetailEnvironment {
  let router: Router
}


struct DetailScreen: Screen {
  let presentationStyle: ScreenPresentationStyle = .push
  let detailID: String
}

struct DetailView: View {
  let store: Store<DetailState, DetailAction>

  var body: some View {
    WithViewStore(store) { viewStore in
      Text("Detail for: \(viewStore.id)")
        .navigationBarItems(
          trailing: Button(
            action: { viewStore.send(.settingsButtonTapped)},
            label: { Image(systemName: "gear") }
          )
        )
    }
  }
}

let detailReducer = Reducer<
  DetailState,
  DetailAction,
  DetailEnvironment
> { state, action, environment in
  switch action {
    case .viewAppeared:
      return .none
    case .settingsButtonTapped:
      return .fireAndForget {
        environment
          .router
          .route(
            .go(to: SettingsScreen())
          )
      }
  }
}

struct DetailView_Previews: PreviewProvider {
  static var previews: some View {
    DetailView(
      store: Store(
        initialState: DetailState(id: "123"),
        reducer: .empty,
        environment: ()
      )
    )
  }
}
