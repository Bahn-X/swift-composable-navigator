// MARK: - Stub
public extension Navigator {
  static func mock(
    navigationTree: @escaping () -> NavigationTreeUpdate = {
      fatalError("navigationTree() unimplemented in stub. Make sure to wrap your application in a Root view or inject Navigator via .environment(\\.navigator, navigator) for testing purposes.")
    },
    go: @escaping (AnyScreen, ScreenID, Bool) -> Void = { _, _, _ in
      fatalError("go(to:) unimplemented in stub. Make sure to wrap your application in a Root view or inject Navigator via .environment(\\.navigator, navigator) for testing purposes.")
    },
    goToOnScreen: @escaping (AnyScreen, AnyScreen, Bool) -> Void = { _, _, _ in
      fatalError("go(to:, on screen:) unimplemented in stub. Make sure to wrap your application in a Root view or inject Navigator via .environment(\\.navigator, navigator) for testing purposes.")
    },
    goToPath: @escaping (ActiveNavigationPath, ScreenID) -> Void = { _, _ in
      fatalError("goTo(path:, to:) unimplemented in stub. Make sure to wrap your application in a Root view or inject Navigator via .environment(\\.navigator, navigator) for testing purposes.")
    },
    goToPathOnScreen: @escaping (ActiveNavigationPath, AnyScreen) -> Void = { _, _ in
      fatalError("goTo(path:, to:) unimplemented in stub. Make sure to wrap your application in a Root view or inject Navigator via .environment(\\.navigator, navigator) for testing purposes.")
    },
    goBack: @escaping (AnyScreen) -> Void = { _ in
      fatalError("goBack(to:) unimplemented in stub. Make sure to wrap your application in a Root view or inject Navigator via .environment(\\.navigator, navigator) for testing purposes.")
    },
    goBackToID: @escaping (ScreenID) -> Void = { _ in
      fatalError("goBack(to:) unimplemented in stub. Make sure to wrap your application in a Root view or inject Navigator via .environment(\\.navigator, navigator) for testing purposes.")
    },
    replace: @escaping (ActiveNavigationPath) -> Void = { _ in
      fatalError("replace(path:) unimplemented in stub. Make sure to wrap your application in a Root view or inject Navigator via .environment(\\.navigator, navigator) for testing purposes.")
    },
    dismiss: @escaping (ScreenID) -> Void = { _ in
      fatalError("dismiss(id:) unimplemented in stub. Make sure to wrap your application in a Root view or inject Navigator via .environment(\\.navigator, navigator) for testing purposes.")
    },
    dismissScreen: @escaping (AnyScreen) -> Void = { _ in
      fatalError("dismiss(screen:) unimplemented in stub. Make sure to wrap your application in a Root view or inject Navigator via .environment(\\.navigator, navigator) for testing purposes.")
    },
    dismissSuccessor: @escaping (ScreenID) -> Void = { _ in
      fatalError("dismissSuccessor(of:) unimplemented in stub. Make sure to wrap your application in a Root view or inject Navigator via .environment(\\.navigator, navigator) for testing purposes.")
    },
    dismissSuccessorOfScreen: @escaping (AnyScreen) -> Void = { _ in
      fatalError("dismissSuccessor(of:) unimplemented in stub. Make sure to wrap your application in a Root view or inject Navigator via .environment(\\.navigator, navigator) for testing purposes.")
    },
    replaceContent: @escaping (ScreenID, AnyScreen) -> Void = { _, _ in
      fatalError("replaceContent(of id:, with:) unimplemented in stub. Make sure to wrap your application in a Root view or inject Navigator via .environment(\\.navigator, navigator) for testing purposes.")
    },
    replaceScreen: @escaping (AnyScreen, AnyScreen) -> Void = { _, _ in
      fatalError("replace(screen:, with:) unimplemented in stub. Make sure to wrap your application in a Root view or inject Navigator via .environment(\\.navigator, navigator) for testing purposes.")
    },
    didAppear: @escaping (ScreenID) -> Void = { _ in
      fatalError("didAppear(id:) unimplemented in stub. Make sure to wrap your application in a Root view or inject Navigator via .environment(\\.navigator, navigator) for testing purposes.")
    },
    activate: @escaping (AnyActivatable) -> Void = { _ in
      fatalError("activate(_ activatable:) unimplemented in stub. Make sure to wrap your application in a Root view or inject Navigator via .environment(\\.navigator, navigator) for testing purposes.")
    }
  ) -> Navigator {
    Navigator(
      navigationTree: navigationTree,
      go: go,
      goToOnScreen: goToOnScreen,
      goToPath: goToPath,
      goToPathOnScreen: goToPathOnScreen,
      goBack: goBack,
      goBackToID: goBackToID,
      replace: replace,
      dismiss: dismiss,
      dismissScreen: dismissScreen,
      dismissSuccessor: dismissSuccessor,
      dismissSuccessorOfScreen: dismissSuccessorOfScreen,
      replaceContent: replaceContent,
      replaceScreen: replaceScreen,
      didAppear: didAppear,
      activate: activate
    )
  }

