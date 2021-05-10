import SwiftUI

/// PathBuilders define how a navigation path is built into a view hierarchy
public protocol PathBuilder {
  associatedtype Content: View
  func build(pathElement: NavigationPathElement) -> Content?
}

/// Convenience type to define PathBuilders based on a build closure
public struct _PathBuilder<Content: View>: PathBuilder {
  private let _buildPathElement: (NavigationPathElement) -> Content?

  public init(_ buildPathElement: @escaping (NavigationPathElement) -> Content?) {
    self._buildPathElement = buildPathElement
  }

  public func build(pathElement: NavigationPathElement) -> Content? {
    return _buildPathElement(pathElement)
  }
}

/// Namespace enum for all available PathBuilders
public enum PathBuilders {}
