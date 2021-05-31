@testable import ComposableNavigator

extension Screen {
  func asPathElement(
    with id: ScreenID = .root,
    hasAppeared: Bool = false
  ) -> ActiveNavigationTreeElement {
    .screen(
      IdentifiedScreen(
        id: id,
        content: self,
        hasAppeared: hasAppeared
      )
    )
  }
}

extension IdentifiedScreen {
  func asPathElement() -> ActiveNavigationTreeElement {
    .screen(self)
  }
}

extension NavigationTreeUpdate {
  init(previous: [IdentifiedScreen], current: [IdentifiedScreen]) {
    self.init(
      previous: previous.map { $0.asPathElement() },
      current: current.map { $0.asPathElement() }
    )
  }
}
