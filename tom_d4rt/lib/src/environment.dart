import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/src/bridge/bridged_enum.dart';
import 'package:tom_d4rt/src/utils/extensions/string.dart';

/// A wrapper for lazy-evaluated global getters with optional setter support.
///
/// When a [GlobalGetter] is stored in the environment and accessed via
/// [Environment.get], the getter function is invoked and the result is
/// returned. This enables lazy evaluation of global variables that may
/// not be initialized at registration time.
///
/// If a [setter] is provided, the [GlobalGetter] also supports assignment.
/// When assigned to via [Environment.assign], the setter function is called
/// instead of replacing the wrapper in the environment.
///
/// ## Example:
/// ```dart
/// // Read-only global getter
/// environment.define('vscode', GlobalGetter(() => VSCode.instance));
///
/// // Global getter with setter support
/// int _counter = 0;
/// environment.define('counter', GlobalGetter(
///   () => _counter,
///   setter: (value) => _counter = value as int,
/// ));
/// ```
class GlobalGetter {
  /// The getter function that returns the value when called.
  final Object? Function() getter;

  /// Optional setter function for assignment support.
  /// If null, assignment to this global is not supported.
  final void Function(Object? value)? setter;

  /// Creates a new global getter wrapper.
  ///
  /// [getter] The function that returns the current value.
  /// [setter] Optional function to handle assignment. If null, assignment
  ///   will throw an error.
  GlobalGetter(this.getter, {this.setter});

  /// Calls the getter and returns the result.
  Object? call() => getter();

  /// Whether this global getter supports assignment.
  bool get hasSetter => setter != null;
}

/// Represents the execution environment for interpreted code.
///
/// The Environment class manages variable bindings, function definitions,
/// class definitions, and bridged types for a specific scope. Environments
/// form a chain through their enclosing relationship, enabling lexical scoping.
///
/// ## Features:
/// - Variable and function storage
/// - Bridged class and enum registration
/// - Extension method management
/// - Prefixed imports support
/// - Scope chain traversal for name resolution
///
/// ## Example:
/// ```dart
/// final globalEnv = Environment();
/// final functionEnv = Environment(enclosing: globalEnv);
///
/// globalEnv.define('globalVar', 42);
/// functionEnv.define('localVar', 'hello');
///
/// // Will find 'globalVar' by traversing up the scope chain
/// final value = functionEnv.get('globalVar');
/// ```
class Environment {
  final Environment? _enclosing;
  final Map<String, Object?> _values = {};
  final Map<String, BridgedClass> _bridgedClasses = {};
  final Map<Type, BridgedClass> _bridgedClassesLookupByType = {};
  // GEN-115 Phase 2 — runtimeType→bridge resolution cache. Populated by
  // [toBridgedInstance] after a non-trivial step-2 / step-3 walk so that
  // repeat lookups of the same private impl type (e.g. _BodyBoxConstraints,
  // _BigIntImpl, FakeTimer) skip the O(N) iteration over every registered
  // bridge. Invalidated on every mutation of [_bridgedClassesLookupByType]
  // via [_invalidateResolutionCache].
  final Map<Type, BridgedClass> _resolvedTypeCache = {};
  final Map<String, BridgedEnum> _bridgedEnums = {}; // Store bridged enums
  final List<InterpretedExtension> _unnamedExtensions =
      []; // Store unnamed extensions
  final Map<String, Environment> _prefixedImports = {}; // For prefixed imports

  /// Creates a new environment, optionally with an enclosing (parent) environment.
  ///
  /// [enclosing] The parent environment for lexical scoping. If null, this becomes a root environment.
  Environment({Environment? enclosing}) : _enclosing = enclosing;

  /// Gets the enclosing (parent) environment, if any.
  Environment? get enclosing => _enclosing;

  /// Gets the map of variable bindings in this environment.
  Map<String, Object?> get values => _values;

  /// Gets the names of all bridged classes registered in this environment.
  List<String> get bridgedClassNames => _bridgedClasses.keys.toList();

  /// Gets the names of all bridged enums registered in this environment.
  List<String> get bridgedEnumNames => _bridgedEnums.keys.toList();

  /// Defines a new variable or function in this environment.
  ///
  /// [name] The name of the variable or function.
  /// [value] The value to bind to the name.
  ///
  /// If a name is already defined or conflicts with a bridged type,
  /// a warning will be logged.
  /// Removes [name] from this environment's local [_values] map.
  ///
  /// Used by [D4rt.resetScriptDeclarations] (interpreter_unfixable.md
  /// §U28) to evict script-declared entries between `execute` /
  /// `executeBundle` calls while preserving the bridge maps. Returns
  /// whether an entry was removed. Does NOT walk the enclosing scope
  /// chain.
  ///
  /// Note: this only mutates [_values]. [_bridgedClasses], [_bridgedEnums],
  /// and [_bridgedClassesLookupByType] are left intact — bridge
  /// registrations survive a reset by design.
  bool removeLocalValue(String name) {
    if (!_values.containsKey(name)) return false;
    _values.remove(name);
    return true;
  }

  void define(String name, Object? value) {
    if (_values.containsKey(name) ||
        _bridgedClasses.containsKey(name) ||
        _bridgedEnums.containsKey(name)) {
      // CHECK: Also check bridged enums
      Logger.warn("Redefining variable or colliding with bridged type: $name");
    }
    _values[name] = value;
  }

  /// Registers a bridged class in this environment.
  ///
  /// [bridgedClass] The bridged class definition to register.
  ///
  /// This makes the native class available for use in interpreted code
  /// under the name specified by the bridged class definition.
  /// Registers a bridged class in this environment.
  ///
  /// [bridgedClass] The bridged class definition to register.
  ///
  /// This makes the native class available for use in interpreted code
  /// under the name specified by the bridged class definition.
  void defineBridge(BridgedClass bridgedClass) {
    final name = bridgedClass.name;

    if (_values.containsKey(name) ||
        _bridgedClasses.containsKey(name) ||
        _bridgedEnums.containsKey(name)) {
      // CHECK: Also check bridged enums
      Logger.warn(
          "Redefining bridged class or colliding with existing definition: $name");
    }
    _bridgedClasses[name] = bridgedClass;
    _bridgedClassesLookupByType[bridgedClass.nativeType] = bridgedClass;
    _invalidateResolutionCache();
    Logger.debug("[Environment] Defined bridge for class: $name");
  }

