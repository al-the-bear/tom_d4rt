import '../runtime_interfaces.dart';
import '../exceptions.dart';
import '../interpreter_visitor.dart';
import 'registration.dart' hide BridgedMethodCallable;
import '../callable.dart';

/// Represents a natively defined class that is accessible to the interpreter.
///
/// BridgedClass allows native Dart classes to be used within interpreted code
/// by providing metadata and adapters for constructors, methods, getters, and setters.
/// This enables seamless integration between native and interpreted environments.
///
/// ## Example:
/// ```dart
/// final bridgedString = BridgedClass(
///   String,
///   name: 'String',
///   constructors: {
///     '': StringConstructor(),
///   },
///   methods: {
///     'toLowerCase': StringToLowerCaseMethod(),
///   },
/// );
/// ```
class BridgedClass implements RuntimeType {
  /// Static registry of supertype relationships for bridged classes.
  /// Maps class name → set of supertype class names.
  /// This allows BridgedClass→BridgedClass subtype checking to walk
  /// the native Dart class hierarchy without dart:mirrors.
  static final Map<String, Set<String>> _supertypeRegistry = {};

  /// Memoised results of [transitiveSupertypeNames], dropped wholesale by
  /// [registerSupertypes].
  ///
  /// SCC19: the closure is read on every `is` and every `catch` once
  /// [isSubtypeOf] consults it, and recomputing it allocates three collections
  /// per query — measured at 0.38us against 0.057us for the direct-supertype
  /// short circuit. Registration happens at startup and the closures are
  /// immutable between registrations, so caching is exact rather than
  /// approximate.
  static final Map<String, List<String>> _transitiveCache = {};

  /// Register supertype relationships for bridged classes.
  /// Each key is a class name, and the value is a list of its supertype names.
  /// Example: {'StatelessWidget': ['Widget', 'DiagnosticableTree']}
  ///
  /// **Idempotent:** The per-key value is a [Set], and we use [Set.addAll]
  /// — repeated calls with the same hierarchy add nothing the second time.
  /// Safe to invoke twice when a process re-runs a generator-emitted
  /// `registerProxyFactories()` block (e.g. on a second `FlutterD4rt`
  /// instance after `_relaxersRegistered` is removed).
  static void registerSupertypes(Map<String, List<String>> hierarchy) {
    for (final entry in hierarchy.entries) {
      _supertypeRegistry.putIfAbsent(entry.key, () => {}).addAll(entry.value);
    }
    // A new edge can lengthen the closure of a class that is not named in
    // `hierarchy` — anything reaching `entry.key` transitively — so the whole
    // cache is dropped rather than selectively pruned. Registration is a
    // startup activity; this runs a handful of times per process.
    _transitiveCache.clear();
  }

  /// Walk the registered supertype chain (transitively) starting from
  /// [className] and return the full set of ancestor class names in
  /// breadth-first order. Used by interface-proxy resolution so an
  /// interpreted class like `PanelTheme extends InheritedTheme` can still
  /// match a proxy factory registered for `InheritedWidget` up the chain.
  /// Excludes [className] itself.
  ///
  /// Nearest-first, so callers that want the most specific supertype can take
  /// the first match. The `seen` set is what makes the walk safe on a cyclic
  /// registry — nothing stops a caller registering one.
  ///
  /// The result is unmodifiable: it is shared with every other caller through
  /// [_transitiveCache], so mutating it would corrupt the next query.
  static List<String> transitiveSupertypeNames(String className) {
    final cached = _transitiveCache[className];
    if (cached != null) return cached;
    final seen = <String>{};
    final order = <String>[];
    final queue = <String>[];
    final direct = _supertypeRegistry[className];
    if (direct != null) queue.addAll(direct);
    while (queue.isNotEmpty) {
      final next = queue.removeAt(0);
      if (!seen.add(next)) continue;
      order.add(next);
      final step = _supertypeRegistry[next];
      if (step != null) queue.addAll(step);
    }
    final result = List<String>.unmodifiable(order);
    _transitiveCache[className] = result;
    return result;
  }

  /// The native Dart type this bridge represents.
  final Type nativeType; // Keep nativeType for bridge logic

  @override
  /// The name of this class as it appears in interpreted code.
  final String name;

