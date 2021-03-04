import SwiftUI

/// PathBuilders define how a navigation path is built into a view hierarchy
public protocol PathBuilder {
  associatedtype Content: View
  func build(pathElement: AnyScreen) -> Content?
}

extension PathBuilder {
  public func build<S: Screen>(pathElement: S) -> Content? {
    self.build(pathElement: pathElement.eraseToAnyScreen())
  }
}

/// Convenience type to define PathBuilders based on a build closure
public struct _PathBuilder<Content: View>: PathBuilder {
  private let _buildPathElement: (AnyScreen) -> Content?

  public init(_ buildPathElement: @escaping (AnyScreen) -> Content?) {
    self._buildPathElement = buildPathElement
  }

  public func build(pathElement: AnyScreen) -> Content? {
    return _buildPathElement(pathElement)
  }
}

/// Namespace enum for all available PathBuilders
public enum PathBuilders {}
