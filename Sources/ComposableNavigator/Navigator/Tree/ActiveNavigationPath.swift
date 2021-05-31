public typealias ActiveNavigationPath = [ActiveNavigationPathElement]

public indirect enum ActiveNavigationPathElement: Hashable {
  case screen(AnyScreen)
  case tabbed(ActiveTab)
}

// MARK: - Tabbed
public extension ActiveNavigationPathElement {
  struct ActiveTab: Hashable {
    let id: AnyActivatable
    let path: ActiveNavigationPath

    public init<A: Activatable>(id: A, path: ActiveNavigationPath) {
      self.id = id.eraseToAnyActivatable()
      self.path = path
    }
  }
}