  /// Clears the [_resolvedTypeCache]. Called from every site that mutates
  /// [_bridgedClassesLookupByType], because a newly-registered bridge can
  /// change the most-specific resolution for previously-cached runtimeTypes.
  void _invalidateResolutionCache() {
    if (_resolvedTypeCache.isNotEmpty) _resolvedTypeCache.clear();
  }

  /// Looks up a bridged class by name, walking the enclosing scope chain.
  /// Returns null if no bridge with [name] is registered in this environment
  /// or any of its parents. Used by the property-access supertype-walk
  /// fallback in `interpreter_visitor.dart` to resolve getters/methods that
  /// are declared on a supertype bridge when the leaf bridge has no matching
  /// adapter (e.g. `_AnimatedEvaluation` wraps as `AnimationWithParentMixin`,
  /// whose bridge lacks `value`; the walk falls back to the `Animation`
  /// bridge where `value` is declared).
  BridgedClass? findBridgedClassByName(String name) {
    Environment? current = this;
    while (current != null) {
      final found = current._bridgedClasses[name];
      if (found != null) return found;
      current = current._enclosing;
    }
    return null;
  }

  /// Pre-registers a bridge's native-type mapping for runtime type resolution.
  ///
  /// Unlike [defineBridge], this does NOT add [bridgedClass.name] to the
  /// lexical scope (`_bridgedClasses`). It only populates
  /// `_bridgedClassesLookupByType` so that [toBridgedInstance] can wrap
  /// native objects returned by bridge methods (e.g. `GestureSettings`
  /// returned by `GestureSettings.copyWith()`) regardless of whether the
  /// script's imports have been processed yet.
  ///
  /// Call this on `globalEnvironment` at interpreter-init time (after
  /// `ModuleLoader` is created but before any script runs) so that all
  /// registered bridges are available for native-object wrapping. The
  /// module-level [defineBridge] calls at import time will overwrite the
  /// type entry if necessary, but the type entry is always present.
  ///
  /// Mirrors the type-population step of [D4rtRunner._registerBridgedDefinitions].
  void registerBridgeType(BridgedClass bridgedClass) {
    _bridgedClassesLookupByType[bridgedClass.nativeType] = bridgedClass;
    _invalidateResolutionCache();
  }

  /// Propagates every bridge registered in this environment's type lookup
  /// to [target] for native-object resolution.
  ///
  /// Use case: stdlib modules (dart:math, dart:io, …) live in isolated
  /// per-stdlib environments to avoid lexical name collisions, but their
  /// native types (e.g. `_Random`) must still be discoverable from
  /// `globalEnvironment.toBridgedInstance` when a script passes a native
  /// instance through an interpreted function. Calling
  /// `stdlibEnv.propagateBridgeTypesTo(globalEnvironment)` after
  /// registration mirrors the type→bridge mapping without leaking the
  /// lexical name `Random` into globalEnvironment.
  ///
  /// Mirror of `tom_d4rt_ast` `Environment.propagateBridgeTypesTo`.
  void propagateBridgeTypesTo(Environment target) {
    if (identical(target, this)) return;
    var added = false;
    for (final entry in _bridgedClassesLookupByType.entries) {
      target._bridgedClassesLookupByType.putIfAbsent(entry.key, () {
        added = true;
        return entry.value;
      });
    }
    if (added) target._invalidateResolutionCache();
  }

  /// GEN-078: Registers a class alias that maps [aliasName] to an existing
  /// bridged class registered under [targetName].
  ///
  /// This allows deprecated type alias names (e.g., `MaterialStateProperty`)
  /// to resolve to their canonical bridged class (e.g., `WidgetStateProperty`).
  void defineBridgeAlias(String aliasName, String targetName) {
    // Walk the scope chain to find the target bridged class
    BridgedClass? target;
    Environment? current = this;
    while (current != null) {
      target = current._bridgedClasses[targetName];
      if (target != null) break;
      current = current._enclosing;
    }
    if (target == null) {
      Logger.warn(
          "[Environment] Cannot register alias '$aliasName' -> '$targetName': "
          "target class not found");
      return;
    }
    _bridgedClasses[aliasName] = target;
    Logger.debug(
        "[Environment] Defined bridge alias: $aliasName -> $targetName");
  }

  /// Converts a native object to a bridged instance if a bridge exists.
  ///
  /// [nativeObject] The native object to convert.
  ///
  /// Returns a [BridgedInstance] if a bridge is found for the object's type,
  /// otherwise throws a [D4rtException] (caller should handle).
  ///
  /// Resolution order:
  ///   1. Direct lookup by [Type] (most specific — bridges with explicit
  ///      [BridgedClass.nativeType]).
  ///   2. [BridgedClass.isAssignable] iteration — keeps the LAST match across
  ///      all enclosing environments. Bridges register general→specific, so
  ///      the last match is the most specific (e.g., CupertinoTextThemeData
  ///      wins over Diagnosticable). Required to disambiguate native types
  ///      whose name happens to be a prefix of another bridge's name —
  ///      e.g., `StringCharacters implements Characters`: without this step
  ///      the name-prefix fallback in [toBridgedClass] would wrap it as
  ///      `String`. Bucket #11 fix.
  ///   3. [toBridgedClass] name-based fallbacks (private impl types,
  ///      generic suffix matching, `*Impl` prefix matching). Used only when
  ///      neither direct type lookup nor isAssignable found a bridge.
  BridgedInstance? toBridgedInstance(Object? nativeObject) {
    if (nativeObject == null) {
      return null;
    }
    final runtimeType = nativeObject.runtimeType;

    // 1) Direct type lookup.
    Environment? current = this;
    while (current != null) {
      final direct = current._bridgedClassesLookupByType[runtimeType];
      if (direct != null) {
        return BridgedInstance(direct, nativeObject);
      }
      current = current._enclosing;
    }

    // 1b) Resolution cache. GEN-115 Phase 2: a previous call already paid
    //     the full step-2 / step-3 cost for this runtimeType; reuse it.
    //     Walks the env chain so a hit in any enclosing scope short-circuits.
    current = this;
    while (current != null) {
      final cached = current._resolvedTypeCache[runtimeType];
      if (cached != null) {
        return BridgedInstance(cached, nativeObject);
      }
      current = current._enclosing;
    }

    // 2) isAssignable iteration. Bridges may register in any order, so we
    //    collect ALL matches and then drop those that are supertypes of
    //    another match using [BridgedClass.transitiveSupertypeNames]. The
    //    remaining set is "leaf" matches; we pick the last one (preserves
    //    legacy LAST-wins behaviour when the registry doesn't disambiguate).
    //
    //    D2 fix: A native object whose runtimeType is a private impl of
    //    BoxConstraints (e.g. `_BodyBoxConstraints`) was wrapped as
    //    `Constraints` because the LAST-match-wins iteration picked the
    //    abstract base. With `BoxConstraints: [Constraints, ...]` registered
    //    in the supertype registry, the filter drops `Constraints` and
    //    keeps `BoxConstraints`, so `.maxWidth` resolves correctly.
    final allMatches = <BridgedClass>[];
    current = this;
    while (current != null) {
      for (final entry in current._bridgedClassesLookupByType.entries) {
        final bridge = entry.value;
        if (bridge.isAssignable != null &&
            bridge.isAssignable!(nativeObject)) {
          allMatches.add(bridge);
        }
      }
      current = current._enclosing;
    }
    if (allMatches.isNotEmpty) {
      final filtered = _filterToMostSpecific(allMatches);
      final picked = filtered.isNotEmpty ? filtered.last : allMatches.last;
      _resolvedTypeCache[runtimeType] = picked;
      return BridgedInstance(picked, nativeObject);
    }

    // 3) Name-based fallbacks (private impl, generic suffix, *Impl prefix).
    //    [toBridgedClass] will throw if no bridge matches — propagate.
    final bridgedClass = toBridgedClass(runtimeType);
    _resolvedTypeCache[runtimeType] = bridgedClass;
    return BridgedInstance(bridgedClass, nativeObject);
  }

