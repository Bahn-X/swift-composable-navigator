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
    let aBuiltView = sut.build(pathElement: AScreen().asPathElement())

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
    let bBuiltView = sut.build(pathElement: BScreen().asPathElement())

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

    let nonMatchingBuilt = sut.build(pathElement: NonMatching().asPathElement())

    XCTAssertNil(nonMatchingBuilt)
  }

  func test_3_buildsPath() {
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
    let aBuiltView = sut.build(pathElement: AScreen().asPathElement())

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
    let bBuiltView = sut.build(pathElement: BScreen().asPathElement())

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
    let cBuiltView = sut.build(pathElement: CScreen().asPathElement())

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

    let nonMatchingBuilt = sut.build(pathElement: NonMatching().asPathElement())

    XCTAssertNil(nonMatchingBuilt)
  }

  func test_4_buildsPath() {
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
    let aBuiltView = sut.build(pathElement: AScreen().asPathElement())

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
    let bBuiltView = sut.build(pathElement: BScreen().asPathElement())

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
    let cBuiltView = sut.build(pathElement: CScreen().asPathElement())

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
    let dBuiltView = sut.build(pathElement: DScreen().asPathElement())

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

    let nonMatchingBuilt = sut.build(pathElement: NonMatching().asPathElement())

    XCTAssertNil(nonMatchingBuilt)
  }

  func test_5_buildsPath() {
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
    let aBuiltView = sut.build(pathElement: AScreen().asPathElement())

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
    let bBuiltView = sut.build(pathElement: BScreen().asPathElement())

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
    let cBuiltView = sut.build(pathElement: CScreen().asPathElement())

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
    let dBuiltView = sut.build(pathElement: DScreen().asPathElement())

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
    let eBuiltView = sut.build(pathElement: EScreen().asPathElement())

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

    let nonMatchingBuilt = sut.build(pathElement: NonMatching().asPathElement())

    XCTAssertNil(nonMatchingBuilt)
  }

  func test_6_buildsPath() {
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
    let aBuiltView = sut.build(pathElement: AScreen().asPathElement())

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
    let bBuiltView = sut.build(pathElement: BScreen().asPathElement())

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
    let cBuiltView = sut.build(pathElement: CScreen().asPathElement())

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
    let dBuiltView = sut.build(pathElement: DScreen().asPathElement())

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
    let eBuiltView = sut.build(pathElement: EScreen().asPathElement())

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
    let fBuiltView = sut.build(pathElement: FScreen().asPathElement())

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

    let nonMatchingBuilt = sut.build(pathElement: NonMatching().asPathElement())

    XCTAssertNil(nonMatchingBuilt)
  }

  func test_7_buildsPath() {
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
    let aBuiltView = sut.build(pathElement: AScreen().asPathElement())

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
    let bBuiltView = sut.build(pathElement: BScreen().asPathElement())

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
    let cBuiltView = sut.build(pathElement: CScreen().asPathElement())

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
    let dBuiltView = sut.build(pathElement: DScreen().asPathElement())

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
    let eBuiltView = sut.build(pathElement: EScreen().asPathElement())

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
    let fBuiltView = sut.build(pathElement: FScreen().asPathElement())

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
    let gBuiltView = sut.build(pathElement: GScreen().asPathElement())

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

    let nonMatchingBuilt = sut.build(pathElement: NonMatching().asPathElement())

    XCTAssertNil(nonMatchingBuilt)
  }

  func test_8_buildsPath() {
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
    let aBuiltView = sut.build(pathElement: AScreen().asPathElement())

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
    let bBuiltView = sut.build(pathElement: BScreen().asPathElement())

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
    let cBuiltView = sut.build(pathElement: CScreen().asPathElement())

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
    let dBuiltView = sut.build(pathElement: DScreen().asPathElement())

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
    let eBuiltView = sut.build(pathElement: EScreen().asPathElement())

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
    let fBuiltView = sut.build(pathElement: FScreen().asPathElement())

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
    let gBuiltView = sut.build(pathElement: GScreen().asPathElement())

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
    let hBuiltView = sut.build(pathElement: HScreen().asPathElement())

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

    let nonMatchingBuilt = sut.build(pathElement: NonMatching().asPathElement())

    XCTAssertNil(nonMatchingBuilt)
  }

  func test_9_buildsPath() {
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
    let aBuiltView = sut.build(pathElement: AScreen().asPathElement())

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
    let bBuiltView = sut.build(pathElement: BScreen().asPathElement())

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
    let cBuiltView = sut.build(pathElement: CScreen().asPathElement())

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
    let dBuiltView = sut.build(pathElement: DScreen().asPathElement())

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
    let eBuiltView = sut.build(pathElement: EScreen().asPathElement())

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
    let fBuiltView = sut.build(pathElement: FScreen().asPathElement())

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
    let gBuiltView = sut.build(pathElement: GScreen().asPathElement())

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
    let hBuiltView = sut.build(pathElement: HScreen().asPathElement())

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
    let iBuiltView = sut.build(pathElement: IScreen().asPathElement())

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

    let nonMatchingBuilt = sut.build(pathElement: NonMatching().asPathElement())

    XCTAssertNil(nonMatchingBuilt)
  }

  func test_10_buildsPath() {
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
    let aBuiltView = sut.build(pathElement: AScreen().asPathElement())

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
    let bBuiltView = sut.build(pathElement: BScreen().asPathElement())

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
    let cBuiltView = sut.build(pathElement: CScreen().asPathElement())

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
    let dBuiltView = sut.build(pathElement: DScreen().asPathElement())

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
    let eBuiltView = sut.build(pathElement: EScreen().asPathElement())

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
    let fBuiltView = sut.build(pathElement: FScreen().asPathElement())

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
    let gBuiltView = sut.build(pathElement: GScreen().asPathElement())

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
    let hBuiltView = sut.build(pathElement: HScreen().asPathElement())

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
    let iBuiltView = sut.build(pathElement: IScreen().asPathElement())

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
    let jBuiltView = sut.build(pathElement: JScreen().asPathElement())

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

    let nonMatchingBuilt = sut.build(pathElement: NonMatching().asPathElement())

    XCTAssertNil(nonMatchingBuilt)
  }
}
