import ComposableNavigator
import SwiftUI

let trains: [Train] = [
  Train(name: "ICE", capacity: 403),
  Train(name: "Regio", capacity: 380),
  Train(name: "SBahn", capacity: 184),
  Train(name: "IC", capacity: 468)
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
