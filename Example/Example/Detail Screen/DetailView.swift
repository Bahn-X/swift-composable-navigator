import ComposableArchitecture
import ComposableNavigator
import SwiftUI

struct DetailState: Equatable {
  let id: String
}

enum DetailAction: Equatable {
  case viewAppeared
  case settingsButtonTapped(ScreenID)
}

struct DetailEnvironment {
  let navigator: Navigator
}


struct DetailScreen: Screen {
  let presentationStyle: ScreenPresentationStyle = .push
  let detailID: String
}

struct DetailView: View {
  @Environment(\.currentScreenID) var currentID
  let store: Store<DetailState, DetailAction>

  var body: some View {
    WithViewStore(store) { viewStore in
      Text("\(viewStore.id)")
        .navigationBarItems(
          trailing: Button(
            action: { viewStore.send(.settingsButtonTapped(currentID))},
            label: { Image(systemName: "gear") }
          )
        )
        .navigationBarTitle("Detail for \(viewStore.id)")
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
    case let .settingsButtonTapped(id):
      return .fireAndForget {
        environment
          .navigator
          .route(
            .go(to: SettingsScreen(), on: id)
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
