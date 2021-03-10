import SwiftUI
import ComposableNavigator

struct HomeScreen: Screen {
  let presentationStyle: ScreenPresentationStyle = .push
  
  struct Builder: NavigationTree {
    var builder: some PathBuilder {
      Screen(
        HomeScreen.self,
        content: { HomeView() },
        nesting: {
          DetailScreen.Builder()
        }
      )
    }
  }
}

struct HomeView: View {
  @Environment(\.navigator) private var navigator: Navigator
  @Environment(\.currentScreen) private var currentScreen
  
  var body: some View {
    VStack {
      List(trains, id: \.name) { train in
        HStack {
          Button(
            action: {
              navigator.go(
                to: DetailScreen(train: train),
                on: currentScreen
              )
            },
            label: { Text(train.name) }
          )
          Spacer()
        }
      }
      Spacer()
    }
    .navigationTitle(Text("Trains"))
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
