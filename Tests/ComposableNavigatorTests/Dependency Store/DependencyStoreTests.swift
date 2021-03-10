@testable import ComposableNavigator
import XCTest

protocol DependencyType {}

final class DependencyStoreTests: XCTestCase {
  private let sut = DependencyStore.shared
  private let dependencyType = DependencyType.self

  struct Dependency: DependencyType {}

  private let dependency = Dependency()
  private let scope: DependencyStore.Scope = "screenScope"

  override func setUp() {
    super.setUp()
    sut.reset()
  }

  // MARK: - Register / Get
  func test_register_global_dependency() {
    sut.registerGlobal(dependency: dependency, representing: dependencyType)

    let storedDependency = sut.get(dependency: dependencyType)
    XCTAssertNotNil(storedDependency)
    XCTAssertTrue(storedDependency is Dependency)
  }

  func test_register_lazy_global_dependency() {
    sut.registerLazyGlobal(dependency: { self.dependency }, representing: dependencyType)

    let storedDependency = sut.get(dependency: dependencyType)
    XCTAssertNotNil(storedDependency)
    XCTAssertTrue(storedDependency is Dependency)
  }

  func test_register_screen_dependency() {
    sut.register(dependency: dependency, representing: dependencyType, in: scope)

    let storedDependency = sut.get(dependency: dependencyType, in: scope)
    XCTAssertNotNil(storedDependency)
    XCTAssertTrue(storedDependency is Dependency)
  }

  func test_register_lazy_screen_dependency() {
    sut.registerLazy(dependency: { self.dependency }, representing: dependencyType, in: scope)

    let storedDependency = sut.get(dependency: dependencyType, in: scope)
    XCTAssertNotNil(storedDependency)
    XCTAssertTrue(storedDependency is Dependency)
  }

  // MARK: - Unregister / Get
  func test_unregister_global_dependency() {
    sut.registerGlobal(dependency: dependency, representing: dependencyType)

    sut.unregisterGlobal(dependency: dependencyType)
    XCTAssertNil(sut.get(dependency: dependencyType))
  }

  func test_unregister_lazy_global_dependency() {
    sut.registerLazyGlobal(dependency: { self.dependency }, representing: dependencyType)

    sut.unregisterGlobal(dependency: dependencyType)
    XCTAssertNil(sut.get(dependency: dependencyType))
  }

  func test_unregister_screen_dependency() {
    sut.register(dependency: dependency, representing: dependencyType, in: scope)

    sut.unregister(dependency: dependencyType, in: scope)
    XCTAssertNil(sut.get(dependency: dependencyType))
  }

  func test_unregister_lazy_screen_dependency() {
    sut.registerLazy(dependency: { self.dependency }, representing: dependencyType, in: scope)

    sut.unregister(dependency: dependencyType, in: scope)
    XCTAssertNil(sut.get(dependency: dependencyType))
  }

  // MARK: - Reset
  func test_reset() {
    let lazyDependency = 1.0
    let lazyDependencyType = type(of: lazyDependency)
    
    sut.registerGlobal(dependency: dependency, representing: dependencyType)
    sut.registerLazy(dependency: { lazyDependency }, representing: dependencyType, in: scope)

    sut.register(dependency: dependency, representing: dependencyType, in: scope)
    sut.registerLazy(dependency: { lazyDependency }, representing: dependencyType, in: scope)

    sut.reset()

    // Global dependencies reset
    XCTAssertNil(sut.get(dependency: dependencyType))
    XCTAssertNil(sut.get(dependency: lazyDependencyType))

    // Screen-scoped dependencies reset
    XCTAssertNil(sut.get(dependency: dependencyType, in: scope))
    XCTAssertNil(sut.get(dependency: lazyDependencyType, in: scope))
  }
}