  static func mock(
    path: @escaping () -> NavigationTreeUpdate = {
      fatalError("path() unimplemented in stub. Make sure to wrap your application in a Root view or inject Navigator via .environment(\\.navigator, navigator) for testing purposes.")
    },
    goToInvoked: @escaping (Navigator.GoToInvocation) -> Void = { _ in
      fatalError("go(to screen:) unimplemented in stub. Make sure to wrap your application in a Root view or inject Navigator via .environment(\\.navigator, navigator) for testing purposes.")
    },
    goToPathInvoked: @escaping (Navigator.GoToPathInvocation) -> Void = { _ in
      fatalError("go(to path:) unimplemented in stub. Make sure to wrap your application in a Root view or inject Navigator via .environment(\\.navigator, navigator) for testing purposes.")
    },
    goBackToInvoked: @escaping (Navigator.GoBackToInvocation) -> Void = { _ in
      fatalError("goBack(to:) unimplemented in stub. Make sure to wrap your application in a Root view or inject Navigator via .environment(\\.navigator, navigator) for testing purposes.")
    },
    replacePathInvoked: @escaping (Navigator.ReplacePathInvocation) -> Void = { _ in
      fatalError("replace(path:) unimplemented in stub. Make sure to wrap your application in a Root view or inject Navigator via .environment(\\.navigator, navigator) for testing purposes.")
    },
    dismissInvoked: @escaping (Navigator.DismissInvocation) -> Void = { _ in
      fatalError("dismiss(id:) unimplemented in stub. Make sure to wrap your application in a Root view or inject Navigator via .environment(\\.navigator, navigator) for testing purposes.")
    },
    dismissSuccessorInvoked: @escaping (Navigator.DismissSuccessorInvocation) -> Void = { _ in
      fatalError("dismissSuccessor(of:) unimplemented in stub. Make sure to wrap your application in a Root view or inject Navigator via .environment(\\.navigator, navigator) for testing purposes.")
    },
    replaceContentInvoked: @escaping (Navigator.ReplaceContentInvocation) -> Void = { _ in
      fatalError("replaceContent(of id:, with:) unimplemented in stub. Make sure to wrap your application in a Root view or inject Navigator via .environment(\\.navigator, navigator) for testing purposes.")
    },
    replaceScreenInvoked: @escaping (Navigator.ReplaceScreenInvocation) -> Void = { _ in
      fatalError("replace(screen:, with:) unimplemented in stub. Make sure to wrap your application in a Root view or inject Navigator via .environment(\\.navigator, navigator) for testing purposes.")
    },
    didAppearInvoked: @escaping (Navigator.DidAppearInvocation) -> Void = { _ in
      fatalError("didAppear(id:) unimplemented in stub. Make sure to wrap your application in a Root view or inject Navigator via .environment(\\.navigator, navigator) for testing purposes.")
    },
    activateInvoked: @escaping (Navigator.ActivateInvocation) -> Void = { _ in
      fatalError("activate(_ activatable:) unimplemented in stub. Make sure to wrap your application in a Root view or inject Navigator via .environment(\\.navigator, navigator) for testing purposes.")
    }
  ) -> Navigator {
    Navigator.mock(
      navigationTree: path,
      go: { screen, id, forceNavigation in
        goToInvoked(
          Navigator.GoToInvocation(
            screen: screen,
            on: .id(id),
            forceNavigation: forceNavigation
          )
        )
      },
      goToOnScreen: { screen, parent, forceNavigation in
        goToInvoked(
          Navigator.GoToInvocation(
            screen: screen,
            on: .screen(parent),
            forceNavigation: forceNavigation
          )
        )
      },
      goToPath: { newPath, id in
        goToPathInvoked(Navigator.GoToPathInvocation(path: newPath, on: .id(id)))
      },
      goToPathOnScreen: { newPath, parent in
        goToPathInvoked(Navigator.GoToPathInvocation(path: newPath, on: .screen(parent)))
      },
      goBack: { screen in
        goBackToInvoked(Navigator.GoBackToInvocation(to: .screen(screen)))
      },
      goBackToID: { id in
        goBackToInvoked(Navigator.GoBackToInvocation(to: .id(id)))
      },
      replace: { newPath in
        replacePathInvoked(Navigator.ReplacePathInvocation(path: newPath))
      },
      dismiss: { id in
        dismissInvoked(Navigator.DismissInvocation(identifier: .id(id)))
      },
      dismissScreen: { screen in
        dismissInvoked(Navigator.DismissInvocation(identifier: .screen(screen)))
      },
      dismissSuccessor: { id in
        dismissSuccessorInvoked(Navigator.DismissSuccessorInvocation(identifier: .id(id)))
      },
      dismissSuccessorOfScreen: { screen in
        dismissSuccessorInvoked(Navigator.DismissSuccessorInvocation(identifier: .screen(screen)))
      },
      replaceContent: { id, newContent in
        replaceContentInvoked(Navigator.ReplaceContentInvocation(id: id, newContent: newContent))
      },
      replaceScreen: { oldContent, newContent in
        replaceScreenInvoked(Navigator.ReplaceScreenInvocation(oldContent: oldContent, newContent: newContent))
      },
      didAppear: { id in
        didAppearInvoked(Navigator.DidAppearInvocation(id: id))
      },
      activate: { activatable in
        activateInvoked(Navigator.ActivateInvocation(activatable: activatable))
      }
    )
  }

