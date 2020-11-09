import ComposableRouter

struct TestRoute: Screen {
  let identifier: String
  let presentationStyle: ScreenPresentationStyle

  init(
    identifier: String,
    presentationStyle: ScreenPresentationStyle
  ) {
    self.identifier = identifier
    self.presentationStyle = presentationStyle
  }
}
