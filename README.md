# The Composable Navigator
`ComposableNavigator` is a library for building deep-linkable SwiftUI applications with composition in mind. `ComposableNavigator` lifts the burden of manually managing navigation state in each screen state off your shoulders and allows to navigate through applications along routing paths. 

## Core concepts
This library mainly revolves around three main concepts: routing paths, `PathBuilder`s, and the navigator. 

### **Routing Path**
A routing path is a path that describes the order of visible screens in the  application. It is a first-class representation of the <url-path> defined in [RFC1738](https://tools.ietf.org/html/rfc1738#section-3.1). A routing path consists of screens.

#### **Screen**
Screens are first-class representation of the information needed to build a particular view. Screens can be parsed from URLs and can contain arguments like IDs, initial values, and flags. Screens define how they are presented. Currently, sheet and push presentation styles are supported.

### **Navigator**
The navigator manages the application's current routing path and allows mutations on it. The navigator acts as an interface to the underlying data source. The navigator object is accessible via the view environment.

```swift
import SwiftUI
struct DemoView: View {
    @Environment(\.navigator) var navigator
    @Environment(\.currentScreenID) var id

    var body: some View {
      VStack {
        Button(
            action: { navigator.go(to: HomeScreen(), on: id) },
            label: { Text("Go to home screen") }
        ),
        Button(
            action: { navigator.go(to: DetailScreen(id: id), on: id) },
            label: { Text("Show detail screen for \(id)") }
        )
      }
    }
}
```

Navigators allow programatic navigation and can be injected where needed, even into your ViewModel. 

### **Path builder**
A `PathBuilder` defines how a path element and its successors are built into a view hierarchy.

#### Path builder composition
The `ComposableNavigator` is based on the concept of `PathBuilder` composition. It uses `PathBuilder` composition to describe all possible routing paths in an application. That also means that all possible paths are instantly accessible via routing paths, i.e. deep-linkable.

Let's look at an example navigator (using TCA):

```swift
let appBuilder: PathBuilder = PathBuilders.screen(
  HomeScreen.self,
  content: {
    HomeView(
      store: appStore.scope(
          state: \.home,
          action: AppAction.home
      )
    )
  },
  nesting: PathBuilders.anyOf(
    DetailScreen.builder(store: detailStore),
    SettingsScreen.builder(store: settingsStore)
  )
)
```

Based on `appBuilder`, the following routing paths are valid routing paths:
```
  /home
  /home/detail?id=0
  /home/settings
```

All available `PathBuilder`s are documented [here](https://github.com/Bahn-X/swift-composable-navigator/wiki/PathBuilders).

## Usage
```swift
import ComposableNavigator
import SwiftUI

let appBuilder: PathBuilder = PathBuilders.screen(
  HomeScreen.self,
  content: { HomeView(...) },
  nesting: .anyOf(
    DetailScreen.builder(...),
    SettingsScreen.builder(...)
  )
)

@main
struct ExampleApp: App {
  let dataSource = Navigator.Datasource(root: HomeScreen())

  var body: some Scene {
    WindowGroup {
      Root(
        dataSource: dataSource,
        pathBuilder: appBuilder
      )
    }
  }
}
```

## Deeplinking
As `ComposableNavigator` builds the view hierarchy based on routing paths, it is the ideal companion to implement deeplinking. Deeplinks come in different forms and shapes, however `ComposableNavigator` abstracts it into a first-class representation in form of the `Deeplink` type. The `ComposableDeeplinking` library that is part of the `ComposableNavigator` contains a couple of helper types that allow you to easily replace the current routing path with a new routing path based on a `Deeplink` by defining a `DeeplinkHandler` and a composable `DeeplinkParser`.

You can find more information on deeplinking and how to use it [here](https://github.com/Bahn-X/swift-composable-navigator/wiki/Deeplinking).

## Dependency injection 
`ComposableNavigator` was inspired by [The Composable Architecture (TCA)](https://github.com/pointfreeco/swift-composable-architecture) and its approach to Reducer composition, dependency injection and state management. As all view building closures are defined in one central place, the app path builder, ComposableNavigator gives you full control over dependency injection. Currently, the helper package `ComposableNavigatorTCA` is part of this repository and therefore the package has a dependency on TCA. This will change in the future when `ComposableNavigatorTCA` gets [extracted into its own repository](https://github.com/Bahn-X/swift-composable-navigator/issues/12).

## License
This library is released under the MIT license. See [LICENSE](LICENSE) for details.