  /// From a list of `isAssignable` matches, return the "most specific"
  /// candidates — typically a single concrete type plus possibly unrelated
  /// mixins. Order is preserved so the caller can apply LAST-wins for
  /// tie-breaking among the leaves.
  ///
  /// **GEN-115 (Phase 1)** — When the generator-emitted
  /// [BridgedClass.hierarchyDepth] is populated for at least one match
  /// (`depth > 0`), specificity is decided by an O(n) `argmax(depth)`
  /// walk. This is exact-semantically equivalent to a Dart `is`-chain
  /// walk picking the most-specific declared type, and replaces the
  /// O(n²) name-based supertype-union walk that depended on the
  /// hand-maintained `_supertypeRegistry`.
  ///
  /// When every match has `depth == 0` (the legacy default for
  /// hand-written or not-yet-regenerated bridges) the resolver falls
  /// back to the older D2 algorithm: build the union of supertype names
  /// across all matches via [BridgedClass.transitiveSupertypeNames] and
  /// drop any match whose name appears in that union (it is an ancestor
  /// of another match).
  List<BridgedClass> _filterToMostSpecific(List<BridgedClass> matches) {
    if (matches.length <= 1) return matches;

    // GEN-115 fast path: depth-driven argmax. Activated when any match
    // carries a generator-emitted depth. We keep every match at the
    // maximum depth (stable order preserved) so LAST-wins among
    // unrelated-but-equally-specific leaves keeps working.
    int maxDepth = 0;
    for (final m in matches) {
      if (m.hierarchyDepth > maxDepth) maxDepth = m.hierarchyDepth;
    }
    if (maxDepth > 0) {
      return matches
          .where((m) => m.hierarchyDepth == maxDepth)
          .toList(growable: false);
    }

    // Legacy D2 path — name-based supertype elimination, kept for bridges
    // that have not yet been regenerated with a populated hierarchyDepth.
    final supertypeUnion = <String>{};
    for (final m in matches) {
      supertypeUnion.addAll(BridgedClass.transitiveSupertypeNames(m.name));
    }
    final leaves =
        matches.where((m) => !supertypeUnion.contains(m.name)).toList(
              growable: false,
            );
    return leaves;
  }

  BridgedClass toBridgedClass(Type nativeType) {
    // Search current environment and enclosing ones
    Environment? current = this;
    while (current != null) {
      BridgedClass? bridgedClass =
          current._bridgedClassesLookupByType[nativeType];

      String nativeTypeName = nativeType.toString();

      if (bridgedClass == null && (nativeTypeName.substring(0, 1) == '_')) {
        if (nativeTypeName.endsWith('Impl')) {
          nativeTypeName = nativeTypeName.substringBeforeLast('Impl');
        }
        // Cluster HASHSET FIX: when matching nativeNames by prefix, choose the
        // LONGEST matching nativeName so a more-specific bridge (e.g. Iterator
        // with `_HashSetIterator` in nativeNames) wins over a less-specific
        // bridge (e.g. Set with `_HashSet` in nativeNames, which is a prefix of
        // `_HashSetIterator`). The exact `name == cleanedName` check still wins
        // first for canonical `_FooImpl → Foo` mappings.
        final cleanedName =
            nativeTypeName.substring(1).substringBefore('<');
        bridgedClass = current._bridgedClassesLookupByType.entries
            .firstWhereOrNull((e) => e.value.name == cleanedName)
            ?.value;
        bridgedClass ??=
            _longestNativeNamePrefixMatch(current, nativeTypeName);
      } else if (bridgedClass == null && nativeTypeName.contains('<')) {
        // Extract the base type name before '<' for accurate matching.
        // Using contains() was too broad — e.g., 'ListMapView<int>'.contains('View<')
        // would falsely match the Flutter View widget bridge.
        final baseTypeName =
            nativeTypeName.substring(0, nativeTypeName.indexOf('<'));
        bridgedClass = current._bridgedClassesLookupByType.entries
            .firstWhereOrNull((e) =>
                baseTypeName == e.value.name ||
                (e.value.nativeNames?.contains(baseTypeName) ?? false))
            ?.value;
        // Suffix match fallback: e.g., CastList → List, ListIterator → Iterator
        // Handles types that embed the bridge name as a suffix.
        bridgedClass ??= current._bridgedClassesLookupByType.entries
            .firstWhereOrNull((e) =>
                e.value.name.length >= 3 &&
                baseTypeName.endsWith(e.value.name) &&
                baseTypeName.length > e.value.name.length)
            ?.value;
      }
      bridgedClass ??= current._bridgedClassesLookupByType.entries
          .firstWhereOrNull((e) => e.value.name == nativeTypeName)
          ?.value;
      // Cluster HASHSET FIX: pick the LONGEST nativeName prefix so a
      // specific bridge (e.g. Iterator's `_HashSetIterator`) wins over a
      // less-specific bridge whose nativeName happens to be a shorter
      // prefix (e.g. Set's `_HashSet`).
      bridgedClass ??=
          _longestNativeNamePrefixMatch(current, nativeTypeName);

      // G-DCLI-05 FIX: Handle non-underscore implementation types like
      // ProgressBothImpl, where the class name contains the bridge name.
      // Check if any registered bridge name is a prefix of the native type name.
      // e.g., "ProgressBothImpl" contains bridge name "Progress"
      if (bridgedClass == null) {
        bridgedClass =
            current._bridgedClassesLookupByType.entries.firstWhereOrNull((e) {
          final bridgeName = e.value.name;
          // Only match if the bridge name is a substantial prefix (>= 3 chars)
          // and the native type name starts with it followed by more chars
          return bridgeName.length >= 3 &&
              nativeTypeName.startsWith(bridgeName) &&
              nativeTypeName.length > bridgeName.length;
        })?.value;
        if (bridgedClass != null) {
          Logger.debug(
              "[Environment] Matched native type '$nativeTypeName' to bridge '${bridgedClass.name}' via prefix matching");
        }
      }

      if (bridgedClass != null) {
        return bridgedClass;
      }

      current = current._enclosing;
    }

    throw RuntimeD4rtException(
        'Cannot bridge native object: No registered bridged class found for native type $nativeType.');
  }

