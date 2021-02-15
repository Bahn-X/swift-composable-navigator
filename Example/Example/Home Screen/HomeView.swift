import ComposableArchitecture
import ComposableNavigator
import SwiftUI

struct HomeState: Equatable {
  var elements: [String]

  var selectedDetail: DetailState?
}

enum HomeAction: Equatable {
  case viewAppeared
  case selected(element: String, on: ScreenID)
  case openSettings(for: String, on: ScreenID)
  case settingsButtonTapped

  case detail(DetailAction)

  case binding(BindingAction<HomeState>)
}

struct HomeEnvironment {
  let navigator: Navigator

  var detail: DetailEnvironment {
    DetailEnvironment(navigator: navigator)
  }
}

struct HomeView: View {
  @Environment(\.currentScreenID) var currentScreenID
  @Environment(\.currentScreen) var currentScreen
  @Environment(\.navigator) var navigator
  let store: Store<HomeState, HomeAction>

  var body: some View {
    WithViewStore(store) { viewStore in
      List {
        Button(
          action: {
            navigator.go(to: SettingsScreen(), on: currentScreen)
          },
          label: {
            HStack {
              Text("Open Settings")
              Image(systemName: "gear")
                .foregroundColor(.gray)
              Spacer()
            }
          }
        )

        ForEach(
          viewStore.elements,
          id: \.self,
          content: { element in
            HStack {
              Button(
                action: {
                  viewStore.send(
                    .selected(element: element, on: currentScreenID)
                  )
                },
                label: {
                  Text("Element \(element)")
                }
              )
              Spacer()
              Image(systemName: "gear")
                .foregroundColor(.gray)
                .onTapGesture {
                  viewStore.send(
                    .openSettings(for: element, on: currentScreenID)
                  )
                }
            }
          }
        )
      }
      .onAppear {
        viewStore.send(.viewAppeared)
      }
      .navigationBarItems(
        trailing: Button(
          action: { viewStore.send(.settingsButtonTapped) },
          label: { Image(systemName: "gear") }
        )
      )
      .navigationBarTitle("Example App")
    }
  }
}

struct HomeScreen: Screen {
  let presentationStyle: ScreenPresentationStyle = .push

  static func builder(
    appStore: Store<AppState, AppAction>
  ) -> some PathBuilder {
    let homeStore = appStore.scope(
      state: \.home,
      action: AppAction.home
    )

    let settingsStore = appStore.scope(
      state: \.settings,
      action: AppAction.settings
    )

    let buildDetailStore = { (detailID: String) -> Store<DetailState?, DetailAction> in
      homeStore.scope(
        state: { state in
          state.selectedDetail?.id == detailID ? state.selectedDetail: nil
        },
        action: HomeAction.detail
      )
    }

    return PathBuilders.screen( // /home
      onAppear: { _ in print("HomeView appeared") },
      content: { (_: HomeScreen) in
        HomeView(
          store: homeStore
        )
      },
      nesting: PathBuilders.anyOf(
        PathBuilders.if(
          screen: { (screen: DetailScreen) in
            PathBuilders.ifLetStore(
              store: buildDetailStore(screen.detailID),
              then: { store in
                DetailScreen.builder(
                  store: store,
                  settingsStore: settingsStore
                )
              }
            )
            .beforeBuild {
              let viewStore = ViewStore(homeStore)
              // we do not navigate to invalid routing paths (i.e. example://detail?id=123)
              if viewStore.elements.contains(screen.detailID),
                 viewStore.state.selectedDetail?.id != screen.detailID {
                viewStore.send(.binding(.set(\.selectedDetail, DetailState(id: screen.detailID))))
              }
            }
          }
        ),
        SettingsScreen.builder(store: settingsStore)
      )
      .onDismiss { (screen: DetailScreen) in
        print("Dismissed \(screen)")
        let viewStore = ViewStore(homeStore)
        // Only if the current detail state represents the dismissed screen, set the state to nil.
        if viewStore.state.selectedDetail?.id == screen.detailID {
          ViewStore(homeStore).send(.binding(.set(\.selectedDetail, nil)))
        }
      }
      .onDismiss(of: SettingsScreen.self) {
        print("Dismissed settings")
      }
    )
  }
}

let homeReducer = Reducer<
  HomeState,
  HomeAction,
  HomeEnvironment
> { state, action, environment in
  switch action {
  case .viewAppeared:
    return .none

  case .settingsButtonTapped:
    return .fireAndForget {
      environment
        .navigator
        .go(to: SettingsScreen(), on: HomeScreen())
    }

  case let .selected(element, screenID):
    return .fireAndForget {
      environment
        .navigator
        .go(to: DetailScreen(detailID: element), on: screenID)
    }

  case let .openSettings(for: element, on: screenID):
    return .fireAndForget {
      environment
        .navigator
        .go(
          to: [
            DetailScreen(detailID: element).eraseToAnyScreen(),
            SettingsScreen().eraseToAnyScreen()
          ],
          on: screenID
        )
    }

  case .binding, .detail:
    return .none
  }
}
.combined(
  with: detailReducer.optional().pullback(
    state: \.selectedDetail,
    action: /HomeAction.detail,
    environment: \.detail
  )
)
.binding(action: /HomeAction.binding)

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      HomeView(
        store: Store(
          initialState: .init(elements: (0..<10).map(String.init)),
          reducer: .empty,
          environment: ()
        )
      )
    }
  }
}
