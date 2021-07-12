public typealias ActiveNavigationTree = [ActiveNavigationTreeElement]

extension ActiveNavigationTree {
  func ids() -> Set<ScreenID> {
    reduce(into: Set<ScreenID>()) { acc, element in
      acc.formUnion(element.ids())
    }
  }

  func contents() -> Set<AnyScreen> {
    reduce(into: Set<AnyScreen>()) { acc, element in
      acc.formUnion(element.contents())
    }
  }

  func activePath() -> ActiveNavigationPath {
    map(\.activeNavigationPathElement)
  }
}