  /// Finds the bridged class whose `nativeNames` contains the LONGEST entry
  /// that is a prefix of [nativeTypeName].
  ///
  /// Cluster HASHSET fix: When multiple bridges declare overlapping native
  /// name prefixes (e.g. Set has `_HashSet`, Iterator has `_HashSetIterator`),
  /// the previous `firstWhereOrNull` would match whichever bridge was
  /// registered first — typically Set, since it registers before Iterator in
  /// `core.dart`. That made `_HashSetIterator` resolve to Set's bridge and
  /// fail with `Bridged class 'Set' has no instance method named 'moveNext'`.
  /// Choosing the longest prefix means an exact `_HashSetIterator` entry on
  /// Iterator wins over Set's shorter `_HashSet` prefix.
  BridgedClass? _longestNativeNamePrefixMatch(
      Environment env, String nativeTypeName) {
    BridgedClass? best;
    int bestLen = 0;
    for (final entry in env._bridgedClassesLookupByType.entries) {
      final names = entry.value.nativeNames;
      if (names == null) continue;
      for (final name in names) {
        if (name.length > bestLen && nativeTypeName.startsWith(name)) {
          bestLen = name.length;
          best = entry.value;
        }
      }
    }
    return best;
  }

  // Method to define bridged enums
  void defineBridgedEnum(BridgedEnum bridgedEnum) {
    final name = bridgedEnum.name;
    if (_values.containsKey(name) ||
        _bridgedClasses.containsKey(name) ||
        _bridgedEnums.containsKey(name)) {
      Logger.warn(
          "Redefining bridged enum or colliding with existing definition: $name");
    }
    _bridgedEnums[name] = bridgedEnum;
    Logger.debug("[Environment] Defined bridge for enum: $name");
  }

  /// Checks if the given object is a bridged enum value
  BridgedEnum? findBridgedEnumForValue(Object value) {
    // Fast-path: bridged enums only ever wrap native Enum instances. Bailing
    // out early for non-enums avoids walking the entire enum registry (and,
    // since Cluster-D added a prefix-import recursion, prevents potential
    // cycles through `_prefixedImports` for non-enum values that callers in
    // `runtime_types.dart` may probe with).
    if (value is! Enum) return null;
    return _findBridgedEnumForValueImpl(value, <Environment>{});
  }

  BridgedEnum? _findBridgedEnumForValueImpl(
      Object value, Set<Environment> visited) {
    // Cluster-D follow-up (pointer_data_test stack overflow): prefixed
    // imports can form cycles in the env graph (a prefixed env's
    // `_enclosing` may point back into an env that already contains it
    // via `_prefixedImports`). Track visited envs to break the cycle.
    if (!visited.add(this)) return null;
    for (final bridgedEnum in _bridgedEnums.values) {
      for (final enumValue in bridgedEnum.values.values) {
        if (enumValue.nativeValue == value) {
          return bridgedEnum;
        }
      }
    }
    // Cluster-D (key_event_type_test): prefixed imports (e.g. `import 'dart:ui'
    // as ui`) store their bridged enums in a sibling environment under
    // _prefixedImports rather than on the _enclosing chain. Search those too
    // so enum-value lookup succeeds regardless of how the enum's library was
    // imported.
    for (final prefixedEnv in _prefixedImports.values) {
      final found =
          prefixedEnv._findBridgedEnumForValueImpl(value, visited);
      if (found != null) return found;
    }
    return _enclosing?._findBridgedEnumForValueImpl(value, visited);
  }

  /// Gets the BridgedEnumValue for a native enum value
  BridgedEnumValue? getBridgedEnumValue(Object value) {
    // Fast-path: bridged enums only ever wrap native Enum instances. Bailing
    // out early for non-enums avoids walking the entire enum registry (and,
    // since Cluster-D added a prefix-import recursion, prevents potential
    // cycles through `_prefixedImports` for non-enum values that callers in
    // `runtime_types.dart` may probe with).
    if (value is! Enum) return null;
    return _getBridgedEnumValueImpl(value, <Environment>{});
  }

  BridgedEnumValue? _getBridgedEnumValueImpl(
      Object value, Set<Environment> visited) {
    // Cluster-D follow-up (pointer_data_test stack overflow): prefixed
    // imports can form cycles in the env graph (a prefixed env's
    // `_enclosing` may point back into an env that already contains it
    // via `_prefixedImports`). Track visited envs to break the cycle.
    if (!visited.add(this)) return null;
    for (final bridgedEnum in _bridgedEnums.values) {
      for (final enumValue in bridgedEnum.values.values) {
        if (enumValue.nativeValue == value) {
          return enumValue;
        }
      }
    }
    // Cluster-D (key_event_type_test): prefixed imports (e.g. `import 'dart:ui'
    // as ui`) store their bridged enums in a sibling environment under
    // _prefixedImports rather than on the _enclosing chain. Search those too
    // so enum-value lookup succeeds regardless of how the enum's library was
    // imported.
    for (final prefixedEnv in _prefixedImports.values) {
      final found = prefixedEnv._getBridgedEnumValueImpl(value, visited);
      if (found != null) return found;
    }
    return _enclosing?._getBridgedEnumValueImpl(value, visited);
  }

