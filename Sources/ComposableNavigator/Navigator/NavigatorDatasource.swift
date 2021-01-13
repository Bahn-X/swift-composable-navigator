import Combine
import Foundation

public protocol NavigatorDatasource: ObservableObject {
  var path: [IdentifiedScreen] { get }
}

public extension Navigator {
  class Datasource: NavigatorDatasource {
    @Published public var path: [IdentifiedScreen]

    let screenID: () -> ScreenID

    public convenience init<S: Screen>(
      root: S,
      screenID: @escaping () -> ScreenID = ScreenID.init
    ) {
      self.init(
        path: [
          IdentifiedScreen(id: .root, content: root, hasAppeared: false)
        ],
        screenID: screenID
      )
    }

    init(
      path: [IdentifiedScreen],
      screenID: @escaping () -> ScreenID = ScreenID.init
    ) {
      self.path = path
      self.screenID = screenID
    }

    func go(to successor: AnyScreen, on id: ScreenID) -> Void {
      guard let index = path.firstIndex(where: { $0.id == id }) else {
        return
      }

      path = path.prefix(through: index) + [
        IdentifiedScreen(
          id: screenID(),
          content: successor,
          hasAppeared: false
        )
      ]
    }

    func goBack(to predecessor: AnyScreen) -> Void {
      guard let index = path.lastIndex(
        where: { $0.content == predecessor }
      ) else {
        return
      }

      path = Array(path.prefix(through: index))
    }

    func replace(path: [AnyScreen]) -> Void {
      let newPath = path.enumerated().map { (index, element) -> IdentifiedScreen in
        let id = index == 0 ? ScreenID.root: screenID()
        return IdentifiedScreen(id: id, content: element, hasAppeared: false)
      }

      self.path = newPath
    }

    func dismiss(id: ScreenID) -> Void {
      guard id != path.first?.id, let index = path.firstIndex(where: { $0.id == id }) else {
        return
      }
      path = Array(path.prefix(upTo: index))
    }

    func dismissSuccessor(of id: ScreenID) -> Void {
      guard let index = path.firstIndex(where: { $0.id == id }) else {
        return
      }

      path = Array(path.prefix(through: index))
    }

    func didAppear(id: ScreenID) -> Void {
      path = path.map { pathElement in
        guard pathElement.id == id else { return pathElement }
        return IdentifiedScreen(
          id: pathElement.id,
          content: pathElement.content,
          hasAppeared: true
        )
      }
    }
  }
}
