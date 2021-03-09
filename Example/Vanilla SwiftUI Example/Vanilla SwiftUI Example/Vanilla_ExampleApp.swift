import ComposableNavigator
import SwiftUI

let trains: [Train] = [
  Train(name: "ICE", capacity: 64),
  Train(name: "Regio", capacity: 23),
  Train(name: "Regio", capacity: 13),
  Train(name: "SBahn", capacity: 65),
  Train(name: "IC", capacity: 90)
]

@main
struct Vanilla_SwiftUI_ExampleApp: App {
  let dataSource: Navigator.Datasource = Navigator.Datasource(root: HomeScreen())
  
  var body: some Scene {
    WindowGroup {
      Root(dataSource: dataSource, pathBuilder: HomeScreen.Builder())
    }
  }
}