  /// Retrieves the value associated with [name].
  /// Searches the current environment, then recursively searches parent environments.
  /// Returns `null` if the name is not found in the entire chain.
  dynamic get(String name) {
    Logger.debug(
        '[Env.get] Attempting to get "$name" in env: $hashCode'); // Log attempt + env hash

    // Check first if the name directly corresponds to a prefixed import.
    if (_prefixedImports.containsKey(name)) {
      Logger.debug(
          "[Env.get] Name '$name' corresponds to a prefixed import. Returning the prefixed environment.");
      return _prefixedImports[name]; // Return the Environment itself.
    }

    // Check if it's a prefixed access (ex: math.pi)
    if (name.contains('.')) {
      final parts = name.split('.');
      if (parts.length == 2) {
        final prefix = parts[0];
        final identifier = parts[1];
        if (_prefixedImports.containsKey(prefix)) {
          Logger.debug(
              "[Env.get] Prefixed access for '$name'. Searching for '$identifier' in the prefixed environment '$prefix'.");
          // Recursive call on the stored environment for the prefix.
          // No need to check _enclosing here, the prefixed environment will do that.
          try {
            return _prefixedImports[prefix]!.get(identifier);
          } on RuntimeD4rtException catch (e) {
            // If the identifier is not found in the prefixed environment, we want the original error to be propagated.
            // Or, according to the desired semantics, we could raise a new error indicating that 'identifier' was not found IN 'prefix'.
            throw RuntimeD4rtException(
                "Undefined name '$identifier' in imported prefix '$prefix'. Original error: ${e.message}");
          }
        } else {
          // The prefix itself is not found as a prefixed import.
          // We could fall into the normal search if 'prefix.identifier' is a valid variable name.
          // However, in Dart, an identifier cannot contain a '.' except for access.
          // So, if the prefix is not in _prefixedImports, it's an error.
          Logger.debug(
              "[Env.get] Prefix '$prefix' for '$name' not found in prefixed imports.");
        }
      } else {
        // Handle the case of multiple points, for example a.b.c. For now, we only support prefix.identifier.
        Logger.warn(
            "[Env.get] Name '$name' contains multiple points, not supported for simple prefixed access.");
        // Falling into the normal search could be an option, but let's raise an error for now
        // because it probably indicates an unexpected usage or an invalid variable name.
        throw RuntimeD4rtException(
            "Complex prefixed access not supported: $name. Use the form prefix.identifier.");
      }
    }

    // Normal search if there's no valid prefixed access or if the prefix is not resolved
    if (_values.containsKey(name)) {
      Logger.debug('[Env.get] Found \'$name\' locally in env: $hashCode');
      final value = _values[name];
      // Unwrap GlobalGetter for lazy evaluation
      if (value is GlobalGetter) {
        return value();
      }
      return value;
    }

    if (_bridgedClasses.containsKey(name)) {
      Logger.debug(
          " [Env.get] Found bridged class '$name' locally in env: $hashCode");
      return _bridgedClasses[name];
    }

    // Check for bridged enums
    if (_bridgedEnums.containsKey(name)) {
      Logger.debug(
          " [Env.get] Found bridged enum '$name' locally in env: $hashCode");
      return _bridgedEnums[name];
    }

    if (_enclosing != null) {
      Logger.debug(
          '[Env.get] Looking for \'$name\' in parent env: ${_enclosing.hashCode}');
      return _enclosing.get(name); // Recurse
    }

    Logger.debug(
        '[Env.get] \'$name\' not found in env chain starting from: $hashCode (no parent)'); // Log chain end
    throw RuntimeD4rtException("Undefined variable: $name");
  }

  /// Unwraps bridge wrappers for setter assignment.
  ///
  /// GEN-054: BridgedEnumValue wraps native enum values during interpretation.
  /// When assigning to a native setter, we need to unwrap back to the native value.
  Object? _unwrapForSetter(Object? value) {
    if (value is BridgedEnumValue) {
      return value.nativeValue;
    }
    // Add other unwrapping cases here as needed
    return value;
  }

  Object? assign(String name, Object? value) {
    Logger.debugLazy(() =>
        "[Env.assign] Attempting to assign '$name' = $value in env: $hashCode");
    if (_values.containsKey(name)) {
      final existing = _values[name];

      // Handle GlobalGetter with setter - call the native setter instead of replacing
      if (existing is GlobalGetter) {
        if (existing.hasSetter) {
          Logger.debug(" [Env.assign] Calling setter for GlobalGetter '$name'");
          // Unwrap BridgedEnumValue to its native value before calling the setter.
          // GEN-054: This ensures bridged enum values can be assigned to native setters.
          final unwrappedValue = _unwrapForSetter(value);
          existing.setter!(unwrappedValue);
          return value;
        } else {
          // GlobalGetter without setter - not assignable
          throw RuntimeD4rtException(
              "Cannot assign to read-only global getter '$name'. "
              "This global only has a getter, not a setter.");
        }
      }

      Logger.debug(" [Env.assign] Assigned '$name' locally in env: $hashCode");
      _values[name] = value;
      return value;
    }

    if (_bridgedClasses.containsKey(name)) {
      throw RuntimeD4rtException(
          "Cannot assign to the name of a bridged class: $name");
    }

    // Prevent assigning to bridged enum names
    if (_bridgedEnums.containsKey(name)) {
      throw RuntimeD4rtException(
          "Cannot assign to the name of a bridged enum: $name");
    }

    if (_enclosing != null) {
      Logger.debug(
          " [Env.assign] '$name' not found locally, assigning in parent env: ${_enclosing.hashCode}");
      return _enclosing.assign(
          name, value); // Delegate to the parent environment
    }

    Logger.debug(
        "[Env.assign] Variable '$name' not found for assignment, throwing error.");
    throw RuntimeD4rtException("Assigning to undefined variable '$name'.");
  }

  // Check if a variable is defined in *this* specific scope
  bool isDefinedLocally(String name) {
    return _values.containsKey(name);
  }

  /// Gets the raw value for a variable if defined locally, without GlobalGetter unwrapping.
  ///
  /// This is useful when you need to access the GlobalGetter wrapper itself
  /// rather than the value it returns. Returns null if not defined locally.
  Object? getRawValueIfDefined(String name) {
    if (_values.containsKey(name)) {
      return _values[name];
    }
    return null;
  }

  // Find the environment where a variable is defined
  Environment? findDefiningEnvironment(String name) {
    if (_values.containsKey(name)) {
      return this;
    }
    if (_enclosing != null) {
      return _enclosing.findDefiningEnvironment(name);
    }
    return null; // Not found in this scope or any enclosing scope
  }

