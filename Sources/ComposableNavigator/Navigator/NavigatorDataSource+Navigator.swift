public extension Navigator {
  /// Initialises a Navigator wrapping a Datasource object
  /// - Parameters:
  ///   - dataSource: The wrapped data source
  init(dataSource: Navigator.Datasource) {
    self.init(
      path: { dataSource.path },
      go: { screen, id in
        dataSource.go(to: screen, on: id)
      },
      goToPath: { path, id in
        dataSource.go(to: path, on: id)
      },
      goBack: { predecessor in
        dataSource.goBack(to: predecessor)
      },
      replace: { path in
        dataSource.replace(path: path)
      },
      dismiss: { id in
        dataSource.dismiss(id: id)
      },
      dismissSuccessor: { id in
        dataSource.dismissSuccessor(of: id)
      },
      didAppear: { id in
        dataSource.didAppear(id: id)
      }
    )
  }
}
