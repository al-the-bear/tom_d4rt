import 'dart:collection';

import 'package:tom_d4rt_ast/runtime.dart';
import 'package:tom_d4rt_ast/src/runtime/utils/extensions/string.dart';

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

/// A `key → BridgedClass` map whose entries may be stored as **deferred
/// thunks** rather than pre-built classes.
///
/// Step #3 of the import-optimization plan (substrate for the generator's
/// lazy emission, plan step #17). [operator []] resolves a thunk on first
/// access and **memoizes** the built [BridgedClass], so a heavy class body
/// (its seven member maps and all adapter closures) is constructed at most
/// once. [containsKey] / [keys] / [length] only consult the thunk keys, so
/// probing for a name never forces a build.
///
/// Used both name-keyed (`K = String`, lexical lookup) and type-keyed
/// (`K = Type`, native-object resolution). Today every entry is a trivial
/// `() => alreadyBuiltClass` thunk (registration still hands over built
/// classes — behaviour unchanged); once the generator emits genuinely
/// deferred thunks, the heavy body is built only when the name/type is
/// first touched during interpretation.
///
/// Mirror of the same class in `tom_d4rt` `environment.dart`.
class _LazyBridgeRegistry<K> extends MapBase<K, BridgedClass> {
  final Map<K, BridgedClass Function()> _thunks = {};
  final Map<K, BridgedClass> _memo = {};

  /// Registers [key] as a deferred [thunk]. The [BridgedClass] is not built
  /// until [operator []] is first called for [key]; any previously memoized
  /// result is dropped so the new thunk wins.
  void putThunk(K key, BridgedClass Function() thunk) {
    _thunks[key] = thunk;
    _memo.remove(key);
  }

  @override
  BridgedClass? operator [](Object? key) {
    final cached = _memo[key];
    if (cached != null) return cached;
    final thunk = _thunks[key];
    if (thunk == null) return null;
    final built = thunk();
    _memo[key as K] = built;
    return built;
  }

  @override
  void operator []=(K key, BridgedClass value) {
    _thunks[key] = () => value;
    _memo[key] = value;
  }

  @override
  BridgedClass? remove(Object? key) {
    _thunks.remove(key);
    return _memo.remove(key);
  }

  @override
  Iterable<K> get keys => _thunks.keys;

  @override
  void clear() {
    _thunks.clear();
    _memo.clear();
  }
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

  // ── S3b additive slot runtime (perf plan_3 §4.6 / §9.3) ───────────────────
  // Per-frame slot array for resolver-eligible block locals (a local read only
  // at depth 0, never an assignment target). Lazily allocated — the
  // overwhelming majority of frames declare no slottable local, so [_slots]
  // stays `null` at zero cost. Additive in S3b: a slotted `define` dual-writes
  // [_slots] AND [_values]; production reads still go through the name `get`;
  // a debug parity assert (`identical(getSlot, get)`) validates the slot model
  // against the live name model. S3c flips eligible reads onto [getSlot] and
  // demotes those locals out of [_values].
  List<Object?>? _slots;

  // name → slot index for the slotted locals of THIS frame. Used only on the
  // WRITE path ([defineSlot] / [assign]) to keep [_slots] in sync when a value
  // is set by a path other than the original `define` (async-init resume, late
  // initialization). The resolved READ path never consults this — it indexes
  // [_slots] by the coordinate's slot directly (note-6, §10.4). Stays `null`
  // on frames with no slotted local.
  Map<String, int>? _slotIndex;

  /// Sentinel for an allocated-but-unwritten slot — distinct from a real
  /// `null` binding, so a stale read is detectable in debug.
  static final Object _unset = Object();

  // Step d (perf plan_3 §4.5): the seven auxiliary collections below are
  // allocated *lazily*. Every Environment frame carries the hot `_values` map,
  // but the overwhelming majority of frames (function bodies, loop blocks,
  // catch clauses, …) register no bridge / enum / extension / prefixed import,
  // so these backing fields stay `null` and cost zero allocation. Each has a
  // pair of accessors:
  //   * the bare-named read view (`_bridgedClasses`, …) returns an empty
  //     `const` collection when the backing field is null — non-allocating and,
  //     being unmodifiable, a tripwire that throws if a write ever slips
  //     through it instead of the `…OrNew` getter;
  //   * the `…OrNew` write view allocates the real collection on first use.
  // Step #3 (import-optimization): the name and type bridge registries are
  // thunk-capable — each entry may be a deferred `() => BridgedClass` built and
  // memoized on first lookup. See [_LazyBridgeRegistry].
  _LazyBridgeRegistry<String>? _bridgedClassesRaw;
  // Same-name bridge overflow: when two distinct bridges register under the
  // same simple name (e.g. `tom_doc_scanner` and `tom_md2latex` both export a
  // `MarkdownParser`), `_bridgedClasses` keeps only the last-registered one.
  // The bridges it displaced are stashed here so static/constructor resolution
  // can fall back to a sibling that declares a member the primary lacks. Null
  // until a genuine name collision occurs — the common one-bridge-per-name case
  // allocates nothing.
  Map<String, List<BridgedClass>>? _shadowedBridgesRaw;
  _LazyBridgeRegistry<Type>? _bridgedClassesLookupByTypeRaw;
  // GEN-115 Phase 2 — runtimeType→bridge resolution cache. Populated by
  // [toBridgedInstance] after a non-trivial step-2 / step-3 walk so that
  // repeat lookups of the same private impl type (e.g. _BodyBoxConstraints,
  // _BigIntImpl, FakeTimer) skip the O(N) iteration over every registered
  // bridge. Invalidated on every mutation of [_bridgedClassesLookupByType]
  // via [_invalidateResolutionCache].
  Map<Type, BridgedClass>? _resolvedTypeCacheRaw;
  // T4 (perf, plan_2 §6 / F3): negative resolution cache — the set of
  // runtimeTypes that have NO bridge (the full step-1/2/3 walk found nothing
  // and [toBridgedClass] threw). Without it, every wrap of a common unbridged
  // native — `InterpretedInstance` operands in `==`, scalar values with no
  // registered bridge, … — re-walks the whole env chain, iterates every
  // registered bridge's `isAssignable`, runs the name-fallback `toString`
  // scans in [toBridgedClass], then throws and is caught at the call
  // boundary, on EVERY call. Caching the miss collapses all of that to a
  // single set probe. Cleared together with [_resolvedTypeCache] on any
  // bridge-type mutation, so a later registration can still turn a cached
  // miss into a hit.
  Set<Type>? _unbridgedTypeCacheRaw;
  Map<String, BridgedEnum>? _bridgedEnumsRaw; // Store bridged enums
  List<InterpretedExtension>? _unnamedExtensionsRaw; // Store unnamed extensions
  Map<String, Environment>? _prefixedImportsRaw; // For prefixed imports

