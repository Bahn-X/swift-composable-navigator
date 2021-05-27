// MARK: - Debug
public extension Navigator {
  /// Enable  logging received function calls and path changes.
  func debug(
    log: @escaping (String) -> Void = { print($0) },
    dumpPath: @escaping (NavigationPathUpdate) -> Void = { dump($0) }
  ) -> Navigator {
    Navigator(
      path: path,
      go: { (screen, id, forceNavigation) in
        go(to: screen, on: id, forceNavigation: forceNavigation)
        log("Sent go(to: \(screen), on: \(id), forceNavigation: \(forceNavigation)).\nNew path:")
        dumpPath(path())
      },
      goToOnScreen: { screen, parent, forceNavigation in
        go(to: screen, on: parent, forceNavigation: forceNavigation)
        log("Sent go(to: \(screen), on: \(parent), forceNavigation: \(forceNavigation)).\nNew path:")
        dumpPath(path())
      },
      goToPath: { newPath, id in
        go(to: newPath, on: id)
        log("Sent go(to path: \(newPath), on: \(id)).\nNew path:")
        dumpPath(path())
      },
      goToPathOnScreen: { newPath, parent in
        go(to: newPath, on: parent)
        log("Sent go(to path: \(newPath), on: \(parent)).\nNew path:")
        dumpPath(path())
      },
      goBack: { (predecessor) in
        goBack(to: predecessor)
        log("Sent goBack(to: \(predecessor)).\nNew path:")
        dumpPath(path())
      },
      goBackToID: { id in
        goBack(to: id)
        log("Sent goBack(to: \(id)).\nNew path:")
        dumpPath(path())
      },
      replace: { (newPath) in
        replace(path: newPath)
        log("Sent replace(path: \(newPath)).\nNew path:")
        dumpPath(path())
      },
      dismiss: { (id) in
        dismiss(id: id)
        log("Sent dismiss(id: \(id)).\nNew path:")
        dumpPath(path())
      },
      dismissScreen: { screen in
        dismiss(screen: screen)
        log("Sent dismiss(screen: \(screen)).\nNew path:")
        dumpPath(path())
      },
      dismissSuccessor: { (id) in
        dismissSuccessor(of: id)
        log("Sent dismissSuccessor(of: \(id)).\nNew path:")
        dumpPath(path())
      },
      dismissSuccessorOfScreen: { screen in
        dismissSuccessor(of: screen)
        log("Sent dismissSuccessor(of: \(screen)).\nNew path:")
        dumpPath(path())
      },
      replaceContent: { id, screen in
        replaceContent(of: id, with: screen)
        log("Sent replaceContent(of: \(id), with: \(screen)).\nNew path:")
        dumpPath(path())
      },
      replaceScreen: { oldContent, newContent in
        replace(screen: oldContent, with: newContent)
        log("Sent replace(screen: \(oldContent), with: \(newContent)).\nNew path:")
        dumpPath(path())
      },
      didAppear: { id in
        didAppear(id: id)
        log("Sent didAppear(id: \(id)).\nNew path:")
        dumpPath(path())
      },
      activate: { activatable in
        activate(activatable)
        log("Sent activate(_ activatable: \(activatable)).\nNew path:")
        dumpPath(path())
      }
    )
  }
}