  /// Additional native class names that should map to this bridged class.
  /// This is essential for mapping Dart's internal implementation classes to their public interfaces.
  ///
  /// For example, Stream has many internal implementations like '_MultiStream', '_ControllerStream',
  /// '_BroadcastStream', etc. When the interpreter encounters these native objects at runtime,
  /// it needs to know they should be treated as 'Stream' instances.
  ///
  /// Without nativeNames:
  /// - runtime error: "No registered bridged class found for native type _MultiStream"
  ///
  /// With nativeNames: ['_MultiStream', '_ControllerStream', ...]:
  /// - The environment can map these internal types to the Stream bridge
  /// - Methods like toList(), listen(), etc. become available on these objects
  ///
  /// Used by Environment.toBridgedClass() to perform fallback lookups when
  /// the exact nativeType doesn't match any registered bridge.
  final List<String>? nativeNames;

  /// A function that determines if the current runtime type is a subtype of another runtime type.
  ///
  /// This function is used to perform subtype checking at runtime, which is essential
  /// for type safety and polymorphism in the bridge system.
  ///
  /// Parameters:
  /// - [other]: The runtime type to check against for subtype relationship
  /// - [value]: Optional value that can be used for additional context during subtype checking
  ///
  /// Returns:
  /// - `true` if this type is a subtype of [other]
  /// - `false` if this type is not a subtype of [other]
  ///
  /// The function can be null if subtype checking is not supported or not needed
  /// for this particular runtime type.
  final bool Function(BridgedClass other, {Object? value})? isSubtypeOfFunc;

  /// A function that determines if a native value can be assigned to this bridged type.
  ///
  /// This is used when bridging native values back to the interpreter. When a native
  /// method returns an instance of a private subclass (e.g., `_Linear extends Curve`),
  /// the bridge lookup by exact type will fail. This function allows the runtime to
  /// find an appropriate supertype bridge by checking `isAssignable(nativeValue)`.
  ///
  /// Example for Curve bridge:
  /// ```dart
  /// BridgedClass(
  ///   nativeType: Curve,
  ///   isAssignable: (v) => v is Curve,
  ///   ...
  /// )
  /// ```
  ///
  /// When `Curves.linear` returns a `_Linear` instance, the runtime will:
  /// 1. Try exact type lookup for `_Linear` - fails (not registered)
  /// 2. Iterate through registered bridges, checking `isAssignable`
  /// 3. Find the `Curve` bridge where `_Linear() is Curve` returns true
  /// 4. Wrap the `_Linear` instance using the `Curve` bridge
  final bool Function(Object?)? isAssignable;

  // Number of expected type parameters
  final int typeParameterCount;

  // Support for mixin usage
  final bool canBeUsedAsMixin;

  /// Whether the bridged native class is `abstract` (cannot be instantiated
  /// directly).
  ///
  /// Plan I: when an interpreted subclass calls `super()` against an abstract
  /// bridged base whose generator emitted no constructor adapter (because of
  /// GEN-051's abstract/sealed skip rule), the runtime treats the super-call
  /// as a no-op — the abstract type can never be constructed natively, so
  /// the subclass's own proxy/state is what carries the bridged identity.
  /// Mirrors the existing `D4.hasInterfaceProxy` fallback behaviour for the
  /// case where no proxy is registered.
  final bool isAbstract;

  /// **GEN-115 (Phase 1)** — Distance from `Object` in the native Dart
  /// inheritance hierarchy, i.e. the number of distinct supertypes
  /// (`allSupertypes.length`, excluding `Object` itself).
  ///
  /// Used by [Environment._filterToMostSpecific] as the primary tiebreaker
  /// when multiple `isAssignable`-positive bridges match a native instance —
  /// the deepest bridge wins, which is exact-semantically equivalent to a
  /// Dart `is`-chain walk picking the most-specific declared type.
  ///
  /// `0` is the legacy default for hand-written bridges that have not yet
  /// been migrated to emit a depth. When all matches have depth `0` (or
  /// equal depth) the resolver falls back to the older name-based
  /// supertype-elimination walk via [transitiveSupertypeNames].
  ///
  /// Populated by the generator from
  /// `ClassInfo.allSupertypeNames.length`. Hand-written bridges may pass
  /// their own depth if they need to participate in tie-breaking; otherwise
  /// leave it at `0` and the name-based walk continues to apply.
  final int hierarchyDepth;

