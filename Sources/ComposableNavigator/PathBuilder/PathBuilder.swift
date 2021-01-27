import SwiftUI

public struct PathBuilder<Content: View> {
  private let _buildPath: ([IdentifiedScreen]) -> Content?

  public init(buildPath: @escaping ([IdentifiedScreen]) -> Content?) {
    self._buildPath = buildPath
  }

  public func build(path: [IdentifiedScreen]) -> Content? {
    return _buildPath(path)
  }
}