  static let stub = Navigator.mock()
}

public extension Navigator {
  enum NavigationIdentifier: Hashable {
    case id(ScreenID)
    case screen(AnyScreen)
  }

  /// Testing helper
  ///
  /// # Example
  /// ```swift
  /// var invocations = [Navigator.GoToInvocation]()
  /// let expectectedInvocations = [
  ///   Navigator.GoToInvocation(screen: testScreen.eraseToAnyScreen(), on: .screen(parent.eraseToAnyScreen()))
  /// ]
  ///
  /// let navigator = Navigator.mock(
  ///   path: { self.path },
  ///   goTo: { screen, id in
  ///     invocations.append(.init(screen: screen, on: id))
  ///   }
  /// )
  ///
  /// navigator.go(to: testScreen, on: parent) // invoke code that invokes go(to:, on id:)
  ///
  /// XCTAssertEqual(expectectedInvocations, invocations)
  ///```
  struct GoToInvocation: Hashable {
    let screen: AnyScreen
    let on: NavigationIdentifier
    let forceNavigation: Bool

    init(
      screen: AnyScreen,
      on: NavigationIdentifier,
      forceNavigation: Bool = false
    ) {
      self.screen = screen
      self.on = on
      self.forceNavigation = forceNavigation
    }
  }

  /// Testing helper
  ///
  /// # Example
  /// ```swift
  /// var invocations = [Navigator.GoToPathInvocation]()
  /// let expectectedInvocations = [
  ///   Navigator.GoToPathInvocation(path: [testScreen.eraseToAnyScreen()], on: .screen(parent.eraseToAnyScreen()))
  /// ]
  ///
  /// let navigator = Navigator.mock(
  ///   path: { self.path },
  ///   goToPath: { path, id in
  ///     invocations.append(.init(path: path, id: id))
  ///   }
  /// )
  ///
  /// sut.go(to: [testScreen.eraseToAnyScreen()], on: parent) // invoke code that invokes go(to path:, on id:)
  ///
  /// XCTAssertEqual(expectectedInvocations, invocations)
  ///```
  struct GoToPathInvocation: Hashable {
    let path: ActiveNavigationPath
    let on: NavigationIdentifier
  }

  /// Testing helper
  ///
  /// # Example
  /// ```swift
  ///  var invocations = [Navigator.ReplacePathInvocation]()
  ///  let expectectedInvocations = [
  ///    Navigator.ReplacePathInvocation(path: [testScreen.eraseToAnyScreen()])
  ///  ]
  ///
  ///  let sut = Navigator.mock(
  ///    path: { self.path },
  ///    replacePath: { path in
  ///      invocations.append(.init(path: path))
  ///    }
  ///  )
  ///
  ///  sut.replace(path: [testScreen.eraseToAnyScreen()]) // invoke code that invokes goBack(to:)
  ///
  ///  XCTAssertEqual(expectectedInvocations, invocations)
  struct ReplacePathInvocation: Hashable {
    let path: ActiveNavigationPath
  }

  /// Testing helper
  ///
  /// # Example
  /// ```swift
  ///  var invocations = [Navigator.GoBackToInvocation]()
  ///  let expectectedInvocations = [
  ///    Navigator.GoBackToInvocation(id: .screen(parent.eraseToAnyScreen()))
  ///  ]
  ///
  ///  let sut = Navigator.mock(
  ///    path: { self.path },
  ///    goBack: { screen in
  ///      invocations.append(.init(id: id))
  ///    }
  ///  )
  ///
  ///  sut.goBack(to: parent) // invoke code that invokes goBack(to:)
  ///
  ///  XCTAssertEqual(expectectedInvocations, invocations)
  ///```
  struct GoBackToInvocation: Hashable {
    let to: NavigationIdentifier
  }

