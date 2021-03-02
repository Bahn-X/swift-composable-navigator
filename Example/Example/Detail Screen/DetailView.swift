import ComposableArchitecture
import ComposableNavigator
import ComposableNavigatorTCA
import SwiftUI

struct DetailState: Equatable {
  let id: String

  var navigationShortcuts = NavigationShortcutsState()
}

enum DetailAction: Equatable {
  case viewAppeared
  case settingsButtonTapped(ScreenID)
  case navigationShortcuts(NavigationShortcutsAction)
}

struct DetailEnvironment {
  let navigator: Navigator

  var navigationShortcuts: NavigationShortcutsEnvironment {
    NavigationShortcutsEnvironment(
      navigator: navigator
    )
  }
}

struct DetailScreen: Screen {
  let presentationStyle: ScreenPresentationStyle = .push
  let detailID: String

  struct Builder: NavigationTree {
    let store: Store<DetailState, DetailAction>
    let settingsStore: Store<SettingsState, SettingsAction>

    var builder: some PathBuilder {
      If { (screen: DetailScreen) in
        Screen(
          DetailScreen.self,
          content: {
            DetailView(
              store: store
            )
          },
          nesting: {
            SettingsScreen.Builder(
              store: settingsStore,
              entrypoint: "detail.\(screen.detailID)"
            )
            .onDismiss(of: SettingsScreen.self) {
              print("Detail settings dismissed")
            }

            NavigationShortcutsScreen.Builder(
              store: store.scope(
                state: \.navigationShortcuts,
                action: DetailAction.navigationShortcuts
              )
            )
          }
        )
      }
    }
  }
}

struct DetailView: View {
  @Environment(\.navigator) var navigator
  @Environment(\.currentScreenID) var currentID
  let store: Store<DetailState, DetailAction>

  var body: some View {
    WithViewStore(store) { viewStore in
      HStack {
        VStack(alignment: .leading, spacing: 16) {
          Button(
            action: {
              navigator.go(
                to: NavigationShortcutsScreen(
                  presentationStyle: .push
                ),
                on: currentID
              )
            },
            label: { Text("Go to [home/detail?id=\(viewStore.id)/shortcuts]") }
          )
          .accessibility(
            identifier: AccessibilityIdentifier.DetailScreen(id: viewStore.id).shortcuts
          )

          NavigationShortcuts(
            accessibilityIdentifiers: AccessibilityIdentifier.NavigationShortcuts(prefix: "detail.\(viewStore.id).shortcuts")
          )
          Spacer()
        }
        Spacer()
      }
      .padding(16)
      .navigationBarItems(
        trailing: Button(
          action: { viewStore.send(.settingsButtonTapped(currentID)) },
          label: { Image(systemName: "gear") }
        )
        .accessibility(
          identifier: AccessibilityIdentifier.DetailScreen(id: viewStore.id).settings
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
>.combine(
  Reducer { _, action, environment in
    switch action {
    case .viewAppeared:
      return .none

    case let .settingsButtonTapped(id):
      return .fireAndForget {
        environment
          .navigator
          .go(to: SettingsScreen(), on: id)
      }

    case .navigationShortcuts:
      return .none
    }
  },
  navigationShortcutsReducer.pullback(
    state: \.navigationShortcuts,
    action: /DetailAction.navigationShortcuts,
    environment: \.navigationShortcuts
  )
)

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
