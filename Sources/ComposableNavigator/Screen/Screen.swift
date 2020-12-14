public protocol Screen: Hashable {
  var presentationStyle: ScreenPresentationStyle { get }
}

public extension Screen {
  func eraseToAnyScreen() -> AnyScreen {
    AnyScreen(self)
  }
}