  // Read views — empty const when the backing field is null (no allocation).
  Map<String, BridgedClass> get _bridgedClasses =>
      _bridgedClassesRaw ?? const <String, BridgedClass>{};
  Map<Type, BridgedClass> get _bridgedClassesLookupByType =>
      _bridgedClassesLookupByTypeRaw ?? const <Type, BridgedClass>{};
  Map<Type, BridgedClass> get _resolvedTypeCache =>
      _resolvedTypeCacheRaw ?? const <Type, BridgedClass>{};
  Set<Type> get _unbridgedTypeCache =>
      _unbridgedTypeCacheRaw ?? const <Type>{};
  Map<String, BridgedEnum> get _bridgedEnums =>
      _bridgedEnumsRaw ?? const <String, BridgedEnum>{};
  List<InterpretedExtension> get _unnamedExtensions =>
      _unnamedExtensionsRaw ?? const <InterpretedExtension>[];
  Map<String, Environment> get _prefixedImports =>
      _prefixedImportsRaw ?? const <String, Environment>{};

  // Write views — allocate the backing collection on first use.
  _LazyBridgeRegistry<String> get _bridgedClassesOrNew =>
      _bridgedClassesRaw ??= _LazyBridgeRegistry<String>();
  Map<String, List<BridgedClass>> get _shadowedBridgesOrNew =>
      _shadowedBridgesRaw ??= {};
  _LazyBridgeRegistry<Type> get _bridgedClassesLookupByTypeOrNew =>
      _bridgedClassesLookupByTypeRaw ??= _LazyBridgeRegistry<Type>();
  Map<Type, BridgedClass> get _resolvedTypeCacheOrNew =>
      _resolvedTypeCacheRaw ??= {};
  Set<Type> get _unbridgedTypeCacheOrNew => _unbridgedTypeCacheRaw ??= {};
  Map<String, BridgedEnum> get _bridgedEnumsOrNew => _bridgedEnumsRaw ??= {};
  List<InterpretedExtension> get _unnamedExtensionsOrNew =>
      _unnamedExtensionsRaw ??= [];
  Map<String, Environment> get _prefixedImportsOrNew =>
      _prefixedImportsRaw ??= {};

  /// OPEN B.9 — when this environment is the top execution scope of a static
  /// member, it holds *snapshots* of the owner class's static fields so that
  /// bare-identifier reads resolve without a class prefix. This marker records
  /// the owning class so that a bare-identifier *write* to one of those
  /// snapshotted fields can be propagated back to the class's authoritative
  /// static slot (`InterpretedClass.setStaticField`). Without it, the write
  /// would only mutate the discarded local snapshot and never survive the call.
  ///
  /// Only set on the static-member execution environment itself; a shadowing
  /// local declared in a nested block lives in a different (unmarked)
  /// environment, so the propagation stays shadow-safe.
  InterpretedClass? staticFieldSnapshotOwner;

  /// Creates a new environment, optionally with an enclosing (parent) environment.
  ///
  /// [enclosing] The parent environment for lexical scoping. If null, this becomes a root environment.
  Environment({Environment? enclosing}) : _enclosing = enclosing {
    D4rtDiag.envAllocs++;
  }

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
  void define(String name, Object? value) {
    if (_values.containsKey(name) ||
        _bridgedClasses.containsKey(name) ||
        _bridgedEnums.containsKey(name)) {
      // CHECK: Also check bridged enums
      Logger.warn("Redefining variable or colliding with bridged type: $name");
    }
    _values[name] = value;
  }

