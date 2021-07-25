import SwiftUI

public struct TabbedNode: View {

  public var body: some View {
    TabView {
      Text("The First Tab")
        .tabItem {
          Image(systemName: "1.square.fill")
          Text("First")
        }
      Text("Another Tab")
        .tabItem {
          Image(systemName: "2.square.fill")
          Text("Second")
        }

      Color.clear
        .tabItem {
          Image(systemName: "3.square.fill")
          Text("Third")
        }
        .tag(1)

      Color.clear
        .tabItem {
          Image(systemName: "4.square.fill")
          Text("Third")
        }
        .tag(1)

      Color.clear
        .tabItem {
          Image(systemName: "5.square.fill")
          Text("Third")
        }
        .tag(1)

      Color.clear
        .tabItem {
          Image(systemName: "6.square.fill")
          Text("Third")
        }
        .tag(1)
    }
    .font(.headline)
  }
}

struct TabbedNode_Previews: PreviewProvider {
  static var previews: some View {
    TabbedNode()
  }
}

