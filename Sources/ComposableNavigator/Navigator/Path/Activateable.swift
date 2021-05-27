public protocol Activatable: Hashable {}

public extension Activatable {
  func eraseToAnyActivatable() -> AnyActivatable {
    if let anyActivatable = self as? AnyActivatable {
      return anyActivatable
    } else {
      return AnyActivatable(self)
    }
  }
}

public struct AnyActivatable: Hashable, Activatable {
  private let activatable: AnyHashable

  public init<A: Activatable>(_ activatable: A) {
    self.activatable = activatable
  }
}
