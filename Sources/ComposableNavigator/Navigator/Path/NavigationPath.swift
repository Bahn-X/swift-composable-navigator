public typealias NavigationPath = [NavigationPathElement]

extension NavigationPath {
  func ids() -> Set<ScreenID> {
    reduce(Set<ScreenID>()) { acc, element in
      acc.union(element.ids())
    }
  }
}
