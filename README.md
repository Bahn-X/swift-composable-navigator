# Composable Navigator

Composable Navigator is a library for building deep-linkable SwiftUI applications with dependency injection, testing and ergonomics in mind. Composable Navigator lifts the burden of manually managing navigation state in each screen state off your shoulders and allows to navigate through applications along routing paths. 

## What is the Composable Navigator?

This library mainly revolves around three main concepts: routing paths, screens, and navigators. 

* **Routing Path**
A routing path is a path that describes the order of visible screens in the  application. It is a first-class representation of the <url-path> defined in [RFC1738](https://tools.ietf.org/html/rfc1738#section-3.1). A routing path consists of screens.  

* **Screen**
A screen is a first-class representation of the information needed to present a given view. Screens can be parsed from URLs and can contain arguments like IDs or flags. Screens define how they are presented, either as a sheet or as a push.

* **Navigator**
The navigator manages the application's current routing path and allows mutations on it. Navigating to a new screen appends it to the routing path. 

There are currently three types of navigators which can be composed: 

### Navigator composition

As the library name suggests, Composable Navigator is based on the concept of navigator composition. It uses navigator composition to describe all possible routing paths in an application. That also means that all possible paths are instantly accessible via routing paths, i.e. deep-linkable.

Let's look at an example navigator:

```swift
let appNavigator: Navigator = .root(
  dataSource: navigatorStore,
  navigator: .screen(
    content: { _ in
      HomeView(
        store: appStore.scope(
            state: \.home,
            action: AppAction.home
        )
      )
    },
    nesting: .anyOf(
      .settingsNavigator(store: settingsStore),
      .detailNavigator(store: detailStore)
    )
  )
)
```

Based on `appNavigator`, the following routing paths are valid routing paths:
```
  /home
  /home/detail?id=0
  /home/settings
```

### Root Navigator

```swift
.root(
  dataSource: navigatorStore,
  navigator: ...
)
```

The root navigator passes actions to the NavigatorStore. An application should only have one root navigator and wrap the routing tree defining navigator.

### Screen Navigator
The screen navigator describes how a single screen is built.  The content closure is only called if the path element's content of type HomeScreen.

```swift
Navigator.screen(
  content: { (_: HomeScreen) in
    HomeView(
     store: appStore.scope(
       state: \.home, 
       action: AppAction.home
     )
    )
  },
  nesting: ...
)
```

The nesting argument optionally expects a navigator and allows to present/push subsequent screens.

### AnyOf Navigator

```swift
.screen(
//  ...
    nesting: .anyOf(
        .settingsNavigator(store: settingsStore),
        .detailNavigator(store: detailStore)
    )
)
    
...
```

If a screen can have more than one possible successor, the AnyOf navigator allows to branch out. In the example, the Home Screen can either route to the Settings or the Detail screen. We express these two possible routing paths by passing an anyOf navigator as a `nesting` argument. 

Read AnyOf navigators as "any of the listed navigators takes care of the path". Given our example, the settings and the detail screen can follow after the home screen. AnyOf allows us to branch out in this case. The resulting app routing tree would be:
```
        -- Settings
Home ---
        -- Detail
```

Keep in mind, that the order of the listed navigators matters. The first navigator that can handle the path will build it. 

### Conditional Navigator
In some cases, you want to make sure that the user will never be able to reach certain parts of your application. For example, you might want to show a login screen as long the user hasn't logged in. For these cases, you can use a conditional navigator.

```swift
.conditional(
    either: homeScreenNavigator(store: homeStore),
    or: loginScreen(store: loginStore),
    basedOn: { user.isLoggedIn }
)
```

The example here would never built routing paths using the homeScreenNavigator if the user isn't logged in. The condition is checked on each change of the routing path.

### Wildcard Navigator
Wildcard navigators allow you to replace any screen with the expected one. Based on the example for the conditional navigator,  you might run into a situation in which your deeplink parser parses a routing path that can only be handled by the homeScreenNavigator. This would lead to an empty application, which is unfortunate. 

To mitigate this problem, you can combine a conditional navigator with a wildcard navigator:

```swift
.conditional(
    either: .wildcard(
        screen: HomeScreen(),
        navigator: homeScreenNavigator(store: homeStore)
    ),
    or: wildcard(
        screen: LoginScreen(), 
        loginScreen(store: loginStore)
    ),
    basedOn: { user.isLoggedIn }
)
```

This is example basically states: Whatever path I get, the first element should be a defined screen.

### Building custom navigators

As an applications navigation tree grows, the number of possible routing paths increases. To avoid code duplication, it is advised to use either global functions or extend the Navigator type with static convience factory methods for each of your apps screen.

```swift
// Option A: Global factory function
func detailNavigator(
  ... // dependencies
) -> Navigator {
  .screen(
    ... // implementation of the detail navigator
  )
}

// Option B: Extend the Navigator type and add a convenience factory method
extension Navigator {
  static func detailNavigator(
  ... // dependencies
  ) -> Navigator {
    .screen(
      ... // implementation of the detail navigator
    )
  }
}
```

In this way, navigators can be reused and plugged in to create new routing paths.

## Dependency injection 

The composable navigator was inspired by [The Composable Architecture (TCA)](https://github.com/pointfreeco/swift-composable-architecture) and it's approach to Reducer composition, dependency injection and state management. As all view building closures are defined in one central place, the app navigator, the composable navigator gives you full control over dependency injection. In the future, we will remove the dependency on TCA to allow usage in Vanilla SwiftUI applications.

## License

This library is released under the MIT license. See [LICENSE](LICENSE) for details.