  /// Writes [value] into this frame's slot array at [slot] and records the
  /// [name]→[slot] mapping, growing/allocating [_slots] lazily.
  ///
  /// S3b is **additive**: the caller still calls [define] to keep the name
  /// binding in [_values]; this records the parallel slot so the debug parity
  /// assert can validate the two views. The [name] is kept so a later [assign]
  /// to the same local keeps the slot in sync (the resolver only slots
  /// read-only locals, but async-init resume and late initialization set the
  /// value through a path other than the original `define`).
  void defineSlot(int slot, String name, Object? value) {
    var slots = _slots;
    if (slots == null) {
      slots = List<Object?>.filled(slot + 1, _unset, growable: true);
      _slots = slots;
    } else if (slot >= slots.length) {
      while (slots.length <= slot) {
        slots.add(_unset);
      }
    }
    slots[slot] = value;
    (_slotIndex ??= {})[name] = slot;
  }

  /// Reads the value at [slot] in THIS frame's slot array. The caller guarantees
  /// (via the static resolver's depth-0 coordinate) that the slot was written by
  /// a preceding [defineSlot] in the same frame. No name hashing — one list
  /// index (note-6, §10.4).
  Object? getSlot(int slot) => _slots![slot];

  /// Removes [name] from this environment's local [_values] map.
  ///
  /// Used by [D4rtRunner.resetScriptDeclarations] (interpreter_unfixable.md
  /// §U28) to evict script-declared entries between `executeBundle` calls
  /// while preserving the bridge maps. Returns whether an entry was
  /// removed. Does NOT walk the enclosing scope chain.
  ///
  /// Note: this only mutates [_values]. [_bridgedClasses], [_bridgedEnums],
  /// and [_bridgedClassesLookupByType] are left intact — bridge
  /// registrations survive a reset by design.
  bool removeLocalValue(String name) {
    if (!_values.containsKey(name)) return false;
    _values.remove(name);
    return true;
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
    // An already-built class registers as a trivial `() => obj` thunk; the
    // lazy substrate resolves it on first lookup and memoizes (behaviour
    // unchanged for eager callers). See [defineBridgeLazy].
    defineBridgeLazy(
        bridgedClass.name, bridgedClass.nativeType, () => bridgedClass);
  }

  /// Registers a bridged class as a **deferred thunk** keyed by [name], plus a
  /// parallel `Type → thunk` entry under [nativeType] for native-object
  /// resolution. The [BridgedClass] is built (and memoized) only when [name]
  /// or [nativeType] is first resolved — the substrate the generator's lazy
  /// emission plugs into (import-optimization plan step #17).
  ///
  /// In the common no-collision case the thunk is stored without building. A
  /// genuine same-name collision (another bridge / enum / value already holds
  /// [name]) resolves the new thunk eagerly so the displaced bridge can be
  /// preserved for static/constructor fallback and the shadow list shares the
  /// same instance the memo will serve. Collisions are rare, so this does not
  /// regress the common lazy path.
  void defineBridgeLazy(
      String name, Type nativeType, BridgedClass Function() thunk) {
    final collides = _values.containsKey(name) ||
        (_bridgedClassesRaw?.containsKey(name) ?? false) ||
        _bridgedEnums.containsKey(name);
    if (collides) {
      // CHECK: Also collides with bridged enums / values.
      Logger.warn(
        "Redefining bridged class or colliding with existing definition: $name",
      );
      // Preserve a displaced same-name bridge so static/constructor resolution
      // can fall back to it (two packages exporting an identically named class).
      final built = thunk();
      _recordShadowedBridge(name, _bridgedClassesRaw?[name], built);
      thunk = () => built;
    }
    _bridgedClassesOrNew.putThunk(name, thunk);
    _bridgedClassesLookupByTypeOrNew.putThunk(nativeType, thunk);
    _invalidateResolutionCache();
    Logger.debug("[Environment] Defined bridge for class: $name");
  }

