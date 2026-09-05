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

  /// Walk the registered supertype chain transitively. Mirror of the
  /// tom_d4rt_ast helper; used by interface-proxy resolution so
  /// e.g. `PanelTheme extends InheritedTheme` finds a proxy factory
  /// registered for `InheritedWidget`.
  ///
  /// Breadth-first and nearest-first, so callers that want the most specific
  /// supertype can take the first match. The `seen` set is what makes the walk
  /// safe on a cyclic registry — nothing stops a caller registering one.
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
      // supertypes and one further hop and then stop, so a chain three levels
      // deep answered false — while the member walk, reading the same registry
      // through [transitiveSupertypeNames], went all the way down. A bridge
      // could therefore resolve its inherited members correctly and deny being
      // a subtype of its own root, and every hierarchy block in the stdlib was
      // written with its closure flattened by hand to work around it.
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

    // This should be handled by visitors (PrefixedIdentifier, PropertyAccess)
    // for them to have access to the visitor if necessary.
    // The logic here is simplified and could be incorrect if a getter
    // would need to be returned as a value.

    // RC-7: Enum property fallback. If the wrapped native object is an Enum,
    // provide access to standard enum properties (.name, .index) even when
    // the bridge doesn't define custom getters for them.
    if (nativeObject is Enum) {
      final enumObj = nativeObject as Enum;
      if (name == 'name') return enumObj.name;
      if (name == 'index') return enumObj.index;
    }

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

  /// SCC32: value equality, delegated to the wrapped native.
  ///
  /// Without this the wrapper compared by identity, so two separately
  /// constructed wrappers around equal natives were different keys. The
  /// interpreted `a == b` expression looked right only because
  /// `visitBinaryExpression` unwraps both operands before comparing — the
  /// wrapper itself was never consulted. So a script got `true` from `==` and a
  /// miss from every hash-based collection, with no error either way. `List`
  /// membership was wrong too (`[Duration(seconds: 1)].contains(Duration(
  /// seconds: 1))` was false), which no amount of hashing would explain and
  /// which is why `hashCode` alone was not the fix.
  ///
  /// **Equality with the raw native is deliberate**, and it is the same choice
  /// [BridgedEnumValue] already made for the same reason. d4rt is not
  /// consistent about wrapping: a constructor call yields a wrapper, while
  /// every bridged *method* return yields a bare native, so
  /// `DateTime(2021).difference(x)` and `Duration(seconds: 1)` are the same
  /// value in two different representations and routinely meet in one
  /// collection.
  ///
  /// This is asymmetric, which is normally a hazard — `raw == wrapper` stays
  /// false because a native's `==` rejects a foreign type, and nothing here can
  /// change that. It is safe because Dart's hash lookup calls
  /// `lookupKey == storedKey`, making the lookup key the receiver: whenever the
  /// wrapper is the value being looked *up*, this operator runs and the
  /// comparison succeeds regardless of how the key was stored. The opposite
  /// direction — a raw native looking up a stored wrapper — would fall on the
  /// unfixable side, which is why hash keys are additionally normalized to the
  /// native at storage time (see `_unwrapHashKey` in the interpreter). Between
  /// the two, no stored key is ever a wrapper and every lookup resolves.
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is BridgedInstance) {
      return nativeObject == other.nativeObject;
    }
    return nativeObject == other;
  }

  /// Must agree with [operator ==], and therefore with the native, or a value
  /// that compares equal would still land in a different bucket.
  @override
  int get hashCode => nativeObject.hashCode;
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
