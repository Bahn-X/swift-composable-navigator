import SwiftUI

struct IsInActiveTabKey: EnvironmentKey {
  static let defaultValue = true
}

public extension EnvironmentValues {
  var isInActiveTab: Bool {
    get {
      self[IsInActiveTabKey.self]
    }
    set {
      self[IsInActiveTabKey.self] = newValue
    }
  }
}