  /// Clears the [_resolvedTypeCache]. Called from every site that mutates
  /// [_bridgedClassesLookupByType], because a newly-registered bridge can
  /// change the most-specific resolution for previously-cached runtimeTypes.
  void _invalidateResolutionCache() {
    _resolvedTypeCacheRaw?.clear();
    _unbridgedTypeCacheRaw?.clear();
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

  /// Stashes a same-name bridge that a new registration is about to displace,
  /// so static/constructor resolution can fall back to it (two packages
  /// exporting an identically named class). No-op when [prior] is null or is
  /// the same instance as [replacement]. Also drops [replacement] from the
  /// shadow list, since it is becoming the primary.
  void _recordShadowedBridge(
      String name, BridgedClass? prior, BridgedClass replacement) {
    if (prior == null || identical(prior, replacement)) return;
    final shadowed = _shadowedBridgesOrNew.putIfAbsent(name, () => []);
    if (!shadowed.any((b) => identical(b, prior))) shadowed.add(prior);
    shadowed.removeWhere((b) => identical(b, replacement));
  }

  /// Returns every bridged class registered under [name] across the scope
  /// chain — the primary (last-wins) bridge of each scope first, followed by
  /// any same-name bridges it displaced.
  ///
  /// Used by static/constructor resolution to disambiguate identically named
  /// bridges from different packages (e.g. two libraries each exporting a
  /// `MarkdownParser`): when the primary bridge lacks the requested member, the
  /// caller can fall back to a sibling that declares it. Returns an empty list
  /// when no bridge with [name] is registered.
  List<BridgedClass> findAllBridgedClassesByName(String name) {
    final result = <BridgedClass>[];
    Environment? current = this;
    while (current != null) {
      final primary = current._bridgedClassesRaw?[name];
      if (primary != null && !result.any((b) => identical(b, primary))) {
        result.add(primary);
      }
      final shadowed = current._shadowedBridgesRaw?[name];
      if (shadowed != null) {
        for (final b in shadowed) {
          if (!result.any((x) => identical(x, b))) result.add(b);
        }
      }
      current = current._enclosing;
    }
    return result;
  }

  /// Pre-registers a bridge's native-type mapping for runtime type resolution.
  ///
  /// Unlike [defineBridge], this does NOT add [bridgedClass.name] to the
  /// lexical scope (`_bridgedClasses`). It only populates
  /// `_bridgedClassesLookupByType` so that [toBridgedInstance] can wrap
  /// native objects returned by bridge methods regardless of whether the
  /// script's imports have been processed yet.
  ///
  /// In practice [D4rtRunner._registerBridgedDefinitions] calls [defineBridge]
  /// (which also sets the type entry), so this method is provided as a
  /// type-only counterpart for callers that want to avoid name-scope pollution.
  /// Mirrors [tom_d4rt:Environment.registerBridgeType].
  void registerBridgeType(BridgedClass bridgedClass) {
    _bridgedClassesLookupByTypeOrNew
        .putThunk(bridgedClass.nativeType, () => bridgedClass);
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
  /// Mirror of `tom_d4rt` `Environment.propagateBridgeTypesTo`.
  void propagateBridgeTypesTo(Environment target) {
    if (identical(target, this)) return;
    var added = false;
    for (final entry in _bridgedClassesLookupByType.entries) {
      target._bridgedClassesLookupByTypeOrNew.putIfAbsent(entry.key, () {
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
        "target class not found",
      );
      return;
    }
    _bridgedClassesOrNew[aliasName] = target;
    Logger.debug(
      "[Environment] Defined bridge alias: $aliasName -> $targetName",
    );
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
      // T4 (perf, F3): negative-cache hit — a previous call already proved this
      // runtimeType has no bridge. Re-throw the same miss without re-walking the
      // chain, iterating every bridge, or running the name-fallback toString.
      if (current._unbridgedTypeCache.contains(runtimeType)) {
        throw RuntimeD4rtException(
            'Cannot bridge native object: No registered bridged class found '
            'for native type $runtimeType.');
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
        if (bridge.isAssignable != null && bridge.isAssignable!(nativeObject)) {
          allMatches.add(bridge);
        }
      }
      current = current._enclosing;
    }
    if (allMatches.isNotEmpty) {
      final filtered = _filterToMostSpecific(allMatches);
      final picked = filtered.isNotEmpty ? filtered.last : allMatches.last;
      _resolvedTypeCacheOrNew[runtimeType] = picked;
      return BridgedInstance(picked, nativeObject);
    }

    // 3) Name-based fallbacks (private impl, generic suffix, *Impl prefix).
    //    [toBridgedClass] will throw if no bridge matches — propagate, but
    //    negative-cache the miss first so repeats short-circuit (T4, F3).
    final BridgedClass bridgedClass;
    try {
      bridgedClass = toBridgedClass(runtimeType);
    } on RuntimeD4rtException {
      _unbridgedTypeCacheOrNew.add(runtimeType);
      rethrow;
    }
    _resolvedTypeCacheOrNew[runtimeType] = bridgedClass;
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
    final leaves = matches
        .where((m) => !supertypeUnion.contains(m.name))
        .toList(growable: false);
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
        // bridge whose nativeName is a shorter prefix (e.g. Set's `_HashSet`).
        // Mirror of tom_d4rt/lib/src/environment.dart.
        final cleanedName = nativeTypeName.substring(1).substringBefore('<');
        bridgedClass = current._bridgedClassesLookupByType.entries
            .firstWhereOrNull((e) => e.value.name == cleanedName)
            ?.value;
        bridgedClass ??= _longestNativeNamePrefixMatch(current, nativeTypeName);
      } else if (bridgedClass == null && nativeTypeName.contains('<')) {
        // Extract the base type name before '<' for accurate matching.
        // Using contains() was too broad — e.g., 'ListMapView<int>'.contains('View<')
        // would falsely match the Flutter View widget bridge.
        final baseTypeName = nativeTypeName.substring(
          0,
          nativeTypeName.indexOf('<'),
        );
        bridgedClass = current._bridgedClassesLookupByType.entries
            .firstWhereOrNull(
              (e) =>
                  baseTypeName == e.value.name ||
                  (e.value.nativeNames?.contains(baseTypeName) ?? false),
            )
            ?.value;
        // Suffix match fallback: e.g., CastList → List, ListIterator → Iterator
        // Handles types that embed the bridge name as a suffix.
        bridgedClass ??= current._bridgedClassesLookupByType.entries
            .firstWhereOrNull(
              (e) =>
                  e.value.name.length >= 3 &&
                  baseTypeName.endsWith(e.value.name) &&
                  baseTypeName.length > e.value.name.length,
            )
            ?.value;
      }
      bridgedClass ??= current._bridgedClassesLookupByType.entries
          .firstWhereOrNull((e) => e.value.name == nativeTypeName)
          ?.value;
      // Cluster HASHSET FIX: pick the LONGEST nativeName prefix so a
      // specific bridge wins over a less-specific bridge whose nativeName
      // is a shorter prefix.
      bridgedClass ??= _longestNativeNamePrefixMatch(current, nativeTypeName);

      // G-DCLI-05 FIX: Handle non-underscore implementation types like
      // ProgressBothImpl, where the class name contains the bridge name.
      // Check if any registered bridge name is a prefix of the native type name.
      // e.g., "ProgressBothImpl" contains bridge name "Progress"
      if (bridgedClass == null) {
        bridgedClass = current._bridgedClassesLookupByType.entries
            .firstWhereOrNull((e) {
              final bridgeName = e.value.name;
              // Only match if the bridge name is a substantial prefix (>= 3 chars)
              // and the native type name starts with it followed by more chars
              return bridgeName.length >= 3 &&
                  nativeTypeName.startsWith(bridgeName) &&
                  nativeTypeName.length > bridgeName.length;
            })
            ?.value;
        if (bridgedClass != null) {
          Logger.debug(
            "[Environment] Matched native type '$nativeTypeName' to bridge '${bridgedClass.name}' via prefix matching",
          );
        }
      }

      if (bridgedClass != null) {
        return bridgedClass;
      }

      current = current._enclosing;
    }

    throw RuntimeD4rtException(
      'Cannot bridge native object: No registered bridged class found for native type $nativeType.',
    );
  }

