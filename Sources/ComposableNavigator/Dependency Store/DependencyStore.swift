import class Foundation.NSRecursiveLock

/// Dependency container for global and scoped dependencies
public class DependencyStore {
  /// Shared `DependencyStore` instance, allowing to access global dependencies throughout an application
  public static let shared = DependencyStore()

  /// Key used to identify stored dependencies
  private enum Key: Hashable {
    case global(ObjectIdentifier)
    case scoped(scope: Scope, type: ObjectIdentifier)

    static func global<T>(_ type: T.Type) -> Key {
      .global(ObjectIdentifier(type))
    }

    static func scoped<T>(scope: Scope, type: T.Type) -> Key {
      .scoped(scope: scope, type: ObjectIdentifier(type))
    }
  }

  /// `Scope` defines the scope in which the dependency is visible
  ///
  /// Dependencies registered in a scope using ` register(dependency:, representing:, in scope:) ` can only be retrieved via `get(dependency:, in scope:)`.
  ///
  /// Such scoped dependencies are not visible globally and the access is therefore limited to callers knowing the scope.
  ///
  /// `Scope`s can be shared, allowing multiple callers access to the same scoped dependencies.
  public struct Scope: Hashable {
    private let scope: String

    public init(_ scope: String) {
      self.scope = scope
    }
  }

  private var store: [Key: Any] = [:]
  private var lazyInits: [Key: () -> Any] = [:]
  private let lock = NSRecursiveLock()

  // MARK: - Register
  private func register<RepresentedType, Dependency>(
    dependency: Dependency,
    representing: RepresentedType.Type,
    for key: Key
  ) {
    guard (dependency as? RepresentedType != nil) else { return }
    lock.lock(); defer { lock.unlock() }
    store[key] = dependency
  }

  /// Registers a new dependency globally.
  ///
  /// Dependencies can be retrieved by calling `dependencyStore.get(dependency: RepresentedType.self)`.
  ///
  /// - Parameters:
  ///   - dependency: The dependency to be stored in the dependency store
  ///   - representing: The represented type
  public func registerGlobal<RepresentedType, Dependency>(
    dependency: Dependency,
    representing: RepresentedType.Type
  ) {
    register(
      dependency: dependency,
      representing: representing,
      for: .global(RepresentedType.self)
    )
  }

  /// Registers a new dependency in a scope.
  ///
  /// Dependencies can be retrieved by calling `dependencyStore.get(dependency:, in scope:)`.
  ///
  /// - Parameters:
  ///   - dependency: The dependency to be stored in the dependency store
  ///   - representing: The represented type
  ///   - scope: Scope to which the dependency is added. Scoped dependencies can only be retrieved by callers knowing the scope.
  public func register<RepresentedType, Dependency>(
    dependency: Dependency,
    representing: RepresentedType.Type,
    in scope: Scope
  ) {
    register(
      dependency: dependency,
      representing: representing,
      for: .scoped(scope: scope, type: RepresentedType.self)
    )
  }

  // MARK: - Register Lazy
  private func registerLazy<Dependency, RepresentedType>(
    dependency: @escaping () -> Dependency,
    representing: RepresentedType.Type,
    for key: Key
  ) {
    lock.lock(); defer { lock.unlock() }
    guard !store.keys.contains(key) else {
      return
    }

    lazyInits[key] = dependency
  }

  /// Registers a new lazy dependency globally. Lazy dependencies are initialised as part of the first `.get` call to retrieve them.
  ///
  /// Global dependencies can be retrieved by calling `dependencyStore.get(dependency: RepresentedType.self)`.
  ///
  /// - Parameters:
  ///   - dependency: The dependency to be stored in the dependency store
  ///   - representing: The represented type
  public func registerLazyGlobal<Dependency, RepresentedType>(
    dependency: @escaping () -> Dependency,
    representing: RepresentedType.Type
  ) {
    registerLazy(
      dependency: dependency,
      representing: representing,
      for: .global(RepresentedType.self)
    )
  }

  /// Registers a new lazy dependency in a scope. Lazy dependencies are initialised as part of the first `.get` call to retrieve them.
  ///
  /// Scoped dependencies can be retrieved by calling `dependencyStore.get(dependency:, in scope:)`.
  ///
  /// - Parameters:
  ///   - dependency: The dependency to be stored in the dependency store
  ///   - representing: The represented type
  ///   - scope: Scope to which the dependency is added. Scoped dependencies can only be retrieved by callers knowing the scope
  public func registerLazy<Dependency, RepresentedType>(
    dependency: @escaping () -> Dependency,
    representing: RepresentedType.Type,
    in scope: Scope
  ) {
    registerLazy(
      dependency: dependency,
      representing: representing,
      for: .scoped(scope: scope, type: RepresentedType.self)
    )
  }

