@testable import ComposableNavigator
import XCTest

final class DependencyStoreTests: XCTestCase {
  private let sut = DependencyStore.shared
  private let dependency = 0
  private let scope = "screenScope"

  private lazy var dependencyType = type(of: dependency)

  override func setUp() {
    super.setUp()
    sut.reset()
  }

  // MARK: - Register / Get
  func test_register_global_dependency() {
    sut.registerGlobal(dependency: dependency)
    XCTAssertEqual(sut.get(dependency: dependencyType), dependency)
  }

  func test_register_lazy_global_dependency() {
    sut.registerLazyGlobal(dependency: { self.dependency })
    XCTAssertEqual(sut.get(dependency: dependencyType), dependency)
  }

  func test_register_screen_dependency() {
    sut.register(dependency: dependency, in: scope)
    XCTAssertEqual(sut.get(dependency: dependencyType, in: scope), dependency)
  }

  func test_register_lazy_screen_dependency() {
    sut.registerLazy(dependency: { self.dependency }, in: scope)
    XCTAssertEqual(sut.get(dependency: dependencyType, in: scope), dependency)
  }

  // MARK: - Unregister / Get
  func test_unregister_global_dependency() {
    sut.registerGlobal(dependency: dependency)

    sut.unregisterGlobal(dependency: dependencyType)
    XCTAssertNil(sut.get(dependency: dependencyType))
  }

  func test_unregister_lazy_global_dependency() {
    sut.registerLazyGlobal(dependency: { self.dependency })

    sut.unregisterGlobal(dependency: dependencyType)
    XCTAssertNil(sut.get(dependency: dependencyType))
  }

  func test_unregister_screen_dependency() {
    sut.register(dependency: dependency, in: scope)

    sut.unregister(dependency: dependencyType, in: scope)
    XCTAssertNil(sut.get(dependency: dependencyType))
  }

  func test_unregister_lazy_screen_dependency() {
    sut.registerLazy(dependency: { self.dependency }, in: scope)

    sut.unregister(dependency: dependencyType, in: scope)
    XCTAssertNil(sut.get(dependency: dependencyType))
  }

  // MARK: - Reset
  func test_reset() {
    let lazyDependency = 1.0
    let lazyDependencyType = type(of: lazyDependency)

    sut.registerGlobal(dependency: dependency)
    sut.registerLazy(dependency: { lazyDependency }, in: scope)

    sut.register(dependency: dependency, in: scope)
    sut.registerLazy(dependency: { lazyDependency }, in: scope)

    sut.reset()

    // Global dependencies reset
    XCTAssertNil(sut.get(dependency: dependencyType))
    XCTAssertNil(sut.get(dependency: lazyDependencyType))

    // Screen-scoped dependencies reset
    XCTAssertNil(sut.get(dependency: dependencyType, in: scope))
    XCTAssertNil(sut.get(dependency: lazyDependencyType, in: scope))
  }
}