  // Method to add unnamed extensions
  void addUnnamedExtension(InterpretedExtension extension) {
    _unnamedExtensions.add(extension);
  }

  // Method to find applicable extension members (Placeholder)
  Callable? findExtensionMember(Object? target, String name,
      {InterpreterVisitor? visitor}) {
    // G-DOV-10/11 FIX: Handle null targets by searching extensions on nullable types
    if (target == null) {
      return _findNullableExtensionMember(name);
    }
    final targetType = getRuntimeType(target); // Helper to get RuntimeType
    if (targetType == null) return null;
    // Search current environment and enclosing ones
    Environment? current = this;
    while (current != null) {
      // Check unnamed extensions
      for (final ext in current._unnamedExtensions) {
        if (_matchesExtensionType(targetType, ext.onType, value: target)) {
          final member = ext.findMember(name);
          if (member != null) {
            Logger.debug(
                " [Environment] Found extension member '$name' in unnamed ext on ${ext.onType.name}");
            // Need to bind 'target' to the call somehow.
            // This will likely require returning a bound callable or modifying the call site.
            return member; // Return the raw callable for now
          }
        }
      }
      // Check named extensions (stored as values)
      for (final value in current._values.values) {
        if (value is InterpretedExtension) {
          if (_matchesExtensionType(targetType, value.onType, value: target)) {
            final member = value.findMember(name);
            if (member != null) {
              Logger.debug(
                  "[Environment] Found extension member '$name' in named ext '${value.name}' on ${value.onType.name}");
              return member; // Return the raw callable
            }
          } else if (targetType is NativeFunction &&
              visitor != null &&
              value.onType is NativeFunction) {
            final valueType = value.onType as NativeFunction;
            if (valueType.name == targetType.name) {
              final member = value.findMember(name);
              if (member != null) {
                Logger.debug(
                    "[Environment] Found extension member '$name' in named ext '${value.name}' on ${value.onType.name}");
                return member; // Return the raw callable
              }
            }
          }
        }
      }
      current = current._enclosing;
    }
    return null; // Not found
  }

  /// G-DOV-10/11 FIX: Find extension members for null targets by checking
  /// extensions declared with nullable on-types (e.g., `extension on String?`).
  Callable? _findNullableExtensionMember(String name) {
    Environment? current = this;
    while (current != null) {
      // Check unnamed extensions with nullable on-type
      for (final ext in current._unnamedExtensions) {
        if (ext.isOnNullableType) {
          final member = ext.findMember(name);
          if (member != null) {
            Logger.debug(
                "[Environment] Found nullable extension member '$name' in unnamed ext on ${ext.onType.name}?");
            return member;
          }
        }
      }
      // Check named extensions with nullable on-type
      for (final value in current._values.values) {
        if (value is InterpretedExtension && value.isOnNullableType) {
          final member = value.findMember(name);
          if (member != null) {
            Logger.debug(
                "[Environment] Found nullable extension member '$name' in named ext '${value.name}' on ${value.onType.name}?");
            return member;
          }
        }
      }
      current = current._enclosing;
    }
    return null;
  }

  /// Checks if a target type matches an extension's `on` type.
  ///
  /// This relaxes the matching for raw types (types without type arguments):
  /// - If target type is `List` (no type args) and extension is on `List<T>`, allow match
  /// - The extension itself handles type constraints at runtime
  bool _matchesExtensionType(
      RuntimeType targetType, RuntimeType extensionOnType,
      {Object? value}) {
    // First try the normal subtype check. Pass the value through so types
    // that need a runtime hierarchy probe (e.g. BridgedEnum.isSubtypeOf
    // checking the underlying native enum against an interface like
    // WidgetStatesConstraint) can perform it.
    if (targetType.isSubtypeOf(extensionOnType, value: value)) {
      return true;
    }

    // Bug-98 fix: Relaxed matching for raw types
    // If the target and extension have the same base type name, allow the match.
    // This handles cases where:
    // - Target is native List (no type parameterization available at runtime)
    // - Extension is on List<int> (has type parameter in declaration)
    if (targetType.name == extensionOnType.name) {
      Logger.debug(
          "[_matchesExtensionType] Allowing same-name type match: ${targetType.name}");
      return true;
    }

    return false;
  }

  // Placeholder helper to get RuntimeType - needs actual implementation
  RuntimeType? getRuntimeType(Object? value) {
    if (value is InterpretedInstance) {
      return value.klass; // InterpretedClass is a RuntimeType
    }
    if (value is BridgedInstance) {
      return value.bridgedClass; // BridgedClass is a RuntimeType
    }
    // G-DOV2-7 FIX: Handle InterpretedEnumValue - return its parent enum as the type
    if (value is InterpretedEnumValue) {
      return value.parentEnum; // InterpretedEnum is a RuntimeType
    }
    // Bucket #4 fix: Handle BridgedEnumValue so extension lookups against the
    // enum's parent BridgedEnum can succeed (e.g. WidgetStateOperators on a
    // WidgetState value).
    if (value is BridgedEnumValue) {
      return value.enumType;
    }
    // Handle Dart primitive/core types by looking them up in the environment
    // Assumes core types (String, int, bool, List, Map, etc.) are registered as BridgedClass
    String? typeName;
    if (value == null) typeName = 'Null';
    if (value is String) typeName = 'String';
    if (value is int) typeName = 'int';
    if (value is double) typeName = 'double';
    if (value is bool) typeName = 'bool';
    if (value is List) typeName = 'List';
    if (value is Map) typeName = 'Map';

    if (typeName != null) {
      // Cluster C26 FIX: For List/Map, prefer a more-specific bridged class
      // (e.g. Uint8List, Int32List) registered for the actual runtime type.
      // `value is List` matches typed-data subclasses, which previously
      // collapsed their runtime type to plain `List` and broke return-type
      // checks on functions declared to return `Uint8List` and friends.
      // If `toBridgedClass` resolves to a more specific bridge, return it;
      // otherwise fall through to the generic lookup below.
      if (value != null && (typeName == 'List' || typeName == 'Map')) {
        try {
          final specific = toBridgedClass(value.runtimeType);
          if (specific.name != typeName) {
            return specific;
          }
        } on RuntimeD4rtException {
          // No specific bridge — fall through to generic typeName lookup.
        }
      }
      try {
        final typeObj = get(typeName); // Look up the type name
        if (typeObj is RuntimeType) {
          return typeObj;
        } else {
          Logger.warn(
              "[getRuntimeType] Found symbol '$typeName' but it's not a RuntimeType (${typeObj?.runtimeType})");
        }
      } on RuntimeD4rtException {
        Logger.warn(
            "[getRuntimeType] RuntimeType for primitive '$typeName' not found in environment.");
      }
    }

    // For other native objects (e.g., DateTime, Duration, etc.), try to find their BridgedClass
    if (value != null) {
      try {
        final bridgedClass = toBridgedClass(value.runtimeType);
        return bridgedClass;
      } on RuntimeD4rtException {
        // No bridged class found for this type
        Logger.debug(
            "[getRuntimeType] No BridgedClass found for native type ${value.runtimeType}");
      }
      // C20a fix: When the runtime type isn't a registered bridge (e.g.
      // private impl types returned by extension operators like
      // `WidgetState.a | WidgetState.b` returning a `_WidgetStateOr`),
      // fall back to `isAssignable` iteration so we can recover the
      // bridged interface (e.g. `WidgetStatesConstraint`) it implements.
      // This lets subsequent operator dispatch (e.g. `& ~WidgetState.x`
      // applied to the OR result) reach the right extension.
      Environment? current = this;
      BridgedClass? bestMatch;
      while (current != null) {
        for (final entry in current._bridgedClassesLookupByType.entries) {
          final bridge = entry.value;
          if (bridge.isAssignable != null && bridge.isAssignable!(value)) {
            bestMatch = bridge;
          }
        }
        current = current._enclosing;
      }
      if (bestMatch != null) {
        Logger.debug(
            "[getRuntimeType] Resolved native ${value.runtimeType} via "
            "isAssignable to BridgedClass(${bestMatch.name})");
        return bestMatch;
      }
    }

    return null; // Type couldn't be determined
  }

