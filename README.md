# Composable Router

Composable Router is a library for building deep-linkable SwiftUI applications with dependency injection, testing and ergonomics in mind. Composable Router lifts the burden of manually managing navigation state in each screen state off your shoulders and allows to navigate through applications along routing paths. 

## What is the Composable Router?

This library mainly revolves around three main concepts: routing paths, screens, and routers. 

* **Routing Path**

A routing path is a path that describes the order of visible screens in the  application. It is a first-class representation of the <url-path> defined in [RFC1738](https://tools.ietf.org/html/rfc1738#section-3.1). A routing path consists of screens.  

* **Screen**
A screen is a first-class representation of the information needed to present a given view. Screens can be parsed from URLs and can contain arguments like IDs or flags. Screens define how they are presented, either as a sheet or as a push.

* **Router**
The router manages the application's current routing path and allows mutations on it. Navigating to a new screen appends it to the routing path. 

There are currently three types of routers which can be composed: 

### Router composition

As the library name suggests, Composable Router is based on the concept of router composition. It uses router composition to describe all possible routing paths in an application. That also means that all possible paths are instantly accessible via routing paths, i.e. deep-linkable.

Let's look at an example router:

```swift
let appRouter: Router = .root(
  store: routerStore,
  router: .screen(
    store: routerStore,
    parse: { pathElement in
        pathElement.name == "home" ? HomeScreen(): nil
    },
    content: { _ in
      HomeView(
        store: appStore.scope(
            state: \.home,
            action: AppAction.home
        )
      )
    },
    nesting: .anyOf(
      .settingsRouter(store: routerStore),
      .detailRouter(store: routerStore)
    )
  )
)
```

Based on `appRouter`, the following routing paths are valid routing paths:
```
  /home
  /home/detail?id=0
  /home/settings
```

### Root Router

```swift
.root(
  store: routerStore,
  router: ...
)
```

The root router passes actions to the RouterStore. An application should only have one root router and wrap the routing tree defining routers.

### Screen Router
The screen router describes how a single screen is built given a routing path.  

```swift
Router.screen(
  store: routerStore,
  parse: { pathElement in
    pathElement.name == "home" ? HomeScreen(): nil
  },
  content: { screen in
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

This router parses the home screen from any URL starting with `home`. The nesting argument optionally expects a router and allows to present subsequent screens.

### AnyOf Router

```swift
...
    nesting: .anyOf(
      .settingsRouter(store: routerStore),
      .detailRouter(store: routerStore)
    )
...
```

If a screen can have more than one possible successor, the AnyOf router allows to branch out. In the example, the Home Screen can either route to the Settings or the Detail screen. We express these two possible routing paths by passing an anyOf router as a `nesting` argument.

### Building custom routers

As an applications navigation tree grows, the number of possible routing paths increases. To avoid code duplication, it is advised to use either global functions or extend the Router type with static convience factory methods for each of your apps screen.

```swift
// Option A: Global factory function
func detailRouter(
  routerStore: Store<RouterState, RouterAction>,
  ... // other dependencies
) -> Router {
  .screen(
    ... // implementation of the detail router
  )
}

// Option B: Extend the router type and add a convenience factory method
extension Router {
  static func detailRouter(
  routerStore: Store<RouterState, RouterAction>,
  ... // other dependencies
  ) -> Router {
    .screen(
      ... // implementation of the detail router
    )
  }
}
```

In this way, Routers can be reused and plugged in to create new routing paths.

## Dependency injection 

The composable router was inspired by [The Composable Architecture (TCA)](https://github.com/pointfreeco/swift-composable-architecture) and it's approach to Reducer composition, dependency injection and state management. As all view building closures are defined in one central place, the app router, the composable router gives you full control over dependency injection. In the future, we will remove the dependency on TCA to allow usage in Vanilla SwiftUI applications.

## License

This library is released under the MIT license. See [LICENSE](LICENSE) for details.