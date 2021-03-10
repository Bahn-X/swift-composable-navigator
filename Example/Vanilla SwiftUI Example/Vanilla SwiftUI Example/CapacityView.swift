import ComposableNavigator
import SwiftUI

struct CapacityScreen: Screen {
  let capacity: Int
  var presentationStyle: ScreenPresentationStyle = .sheet(allowsPush: true)
  
  struct Builder: NavigationTree {
    var builder: some PathBuilder {
      Screen { (screen: CapacityScreen) in
        CapacityView(capacity: screen.capacity)
      }
    }
  }
}

struct CapacityView: View {
  @Environment(\.navigator) private var navigator
  @Environment(\.currentScreen) private var currentScreen
  
  let capacity: Int
  
  var body: some View {
    VStack {
      Image(systemName: "person.3.fill")
        .imageScale(.medium)
        .padding(.bottom)
      Text("\(capacity)")
        .font(.largeTitle)
        .bold()
    }
    .navigationBarItems(
      trailing: Button(
        action: { navigator.dismiss(screen: currentScreen) },
        label: { Image(systemName: "xmark") })
    )
    .navigationTitle(Text("Capacity"))
  }
}

struct CapacityView_Previews: PreviewProvider {
  static var previews: some View {
    CapacityView(capacity: 101)
  }
}