  // MARK: - Get
  private func get<Dependency>(dependency type: Dependency.Type, for key: Key) -> Dependency? {
    lock.lock(); defer { lock.unlock() }
    if store[key] == nil,
       let lazyInit = lazyInits[key],
       let initialised = lazyInit() as? Dependency
    {
      lazyInits[key] = nil
      store[key] = initialised
      return initialised
    } else {
      return store[key] as? Dependency
    }
  }

  /// Retrieves a global dependency.
  ///
  /// Global dependencies can be retrieved after registering them via `registerGlobal<RepresentedType, Dependency>(dependency: Dependency, representing: RepresentedType.Type)`.
  ///
  /// ## ⚠️ Important ⚠️
  /// Dependencies are retrieved via the type they are registered to represent (RepresentedType).
  /// This allows you to register a concrete implementation of a Protocol and retrieve it via the protocol type.
  ///
  /// - Parameters:
  ///   - dependency: The dependency type to be retrieved
  public func get<Dependency>(dependency type: Dependency.Type) -> Dependency? {
    get(
      dependency: type,
      for: .global(type)
    )
  }

  /// Retrieves a scoped dependency.
  ///
  /// Global dependencies can be retrieved after registering them via `registerGlobal<RepresentedType, Dependency>(dependency: Dependency, representing: RepresentedType.Type, in scope: Scope)`.
  ///
  /// ## ⚠️ Important ⚠️
  /// Dependencies are retrieved via the type they are registered to represent (RepresentedType).
  /// This allows you to register a concrete implementation of a Protocol and retrieve it via the protocol type.
  ///
  /// - Parameters:
  ///   - dependency: The dependency type to be retrieved
  ///   - scope: The `Scope` in which the dependency is held
  public func get<Dependency>(dependency type: Dependency.Type, in scope: Scope) -> Dependency? {
    get(
      dependency: type,
      for: .scoped(scope: scope, type: type)
    )
  }

  // MARK: - Unregister
  private func unregister<Dependency>(dependency: Dependency.Type, for key: Key) {
    lock.lock(); defer { lock.unlock() }
    store[key] = nil
    lazyInits[key] = nil
  }

  /// Removes a global dependency from the store.
  ///
  /// After registering them via `registerGlobal<RepresentedType, Dependency>(dependency: Dependency, representing: RepresentedType.Type)`, a global dependency can be removed by calling `unregisterGlobal<Dependency>(dependency type: Dependency.Type)`.
  ///
  /// ## ⚠️ Important ⚠️
  /// Dependencies need to be unregistered via the type they are registered to represent (RepresentedType).
  /// This allows you to register a concrete implementation of a Protocol and retrieve it via the protocol type.
  ///
  /// - Parameters:
  ///   - dependency: The dependency type to be removed
  public func unregisterGlobal<Dependency>(dependency type: Dependency.Type) {
    unregister(
      dependency: type,
      for: .global(type)
    )
  }

  /// Removes a scoped dependency from the store.
  ///
  /// After registering a scoped dependency via `registerGlobal<RepresentedType, Dependency>(dependency: Dependency, representing: RepresentedType.Type, in scope: Scope)`, a scoped dependency can be removed by calling `unregisterGlobal<Dependency>(dependency type: Dependency.Type, in scope: Scope)`.
  ///
  /// ## ⚠️ Important ⚠️
  /// Dependencies need to be unregistered via the type they are registered to represent (RepresentedType).
  /// This allows you to register a concrete implementation of a Protocol and retrieve it via the protocol type.
  ///
  /// - Parameters:
  ///   - dependency: The dependency type to be removed
  ///   - scope: The `Scope` in which the dependency is held
  public func unregister<Dependency>(dependency type: Dependency.Type, in scope: Scope) {
    unregister(
      dependency: type,
      for: .scoped(scope: scope, type: type)
    )
  }

  // MARK: - Reset
  /// Resets the store and removes all dependencies
  public func reset() {
    lock.lock(); defer { lock.unlock() }
    store = [:]
    lazyInits = [:]
  }
}

extension DependencyStore.Scope: ExpressibleByStringLiteral {
  public init(stringLiteral value: String) {
    self.init(value)
  }
}
