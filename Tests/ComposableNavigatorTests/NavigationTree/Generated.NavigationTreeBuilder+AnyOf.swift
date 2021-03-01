// AUTO-GENERATED: Do not edit
import ComposableNavigator
import SnapshotTesting
import SwiftUI
import XCTest

final class PathBuilder_AnyOfTests: XCTestCase {
  struct NonMatching: Screen {
    let presentationStyle: ScreenPresentationStyle = .push
  }

  struct AScreen: Screen {
    let presentationStyle: ScreenPresentationStyle = .push
  }

  struct BScreen: Screen {
    let presentationStyle: ScreenPresentationStyle = .push
  }

  struct CScreen: Screen {
    let presentationStyle: ScreenPresentationStyle = .push
  }

  struct DScreen: Screen {
    let presentationStyle: ScreenPresentationStyle = .push
  }

  struct EScreen: Screen {
    let presentationStyle: ScreenPresentationStyle = .push
  }

  struct FScreen: Screen {
    let presentationStyle: ScreenPresentationStyle = .push
  }

  struct GScreen: Screen {
    let presentationStyle: ScreenPresentationStyle = .push
  }

  struct HScreen: Screen {
    let presentationStyle: ScreenPresentationStyle = .push
  }

  struct IScreen: Screen {
    let presentationStyle: ScreenPresentationStyle = .push
  }

  struct JScreen: Screen {
    let presentationStyle: ScreenPresentationStyle = .push
  }

