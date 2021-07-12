public extension Navigator {
  /// Initialises a Navigator wrapping a Datasource object
  /// - Parameters:
  ///   - dataSource: The wrapped data source
  init(dataSource: Navigator.Datasource) {
    self.init(
      navigationTree: { dataSource.navigationTree },
      go: dataSource.go,
      goToOnScreen: dataSource.go,
      goToPath: dataSource.go,
      goToPathOnScreen: dataSource.go,
      goBack: dataSource.goBack,
      goBackToID: dataSource.goBack,
      replace: dataSource.replace,
      dismiss: dataSource.dismiss,
      dismissScreen: dataSource.dismiss,
      dismissSuccessor: dataSource.dismissSuccessor,
      dismissSuccessorOfScreen: dataSource.dismissSuccessor,
      replaceContent: dataSource.replaceContent,
      replaceScreen: dataSource.replace,
      didAppear: dataSource.didAppear,
      activate: dataSource.activate
    )
  }
}