  /// Creates a shallow copy of this environment, optionally filtering symbols.
  ///
  /// If [showNames] is provided, only symbols (values, bridged classes, enums, prefixed imports)
  /// whose names are in [showNames] will be included in the new environment.
  /// If [hideNames] is provided, all symbols will be included *except* those
  /// whose names are in [hideNames].
  ///
  /// It is an error to provide both [showNames] and [hideNames].
  /// Unnamed extensions are always copied.
  Environment shallowCopyFiltered({
    Set<String>? showNames,
    Set<String>? hideNames,
  }) {
    if (showNames != null && hideNames != null) {
      throw ArgumentD4rtException(
          'Cannot provide both showNames and hideNames to shallowCopyFiltered.');
    }

    final newEnv = Environment(enclosing: _enclosing);

    // Filter _values
    _values.forEach((name, value) {
      bool include = true;
      if (showNames != null) {
        include = showNames.contains(name);
      } else if (hideNames != null) {
        include = !hideNames.contains(name);
      }
      if (include) {
        newEnv._values[name] = value;
      }
    });

    // Filter _bridgedClasses and rebuild _bridgedClassesLookupByType
    _bridgedClasses.forEach((name, bridgedClass) {
      bool include = true;
      if (showNames != null) {
        include = showNames.contains(name);
      } else if (hideNames != null) {
        include = !hideNames.contains(name);
      }
      if (include) {
        newEnv._bridgedClasses[name] = bridgedClass;
        newEnv._bridgedClassesLookupByType[bridgedClass.nativeType] =
            bridgedClass;
      }
    });

    // Filter _bridgedEnums
    _bridgedEnums.forEach((name, bridgedEnum) {
      bool include = true;
      if (showNames != null) {
        include = showNames.contains(name);
      } else if (hideNames != null) {
        include = !hideNames.contains(name);
      }
      if (include) {
        newEnv._bridgedEnums[name] = bridgedEnum;
      }
    });

    // Filter _prefixedImports
    _prefixedImports.forEach((name, environment) {
      bool include = true;
      if (showNames != null) {
        include = showNames.contains(name);
      } else if (hideNames != null) {
        include = !hideNames.contains(name);
      }
      if (include) {
        newEnv._prefixedImports[name] =
            environment; // Copy the reference to the prefixed environment
      }
    });

    // Copy unnamed extensions (cannot be filtered by name)
    newEnv._unnamedExtensions.addAll(_unnamedExtensions);

    Logger.debug(
        "[Environment.shallowCopyFiltered] Created filtered environment. Original size: ${_values.length} values. New size: ${newEnv._values.length} values.");
    return newEnv;
  }