  // Adapters for constructors
  Map<String, BridgedConstructorCallable> constructors = {};
  // Adapters for instance methods
  Map<String, BridgedMethodAdapter> methods = {};
  // Adapters for static members and getters/setters
  Map<String, BridgedStaticMethodAdapter> staticMethods = {};
  Map<String, BridgedStaticGetterAdapter> staticGetters = {};
  Map<String, BridgedStaticSetterAdapter> staticSetters = {};
  Map<String, BridgedInstanceGetterAdapter> getters = {};
  Map<String, BridgedInstanceSetterAdapter> setters = {};

  // Signature strings for introspection
  Map<String, String> constructorSignatures = {};
  Map<String, String> methodSignatures = {};
  Map<String, String> staticMethodSignatures = {};
  Map<String, String> staticGetterSignatures = {};
  Map<String, String> staticSetterSignatures = {};
  Map<String, String> getterSignatures = {};
  Map<String, String> setterSignatures = {};

  BridgedClass({
    required this.nativeType,
    required this.name,
    this.nativeNames,
    this.typeParameterCount = 0,
    this.canBeUsedAsMixin = false,
    this.isAbstract = false,
    this.hierarchyDepth = 0,
    this.isAssignable,
    this.constructors = const {},
    this.staticMethods = const {},
    this.staticGetters = const {},
    this.staticSetters = const {},
    this.methods = const {},
    this.getters = const {},
    this.setters = const {},
    this.constructorSignatures = const {},
    this.methodSignatures = const {},
    this.staticMethodSignatures = const {},
    this.staticGetterSignatures = const {},
    this.staticSetterSignatures = const {},
    this.getterSignatures = const {},
    this.setterSignatures = const {},
    this.isSubtypeOfFunc,
  });

  @override
  bool isSubtypeOf(RuntimeType other, {Object? value}) {
    // Any concrete type is a subtype of a type parameter (T)
    if (other is TypeParameter) return true;

    if (other is BridgedClass) {
      if (isSubtypeOfFunc != null) {
        return isSubtypeOfFunc!.call(other, value: value);
      }
      if (name == 'num') {
        // DFUB7: `num` is a subtype of `num` (and, below, of `Object`), but NOT
        // of its own subtypes `int`/`double`. The downward direction
        // (int/double <: num) is handled separately further down. Returning
        // true for int/double here made num a subtype of its subtypes.
        final isSubtype = switch (other.name) {
          'num' => true,
          _ => false,
        };
        return isSubtype;
      }

      if (nativeType == other.nativeType) return true;

      // Common Dart type hierarchy relationships
      // Object is a supertype of everything
      if (other.name == 'Object') return true;
      // List, Set implement Iterable
      if (other.name == 'Iterable' && (name == 'List' || name == 'Set')) {
        return true;
      }
      // int, double are subtypes of num
      if (other.name == 'num' && (name == 'int' || name == 'double')) {
        return true;
      }

      // GEN-075: Check native type hierarchy via isAssignable
      // When the value's native object satisfies the target class's isAssignable,
      // the native type IS a subtype (e.g., Row is a subtype of Widget).
      if (value != null && other.isAssignable != null) {
        final nativeValue = value is BridgedInstance
            ? value.nativeObject
            : value;
        if (other.isAssignable!(nativeValue)) return true;
      }

      // RC-7b: Check static supertype registry for native class hierarchy.
      // This handles cases like StatelessWidget→Widget where BridgedClass
      // objects don't have parent references.
      //
      // SCC19: consult the FULL closure. This used to check the direct
      // supertypes and one further hop and then stop — the comment here said
      // "walk the registry chain", but it walked exactly one extra link — so a
      // chain three levels deep answered false, while the member walk, reading
      // the same registry through [transitiveSupertypeNames], went all the way
      // down. A bridge could therefore resolve its inherited members correctly
      // and deny being a subtype of its own root, and every hierarchy block in
      // the stdlib was written with its closure flattened by hand to work
      // around it.
      //
      // The direct hit is kept as a short circuit: it answers most queries
      // without allocating the walk at all.
      final supertypes = _supertypeRegistry[name];
      if (supertypes == null) return false;
      if (supertypes.contains(other.name)) return true;
      return transitiveSupertypeNames(name).contains(other.name);
    }

    return false;
  }

