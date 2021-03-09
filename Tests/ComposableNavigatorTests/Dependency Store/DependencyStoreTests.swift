@testable import ComposableNavigator
import XCTest

final class DependencyStoreTests: XCTestCase {
  private let sut = DependencyStore.shared
  private let dependency = 0
  private let screenID = ScreenID()

  private lazy var dependencyType = type(of: dependency)

  override func setUp() {
    super.setUp()
    sut.reset()
  }

  // MARK: - Register / Get
  func test_register_global_dependency() {
    sut.registerGlobal(dependency: dependency)
    XCTAssertEqual(sut.get(of: dependencyType), dependency)
  }

  func test_register_lazy_global_dependency() {
    sut.registerLazyGlobal(dependency: { self.dependency })
    XCTAssertEqual(sut.get(of: dependencyType), dependency)
  }

  func test_register_screen_dependency() {
    sut.register(dependency: dependency, for: screenID)
    XCTAssertEqual(sut.get(of: dependencyType, for: screenID), dependency)
  }

  func test_register_lazy_screen_dependency() {
    sut.registerLazy(dependency: { self.dependency }, for: screenID)
    XCTAssertEqual(sut.get(of: dependencyType, for: screenID), dependency)
  }

  // MARK: - Unregister / Get
  func test_unregister_global_dependency() {
    sut.registerGlobal(dependency: dependency)

    sut.unregisterGlobal(of: dependencyType)
    XCTAssertNil(sut.get(of: dependencyType))
  }

  func test_unregister_lazy_global_dependency() {
    sut.registerLazyGlobal(dependency: { self.dependency })

    sut.unregisterGlobal(of: dependencyType)
    XCTAssertNil(sut.get(of: dependencyType))
  }

  func test_unregister_screen_dependency() {
    sut.register(dependency: dependency, for: screenID)

    sut.unregister(dependency: dependencyType, of: screenID)
    XCTAssertNil(sut.get(of: dependencyType))
  }

  func test_unregister_lazy_screen_dependency() {
    sut.registerLazy(dependency: { self.dependency }, for: screenID)

    sut.unregister(dependency: dependencyType, of: screenID)
    XCTAssertNil(sut.get(of: dependencyType))
  }

  // MARK: - Reset
  func test_reset() {
    let lazyDependency = 1.0
    let lazyDependencyType = type(of: lazyDependency)

    sut.registerGlobal(dependency: dependency)
    sut.registerLazy(dependency: { lazyDependency }, for: screenID)

    sut.register(dependency: dependency, for: screenID)
    sut.registerLazy(dependency: { lazyDependency }, for: screenID)

    sut.reset()

    // Global dependencies reset
    XCTAssertNil(sut.get(of: dependencyType))
    XCTAssertNil(sut.get(of: lazyDependencyType))

    // Screen-scoped dependencies reset
    XCTAssertNil(sut.get(of: dependencyType, for: screenID))
    XCTAssertNil(sut.get(of: lazyDependencyType, for: screenID))
  }
}
