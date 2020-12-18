public extension PathBuilder {
  /***
   ```swift
   .screen(
   //  ...
       nesting: .anyOf(
           SettingsScreen.builder(store: settingsStore),
           DetailScreen.builder(store: detailStore)
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

  */
  static func anyOf(
    _ builders: [PathBuilder]
  ) -> PathBuilder {
    PathBuilder(
      buildPath: { path in
        for builder in builders {
          if let view = builder.build(path: path) {
            return view
          }
        }
        return nil
      }
    )
  }

  static func anyOf(
    _ builders: PathBuilder...
  ) -> PathBuilder {
    anyOf(builders)
  }
}
