import ComposableNavigator
import SwiftUI

struct DetailScreen: Screen {
  let train: Train
  let presentationStyle: ScreenPresentationStyle = .push
  
  struct Builder: NavigationTree {
    var builder: some PathBuilder {
      Screen(
        content: { (screen: DetailScreen) in
          DetailView(train: screen.train)
        },
        nesting: {
          CapacityScreen.Builder()
        }
      )
    }
  }
}

struct DetailView: View {
  @Environment(\.navigator) private var navigator
  @Environment(\.currentScreen) private var currentScreen
  
  let train: Train
  
  var body: some View {
    VStack {
      Text(train.name)
        .padding()
      Button(
        action: {
          navigator.go(
            to: CapacityScreen(capacity: train.capacity),
            on: currentScreen
          )
        },
        label: { Text("Show capacity").foregroundColor(.red) }
      )
    }
    .navigationTitle(train.name)
  }
}

struct DetailView_Previews: PreviewProvider {
  static var previews: some View {
    DetailView(train: Train(name: "ICE", capacity: 63))
  }
}