  /// Testing helper
  ///
  /// # Example
  /// ```swift
  ///  var invocations = [Navigator.DismissInvocation]()
  ///  let expectectedInvocations = [
  ///    Navigator.DismissInvocation(identifier: .id(expectedID))
  ///  ]
  ///
  ///  let sut = Navigator.mock(
  ///    path: { self.path },
  ///    dismiss: { id in
  ///      invocations.append(.init(id: id))
  ///    }
  ///  )
  ///
  ///  sut.dismiss(id: expectedID) // invoke code that invokes dismiss(id:)
  ///
  ///  XCTAssertEqual(expectectedInvocations, invocations)
  ///```
  struct DismissInvocation: Hashable {
    let identifier: NavigationIdentifier
  }

  /// Testing helper
  ///
  /// # Example
  /// ```swift
  ///  var invocations = [Navigator.DismissInvocation]()
  ///  let expectectedInvocations = [
  ///    Navigator.DismissInvocation(id: .id(expectedID))
  ///  ]
  ///
  ///  let sut = Navigator.mock(
  ///    path: { self.path },
  ///    dismissSuccessor: { id in
  ///      invocations.append(.init(id: id))
  ///    }
  ///  )
  ///
  ///  sut.dismissSuccessor(of: expectedID) // invoke code that invokes dismissSuccessor(of:)
  ///
  ///  XCTAssertEqual(expectectedInvocations, invocations)
  ///```
  typealias DismissSuccessorInvocation = DismissInvocation

  /// Testing helper
  ///
  /// # Example
  /// ```swift
  ///  var invocations = [Navigator.ReplaceScreenInvocation]()
  ///  let expectectedInvocations = [
  ///    Navigator.ReplaceScreenInvocation(
  ///     oldContent: oldContent.eraseToAnyScreen(),
  ///     newContent: expectedContent.eraseToAnyScreen()
  ///    )
  ///  ]
  ///
  ///  let sut = Navigator.mock(
  ///    path: { self.path },
  ///    didAppear: { id in
  ///      invocations.append(.init(id: id))
  ///    }
  ///  )
  ///
  ///  sut.replace(screen: oldContent, with: expectedContent) // invoke code that invokes dismissSuccessor(of:)
  ///
  ///  XCTAssertEqual(expectectedInvocations, invocations)
  ///```
  struct ReplaceScreenInvocation: Hashable {
    let oldContent: AnyScreen
    let newContent: AnyScreen
  }

  /// Testing helper
  ///
  /// # Example
  /// ```swift
  ///  var invocations = [Navigator.ReplaceContentInvocation]()
  ///  let expectectedInvocations = [
  ///    Navigator.ReplaceContentInvocation(
  ///     id: expectedID,
  ///     newContent: expectedContent.eraseToAnyScreen()
  ///    )
  ///  ]
  ///
  ///  let sut = Navigator.mock(
  ///    path: { self.path },
  ///    didAppear: { id in
  ///      invocations.append(.init(id: id))
  ///    }
  ///  )
  ///
  ///  sut.didAppear(id: expectedID) // invoke code that invokes dismissSuccessor(of:)
  ///
  ///  XCTAssertEqual(expectectedInvocations, invocations)
  ///```
  struct ReplaceContentInvocation: Hashable {
    let id: ScreenID
    let newContent: AnyScreen
  }

  /// Testing helper
  ///
  /// # Example
  /// ```swift
  ///  var invocations = [Navigator.DidAppearInvocation]()
  ///  let expectectedInvocations = [
  ///    Navigator.DidAppearInvocation(id: expectedID)
  ///  ]
  ///
  ///  let sut = Navigator.mock(
  ///    path: { self.path },
  ///    didAppear: { id in
  ///      invocations.append(.init(id: id))
  ///    }
  ///  )
  ///
  ///  sut.didAppear(id: expectedID) // invoke code that invokes dismissSuccessor(of:)
  ///
  ///  XCTAssertEqual(expectectedInvocations, invocations)
  ///```
  struct DidAppearInvocation: Hashable {
    let id: ScreenID
  }

  /// Testing helper
  ///
  /// # Example
  /// ```swift
  ///  var invocations = [Navigator.ActivateInvocation]()
  ///  let expectectedInvocations = [
  ///    Navigator.ActivateInvocation(activatable: expectedActivatable)
  ///  ]
  ///
  ///  let sut = Navigator.mock(
  ///    path: { self.path },
  ///    didAppear: { activatable in
  ///      invocations.append(.init(activatable: activatable))
  ///    }
  ///  )
  ///
  ///  sut.activate(id: expectedActivatable) // invoke code that invokes dismissSuccessor(of:)
  ///
  ///  XCTAssertEqual(expectectedInvocations, invocations)
  ///```
  struct ActivateInvocation: Hashable {
    let activatable: AnyActivatable
  }
}
