/// The Screen protocol is the underlying protocol for routing path elements. Each routing path element defines how it is presented.
public protocol Screen: Hashable {
  var presentationStyle: ScreenPresentationStyle { get }
}

public extension Screen {
  /// Erase an instance of a concrete Screen type to AnyScreen
  func eraseToAnyScreen() -> AnyScreen {
    AnyScreen(self)
  }
}
