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
              .accessibility(identifier: AccessibilityIdentifier.HomeScreen.detail(for: element))

              Spacer()
              Image(systemName: "gear")
                .foregroundColor(.gray)
                .onTapGesture {
                  viewStore.send(
                    .openSettings(for: element, on: currentScreenID)
                  )
                }
                .accessibility(addTraits: [.isButton])
                .accessibility(identifier: AccessibilityIdentifier.HomeScreen.detailSettings(for: element))
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
        .accessibility(identifier: AccessibilityIdentifier.HomeScreen.settingsNavigationBarItem)
      )
      .navigationBarTitle("Example App")
    }
  }
}

enum HomeTabs: Activatable {
  case list
  case settings
}

struct HomeScreen: Screen {
  let presentationStyle: ScreenPresentationStyle = .push

  struct Builder: NavigationTree {
    let appStore: Store<AppState, AppAction>

    var homeStore: Store<HomeState, HomeAction> {
      appStore.scope(
        state: \.home,
        action: AppAction.home
      )
    }

    var settingsStore: Store<SettingsState, SettingsAction> {
      appStore.scope(
        state: \.settings,
        action: AppAction.settings
      )
    }

    func detailStore(for detailID: String) -> Store<DetailState?, DetailAction> {
      homeStore.scope(
        state: { state in
          state.selectedDetail?.id == detailID ? state.selectedDetail : nil
        },
        action: HomeAction.detail
      )
    }

    var builder: some PathBuilder {
      Tabbed(
        .init(
          tag: HomeTabs.list,
          contentBuilder: {
            Screen( // /home
              HomeScreen.self,
              onAppear: { _ in print("HomeView appeared") },
              content: { HomeView(store: homeStore) },
              nesting: {
                If { (screen: DetailScreen) in
                  IfLetStore(
                    store: detailStore(for: screen.detailID),
                    then: { store in
                      DetailScreen.Builder(
                        store: store,
                        settingsStore: settingsStore
                      )
                        .onDismiss { (screen: DetailScreen) in
                          print("Dismissed \(screen)")
                          let viewStore = ViewStore(homeStore)
                          // Only if the current detail state represents the dismissed screen, set the state to nil.
                          if viewStore.state.selectedDetail?.id == screen.detailID {
                            ViewStore(homeStore).send(.binding(.set(\.selectedDetail, nil)))
                          }
                        }
                    }
                  )
                    .beforeBuild {
                      let viewStore = ViewStore(homeStore)
                      // we do not navigate to invalid navigation paths (i.e. example://detail?id=123)
                      if viewStore.elements.contains(screen.detailID),
                         viewStore.state.selectedDetail?.id != screen.detailID {
                        viewStore.send(.binding(.set(\.selectedDetail, DetailState(id: screen.detailID))))
                      }
                    }
                }

                SettingsScreen.Builder(
                  store: settingsStore,
                  entrypoint: "home"
                ).onDismiss(of: SettingsScreen.self) {
                  print("Dismissed settings")
                }
              }
            )
          },
          tabItem: {
            Image(systemName: "list.triangle")
            Text("List")

          },
          defaultContent: .screen(HomeScreen().eraseToAnyScreen())
        ),
        .init(
          tag: HomeTabs.settings,
          contentBuilder: {
            SettingsScreen.Builder(
              store: settingsStore,
              entrypoint: "home"
            ).onDismiss(of: SettingsScreen.self) {
              print("Dismissed settings")
            }
          },
          tabItem: {
            Image(systemName: "gear")
            Text("Settings")
          },
          defaultContent: .screen(SettingsScreen().eraseToAnyScreen())
        )
      )
    }
  }
}

let homeReducer = Reducer<
  HomeState,
  HomeAction,
  HomeEnvironment
> { _, action, environment in
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
            SettingsScreen().eraseToAnyScreen(),
          ].map(ActiveNavigationPathElement.screen),
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
