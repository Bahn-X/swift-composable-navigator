public typealias NavigationPath = [NavigationPathElement]

extension NavigationPath {
  func ids() -> Set<ScreenID> {
    reduce(Set<ScreenID>()) { acc, element in
      acc.union(element.ids())
    }
  }

  func contents() -> Set<AnyScreen> {
    reduce(Set<AnyScreen>()) { acc, element in
      acc.union(element.contents())
    }
  }
}
