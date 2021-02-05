import Foundation

/// A unique identifier for Screens
public typealias ScreenID = UUID

public extension ScreenID {
  /// The ID of the root of any routing path
  static let root = UUID(uuidString: "00000000-0000-0000-0000-000000000000")!
}
