import Foundation
import ComposableArchitecture
import SwiftUI

public struct Navigator: View {
  public typealias DataSource = Store<NavigatorState, NavigatorAction>

  private let _route: (NavigatorAction) -> Void
  private let _buildPath: ([IdentifiedScreen]) -> Routed?
  private let _content: () -> Root
  private let _lateInit: (DataSource) -> Navigator

  init(
    route: @escaping (NavigatorAction) -> Void,
    content: Root
  ) {
    self._route = route
    self._content = { content }

    self._buildPath = { _ in
      fatalError("buildPath unimplemented. Root navigators do not build paths.")
    }

    self._lateInit = { _ in
      fatalError("late init unimplemented. Root navigator cannot be late initialised.")
    }
  }

  public init(
    buildPath: @escaping ([IdentifiedScreen]) -> Routed?
  ) {
    self._route = { _ in
      fatalError("route unimplemented. Wrap your Navigator in a Root navigator.")
    }

    self._content = {
      fatalError("content unimplemented. Wrap your Navigator in a Root navigator.")
    }

    self._buildPath = buildPath

    self._lateInit = { _ in
      fatalError("unexpected late init call. Did you try late initialising an already intialised navigator?")
    }
  }

  init(lateInit: @escaping (DataSource) -> Navigator) {
    self._lateInit = lateInit

    self._route = { _ in
      fatalError("route unimplemented. Wrap your Navigator in a Root navigator.")
    }

    self._content = {
      fatalError("content unimplemented. Wrap your Navigator in a Root navigator.")
    }

    self._buildPath = { _ in
      fatalError("buildPath unimplemented. Wrap your Navigator in a Root navigator.")
    }
  }

  public func route(_ action: NavigatorAction) -> Void {
    _route(action)
  }

  public var body: some View {
    _content()
  }
    
  func build(path: [IdentifiedScreen]) -> Routed? {
    return _buildPath(path)
  }

  func lateInit(dataSource: DataSource) -> Navigator {
    _lateInit(dataSource)
  }
}
