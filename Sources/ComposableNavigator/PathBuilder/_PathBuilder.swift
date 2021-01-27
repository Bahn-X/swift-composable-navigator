import SwiftUI

public protocol PathBuilder {
  associatedtype Content: View
  func build(path: [IdentifiedScreen]) -> Content?
}

public struct _PathBuilder<Content: View>: PathBuilder {
  private let _buildPath: ([IdentifiedScreen]) -> Content?

  public init(buildPath: @escaping ([IdentifiedScreen]) -> Content?) {
    self._buildPath = buildPath
  }

  public func build(path: [IdentifiedScreen]) -> Content? {
    return _buildPath(path)
  }
}

public enum PathBuilders {}
