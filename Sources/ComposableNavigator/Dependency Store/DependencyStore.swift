import class Foundation.NSRecursiveLock

public class DependencyStore {
  public static let shared = DependencyStore()

  private enum Key: Hashable {
    case global(String)
    case screen(id: ScreenID, type: String)

    static func global<T>(_ type: T.Type) -> Key {
      .global(String(describing: T.self))
    }

    static func screen<T>(id: ScreenID, type: T.Type) -> Key {
      .screen(id: id, type: String(describing: T.self))
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

  public func registerLazyGlobal<Dependency>(dependency: @escaping () -> Dependency) {
    lock.lock(); defer { lock.unlock() }
    lazyInits[.global(Dependency.self)] = dependency
  }

  func register<Dependency>(dependency: Dependency, for screen: ScreenID) {
    lock.lock(); defer { lock.unlock() }
    store[.screen(id: screen, type: Dependency.self)] = dependency
  }

  func registerLazy<Dependency>(dependency: @escaping () -> Dependency, for screen: ScreenID) {
    lock.lock(); defer { lock.unlock() }
    lazyInits[.screen(id: screen, type: Dependency.self)] = dependency
  }

  // MARK: - Get
  private func get<Dependency>(of type: Dependency.Type, for key: Key) -> Dependency? {
    if store[key] == nil, let lazyInit = lazyInits[key] as? () -> Dependency {
      lazyInits[key] = nil
      let initialised = lazyInit()
      store[key] = initialised
      return initialised
    } else {
      return store[key] as? Dependency
    }
  }

  public func get<Dependency>(of type: Dependency.Type) -> Dependency? {
    lock.lock(); defer { lock.unlock() }
    return get(of: type, for: .global(type))
  }

  public func get<Dependency>(of type: Dependency.Type, for screen: ScreenID) -> Dependency? {
    lock.lock(); defer { lock.unlock() }
    return get(of: type, for: .screen(id: screen, type: type))
  }

  // MARK: - Unregister
  public func unregisterGlobal<Dependency>(of type: Dependency.Type) {
    lock.lock(); defer { lock.unlock() }
    let key = Key.global(Dependency.self)

    store[key] = nil
    lazyInits[key] = nil
  }

  public func unregister<Dependency>(dependency: Dependency.Type, of screen: ScreenID) {
    lock.lock(); defer { lock.unlock() }
    let key = Key.screen(id: screen, type: Dependency.self)

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