  // Method to find a constructor adapter
  BridgedConstructorCallable? findConstructorAdapter(String name) {
    return constructors[name];
  }

  // Method to find an instance method adapter
  BridgedMethodAdapter? findInstanceMethodAdapter(String name) {
    return methods[name];
  }

  // Finders for other adapters
  BridgedStaticMethodAdapter? findStaticMethodAdapter(String name) {
    return staticMethods[name];
  }

  BridgedStaticGetterAdapter? findStaticGetterAdapter(String name) {
    return staticGetters[name];
  }

  BridgedStaticSetterAdapter? findStaticSetterAdapter(String name) {
    return staticSetters[name];
  }

  BridgedInstanceGetterAdapter? findInstanceGetterAdapter(String name) {
    return getters[name];
  }

  BridgedInstanceSetterAdapter? findInstanceSetterAdapter(String name) {
    return setters[name];
  }
}

/// Represents an instance of a bridged native class.
class BridgedInstance<T extends Object> implements RuntimeValue {
  final BridgedClass bridgedClass;
  final T nativeObject;
  // Stores the type arguments provided at creation
  final List<RuntimeType> typeArguments;

  // Main constructor
  BridgedInstance(
    this.bridgedClass,
    this.nativeObject, {
    this.typeArguments = const [],
  }) {
    D4rtDiag.bridgedAllocs++;
  }

  @override
  RuntimeType get valueType => bridgedClass;

  @override
  Object? get(String name) {
    // 1. Check if it's a BRIDGED instance METHOD
    final methodAdapter = bridgedClass.findInstanceMethodAdapter(name);
    if (methodAdapter != null) {
      // Return a Callable bound to this instance and the adapter
      return BridgedMethodCallable(this, methodAdapter, name);
    }

    // RC-7: If the wrapped native object is an Enum, handle .name and .index
    // This covers cases where a bridged getter returns a native enum value
    // wrapped in BridgedInstance (e.g., paint.blendMode returns BlendMode.srcOver
    // as a BridgedInstance, then .name is requested).
    if (nativeObject is Enum) {
      switch (name) {
        case 'name':
          return (nativeObject as Enum).name;
        case 'index':
          return (nativeObject as Enum).index;
      }
    }

    // This should be handled by visitors (PrefixedIdentifier, PropertyAccess)
    // for them to have access to the visitor if necessary.
    // The logic here is simplified and could be incorrect if a getter
    // would need to be returned as a value.

    // 3. If neither method nor getter found, throw an error
    throw UndefinedMemberD4rtException(
      "Undefined property or method '$name' on bridged instance of '${bridgedClass.name}'",
      memberName: name,
    );
  }

  @override
  void set(String name, Object? value, [InterpreterVisitor? visitor]) {
    // Visitor is optional
    throw UnimplementedD4rtException(
      "set('$name', ...) not implemented for BridgedInstance of '${bridgedClass.name}'",
    );
  }

  @override
  String toString() {
    // Delegate to the native toString() method? Or just a representation?
    try {
      return nativeObject.toString();
    } catch (_) {
      return "Instance of native '${bridgedClass.name}'";
    }
  }
}

/// Represents a generic type parameter like T, U, etc.
class TypeParameter implements RuntimeType {
  @override
  final String name;
  final RuntimeType?
  bound; // The extends clause if any (e.g., T extends Object)

  TypeParameter(this.name, {this.bound});

  @override
  bool isSubtypeOf(RuntimeType other, {Object? value}) {
    // DFUB7: a type parameter is trivially a subtype of another type parameter.
    if (other is TypeParameter) return true;
    // Bounded (`T extends X`): T is a subtype of `other` exactly when its bound
    // is — e.g. `T extends num` is not a subtype of `String`.
    if (bound != null) return bound!.isSubtypeOf(other, value: value);
    // Unbounded (`T`, implicitly `T extends Object?`): only the top types.
    return _isTopType(other);
  }

  /// DFUB7: the Dart top types an unbounded type parameter is a subtype of.
  static bool _isTopType(RuntimeType other) {
    final n = other.name;
    return n == 'Object' || n == 'dynamic' || n == 'void';
  }

  @override
  String toString() => name;
}
