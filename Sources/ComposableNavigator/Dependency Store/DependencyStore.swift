import class Foundation.NSRecursiveLock

public class DependencyStore {
  public static let shared = DependencyStore()

  private enum Key: Hashable {
    case global(String)
    case scoped(scope: String, type: String)

    static func global<T>(_ type: T.Type) -> Key {
      .global(String(describing: T.self))
    }

    static func scoped<T>(scope: String, type: T.Type) -> Key {
      .scoped(scope: scope, type: String(describing: T.self))
    }
  }

  private var store: [Key: Any] = [:]
  private var lazyInits: [Key: Any] = [:]
  private let lock = NSRecursiveLock()

  // MARK: - Register
  public func registerGlobal<Dependency>(dependency: Dependency) {
    lock.lock(); defer { lock.unlock() }
    store[.global(Dependency.self)] = dependency
  }

  public func register<Dependency>(dependency: Dependency, in scope: String) {
    lock.lock(); defer { lock.unlock() }
    store[.scoped(scope: scope, type: Dependency.self)] = dependency
  }

  // MARK: - Register Lazy
  private func registerLazy<Dependency>(dependency: @escaping () -> Dependency, for key: Key) {
    lock.lock(); defer { lock.unlock() }
    guard !store.keys.contains(key) else {
      return
    }

    lazyInits[key] = dependency
  }

  public func registerLazyGlobal<Dependency>(dependency: @escaping () -> Dependency) {
    registerLazy(dependency: dependency, for: .global(Dependency.self))
  }

  public func registerLazy<Dependency>(dependency: @escaping () -> Dependency, in scope: String) {
    registerLazy(dependency: dependency, for: .scoped(scope: scope, type: Dependency.self))
  }

  // MARK: - Get
  private func get<Dependency>(dependency type: Dependency.Type, for key: Key) -> Dependency? {
    if store[key] == nil, let lazyInit = lazyInits[key] as? () -> Dependency {
      lazyInits[key] = nil
      let initialised = lazyInit()
      store[key] = initialised
      return initialised
    } else {
      return store[key] as? Dependency
    }
  }

  public func get<Dependency>(dependency type: Dependency.Type) -> Dependency? {
    lock.lock(); defer { lock.unlock() }
    return get(dependency: type, for: .global(type))
  }

  public func get<Dependency>(dependency type: Dependency.Type, in scope: String) -> Dependency? {
    lock.lock(); defer { lock.unlock() }
    return get(dependency: type, for: .scoped(scope: scope, type: type))
  }

  // MARK: - Unregister
  public func unregisterGlobal<Dependency>(dependency type: Dependency.Type) {
    lock.lock(); defer { lock.unlock() }
    let key = Key.global(Dependency.self)

    store[key] = nil
    lazyInits[key] = nil
  }

  public func unregister<Dependency>(dependency: Dependency.Type, in scope: String) {
    lock.lock(); defer { lock.unlock() }
    let key = Key.scoped(scope: scope, type: Dependency.self)

    store[key] = nil
    lazyInits[key] = nil
  }

  // MARK: - Reset
  public func reset() {
    lock.lock(); defer { lock.unlock() }
    store = [:]
    lazyInits = [:]
  }
}
