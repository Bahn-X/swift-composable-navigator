public extension Navigator {
  /// Initialises a Navigator wrapping a Datasource object
  /// - Parameters:
  ///   - dataSource: The wrapped data source
  init(dataSource: Navigator.Datasource) {
    self.init(
      path: { dataSource.path },
      go: { screen, id, forceNavigation in
        dataSource.go(to: screen, on: id, forceNavigation: forceNavigation)
      },
      goToOnScreen: { screen, parent, forceNavigation in
        dataSource.go(to: screen, on: parent, forceNavigation: forceNavigation)
      },
      goToPath: { path, id in
        dataSource.go(to: path, on: id)
      },
      goToPathOnScreen: { path, parent in
        dataSource.go(to: path, on: parent)
      },
      goBack: { predecessor in
        dataSource.goBack(to: predecessor)
      },
      goBackToID: { id in
        dataSource.goBack(to: id)
      },
      replace: { path in
        dataSource.replace(path: path)
      },
      dismiss: { id in
        dataSource.dismiss(id: id)
      },
      dismissScreen: { screen in
        dataSource.dismiss(screen: screen)
      },
      dismissSuccessor: { id in
        dataSource.dismissSuccessor(of: id)
      },
      dismissSuccessorOfScreen: { screen in
        dataSource.dismissSuccessor(of: screen)
      },
      replaceContent: { id, newContent in
        dataSource.replaceContent(of: id, with: newContent)
      },
      replaceScreen: { oldContent, newContent in
        dataSource.replace(screen: oldContent, with: newContent)
      },
      didAppear: { id in
        dataSource.didAppear(id: id)
      }
    )
  }
}
