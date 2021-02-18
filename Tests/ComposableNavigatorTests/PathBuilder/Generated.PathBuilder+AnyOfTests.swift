// AUTO-GENERATED: Do not edit
import ComposableNavigator
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
    var path = [IdentifiedScreen]()

    let sut = PathBuilders.anyOf(
      PathBuilders.screen(
        AScreen.self,
        content: { Text("A") }
      ),
      PathBuilders.screen(
        BScreen.self,
        content: { Text("B") }
      )
    )

    // MARK: aScreen
    let aScreen = AScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: aScreen,
        hasAppeared: false
      )
    ]

    let aBuiltView = sut.build(path: path)

    guard case .a = aBuiltView else {
      XCTFail("Expected \(AScreen.self) to build Either.a. Got \(aBuiltView.debugDescription).")
      return 
    }

    // MARK: bScreen
    let bScreen = BScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: bScreen,
        hasAppeared: false
      )
    ]

    let bBuiltView = sut.build(path: path)

    guard case .b = bBuiltView else {
      XCTFail("Expected \(BScreen.self) to build Either.b. Got \(bBuiltView.debugDescription).")
      return 
    }

    let nonMatchingBuilt = sut.build(
      path: [
        IdentifiedScreen(
          id: .root,
          content: NonMatching(),
          hasAppeared: false
        )
      ]
    )

    XCTAssertNil(nonMatchingBuilt)
  }

  func test_3_buildsPath() {
    var path = [IdentifiedScreen]()

    let sut = PathBuilders.anyOf(
      PathBuilders.screen(
        AScreen.self,
        content: { Text("A") }
      ),
      PathBuilders.screen(
        BScreen.self,
        content: { Text("B") }
      ),
      PathBuilders.screen(
        CScreen.self,
        content: { Text("C") }
      )
    )

    // MARK: aScreen
    let aScreen = AScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: aScreen,
        hasAppeared: false
      )
    ]

    let aBuiltView = sut.build(path: path)

    guard case .a = aBuiltView else {
      XCTFail("Expected \(AScreen.self) to build Either.a. Got \(aBuiltView.debugDescription).")
      return 
    }

    // MARK: bScreen
    let bScreen = BScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: bScreen,
        hasAppeared: false
      )
    ]

    let bBuiltView = sut.build(path: path)

    guard case .b = bBuiltView else {
      XCTFail("Expected \(BScreen.self) to build Either.b. Got \(bBuiltView.debugDescription).")
      return 
    }

    // MARK: cScreen
    let cScreen = CScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: cScreen,
        hasAppeared: false
      )
    ]

    let cBuiltView = sut.build(path: path)

    guard case .c = cBuiltView else {
      XCTFail("Expected \(CScreen.self) to build Either.c. Got \(cBuiltView.debugDescription).")
      return 
    }

    let nonMatchingBuilt = sut.build(
      path: [
        IdentifiedScreen(
          id: .root,
          content: NonMatching(),
          hasAppeared: false
        )
      ]
    )

    XCTAssertNil(nonMatchingBuilt)
  }

  func test_4_buildsPath() {
    var path = [IdentifiedScreen]()

    let sut = PathBuilders.anyOf(
      PathBuilders.screen(
        AScreen.self,
        content: { Text("A") }
      ),
      PathBuilders.screen(
        BScreen.self,
        content: { Text("B") }
      ),
      PathBuilders.screen(
        CScreen.self,
        content: { Text("C") }
      ),
      PathBuilders.screen(
        DScreen.self,
        content: { Text("D") }
      )
    )

    // MARK: aScreen
    let aScreen = AScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: aScreen,
        hasAppeared: false
      )
    ]

    let aBuiltView = sut.build(path: path)

    guard case .a = aBuiltView else {
      XCTFail("Expected \(AScreen.self) to build Either.a. Got \(aBuiltView.debugDescription).")
      return 
    }

    // MARK: bScreen
    let bScreen = BScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: bScreen,
        hasAppeared: false
      )
    ]

    let bBuiltView = sut.build(path: path)

    guard case .b = bBuiltView else {
      XCTFail("Expected \(BScreen.self) to build Either.b. Got \(bBuiltView.debugDescription).")
      return 
    }

    // MARK: cScreen
    let cScreen = CScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: cScreen,
        hasAppeared: false
      )
    ]

    let cBuiltView = sut.build(path: path)

    guard case .c = cBuiltView else {
      XCTFail("Expected \(CScreen.self) to build Either.c. Got \(cBuiltView.debugDescription).")
      return 
    }

    // MARK: dScreen
    let dScreen = DScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: dScreen,
        hasAppeared: false
      )
    ]

    let dBuiltView = sut.build(path: path)

    guard case .d = dBuiltView else {
      XCTFail("Expected \(DScreen.self) to build Either.d. Got \(dBuiltView.debugDescription).")
      return 
    }

    let nonMatchingBuilt = sut.build(
      path: [
        IdentifiedScreen(
          id: .root,
          content: NonMatching(),
          hasAppeared: false
        )
      ]
    )

    XCTAssertNil(nonMatchingBuilt)
  }

  func test_5_buildsPath() {
    var path = [IdentifiedScreen]()

    let sut = PathBuilders.anyOf(
      PathBuilders.screen(
        AScreen.self,
        content: { Text("A") }
      ),
      PathBuilders.screen(
        BScreen.self,
        content: { Text("B") }
      ),
      PathBuilders.screen(
        CScreen.self,
        content: { Text("C") }
      ),
      PathBuilders.screen(
        DScreen.self,
        content: { Text("D") }
      ),
      PathBuilders.screen(
        EScreen.self,
        content: { Text("E") }
      )
    )

    // MARK: aScreen
    let aScreen = AScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: aScreen,
        hasAppeared: false
      )
    ]

    let aBuiltView = sut.build(path: path)

    guard case .a = aBuiltView else {
      XCTFail("Expected \(AScreen.self) to build Either.a. Got \(aBuiltView.debugDescription).")
      return 
    }

    // MARK: bScreen
    let bScreen = BScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: bScreen,
        hasAppeared: false
      )
    ]

    let bBuiltView = sut.build(path: path)

    guard case .b = bBuiltView else {
      XCTFail("Expected \(BScreen.self) to build Either.b. Got \(bBuiltView.debugDescription).")
      return 
    }

    // MARK: cScreen
    let cScreen = CScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: cScreen,
        hasAppeared: false
      )
    ]

    let cBuiltView = sut.build(path: path)

    guard case .c = cBuiltView else {
      XCTFail("Expected \(CScreen.self) to build Either.c. Got \(cBuiltView.debugDescription).")
      return 
    }

    // MARK: dScreen
    let dScreen = DScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: dScreen,
        hasAppeared: false
      )
    ]

    let dBuiltView = sut.build(path: path)

    guard case .d = dBuiltView else {
      XCTFail("Expected \(DScreen.self) to build Either.d. Got \(dBuiltView.debugDescription).")
      return 
    }

    // MARK: eScreen
    let eScreen = EScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: eScreen,
        hasAppeared: false
      )
    ]

    let eBuiltView = sut.build(path: path)

    guard case .e = eBuiltView else {
      XCTFail("Expected \(EScreen.self) to build Either.e. Got \(eBuiltView.debugDescription).")
      return 
    }

    let nonMatchingBuilt = sut.build(
      path: [
        IdentifiedScreen(
          id: .root,
          content: NonMatching(),
          hasAppeared: false
        )
      ]
    )

    XCTAssertNil(nonMatchingBuilt)
  }

  func test_6_buildsPath() {
    var path = [IdentifiedScreen]()

    let sut = PathBuilders.anyOf(
      PathBuilders.screen(
        AScreen.self,
        content: { Text("A") }
      ),
      PathBuilders.screen(
        BScreen.self,
        content: { Text("B") }
      ),
      PathBuilders.screen(
        CScreen.self,
        content: { Text("C") }
      ),
      PathBuilders.screen(
        DScreen.self,
        content: { Text("D") }
      ),
      PathBuilders.screen(
        EScreen.self,
        content: { Text("E") }
      ),
      PathBuilders.screen(
        FScreen.self,
        content: { Text("F") }
      )
    )

    // MARK: aScreen
    let aScreen = AScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: aScreen,
        hasAppeared: false
      )
    ]

    let aBuiltView = sut.build(path: path)

    guard case .a = aBuiltView else {
      XCTFail("Expected \(AScreen.self) to build Either.a. Got \(aBuiltView.debugDescription).")
      return 
    }

    // MARK: bScreen
    let bScreen = BScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: bScreen,
        hasAppeared: false
      )
    ]

    let bBuiltView = sut.build(path: path)

    guard case .b = bBuiltView else {
      XCTFail("Expected \(BScreen.self) to build Either.b. Got \(bBuiltView.debugDescription).")
      return 
    }

    // MARK: cScreen
    let cScreen = CScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: cScreen,
        hasAppeared: false
      )
    ]

    let cBuiltView = sut.build(path: path)

    guard case .c = cBuiltView else {
      XCTFail("Expected \(CScreen.self) to build Either.c. Got \(cBuiltView.debugDescription).")
      return 
    }

    // MARK: dScreen
    let dScreen = DScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: dScreen,
        hasAppeared: false
      )
    ]

    let dBuiltView = sut.build(path: path)

    guard case .d = dBuiltView else {
      XCTFail("Expected \(DScreen.self) to build Either.d. Got \(dBuiltView.debugDescription).")
      return 
    }

    // MARK: eScreen
    let eScreen = EScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: eScreen,
        hasAppeared: false
      )
    ]

    let eBuiltView = sut.build(path: path)

    guard case .e = eBuiltView else {
      XCTFail("Expected \(EScreen.self) to build Either.e. Got \(eBuiltView.debugDescription).")
      return 
    }

    // MARK: fScreen
    let fScreen = FScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: fScreen,
        hasAppeared: false
      )
    ]

    let fBuiltView = sut.build(path: path)

    guard case .f = fBuiltView else {
      XCTFail("Expected \(FScreen.self) to build Either.f. Got \(fBuiltView.debugDescription).")
      return 
    }

    let nonMatchingBuilt = sut.build(
      path: [
        IdentifiedScreen(
          id: .root,
          content: NonMatching(),
          hasAppeared: false
        )
      ]
    )

    XCTAssertNil(nonMatchingBuilt)
  }

  func test_7_buildsPath() {
    var path = [IdentifiedScreen]()

    let sut = PathBuilders.anyOf(
      PathBuilders.screen(
        AScreen.self,
        content: { Text("A") }
      ),
      PathBuilders.screen(
        BScreen.self,
        content: { Text("B") }
      ),
      PathBuilders.screen(
        CScreen.self,
        content: { Text("C") }
      ),
      PathBuilders.screen(
        DScreen.self,
        content: { Text("D") }
      ),
      PathBuilders.screen(
        EScreen.self,
        content: { Text("E") }
      ),
      PathBuilders.screen(
        FScreen.self,
        content: { Text("F") }
      ),
      PathBuilders.screen(
        GScreen.self,
        content: { Text("G") }
      )
    )

    // MARK: aScreen
    let aScreen = AScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: aScreen,
        hasAppeared: false
      )
    ]

    let aBuiltView = sut.build(path: path)

    guard case .a = aBuiltView else {
      XCTFail("Expected \(AScreen.self) to build Either.a. Got \(aBuiltView.debugDescription).")
      return 
    }

    // MARK: bScreen
    let bScreen = BScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: bScreen,
        hasAppeared: false
      )
    ]

    let bBuiltView = sut.build(path: path)

    guard case .b = bBuiltView else {
      XCTFail("Expected \(BScreen.self) to build Either.b. Got \(bBuiltView.debugDescription).")
      return 
    }

    // MARK: cScreen
    let cScreen = CScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: cScreen,
        hasAppeared: false
      )
    ]

    let cBuiltView = sut.build(path: path)

    guard case .c = cBuiltView else {
      XCTFail("Expected \(CScreen.self) to build Either.c. Got \(cBuiltView.debugDescription).")
      return 
    }

    // MARK: dScreen
    let dScreen = DScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: dScreen,
        hasAppeared: false
      )
    ]

    let dBuiltView = sut.build(path: path)

    guard case .d = dBuiltView else {
      XCTFail("Expected \(DScreen.self) to build Either.d. Got \(dBuiltView.debugDescription).")
      return 
    }

    // MARK: eScreen
    let eScreen = EScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: eScreen,
        hasAppeared: false
      )
    ]

    let eBuiltView = sut.build(path: path)

    guard case .e = eBuiltView else {
      XCTFail("Expected \(EScreen.self) to build Either.e. Got \(eBuiltView.debugDescription).")
      return 
    }

    // MARK: fScreen
    let fScreen = FScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: fScreen,
        hasAppeared: false
      )
    ]

    let fBuiltView = sut.build(path: path)

    guard case .f = fBuiltView else {
      XCTFail("Expected \(FScreen.self) to build Either.f. Got \(fBuiltView.debugDescription).")
      return 
    }

    // MARK: gScreen
    let gScreen = GScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: gScreen,
        hasAppeared: false
      )
    ]

    let gBuiltView = sut.build(path: path)

    guard case .g = gBuiltView else {
      XCTFail("Expected \(GScreen.self) to build Either.g. Got \(gBuiltView.debugDescription).")
      return 
    }

    let nonMatchingBuilt = sut.build(
      path: [
        IdentifiedScreen(
          id: .root,
          content: NonMatching(),
          hasAppeared: false
        )
      ]
    )

    XCTAssertNil(nonMatchingBuilt)
  }

  func test_8_buildsPath() {
    var path = [IdentifiedScreen]()

    let sut = PathBuilders.anyOf(
      PathBuilders.screen(
        AScreen.self,
        content: { Text("A") }
      ),
      PathBuilders.screen(
        BScreen.self,
        content: { Text("B") }
      ),
      PathBuilders.screen(
        CScreen.self,
        content: { Text("C") }
      ),
      PathBuilders.screen(
        DScreen.self,
        content: { Text("D") }
      ),
      PathBuilders.screen(
        EScreen.self,
        content: { Text("E") }
      ),
      PathBuilders.screen(
        FScreen.self,
        content: { Text("F") }
      ),
      PathBuilders.screen(
        GScreen.self,
        content: { Text("G") }
      ),
      PathBuilders.screen(
        HScreen.self,
        content: { Text("H") }
      )
    )

    // MARK: aScreen
    let aScreen = AScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: aScreen,
        hasAppeared: false
      )
    ]

    let aBuiltView = sut.build(path: path)

    guard case .a = aBuiltView else {
      XCTFail("Expected \(AScreen.self) to build Either.a. Got \(aBuiltView.debugDescription).")
      return 
    }

    // MARK: bScreen
    let bScreen = BScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: bScreen,
        hasAppeared: false
      )
    ]

    let bBuiltView = sut.build(path: path)

    guard case .b = bBuiltView else {
      XCTFail("Expected \(BScreen.self) to build Either.b. Got \(bBuiltView.debugDescription).")
      return 
    }

    // MARK: cScreen
    let cScreen = CScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: cScreen,
        hasAppeared: false
      )
    ]

    let cBuiltView = sut.build(path: path)

    guard case .c = cBuiltView else {
      XCTFail("Expected \(CScreen.self) to build Either.c. Got \(cBuiltView.debugDescription).")
      return 
    }

    // MARK: dScreen
    let dScreen = DScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: dScreen,
        hasAppeared: false
      )
    ]

    let dBuiltView = sut.build(path: path)

    guard case .d = dBuiltView else {
      XCTFail("Expected \(DScreen.self) to build Either.d. Got \(dBuiltView.debugDescription).")
      return 
    }

    // MARK: eScreen
    let eScreen = EScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: eScreen,
        hasAppeared: false
      )
    ]

    let eBuiltView = sut.build(path: path)

    guard case .e = eBuiltView else {
      XCTFail("Expected \(EScreen.self) to build Either.e. Got \(eBuiltView.debugDescription).")
      return 
    }

    // MARK: fScreen
    let fScreen = FScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: fScreen,
        hasAppeared: false
      )
    ]

    let fBuiltView = sut.build(path: path)

    guard case .f = fBuiltView else {
      XCTFail("Expected \(FScreen.self) to build Either.f. Got \(fBuiltView.debugDescription).")
      return 
    }

    // MARK: gScreen
    let gScreen = GScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: gScreen,
        hasAppeared: false
      )
    ]

    let gBuiltView = sut.build(path: path)

    guard case .g = gBuiltView else {
      XCTFail("Expected \(GScreen.self) to build Either.g. Got \(gBuiltView.debugDescription).")
      return 
    }

    // MARK: hScreen
    let hScreen = HScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: hScreen,
        hasAppeared: false
      )
    ]

    let hBuiltView = sut.build(path: path)

    guard case .h = hBuiltView else {
      XCTFail("Expected \(HScreen.self) to build Either.h. Got \(hBuiltView.debugDescription).")
      return 
    }

    let nonMatchingBuilt = sut.build(
      path: [
        IdentifiedScreen(
          id: .root,
          content: NonMatching(),
          hasAppeared: false
        )
      ]
    )

    XCTAssertNil(nonMatchingBuilt)
  }

  func test_9_buildsPath() {
    var path = [IdentifiedScreen]()

    let sut = PathBuilders.anyOf(
      PathBuilders.screen(
        AScreen.self,
        content: { Text("A") }
      ),
      PathBuilders.screen(
        BScreen.self,
        content: { Text("B") }
      ),
      PathBuilders.screen(
        CScreen.self,
        content: { Text("C") }
      ),
      PathBuilders.screen(
        DScreen.self,
        content: { Text("D") }
      ),
      PathBuilders.screen(
        EScreen.self,
        content: { Text("E") }
      ),
      PathBuilders.screen(
        FScreen.self,
        content: { Text("F") }
      ),
      PathBuilders.screen(
        GScreen.self,
        content: { Text("G") }
      ),
      PathBuilders.screen(
        HScreen.self,
        content: { Text("H") }
      ),
      PathBuilders.screen(
        IScreen.self,
        content: { Text("I") }
      )
    )

    // MARK: aScreen
    let aScreen = AScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: aScreen,
        hasAppeared: false
      )
    ]

    let aBuiltView = sut.build(path: path)

    guard case .a = aBuiltView else {
      XCTFail("Expected \(AScreen.self) to build Either.a. Got \(aBuiltView.debugDescription).")
      return 
    }

    // MARK: bScreen
    let bScreen = BScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: bScreen,
        hasAppeared: false
      )
    ]

    let bBuiltView = sut.build(path: path)

    guard case .b = bBuiltView else {
      XCTFail("Expected \(BScreen.self) to build Either.b. Got \(bBuiltView.debugDescription).")
      return 
    }

    // MARK: cScreen
    let cScreen = CScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: cScreen,
        hasAppeared: false
      )
    ]

    let cBuiltView = sut.build(path: path)

    guard case .c = cBuiltView else {
      XCTFail("Expected \(CScreen.self) to build Either.c. Got \(cBuiltView.debugDescription).")
      return 
    }

    // MARK: dScreen
    let dScreen = DScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: dScreen,
        hasAppeared: false
      )
    ]

    let dBuiltView = sut.build(path: path)

    guard case .d = dBuiltView else {
      XCTFail("Expected \(DScreen.self) to build Either.d. Got \(dBuiltView.debugDescription).")
      return 
    }

    // MARK: eScreen
    let eScreen = EScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: eScreen,
        hasAppeared: false
      )
    ]

    let eBuiltView = sut.build(path: path)

    guard case .e = eBuiltView else {
      XCTFail("Expected \(EScreen.self) to build Either.e. Got \(eBuiltView.debugDescription).")
      return 
    }

    // MARK: fScreen
    let fScreen = FScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: fScreen,
        hasAppeared: false
      )
    ]

    let fBuiltView = sut.build(path: path)

    guard case .f = fBuiltView else {
      XCTFail("Expected \(FScreen.self) to build Either.f. Got \(fBuiltView.debugDescription).")
      return 
    }

    // MARK: gScreen
    let gScreen = GScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: gScreen,
        hasAppeared: false
      )
    ]

    let gBuiltView = sut.build(path: path)

    guard case .g = gBuiltView else {
      XCTFail("Expected \(GScreen.self) to build Either.g. Got \(gBuiltView.debugDescription).")
      return 
    }

    // MARK: hScreen
    let hScreen = HScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: hScreen,
        hasAppeared: false
      )
    ]

    let hBuiltView = sut.build(path: path)

    guard case .h = hBuiltView else {
      XCTFail("Expected \(HScreen.self) to build Either.h. Got \(hBuiltView.debugDescription).")
      return 
    }

    // MARK: iScreen
    let iScreen = IScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: iScreen,
        hasAppeared: false
      )
    ]

    let iBuiltView = sut.build(path: path)

    guard case .i = iBuiltView else {
      XCTFail("Expected \(IScreen.self) to build Either.i. Got \(iBuiltView.debugDescription).")
      return 
    }

    let nonMatchingBuilt = sut.build(
      path: [
        IdentifiedScreen(
          id: .root,
          content: NonMatching(),
          hasAppeared: false
        )
      ]
    )

    XCTAssertNil(nonMatchingBuilt)
  }

  func test_10_buildsPath() {
    var path = [IdentifiedScreen]()

    let sut = PathBuilders.anyOf(
      PathBuilders.screen(
        AScreen.self,
        content: { Text("A") }
      ),
      PathBuilders.screen(
        BScreen.self,
        content: { Text("B") }
      ),
      PathBuilders.screen(
        CScreen.self,
        content: { Text("C") }
      ),
      PathBuilders.screen(
        DScreen.self,
        content: { Text("D") }
      ),
      PathBuilders.screen(
        EScreen.self,
        content: { Text("E") }
      ),
      PathBuilders.screen(
        FScreen.self,
        content: { Text("F") }
      ),
      PathBuilders.screen(
        GScreen.self,
        content: { Text("G") }
      ),
      PathBuilders.screen(
        HScreen.self,
        content: { Text("H") }
      ),
      PathBuilders.screen(
        IScreen.self,
        content: { Text("I") }
      ),
      PathBuilders.screen(
        JScreen.self,
        content: { Text("J") }
      )
    )

    // MARK: aScreen
    let aScreen = AScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: aScreen,
        hasAppeared: false
      )
    ]

    let aBuiltView = sut.build(path: path)

    guard case .a = aBuiltView else {
      XCTFail("Expected \(AScreen.self) to build Either.a. Got \(aBuiltView.debugDescription).")
      return 
    }

    // MARK: bScreen
    let bScreen = BScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: bScreen,
        hasAppeared: false
      )
    ]

    let bBuiltView = sut.build(path: path)

    guard case .b = bBuiltView else {
      XCTFail("Expected \(BScreen.self) to build Either.b. Got \(bBuiltView.debugDescription).")
      return 
    }

    // MARK: cScreen
    let cScreen = CScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: cScreen,
        hasAppeared: false
      )
    ]

    let cBuiltView = sut.build(path: path)

    guard case .c = cBuiltView else {
      XCTFail("Expected \(CScreen.self) to build Either.c. Got \(cBuiltView.debugDescription).")
      return 
    }

    // MARK: dScreen
    let dScreen = DScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: dScreen,
        hasAppeared: false
      )
    ]

    let dBuiltView = sut.build(path: path)

    guard case .d = dBuiltView else {
      XCTFail("Expected \(DScreen.self) to build Either.d. Got \(dBuiltView.debugDescription).")
      return 
    }

    // MARK: eScreen
    let eScreen = EScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: eScreen,
        hasAppeared: false
      )
    ]

    let eBuiltView = sut.build(path: path)

    guard case .e = eBuiltView else {
      XCTFail("Expected \(EScreen.self) to build Either.e. Got \(eBuiltView.debugDescription).")
      return 
    }

    // MARK: fScreen
    let fScreen = FScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: fScreen,
        hasAppeared: false
      )
    ]

    let fBuiltView = sut.build(path: path)

    guard case .f = fBuiltView else {
      XCTFail("Expected \(FScreen.self) to build Either.f. Got \(fBuiltView.debugDescription).")
      return 
    }

    // MARK: gScreen
    let gScreen = GScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: gScreen,
        hasAppeared: false
      )
    ]

    let gBuiltView = sut.build(path: path)

    guard case .g = gBuiltView else {
      XCTFail("Expected \(GScreen.self) to build Either.g. Got \(gBuiltView.debugDescription).")
      return 
    }

    // MARK: hScreen
    let hScreen = HScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: hScreen,
        hasAppeared: false
      )
    ]

    let hBuiltView = sut.build(path: path)

    guard case .h = hBuiltView else {
      XCTFail("Expected \(HScreen.self) to build Either.h. Got \(hBuiltView.debugDescription).")
      return 
    }

    // MARK: iScreen
    let iScreen = IScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: iScreen,
        hasAppeared: false
      )
    ]

    let iBuiltView = sut.build(path: path)

    guard case .i = iBuiltView else {
      XCTFail("Expected \(IScreen.self) to build Either.i. Got \(iBuiltView.debugDescription).")
      return 
    }

    // MARK: jScreen
    let jScreen = JScreen()
    path = [
      IdentifiedScreen(
        id: .root,
        content: jScreen,
        hasAppeared: false
      )
    ]

    let jBuiltView = sut.build(path: path)

    guard case .j = jBuiltView else {
      XCTFail("Expected \(JScreen.self) to build Either.j. Got \(jBuiltView.debugDescription).")
      return 
    }

    let nonMatchingBuilt = sut.build(
      path: [
        IdentifiedScreen(
          id: .root,
          content: NonMatching(),
          hasAppeared: false
        )
      ]
    )

    XCTAssertNil(nonMatchingBuilt)
  }
}
