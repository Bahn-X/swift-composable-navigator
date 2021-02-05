import SwiftUI

/// PathBuilders define how to build a routing path
public protocol PathBuilder {
  associatedtype Content: View
  func build(path: [IdentifiedScreen]) -> Content?
}

/// Convenience type to define PathBuilders based on a build closure
public struct _PathBuilder<Content: View>: PathBuilder {
  private let _buildPath: ([IdentifiedScreen]) -> Content?

  public init(buildPath: @escaping ([IdentifiedScreen]) -> Content?) {
    self._buildPath = buildPath
  }

  public func build(path: [IdentifiedScreen]) -> Content? {
    return _buildPath(path)
  }
}

/// Namespace enum for all available PathBuilders
public enum PathBuilders {}