  func test_2_buildsPath() {
    var path = PathComponentUpdate.empty

    let sut = EmptyNavigationTree().AnyOf {
      PathBuilders.screen(
        AScreen.self,
        content: { Text("A") }
      )
      PathBuilders.screen(
        BScreen.self,
        content: { Text("B") }
      )
    }

    // MARK: aScreen
    let aScreen = AScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: aScreen,
        hasAppeared: false
      )
    )

    let aBuiltView = sut.build(path: path)

    guard case .a = aBuiltView else {
      XCTFail("Expected \(AScreen.self) to build Either.a. Got \(aBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: aBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: bScreen
    let bScreen = BScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: bScreen,
        hasAppeared: false
      )
    )

    let bBuiltView = sut.build(path: path)

    guard case .b = bBuiltView else {
      XCTFail("Expected \(BScreen.self) to build Either.b. Got \(bBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: bBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: NonMatching(),
        hasAppeared: false
      )
    )

    let nonMatchingBuilt = sut.build(
      path: path
    )

    XCTAssertNil(nonMatchingBuilt)
  }

  func test_3_buildsPath() {
    var path = PathComponentUpdate.empty

    let sut = EmptyNavigationTree().AnyOf {
      PathBuilders.screen(
        AScreen.self,
        content: { Text("A") }
      )
      PathBuilders.screen(
        BScreen.self,
        content: { Text("B") }
      )
      PathBuilders.screen(
        CScreen.self,
        content: { Text("C") }
      )
    }

    // MARK: aScreen
    let aScreen = AScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: aScreen,
        hasAppeared: false
      )
    )

    let aBuiltView = sut.build(path: path)

    guard case .a = aBuiltView else {
      XCTFail("Expected \(AScreen.self) to build Either.a. Got \(aBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: aBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: bScreen
    let bScreen = BScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: bScreen,
        hasAppeared: false
      )
    )

    let bBuiltView = sut.build(path: path)

    guard case .b = bBuiltView else {
      XCTFail("Expected \(BScreen.self) to build Either.b. Got \(bBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: bBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: cScreen
    let cScreen = CScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: cScreen,
        hasAppeared: false
      )
    )

    let cBuiltView = sut.build(path: path)

    guard case .c = cBuiltView else {
      XCTFail("Expected \(CScreen.self) to build Either.c. Got \(cBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: cBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: NonMatching(),
        hasAppeared: false
      )
    )

    let nonMatchingBuilt = sut.build(
      path: path
    )

    XCTAssertNil(nonMatchingBuilt)
  }

  func test_4_buildsPath() {
    var path = PathComponentUpdate.empty

    let sut = EmptyNavigationTree().AnyOf {
      PathBuilders.screen(
        AScreen.self,
        content: { Text("A") }
      )
      PathBuilders.screen(
        BScreen.self,
        content: { Text("B") }
      )
      PathBuilders.screen(
        CScreen.self,
        content: { Text("C") }
      )
      PathBuilders.screen(
        DScreen.self,
        content: { Text("D") }
      )
    }

    // MARK: aScreen
    let aScreen = AScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: aScreen,
        hasAppeared: false
      )
    )

    let aBuiltView = sut.build(path: path)

    guard case .a = aBuiltView else {
      XCTFail("Expected \(AScreen.self) to build Either.a. Got \(aBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: aBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: bScreen
    let bScreen = BScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: bScreen,
        hasAppeared: false
      )
    )

    let bBuiltView = sut.build(path: path)

    guard case .b = bBuiltView else {
      XCTFail("Expected \(BScreen.self) to build Either.b. Got \(bBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: bBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: cScreen
    let cScreen = CScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: cScreen,
        hasAppeared: false
      )
    )

    let cBuiltView = sut.build(path: path)

    guard case .c = cBuiltView else {
      XCTFail("Expected \(CScreen.self) to build Either.c. Got \(cBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: cBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: dScreen
    let dScreen = DScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: dScreen,
        hasAppeared: false
      )
    )

    let dBuiltView = sut.build(path: path)

    guard case .d = dBuiltView else {
      XCTFail("Expected \(DScreen.self) to build Either.d. Got \(dBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: dBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: NonMatching(),
        hasAppeared: false
      )
    )

    let nonMatchingBuilt = sut.build(
      path: path
    )

    XCTAssertNil(nonMatchingBuilt)
  }

  func test_5_buildsPath() {
    var path = PathComponentUpdate.empty

    let sut = EmptyNavigationTree().AnyOf {
      PathBuilders.screen(
        AScreen.self,
        content: { Text("A") }
      )
      PathBuilders.screen(
        BScreen.self,
        content: { Text("B") }
      )
      PathBuilders.screen(
        CScreen.self,
        content: { Text("C") }
      )
      PathBuilders.screen(
        DScreen.self,
        content: { Text("D") }
      )
      PathBuilders.screen(
        EScreen.self,
        content: { Text("E") }
      )
    }

    // MARK: aScreen
    let aScreen = AScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: aScreen,
        hasAppeared: false
      )
    )

    let aBuiltView = sut.build(path: path)

    guard case .a = aBuiltView else {
      XCTFail("Expected \(AScreen.self) to build Either.a. Got \(aBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: aBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: bScreen
    let bScreen = BScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: bScreen,
        hasAppeared: false
      )
    )

    let bBuiltView = sut.build(path: path)

    guard case .b = bBuiltView else {
      XCTFail("Expected \(BScreen.self) to build Either.b. Got \(bBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: bBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: cScreen
    let cScreen = CScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: cScreen,
        hasAppeared: false
      )
    )

    let cBuiltView = sut.build(path: path)

    guard case .c = cBuiltView else {
      XCTFail("Expected \(CScreen.self) to build Either.c. Got \(cBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: cBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: dScreen
    let dScreen = DScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: dScreen,
        hasAppeared: false
      )
    )

    let dBuiltView = sut.build(path: path)

    guard case .d = dBuiltView else {
      XCTFail("Expected \(DScreen.self) to build Either.d. Got \(dBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: dBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: eScreen
    let eScreen = EScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: eScreen,
        hasAppeared: false
      )
    )

    let eBuiltView = sut.build(path: path)

    guard case .e = eBuiltView else {
      XCTFail("Expected \(EScreen.self) to build Either.e. Got \(eBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: eBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: NonMatching(),
        hasAppeared: false
      )
    )

    let nonMatchingBuilt = sut.build(
      path: path
    )

    XCTAssertNil(nonMatchingBuilt)
  }

  func test_6_buildsPath() {
    var path = PathComponentUpdate.empty

    let sut = EmptyNavigationTree().AnyOf {
      PathBuilders.screen(
        AScreen.self,
        content: { Text("A") }
      )
      PathBuilders.screen(
        BScreen.self,
        content: { Text("B") }
      )
      PathBuilders.screen(
        CScreen.self,
        content: { Text("C") }
      )
      PathBuilders.screen(
        DScreen.self,
        content: { Text("D") }
      )
      PathBuilders.screen(
        EScreen.self,
        content: { Text("E") }
      )
      PathBuilders.screen(
        FScreen.self,
        content: { Text("F") }
      )
    }

    // MARK: aScreen
    let aScreen = AScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: aScreen,
        hasAppeared: false
      )
    )

    let aBuiltView = sut.build(path: path)

    guard case .a = aBuiltView else {
      XCTFail("Expected \(AScreen.self) to build Either.a. Got \(aBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: aBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: bScreen
    let bScreen = BScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: bScreen,
        hasAppeared: false
      )
    )

    let bBuiltView = sut.build(path: path)

    guard case .b = bBuiltView else {
      XCTFail("Expected \(BScreen.self) to build Either.b. Got \(bBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: bBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: cScreen
    let cScreen = CScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: cScreen,
        hasAppeared: false
      )
    )

    let cBuiltView = sut.build(path: path)

    guard case .c = cBuiltView else {
      XCTFail("Expected \(CScreen.self) to build Either.c. Got \(cBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: cBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: dScreen
    let dScreen = DScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: dScreen,
        hasAppeared: false
      )
    )

    let dBuiltView = sut.build(path: path)

    guard case .d = dBuiltView else {
      XCTFail("Expected \(DScreen.self) to build Either.d. Got \(dBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: dBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: eScreen
    let eScreen = EScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: eScreen,
        hasAppeared: false
      )
    )

    let eBuiltView = sut.build(path: path)

    guard case .e = eBuiltView else {
      XCTFail("Expected \(EScreen.self) to build Either.e. Got \(eBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: eBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: fScreen
    let fScreen = FScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: fScreen,
        hasAppeared: false
      )
    )

    let fBuiltView = sut.build(path: path)

    guard case .f = fBuiltView else {
      XCTFail("Expected \(FScreen.self) to build Either.f. Got \(fBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: fBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: NonMatching(),
        hasAppeared: false
      )
    )

    let nonMatchingBuilt = sut.build(
      path: path
    )

    XCTAssertNil(nonMatchingBuilt)
  }

  func test_7_buildsPath() {
    var path = PathComponentUpdate.empty

    let sut = EmptyNavigationTree().AnyOf {
      PathBuilders.screen(
        AScreen.self,
        content: { Text("A") }
      )
      PathBuilders.screen(
        BScreen.self,
        content: { Text("B") }
      )
      PathBuilders.screen(
        CScreen.self,
        content: { Text("C") }
      )
      PathBuilders.screen(
        DScreen.self,
        content: { Text("D") }
      )
      PathBuilders.screen(
        EScreen.self,
        content: { Text("E") }
      )
      PathBuilders.screen(
        FScreen.self,
        content: { Text("F") }
      )
      PathBuilders.screen(
        GScreen.self,
        content: { Text("G") }
      )
    }

    // MARK: aScreen
    let aScreen = AScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: aScreen,
        hasAppeared: false
      )
    )

    let aBuiltView = sut.build(path: path)

    guard case .a = aBuiltView else {
      XCTFail("Expected \(AScreen.self) to build Either.a. Got \(aBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: aBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: bScreen
    let bScreen = BScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: bScreen,
        hasAppeared: false
      )
    )

    let bBuiltView = sut.build(path: path)

    guard case .b = bBuiltView else {
      XCTFail("Expected \(BScreen.self) to build Either.b. Got \(bBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: bBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: cScreen
    let cScreen = CScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: cScreen,
        hasAppeared: false
      )
    )

    let cBuiltView = sut.build(path: path)

    guard case .c = cBuiltView else {
      XCTFail("Expected \(CScreen.self) to build Either.c. Got \(cBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: cBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: dScreen
    let dScreen = DScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: dScreen,
        hasAppeared: false
      )
    )

    let dBuiltView = sut.build(path: path)

    guard case .d = dBuiltView else {
      XCTFail("Expected \(DScreen.self) to build Either.d. Got \(dBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: dBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: eScreen
    let eScreen = EScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: eScreen,
        hasAppeared: false
      )
    )

    let eBuiltView = sut.build(path: path)

    guard case .e = eBuiltView else {
      XCTFail("Expected \(EScreen.self) to build Either.e. Got \(eBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: eBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: fScreen
    let fScreen = FScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: fScreen,
        hasAppeared: false
      )
    )

    let fBuiltView = sut.build(path: path)

    guard case .f = fBuiltView else {
      XCTFail("Expected \(FScreen.self) to build Either.f. Got \(fBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: fBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: gScreen
    let gScreen = GScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: gScreen,
        hasAppeared: false
      )
    )

    let gBuiltView = sut.build(path: path)

    guard case .g = gBuiltView else {
      XCTFail("Expected \(GScreen.self) to build Either.g. Got \(gBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: gBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: NonMatching(),
        hasAppeared: false
      )
    )

    let nonMatchingBuilt = sut.build(
      path: path
    )

    XCTAssertNil(nonMatchingBuilt)
  }

  func test_8_buildsPath() {
    var path = PathComponentUpdate.empty

    let sut = EmptyNavigationTree().AnyOf {
      PathBuilders.screen(
        AScreen.self,
        content: { Text("A") }
      )
      PathBuilders.screen(
        BScreen.self,
        content: { Text("B") }
      )
      PathBuilders.screen(
        CScreen.self,
        content: { Text("C") }
      )
      PathBuilders.screen(
        DScreen.self,
        content: { Text("D") }
      )
      PathBuilders.screen(
        EScreen.self,
        content: { Text("E") }
      )
      PathBuilders.screen(
        FScreen.self,
        content: { Text("F") }
      )
      PathBuilders.screen(
        GScreen.self,
        content: { Text("G") }
      )
      PathBuilders.screen(
        HScreen.self,
        content: { Text("H") }
      )
    }

    // MARK: aScreen
    let aScreen = AScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: aScreen,
        hasAppeared: false
      )
    )

    let aBuiltView = sut.build(path: path)

    guard case .a = aBuiltView else {
      XCTFail("Expected \(AScreen.self) to build Either.a. Got \(aBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: aBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: bScreen
    let bScreen = BScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: bScreen,
        hasAppeared: false
      )
    )

    let bBuiltView = sut.build(path: path)

    guard case .b = bBuiltView else {
      XCTFail("Expected \(BScreen.self) to build Either.b. Got \(bBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: bBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: cScreen
    let cScreen = CScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: cScreen,
        hasAppeared: false
      )
    )

    let cBuiltView = sut.build(path: path)

    guard case .c = cBuiltView else {
      XCTFail("Expected \(CScreen.self) to build Either.c. Got \(cBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: cBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: dScreen
    let dScreen = DScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: dScreen,
        hasAppeared: false
      )
    )

    let dBuiltView = sut.build(path: path)

    guard case .d = dBuiltView else {
      XCTFail("Expected \(DScreen.self) to build Either.d. Got \(dBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: dBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: eScreen
    let eScreen = EScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: eScreen,
        hasAppeared: false
      )
    )

    let eBuiltView = sut.build(path: path)

    guard case .e = eBuiltView else {
      XCTFail("Expected \(EScreen.self) to build Either.e. Got \(eBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: eBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: fScreen
    let fScreen = FScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: fScreen,
        hasAppeared: false
      )
    )

    let fBuiltView = sut.build(path: path)

    guard case .f = fBuiltView else {
      XCTFail("Expected \(FScreen.self) to build Either.f. Got \(fBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: fBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: gScreen
    let gScreen = GScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: gScreen,
        hasAppeared: false
      )
    )

    let gBuiltView = sut.build(path: path)

    guard case .g = gBuiltView else {
      XCTFail("Expected \(GScreen.self) to build Either.g. Got \(gBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: gBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: hScreen
    let hScreen = HScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: hScreen,
        hasAppeared: false
      )
    )

    let hBuiltView = sut.build(path: path)

    guard case .h = hBuiltView else {
      XCTFail("Expected \(HScreen.self) to build Either.h. Got \(hBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: hBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: NonMatching(),
        hasAppeared: false
      )
    )

    let nonMatchingBuilt = sut.build(
      path: path
    )

    XCTAssertNil(nonMatchingBuilt)
  }

  func test_9_buildsPath() {
    var path = PathComponentUpdate.empty

    let sut = EmptyNavigationTree().AnyOf {
      PathBuilders.screen(
        AScreen.self,
        content: { Text("A") }
      )
      PathBuilders.screen(
        BScreen.self,
        content: { Text("B") }
      )
      PathBuilders.screen(
        CScreen.self,
        content: { Text("C") }
      )
      PathBuilders.screen(
        DScreen.self,
        content: { Text("D") }
      )
      PathBuilders.screen(
        EScreen.self,
        content: { Text("E") }
      )
      PathBuilders.screen(
        FScreen.self,
        content: { Text("F") }
      )
      PathBuilders.screen(
        GScreen.self,
        content: { Text("G") }
      )
      PathBuilders.screen(
        HScreen.self,
        content: { Text("H") }
      )
      PathBuilders.screen(
        IScreen.self,
        content: { Text("I") }
      )
    }

    // MARK: aScreen
    let aScreen = AScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: aScreen,
        hasAppeared: false
      )
    )

    let aBuiltView = sut.build(path: path)

    guard case .a = aBuiltView else {
      XCTFail("Expected \(AScreen.self) to build Either.a. Got \(aBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: aBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: bScreen
    let bScreen = BScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: bScreen,
        hasAppeared: false
      )
    )

    let bBuiltView = sut.build(path: path)

    guard case .b = bBuiltView else {
      XCTFail("Expected \(BScreen.self) to build Either.b. Got \(bBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: bBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: cScreen
    let cScreen = CScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: cScreen,
        hasAppeared: false
      )
    )

    let cBuiltView = sut.build(path: path)

    guard case .c = cBuiltView else {
      XCTFail("Expected \(CScreen.self) to build Either.c. Got \(cBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: cBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: dScreen
    let dScreen = DScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: dScreen,
        hasAppeared: false
      )
    )

    let dBuiltView = sut.build(path: path)

    guard case .d = dBuiltView else {
      XCTFail("Expected \(DScreen.self) to build Either.d. Got \(dBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: dBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: eScreen
    let eScreen = EScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: eScreen,
        hasAppeared: false
      )
    )

    let eBuiltView = sut.build(path: path)

    guard case .e = eBuiltView else {
      XCTFail("Expected \(EScreen.self) to build Either.e. Got \(eBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: eBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: fScreen
    let fScreen = FScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: fScreen,
        hasAppeared: false
      )
    )

    let fBuiltView = sut.build(path: path)

    guard case .f = fBuiltView else {
      XCTFail("Expected \(FScreen.self) to build Either.f. Got \(fBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: fBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: gScreen
    let gScreen = GScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: gScreen,
        hasAppeared: false
      )
    )

    let gBuiltView = sut.build(path: path)

    guard case .g = gBuiltView else {
      XCTFail("Expected \(GScreen.self) to build Either.g. Got \(gBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: gBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: hScreen
    let hScreen = HScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: hScreen,
        hasAppeared: false
      )
    )

    let hBuiltView = sut.build(path: path)

    guard case .h = hBuiltView else {
      XCTFail("Expected \(HScreen.self) to build Either.h. Got \(hBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: hBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: iScreen
    let iScreen = IScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: iScreen,
        hasAppeared: false
      )
    )

    let iBuiltView = sut.build(path: path)

    guard case .i = iBuiltView else {
      XCTFail("Expected \(IScreen.self) to build Either.i. Got \(iBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: iBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: NonMatching(),
        hasAppeared: false
      )
    )

    let nonMatchingBuilt = sut.build(
      path: path
    )

    XCTAssertNil(nonMatchingBuilt)
  }

  func test_10_buildsPath() {
    var path = PathComponentUpdate.empty

    let sut = EmptyNavigationTree().AnyOf {
      PathBuilders.screen(
        AScreen.self,
        content: { Text("A") }
      )
      PathBuilders.screen(
        BScreen.self,
        content: { Text("B") }
      )
      PathBuilders.screen(
        CScreen.self,
        content: { Text("C") }
      )
      PathBuilders.screen(
        DScreen.self,
        content: { Text("D") }
      )
      PathBuilders.screen(
        EScreen.self,
        content: { Text("E") }
      )
      PathBuilders.screen(
        FScreen.self,
        content: { Text("F") }
      )
      PathBuilders.screen(
        GScreen.self,
        content: { Text("G") }
      )
      PathBuilders.screen(
        HScreen.self,
        content: { Text("H") }
      )
      PathBuilders.screen(
        IScreen.self,
        content: { Text("I") }
      )
      PathBuilders.screen(
        JScreen.self,
        content: { Text("J") }
      )
    }

    // MARK: aScreen
    let aScreen = AScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: aScreen,
        hasAppeared: false
      )
    )

    let aBuiltView = sut.build(path: path)

    guard case .a = aBuiltView else {
      XCTFail("Expected \(AScreen.self) to build Either.a. Got \(aBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: aBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: bScreen
    let bScreen = BScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: bScreen,
        hasAppeared: false
      )
    )

    let bBuiltView = sut.build(path: path)

    guard case .b = bBuiltView else {
      XCTFail("Expected \(BScreen.self) to build Either.b. Got \(bBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: bBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: cScreen
    let cScreen = CScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: cScreen,
        hasAppeared: false
      )
    )

    let cBuiltView = sut.build(path: path)

    guard case .c = cBuiltView else {
      XCTFail("Expected \(CScreen.self) to build Either.c. Got \(cBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: cBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: dScreen
    let dScreen = DScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: dScreen,
        hasAppeared: false
      )
    )

    let dBuiltView = sut.build(path: path)

    guard case .d = dBuiltView else {
      XCTFail("Expected \(DScreen.self) to build Either.d. Got \(dBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: dBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: eScreen
    let eScreen = EScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: eScreen,
        hasAppeared: false
      )
    )

    let eBuiltView = sut.build(path: path)

    guard case .e = eBuiltView else {
      XCTFail("Expected \(EScreen.self) to build Either.e. Got \(eBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: eBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: fScreen
    let fScreen = FScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: fScreen,
        hasAppeared: false
      )
    )

    let fBuiltView = sut.build(path: path)

    guard case .f = fBuiltView else {
      XCTFail("Expected \(FScreen.self) to build Either.f. Got \(fBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: fBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: gScreen
    let gScreen = GScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: gScreen,
        hasAppeared: false
      )
    )

    let gBuiltView = sut.build(path: path)

    guard case .g = gBuiltView else {
      XCTFail("Expected \(GScreen.self) to build Either.g. Got \(gBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: gBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: hScreen
    let hScreen = HScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: hScreen,
        hasAppeared: false
      )
    )

    let hBuiltView = sut.build(path: path)

    guard case .h = hBuiltView else {
      XCTFail("Expected \(HScreen.self) to build Either.h. Got \(hBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: hBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: iScreen
    let iScreen = IScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: iScreen,
        hasAppeared: false
      )
    )

    let iBuiltView = sut.build(path: path)

    guard case .i = iBuiltView else {
      XCTFail("Expected \(IScreen.self) to build Either.i. Got \(iBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: iBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    // MARK: jScreen
    let jScreen = JScreen()
    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: jScreen,
        hasAppeared: false
      )
    )

    let jBuiltView = sut.build(path: path)

    guard case .j = jBuiltView else {
      XCTFail("Expected \(JScreen.self) to build Either.j. Got \(jBuiltView.debugDescription).")
      return 
    }

    assertSnapshot(
      matching: jBuiltView
        .frame(width: 20, height: 20)
        .environmentObject(Navigator.Datasource(path: [])),
      as: .image
    )

    path = PathComponentUpdate(
      previous: nil,
      current: IdentifiedScreen(
        id: .root,
        content: NonMatching(),
        hasAppeared: false
      )
    )

    let nonMatchingBuilt = sut.build(
      path: path
    )

    XCTAssertNil(nonMatchingBuilt)
  }
}
