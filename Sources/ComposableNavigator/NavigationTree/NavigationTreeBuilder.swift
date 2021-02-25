import SwiftUI

#if swift(>=5.4)
@resultBuilder
public enum NavigationTreeBuilder {
  public static func buildBlock<P: PathBuilder>(_ builder: P) -> P {
    builder
  }
}
#else
@_functionBuilder
public enum NavigationTreeBuilder {
  public static func buildBlock<P: PathBuilder>(_ builder: P) -> P {
    builder
  }
}
#endif
