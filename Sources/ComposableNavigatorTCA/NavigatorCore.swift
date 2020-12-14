import ComposableArchitecture
import ComposableNavigator

public struct NavigatorState: Equatable {
  var path: [IdentifiedScreen]

  public init<Root: Screen>(root: Root) {
    self.path = [
      IdentifiedScreen(id: .root, content: root)
    ]
  }

  public init(path: [IdentifiedScreen]) {
    self.path = path
  }

  func screen(with id: ScreenID) -> IdentifiedScreen? {
    path.first(where: { $0.id == id })
  }

  func suffix(from id: ScreenID) -> [IdentifiedScreen]? {
    guard let index = path.firstIndex(where: { $0.id == id }) else {
      return nil
    }

    return Array(path.suffix(from: index))
  }
}

public enum NavigatorAction: Equatable {
  /// Appends the provided route to the current path
  case go(to: AnyScreen, on: ScreenID)

  /// Searches for the first occurence of the provided route in the path and moves back to it
  case goBack(to: AnyScreen)

  /// Replaces the current navigation path with the provided path
  case replace(path: [AnyScreen])

  /// Dimisses the screen identified by the provided id. This leads either to a pop or sheet dismiss, depending on the screen presentation style
  case dismiss(ScreenID)
  case dismissSuccessor(of: ScreenID)

  case didAppear(ScreenID)
}

public struct NavigatorEnvironment {
  let screenID: () -> ScreenID

  public init(screenID: @escaping () -> ScreenID) {
    self.screenID = screenID
  }
}

public let navigatorReducer = Reducer<
  NavigatorState,
  NavigatorAction,
  NavigatorEnvironment
> { state, action, environment in
  switch action {
    case let .go(to: successor, on: id):
      guard let index = state.path.firstIndex(where: { $0.id == id }) else {
        return .none
      }

      state.path = state.path.prefix(upTo: index.advanced(by: 1)) + [
        IdentifiedScreen(id: environment.screenID(), content: successor)
      ]
      return .none

    case let .goBack(to: predecessor):
      let reversedPath = state.path.reversed()

      guard let index = reversedPath.firstIndex(
        where: { $0.content == predecessor }
      ) else {
        return .none
      }

      state.path = reversedPath
        .suffix(from: index)
        .reversed()
      return .none

    case let .replace(path: path):
      let newPath = path.enumerated().map { (index, element) -> IdentifiedScreen in
        let id = index == 0 ? ScreenID.root: environment.screenID()
        return IdentifiedScreen(id: id, content: element)
      }
      state.path = newPath
      return .none

    case let .dismiss(id):
      guard id != state.path.first?.id, let index = state.path.firstIndex(where: { $0.id == id }) else {
        return .none
      }
      state.path = Array(state.path.prefix(upTo: index))
      return .none

    case let .dismissSuccessor(of: id):
      guard let index = state.path.firstIndex(where: { $0.id == id }) else {
        return .none
      }
      state.path = Array(state.path.prefix(upTo: index.advanced(by: 1)))
      return .none

    case let .didAppear(id):
      guard let index = state.path.firstIndex(where: { $0.id == id }) else {
        return .none
      }
      state.path[index].hasAppeared = true
      return .none
  }
}