  /// Finds the bridged class whose `nativeNames` contains the LONGEST entry
  /// that is a prefix of [nativeTypeName].
  ///
  /// Cluster HASHSET fix (mirror of tom_d4rt/lib/src/environment.dart):
  /// when multiple bridges declare overlapping native name prefixes (e.g. Set
  /// has `_HashSet`, Iterator has `_HashSetIterator`), the previous
  /// `firstWhereOrNull` would match whichever bridge was registered first —
  /// typically Set, since it registers before Iterator in `core.dart`. That
  /// made `_HashSetIterator` resolve to Set's bridge and fail with
  /// `Bridged class 'Set' has no instance method named 'moveNext'`. Choosing
  /// the longest prefix means an exact `_HashSetIterator` entry on Iterator
  /// wins over Set's shorter `_HashSet` prefix.
  BridgedClass? _longestNativeNamePrefixMatch(
    Environment env,
    String nativeTypeName,
  ) {
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
        "Redefining bridged enum or colliding with existing definition: $name",
      );
    }
    _bridgedEnumsOrNew[name] = bridgedEnum;
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
    Object value,
    Set<Environment> visited,
  ) {
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
      final found = prefixedEnv._findBridgedEnumForValueImpl(value, visited);
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
    Object value,
    Set<Environment> visited,
  ) {
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

  /// Sentinel returned by [lookup] when [name] resolves to no binding in the
  /// whole chain. A fresh identity object so it can never collide with a real
  /// stored value (including `null`). Lets callers on the hot path distinguish
  /// "absent" from "present-but-null" WITHOUT throwing — see [lookup].
  static final Object kNotFound = Object();

  /// Retrieves the value associated with [name], throwing
  /// `RuntimeD4rtException("Undefined variable: ...")` when it is absent.
  ///
  /// Thin wrapper over [lookup]: this is the throwing contract the bulk of the
  /// interpreter relies on. Resolution callers that fall back on a miss (e.g.
  /// implicit-`this` member access in [InterpreterVisitor.visitSimpleIdentifier])
  /// should call [lookup] directly to avoid the cost of constructing, throwing
  /// and catching an exception — with its stack-trace capture — on every miss.
  dynamic get(String name) {
    final value = lookup(name);
    if (identical(value, kNotFound)) {
      throw RuntimeD4rtException("Undefined variable: $name");
    }
    return value;
  }

  /// Non-throwing variant of [get]: resolves [name] across the lexical chain
  /// (locals, bridged classes/enums, prefixed imports) and returns [kNotFound]
  /// instead of throwing when nothing matches.
  ///
  /// Why this exists: the lexical → implicit-`this` fallback in
  /// [InterpreterVisitor.visitSimpleIdentifier] runs on every bare-identifier
  /// read. For an instance-member reference (a field/getter named without
  /// `this.`) the lexical probe necessarily misses, and the old throwing [get]
  /// turned that routine miss into a thrown+caught `RuntimeD4rtException` with a
  /// captured stack trace — thousands per second under an animation loop,
  /// dominating both CPU and allocation. Returning a sentinel keeps the miss on
  /// the normal return path. (The rare malformed-prefix errors below still
  /// throw — they are genuine errors, not "not found".)
  Object? lookup(String name) {
    // Env.get is the single hottest interpreter path (perf plan round 2, T1).
    // Two structural choices keep it cheap:
    //   1. Walk the enclosing chain ITERATIVELY rather than via `get` recursion,
    //      so each scope level costs one loop turn instead of a virtual call
    //      plus re-entry of the per-level guards below.
    //   2. Probe `_values` ONCE on the local-hit path: read the value first and
    //      only fall back to `containsKey` when the read is null (to tell a key
    //      mapped to null from an absent key). The common non-null hit pays a
    //      single hash instead of `containsKey` + `[]`.
    Environment? env = this;
    while (env != null) {
      if (Logger.isDebug) {
        Logger.debug(
          '[Env.get] Attempting to get "$name" in env: ${env.hashCode}',
        ); // Log attempt + env hash
      }

      // Prefixed-import resolution only applies when this environment actually
      // holds prefixed imports — true only at import scopes (typically the
      // global env), never at the function/block/loop scopes walked on the hot
      // path. The `isNotEmpty` length-check is O(1) and lets us skip a
      // `containsKey` hash plus a `name.contains('.')` scan on every lookup.
      if (env._prefixedImports.isNotEmpty) {
        // Check first if the name directly corresponds to a prefixed import.
        if (env._prefixedImports.containsKey(name)) {
          if (Logger.isDebug) {
            Logger.debug(
              "[Env.get] Name '$name' corresponds to a prefixed import. Returning the prefixed environment.",
            );
          }
          return env._prefixedImports[name]; // Return the Environment itself.
        }

        // Check if it's a prefixed access (ex: math.pi)
        if (name.contains('.')) {
          final parts = name.split('.');
          if (parts.length == 2) {
            final prefix = parts[0];
            final identifier = parts[1];
            if (env._prefixedImports.containsKey(prefix)) {
              if (Logger.isDebug) {
                Logger.debug(
                  "[Env.get] Prefixed access for '$name'. Searching for '$identifier' in the prefixed environment '$prefix'.",
                );
              }
              // Recursive call on the stored environment for the prefix.
              // No need to check _enclosing here, the prefixed environment will do that.
              try {
                return env._prefixedImports[prefix]!.get(identifier);
              } on RuntimeD4rtException catch (e) {
                // If the identifier is not found in the prefixed environment, we want the original error to be propagated.
                // Or, according to the desired semantics, we could raise a new error indicating that 'identifier' was not found IN 'prefix'.
                throw RuntimeD4rtException(
                  "Undefined name '$identifier' in imported prefix '$prefix'. Original error: ${e.message}",
                );
              }
            } else {
              // The prefix itself is not found as a prefixed import.
              // We could fall into the normal search if 'prefix.identifier' is a valid variable name.
              // However, in Dart, an identifier cannot contain a '.' except for access.
              // So, if the prefix is not in _prefixedImports, it's an error.
              if (Logger.isDebug) {
                Logger.debug(
                  "[Env.get] Prefix '$prefix' for '$name' not found in prefixed imports.",
                );
              }
            }
          } else {
            // Handle the case of multiple points, for example a.b.c. For now, we only support prefix.identifier.
            Logger.warn(
              "[Env.get] Name '$name' contains multiple points, not supported for simple prefixed access.",
            );
            // Falling into the normal search could be an option, but let's raise an error for now
            // because it probably indicates an unexpected usage or an invalid variable name.
            throw RuntimeD4rtException(
              "Complex prefixed access not supported: $name. Use the form prefix.identifier.",
            );
          }
        }
      }

      // Normal search. Single probe: read once, only re-check `containsKey`
      // when the read returned null (key-mapped-to-null vs absent).
      final localValue = env._values[name];
      if (localValue != null || env._values.containsKey(name)) {
        if (Logger.isDebug) {
          Logger.debug(
            '[Env.get] Found \'$name\' locally in env: ${env.hashCode}',
          );
        }
        // Unwrap GlobalGetter for lazy evaluation
        if (localValue is GlobalGetter) {
          return localValue();
        }
        return localValue;
      }

      // Bridged classes/enums are registered only at import/global scopes, so
      // these maps are empty at the function/block/loop scopes traversed on the
      // hot chain walk. The O(1) `isNotEmpty` guard skips a `containsKey` hash
      // at every such intermediate level.
      if (env._bridgedClasses.isNotEmpty &&
          env._bridgedClasses.containsKey(name)) {
        if (Logger.isDebug) {
          Logger.debug(
            " [Env.get] Found bridged class '$name' locally in env: ${env.hashCode}",
          );
        }
        return env._bridgedClasses[name];
      }

      // Check for bridged enums
      if (env._bridgedEnums.isNotEmpty && env._bridgedEnums.containsKey(name)) {
        if (Logger.isDebug) {
          Logger.debug(
            " [Env.get] Found bridged enum '$name' locally in env: ${env.hashCode}",
          );
        }
        return env._bridgedEnums[name];
      }

      // Move up the lexical scope chain (iterative — no recursion).
      final parent = env._enclosing;
      if (Logger.isDebug && parent != null) {
        Logger.debug(
          '[Env.get] Looking for \'$name\' in parent env: ${parent.hashCode}',
        );
      }
      env = parent;
    }

    if (Logger.isDebug) {
      Logger.debug(
        '[Env.get] \'$name\' not found in env chain starting from: $hashCode (no parent)',
      ); // Log chain end
    }
    return kNotFound;
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
    if (Logger.isDebug) {
      Logger.debug(
        "[Env.assign] Attempting to assign '$name' = $value in env: $hashCode",
      );
    }
    if (_values.containsKey(name)) {
      final existing = _values[name];

      // Handle GlobalGetter with setter - call the native setter instead of replacing
      if (existing is GlobalGetter) {
        if (existing.hasSetter) {
          if (Logger.isDebug) {
            Logger.debug(
              " [Env.assign] Calling setter for GlobalGetter '$name'",
            );
          }
          // Unwrap BridgedEnumValue to its native value before calling the setter.
          // GEN-054: This ensures bridged enum values can be assigned to native setters.
          final unwrappedValue = _unwrapForSetter(value);
          existing.setter!(unwrappedValue);
          return value;
        } else {
          // GlobalGetter without setter - not assignable
          throw RuntimeD4rtException(
            "Cannot assign to read-only global getter '$name'. "
            "This global only has a getter, not a setter.",
          );
        }
      }

      if (Logger.isDebug) {
        Logger.debug(
          " [Env.assign] Assigned '$name' locally in env: $hashCode",
        );
      }
      _values[name] = value;
      // S3b additive: keep a slotted local's slot in sync when its value is set
      // through `assign` (async-init resume, late init) rather than the original
      // `define`, so the debug parity assert holds. O(1) null-guarded — frames
      // with no slotted local skip the map probe entirely.
      if (_slotIndex != null) {
        final slot = _slotIndex![name];
        if (slot != null) _slots![slot] = value;
      }
      return value;
    }

    if (_bridgedClasses.containsKey(name)) {
      throw RuntimeD4rtException(
        "Cannot assign to the name of a bridged class: $name",
      );
    }

    // Prevent assigning to bridged enum names
    if (_bridgedEnums.containsKey(name)) {
      throw RuntimeD4rtException(
        "Cannot assign to the name of a bridged enum: $name",
      );
    }

    if (_enclosing != null) {
      if (Logger.isDebug) {
        Logger.debug(
          " [Env.assign] '$name' not found locally, assigning in parent env: ${_enclosing.hashCode}",
        );
      }
      return _enclosing.assign(
        name,
        value,
      ); // Delegate to the parent environment
    }

    Logger.debug(
      "[Env.assign] Variable '$name' not found for assignment, throwing error.",
    );
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
    _unnamedExtensionsOrNew.add(extension);
  }

  // Method to find applicable extension members (Placeholder)
  Callable? findExtensionMember(
    Object? target,
    String name, {
    InterpreterVisitor? visitor,
  }) {
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
              " [Environment] Found extension member '$name' in unnamed ext on ${ext.onType.name}",
            );
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
                "[Environment] Found extension member '$name' in named ext '${value.name}' on ${value.onType.name}",
              );
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
                  "[Environment] Found extension member '$name' in named ext '${value.name}' on ${value.onType.name}",
                );
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
              "[Environment] Found nullable extension member '$name' in unnamed ext on ${ext.onType.name}?",
            );
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
              "[Environment] Found nullable extension member '$name' in named ext '${value.name}' on ${value.onType.name}?",
            );
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
    RuntimeType targetType,
    RuntimeType extensionOnType, {
    Object? value,
  }) {
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
        "[_matchesExtensionType] Allowing same-name type match: ${targetType.name}",
      );
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
            "[getRuntimeType] Found symbol '$typeName' but it's not a RuntimeType (${typeObj?.runtimeType})",
          );
        }
      } on RuntimeD4rtException {
        Logger.warn(
          "[getRuntimeType] RuntimeType for primitive '$typeName' not found in environment.",
        );
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
          "[getRuntimeType] No BridgedClass found for native type ${value.runtimeType}",
        );
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
          "isAssignable to BridgedClass(${bestMatch.name})",
        );
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
        'Cannot provide both showNames and hideNames to shallowCopyFiltered.',
      );
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
        newEnv._bridgedClassesOrNew[name] = bridgedClass;
        newEnv._bridgedClassesLookupByTypeOrNew[bridgedClass.nativeType] =
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
        newEnv._bridgedEnumsOrNew[name] = bridgedEnum;
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
        newEnv._prefixedImportsOrNew[name] =
            environment; // Copy the reference to the prefixed environment
      }
    });

    // Copy unnamed extensions (cannot be filtered by name)
    newEnv._unnamedExtensionsOrNew.addAll(_unnamedExtensions);

    Logger.debug(
      "[Environment.shallowCopyFiltered] Created filtered environment. Original size: ${_values.length} values. New size: ${newEnv._values.length} values.",
    );
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
  void importEnvironment(
    Environment other, {
    Set<String>? show,
    Set<String>? hide,
    bool errorOnConflict = false,
  }) {
    if (show != null && hide != null) {
      throw ArgumentD4rtException(
        'Cannot provide both show and hide to importEnvironment.',
      );
    }

    Environment sourceEnvToImportFrom;

    if (show != null || hide != null) {
      sourceEnvToImportFrom = other.shallowCopyFiltered(
        showNames: show,
        hideNames: hide,
      );
      Logger.debug(
        "[Environment.importEnvironment] Importing from a filtered version of other env (hashCode: ${other.hashCode}).",
      );
    } else {
      sourceEnvToImportFrom = other;
      Logger.debug(
        "[Environment.importEnvironment] Importing directly from other env (hashCode: ${other.hashCode}).",
      );
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
              "Name conflict in environment: Symbol '$name' is already defined.",
            );
          }
          // GEN-100 FIX: Import wins for value conflicts too.
          // This handles cases where a pre-registered function or variable
          // is overwritten by an explicit import.
          Logger.debug(
            "[Environment.importEnvironment] GEN-100: Overwriting pre-registered "
            "value '$name' with imported version",
          );
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
            "Name conflict in environment: Symbol '$name' is already defined.",
          );
        }
        // GEN-100 FIX: Import values can override pre-registered bridged
        // types when a library re-exports something with the same name.
        Logger.debug(
          "[Environment.importEnvironment] GEN-100: Import value '$name' "
          "replaces pre-registered type definition",
        );
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
            "Name conflict in environment: Symbol '$name' is already defined.",
          );
        }
        // GEN-100 FIX: When a bridged class with the same name but different
        // definition exists (e.g., dart:ui.TextStyle pre-registered vs
        // painting.TextStyle from an explicit import), the IMPORT WINS.
        // This matches Dart's import semantics: explicit imports take priority
        // over pre-registered (ambient) definitions.
        Logger.debug(
          "[Environment.importEnvironment] GEN-100: Overwriting pre-registered "
          "bridged class '$name' with imported version",
        );
        // Preserve the displaced same-name bridge (e.g. tom_doc_scanner's
        // MarkdownParser shadowed by tom_md2latex's) so static/constructor
        // resolution can fall back to it.
        _recordShadowedBridge(name, _bridgedClassesRaw?[name], bridgedClass);
        _bridgedClassesOrNew[name] = bridgedClass;
        _bridgedClassesLookupByTypeOrNew[bridgedClass.nativeType] = bridgedClass;
        _invalidateResolutionCache();
        return;
      }
      if (_values.containsKey(name) ||
          _bridgedEnums.containsKey(name) ||
          _prefixedImports.containsKey(name)) {
        if (errorOnConflict) {
          throw RuntimeD4rtException(
            "Name conflict in environment: Symbol '$name' is already defined.",
          );
        }
        // Cluster A fix: a local script-level declaration (interpreted enum,
        // class, function, or top-level variable) shadows an imported bridged
        // class with the same name. Per Dart import semantics local
        // declarations always win over imports for unprefixed names — silently
        // skip the import. Type-based lookups still find the bridge via the
        // global _bridgedClassesLookupByType map.
        Logger.debug(
          "[Environment.importEnvironment] Local declaration of '$name' "
          "shadows imported bridged class — skipping import",
        );
        return;
      }
      _bridgedClassesOrNew[name] = bridgedClass;
      _bridgedClassesLookupByTypeOrNew[bridgedClass.nativeType] = bridgedClass;
      _invalidateResolutionCache();
    });

    // Carry over any same-name bridges the source itself had shadowed, so a
    // multi-hop import chain keeps every package's bridge reachable for
    // static/constructor fallback.
    sourceEnvToImportFrom._shadowedBridgesRaw?.forEach((name, bridges) {
      for (final bridge in bridges) {
        if (identical(_bridgedClassesRaw?[name], bridge)) continue;
        final shadowed = _shadowedBridgesOrNew.putIfAbsent(name, () => []);
        if (!shadowed.any((b) => identical(b, bridge))) shadowed.add(bridge);
      }
    });

    sourceEnvToImportFrom._bridgedEnums.forEach((name, bridgedEnum) {
      if (_bridgedEnums.containsKey(name)) {
        // Allow if it's the same bridged enum (identity check)
        if (identical(_bridgedEnums[name], bridgedEnum)) {
          return;
        }
        if (errorOnConflict) {
          throw RuntimeD4rtException(
            "Name conflict in environment: Symbol '$name' is already defined.",
          );
        }
        // GEN-100 FIX: Import wins for enum conflicts too.
        Logger.debug(
          "[Environment.importEnvironment] GEN-100: Overwriting pre-registered "
          "bridged enum '$name' with imported version",
        );
        _bridgedEnumsOrNew[name] = bridgedEnum;
        return;
      }
      if (_values.containsKey(name) ||
          _bridgedClasses.containsKey(name) ||
          _prefixedImports.containsKey(name)) {
        if (errorOnConflict) {
          throw RuntimeD4rtException(
            "Name conflict in environment: Symbol '$name' is already defined.",
          );
        }
        // Cluster A fix: local declaration shadows imported bridged enum.
        // See comment on the bridged-class branch above.
        Logger.debug(
          "[Environment.importEnvironment] Local declaration of '$name' "
          "shadows imported bridged enum — skipping import",
        );
        return;
      }
      _bridgedEnumsOrNew[name] = bridgedEnum;
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
        _prefixedImports[name]!.importEnvironment(env, errorOnConflict: false);
        return;
      }
      if (_values.containsKey(name) ||
          _bridgedClasses.containsKey(name) ||
          _bridgedEnums.containsKey(name)) {
        throw RuntimeD4rtException(
          "Name conflict in environment: Symbol '$name' (prefixed import) is already defined or collides with another symbol type.",
        );
      }
      _prefixedImportsOrNew[name] = env;
    });

    // Unnamed extensions are additive. C11: Guard against the self-import /
    // shared-reference case where `this` and `sourceEnvToImportFrom` share the
    // same `_unnamedExtensions` list (observed in the foundation/
    // synchronousfuture_test corpus: the module loader returns the importing
    // environment itself for a transitive import, so `addAll(sameList)`
    // iterates the list while mutating it and throws
    // `ConcurrentModificationError`). Skipping the merge is correct: the
    // destination already contains every element of the source.
    if (!identical(
      _unnamedExtensions,
      sourceEnvToImportFrom._unnamedExtensions,
    )) {
      _unnamedExtensionsOrNew.addAll(sourceEnvToImportFrom._unnamedExtensions);
    }

    Logger.debug(
      "[Environment.importEnvironment] Merge complete. Current env (hashCode: $hashCode) updated.",
    );
  }

  // New method to handle prefixed imports
  void definePrefixedImport(String prefix, Environment importEnvironment) {
    Logger.debug(
      "[Env.definePrefixedImport] Defining prefixed import '$prefix' with environment $importEnvironment (hash: ${importEnvironment.hashCode})",
    );
    _prefixedImportsOrNew[prefix] = importEnvironment;
  }
}
