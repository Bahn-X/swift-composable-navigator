# Path builders
## Screen path builder
The screen path builder describes how a single screen is built.  The content closure is only called if the path element's content of type HomeScreen.

```swift
PathBuilder.screen(
  HomeScreen.self,
  content: {
    HomeView(...)
  },
  nesting: ...
)
```

The Home screen builder extracts `HomeScreen` instances from the routing path and uses it's nesting path builder to build the remaining path. 

## AnyOf path builder
```swift
.screen(
//  ...
    nesting: .anyOf(
        SettingsScreen.builder(...),
        DetailScreen.builder(...)
    )
)
...
```

If a screen can have more than one possible successor, the AnyOf path builder allows to branch out. In the example, the Home Screen can either route to the Settings or the Detail screen. We express these two possible routing paths by passing an anyOf path builder as a `nesting` argument. 

Read AnyOf path builders as "any of the listed path builder builds the path". Given our example, the settings and the detail screen can follow after the home screen. AnyOf allows us to branch out in this case. The resulting app routing tree would be:
```
        -- Settings
Home ---
        -- Detail
```

Keep in mind, that the order of the listed path builders matters. The first path builders that can handle the path will build it. 

## Conditional path builder
In some cases, you want to make sure that the user will never be able to reach certain parts of your application. For example, you might want to show a login screen as long the user hasn't logged in. For these cases, you can use a conditional path builders.

```swift
.conditional(
    either: HomeScreen.builder(store: homeStore),
    or: LoginScreen.builder(store: loginStore),
    basedOn: { user.isLoggedIn }
)
```

The example here would never built routing paths using the HomeScreen.nuilder if the user isn't logged in. The condition is checked on each change of the routing path.

### if let path builder
The ifLet path builder unwraps an optional value and provides it to the path builder defining closure. 

```swift
.if(
  let: { store.detailStore }, 
  then: { detailStore in 
    DetailScreen.builder(store: detailStore)
  }
  else: // fallback if the value is not set.
)
```

### if screen path builder
The ifLet path builder unwraps a screen, if the path element matches the screen type, and provides it to the path builder defining closure. 

```swift
.if(
  screen: { (screen: DetailScreen) in
    DetailScreen.builder(store.detailStore(for: screen.id))
  },
  else: // fallback
)
```

## Wildcard path builder
Wildcard path builder replaces any screen with a predefined one. Based on the example for the conditional path builder, you might run into a situation in which your deeplink parser parses a routing path that can only be handled by the homeScreenBuilder. This would lead to an empty application, which is unfortunate. 

To mitigate this problem, you can combine a conditional path builder with a wildcard path builder:

```swift
.conditional(
    either: .wildcard(
        screen: HomeScreen(),
        pathBuilder: HomeScreen.builder(store: homeStore)
    ),
    or: wildcard(
        screen: LoginScreen(), 
        loginScreen(store: loginStore)
    ),
    basedOn: { user.isLoggedIn }
)
```

This is example basically states: Whatever path I get, the first element should be a defined screen.

## Empty path builder
The empty path builder does not build any screen and just returns nil for all screens. You can use .empty as a stub.

## Implementing custom path builder
As an applications routing tree grows, the number of possible routing paths increases. To avoid code duplication, use any of these three patterns: 

### Option A: global functions
```swift
// Option A: Global factory function
func detailScreenBuilder(
  ... // dependencies
) -> PathBuilder {
  .screen(
    DetailScreen.self,
    ... // implementation of the detail path builder
  )
}
```

### Option B: Extending the PathBuilder type
Extend the PathBuilder type with static convenience factory methods for each of your apps screen.
```swift
extension PathBuilder {
  static func detailScreenBuilder(
  ... // dependencies
  ) -> PathBuilder {
    .screen(
      DetailScreen.self,
      ... // implementation of the detail path builder
    )
  }
}
```

### Option C: Extend screen types
Extend the screen type with static convenience factory methods.
```swift
extension DetailScreen {
  static func builder(
  ... // dependencies
  ) -> PathBuilder {
    .screen(
      DetailScreen.self,
      ... // implementation of the detail path builder
    )
  }
}
```

All three options allow to reuse path builders, and extend your routing tree.