  /// Imports definitions from another environment into this one.
  /// Can be filtered using [show] or [hide] combinators.
  /// If no filter is provided, all symbols from [other] are merged.
  /// This method directly modifies the current environment.
  ///
  /// When [errorOnConflict] is true (used by `export` directives merging into
  /// a library's exported environment — see Cluster EXPORT, I-MISC-40/41),
  /// duplicate symbols with non-identical definitions raise a
  /// `RuntimeD4rtException('Name conflict in environment: ...')` instead of
  /// silently overwriting. The default `false` preserves the import-wins
  /// semantics expected of regular `import` directives.
  void importEnvironment(Environment other,
      {Set<String>? show, Set<String>? hide, bool errorOnConflict = false}) {
    if (show != null && hide != null) {
      throw ArgumentD4rtException(
          'Cannot provide both show and hide to importEnvironment.');
    }

    Environment sourceEnvToImportFrom;

    if (show != null || hide != null) {
      sourceEnvToImportFrom =
          other.shallowCopyFiltered(showNames: show, hideNames: hide);
      Logger.debug(
          "[Environment.importEnvironment] Importing from a filtered version of other env (hashCode: ${other.hashCode}).");
    } else {
      sourceEnvToImportFrom = other;
      Logger.debug(
          "[Environment.importEnvironment] Importing directly from other env (hashCode: ${other.hashCode}).");
    }

    // Perform the merge from sourceEnvToImportFrom
    sourceEnvToImportFrom._values.forEach((name, value) {
      if (_values.containsKey(name)) {
        // Allow if it's the same value (e.g., same class/function imported via different paths)
        if (!identical(_values[name], value)) {
          if (errorOnConflict) {
            // Cluster EXPORT (I-MISC-40/41): export-merge cannot silently
            // overwrite — a library that re-publishes two different
            // definitions of the same name is malformed.
            throw RuntimeD4rtException(
                "Name conflict in environment: Symbol '$name' is already defined.");
          }
          // GEN-100 sync: import wins for value conflicts (matches tom_d4rt_ast).
          // Explicit imports take priority over pre-registered ambient definitions.
          Logger.debug(
              "[Environment.importEnvironment] GEN-100: Overwriting pre-registered "
              "value '$name' with imported version");
          _values[name] = value;
        }
        // Same value, skip the duplicate
        return;
      }
      if (_bridgedClasses.containsKey(name) ||
          _bridgedEnums.containsKey(name) ||
          _prefixedImports.containsKey(name)) {
        if (errorOnConflict) {
          throw RuntimeD4rtException(
              "Name conflict in environment: Symbol '$name' is already defined.");
        }
        // GEN-100 sync: import value can replace pre-registered type definition.
        Logger.debug(
            "[Environment.importEnvironment] GEN-100: Import value '$name' "
            "replaces pre-registered type definition");
      }
      _values[name] = value;
    });

    sourceEnvToImportFrom._bridgedClasses.forEach((name, bridgedClass) {
      if (_bridgedClasses.containsKey(name)) {
        // Allow if it's the same bridged class (identity check)
        if (identical(_bridgedClasses[name], bridgedClass)) {
          return;
        }
        if (errorOnConflict) {
          throw RuntimeD4rtException(
              "Name conflict in environment: Symbol '$name' is already defined.");
        }
        // GEN-100 sync: When a bridged class with the same name but different
        // definition exists (e.g., dart:ui.TextStyle pre-registered vs
        // painting.TextStyle from an explicit import), the IMPORT WINS.
        // This matches Dart's import semantics: explicit imports take priority
        // over pre-registered (ambient) definitions.
        Logger.debug(
            "[Environment.importEnvironment] GEN-100: Overwriting pre-registered "
            "bridged class '$name' with imported version");
        _bridgedClasses[name] = bridgedClass;
        _bridgedClassesLookupByType[bridgedClass.nativeType] = bridgedClass;
        _invalidateResolutionCache();
        return;
      }
      if (_values.containsKey(name) ||
          _bridgedEnums.containsKey(name) ||
          _prefixedImports.containsKey(name)) {
        if (errorOnConflict) {
          throw RuntimeD4rtException(
              "Name conflict in environment: Symbol '$name' is already defined.");
        }
        // Cluster A fix: a local script-level declaration (interpreted enum,
        // class, function, or top-level variable) shadows an imported bridged
        // class with the same name. Per Dart import semantics local
        // declarations always win over imports for unprefixed names — silently
        // skip the import. Type-based lookups still find the bridge via the
        // global _bridgedClassesLookupByType map.
        Logger.debug(
            "[Environment.importEnvironment] Local declaration of '$name' "
            "shadows imported bridged class — skipping import");
        return;
      }
      _bridgedClasses[name] = bridgedClass;
      _bridgedClassesLookupByType[bridgedClass.nativeType] = bridgedClass;
      _invalidateResolutionCache();
    });

    sourceEnvToImportFrom._bridgedEnums.forEach((name, bridgedEnum) {
      if (_bridgedEnums.containsKey(name)) {
        // Allow if it's the same bridged enum (identity check)
        if (identical(_bridgedEnums[name], bridgedEnum)) {
          return;
        }
        if (errorOnConflict) {
          throw RuntimeD4rtException(
              "Name conflict in environment: Symbol '$name' is already defined.");
        }
        // GEN-100 sync: import wins for enum conflicts too.
        Logger.debug(
            "[Environment.importEnvironment] GEN-100: Overwriting pre-registered "
            "bridged enum '$name' with imported version");
        _bridgedEnums[name] = bridgedEnum;
        return;
      }
      if (_values.containsKey(name) ||
          _bridgedClasses.containsKey(name) ||
          _prefixedImports.containsKey(name)) {
        if (errorOnConflict) {
          throw RuntimeD4rtException(
              "Name conflict in environment: Symbol '$name' is already defined.");
        }
        // Cluster A fix: local declaration shadows imported bridged enum.
        // See comment on the bridged-class branch above.
        Logger.debug(
            "[Environment.importEnvironment] Local declaration of '$name' "
            "shadows imported bridged enum — skipping import");
        return;
      }
      _bridgedEnums[name] = bridgedEnum;
    });

    sourceEnvToImportFrom._prefixedImports.forEach((name, env) {
      if (_prefixedImports.containsKey(name)) {
        // Same identity — nothing to do.
        if (identical(_prefixedImports[name], env)) {
          return;
        }
        // Different env objects bound to the same prefix. This is legal in
        // Dart: multiple files (or even a single file) may declare imports
        // with the same prefix, and the prefix scope is additive over all of
        // them (`import 'dart:math' as m;` and `import 'package:foo' as m;`
        // both expose names via `m.`). In our module loader the per-file
        // module environments each create their own `shallowCopyFiltered`
        // copy of the imported env, so even imports of the *same library*
        // under the same prefix produce non-identical env objects in two
        // different files. Merge the contents instead of throwing.
        _prefixedImports[name]!
            .importEnvironment(env, errorOnConflict: false);
        return;
      }
      if (_values.containsKey(name) ||
          _bridgedClasses.containsKey(name) ||
          _bridgedEnums.containsKey(name)) {
        throw RuntimeD4rtException(
            "Name conflict in environment: Symbol '$name' (prefixed import) is already defined or collides with another symbol type.");
      }
      _prefixedImports[name] = env;
    });

    // Unnamed extensions are additive. C11: Guard against the self-import /
    // shared-reference case where `this` and `sourceEnvToImportFrom` share the
    // same `_unnamedExtensions` list (mirror of the fix in tom_d4rt_ast).
    // When they alias, `addAll(sameList)` iterates the list while mutating it
    // and throws `ConcurrentModificationError`. Skipping the merge is
    // correct: the destination already contains every element of the source.
    if (!identical(
        _unnamedExtensions, sourceEnvToImportFrom._unnamedExtensions)) {
      _unnamedExtensions.addAll(sourceEnvToImportFrom._unnamedExtensions);
    }

    Logger.debug(
        "[Environment.importEnvironment] Merge complete. Current env (hashCode: $hashCode) updated.");
  }

  // New method to handle prefixed imports
  void definePrefixedImport(String prefix, Environment importEnvironment) {
    Logger.debug(
        "[Env.definePrefixedImport] Defining prefixed import '$prefix' with environment $importEnvironment (hash: ${importEnvironment.hashCode})");
    _prefixedImports[prefix] = importEnvironment;
  }

}
