import 'dart:async';
import 'dart:io';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/error/error.dart';
import 'package:tom_d4rt/src/bridge/bridged_enum.dart';
import 'package:tom_d4rt/src/utils/logger/logger.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:tom_d4rt/src/bridge/bridged_types.dart';
import 'package:tom_d4rt/src/runtime_types.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:tom_d4rt/src/environment.dart';
import 'package:tom_d4rt/src/interpreter_visitor.dart';
import 'package:tom_d4rt/src/module_loader.dart';
import 'package:tom_d4rt/src/exceptions.dart';
import 'package:tom_d4rt/src/callable.dart';
import 'package:tom_d4rt/src/declaration_visitor.dart';
import 'package:tom_d4rt/src/generator/d4.dart';
import 'package:tom_d4rt/src/stdlib/stdlib.dart';
import 'package:tom_d4rt/src/bridge/registration.dart';
import 'package:tom_d4rt/src/security/permissions.dart';
import 'package:tom_d4rt/src/introspection.dart';
import 'package:tom_d4rt/src/profiler.dart';

/// Wrapper class for library-scoped variables.
/// Stores a variable name, its value, and optionally its canonical source URI
/// for deduplication across re-exports.
class LibraryVariable {
  final String name;
  final Object? value;

  /// The canonical source URI where this variable is defined.
  ///
  /// Used for deduplication: when the same variable is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server both
  /// re-export tom_basics), we need to recognize they're the same element.
  /// Format: `package:pkg_name/path/to/source.dart`
  final String? sourceUri;

  const LibraryVariable(this.name, this.value, {this.sourceUri});
}

/// Wrapper class for library-scoped getters.
/// Stores a getter name, its function, and optionally its canonical source URI
/// for deduplication across re-exports.
class LibraryGetter {
  final String name;
  final Object? Function() getter;

  /// The canonical source URI where this getter is defined.
  /// See [LibraryVariable.sourceUri] for details.
  final String? sourceUri;

  const LibraryGetter(this.name, this.getter, {this.sourceUri});
}

/// Wrapper class for library-scoped setters.
/// Stores a setter name, its function, and optionally its canonical source URI
/// for deduplication across re-exports.
///
/// Setters are paired with getters to enable full read-write access to
/// top-level variables that use getter/setter pairs.
class LibrarySetter {
  final String name;
  final void Function(Object? value) setter;

  /// The canonical source URI where this setter is defined.
  /// See [LibraryVariable.sourceUri] for details.
  final String? sourceUri;

  const LibrarySetter(this.name, this.setter, {this.sourceUri});
}

/// Wrapper class for library-scoped functions.
/// Stores a native function with its canonical source URI for deduplication.
class LibraryFunction {
  final NativeFunction function;

  /// The canonical source URI where this function is defined.
  /// See [LibraryVariable.sourceUri] for details.
  final String? sourceUri;

  /// The full signature of the function as a display string.
  final String? signature;

  const LibraryFunction(this.function, {this.sourceUri, this.signature});

  /// Convenience getter for the function name.
  String get name => function.name;
}

/// Wrapper class for library-scoped bridged classes.
/// Stores a bridged class with its canonical source URI for deduplication.
///
/// Step #17 (import-optimization): the wrapped [BridgedClass] is built lazily
/// via a deferred [thunk] and memoized on first access to [bridgedClass]. The
/// [name] and [nativeType] are stored up front so registration / lookup
/// filtering / warm-parent type seeding can run **without** forcing the heavy
/// member-map + adapter-closure build. The eager constructor wraps an
/// already-built class as a trivial `() => obj` thunk (behaviour unchanged).
class LibraryClass {
  /// The class name — always available without building the bridge.
  final String name;

  /// The native Dart type the bridge wraps — available without building.
  final Type nativeType;

  /// The canonical source URI where this class is defined.
  /// See [LibraryVariable.sourceUri] for details.
  final String? sourceUri;

  final BridgedClass Function() _thunk;
  BridgedClass? _built;

  /// Eager wrapper: [bridgedClass] is already built.
  LibraryClass(BridgedClass bridgedClass, {this.sourceUri})
    : name = bridgedClass.name,
      nativeType = bridgedClass.nativeType,
      _built = bridgedClass,
      _thunk = (() => bridgedClass);

  /// Lazy wrapper: [thunk] builds the bridge on first access to [bridgedClass].
  LibraryClass.lazy(this.name, this.nativeType, this._thunk, {this.sourceUri});

  /// The bridged class, built (and memoized) on first access.
  BridgedClass get bridgedClass => _built ??= _thunk();

  /// A deferred thunk that resolves (and memoizes) [bridgedClass] on call —
  /// lets callers forward laziness onward without building now (e.g.
  /// module-loader / warm-parent transfers register `libClass.thunk`).
  BridgedClass Function() get thunk =>
      () => bridgedClass;
}

/// Wrapper class for library-scoped bridged enums.
/// Stores a bridged enum with its canonical source URI for deduplication.
class LibraryEnum {
  final BridgedEnumDefinition enumDefinition;

  /// The canonical source URI where this enum is defined.
  /// See [LibraryVariable.sourceUri] for details.
  final String? sourceUri;

  const LibraryEnum(this.enumDefinition, {this.sourceUri});

  /// Convenience getter for the enum name.
  String get name => enumDefinition.name;
}

/// Wrapper class for library-scoped bridged extensions.
/// Stores a bridged extension definition with its canonical source URI.
class LibraryExtension {
  final BridgedExtensionDefinition extensionDefinition;

  /// The canonical source URI where this extension is defined.
  /// See [LibraryVariable.sourceUri] for details.
  final String? sourceUri;

  const LibraryExtension(this.extensionDefinition, {this.sourceUri});

  /// Convenience getter for the extension name.
  String? get name => extensionDefinition.name;
}

/// Step 7 (import-optimization plan) — process-global registration payload
/// for a single bridge package.
///
/// Holds the same per-URI registries the [D4rt] instance fields hold today,
/// but keyed once per package name in the static [D4rt._packagePool] so the
/// (expensive) bridge registration for a package is paid at most once per
/// process and can be reused across every interpreter instance and every
/// `execute*` call.
///
/// The shapes here are intentionally identical to the per-instance fields so
/// that building the warm parent (step 8) and the per-module registries for a
/// migrated instance is a mechanical merge rather than a re-modelling. Mirror
/// of `_PackageBridgeBundle` on [D4rtRunner] in `tom_d4rt_ast`.
class _PackageBridgeBundle {
  final Map<String, Map<String, LibraryEnum>> bridgedEnumDefinitions = {};
  final Map<String, Map<String, LibraryClass>> bridgedClasses = {};
  final Map<String, List<LibraryExtension>> bridgedExtensions = {};
  final List<({String aliasName, String targetName, String library})>
  classAliases = [];
  final List<({String name, String library})> functionTypedefs = [];
  final Map<String, Map<String, LibraryFunction>> libraryFunctions = {};
  final Map<String, Map<String, LibraryVariable>> libraryVariables = {};
  final Map<String, Map<String, LibraryGetter>> libraryGetters = {};
  final Map<String, Map<String, LibrarySetter>> librarySetters = {};
  // Step #17 — thunk-backed so a pooled package's native-type lookup is stored
  // deferred (built on first wrap), not materialized at registration time.
  final LazyBridgeRegistry<Type> bridgedDefLookupByType = LazyBridgeRegistry();
  final Map<String, List<({String uri, Set<String>? show, Set<String>? hide})>>
  libraryReExports = {};

  /// The single extension callback registered for this package via
  /// [D4rt.registerExtensions]. One callback per package name (idempotent
  /// overwrite). Fired by [D4rt.finalizeBridges].
  void Function()? extensionCallback;

  /// Step 11 — whether [extensionCallback] has already been fired in this
  /// process. The bundle lives in the process-global `_packagePool`, so this
  /// flag enforces the once-per-package-per-process firing contract:
  /// [D4rt.finalizeBridges] fires the callback only when this is `false`,
  /// then sets it `true`. A second interpreter whose [finalizeBridges]
  /// encounters the same (already-fired) pooled package skips it — the
  /// callback's static D4 / BridgedClass side effects are already in place.
  /// Reset together with the pool by `debugResetPool`.
  bool extensionFired = false;
}

/// The main D4rt interpreter class.
///
/// This class provides the primary interface for executing Dart code at runtime.
/// It manages the interpretation environment, handles bridged types, and provides
/// methods for code execution with proper error handling and debugging support.
///
/// ## Example:
/// ```dart
/// final interpreter = D4rt();
///
/// // Register a bridged class to make native types available in interpreted code
/// interpreter.registerBridgedClass(myBridgedClass, 'my_library');
///
/// // Execute Dart code
/// final result = await interpreter.execute(source: '''
///   void main() {
///     print("Hello from D4rt!");
///   }
/// ''');
/// ```
class D4rt {
  /// Creates an interpreter.
  ///
  /// [reuseAcrossRuns] controls the cross-run performance caches (the warm
  /// parent and the per-bridged-module environments). When `true` (the
  /// default) those caches are kept alive across repeated `execute*` calls so
  /// the expensive bridge-binding surface is built once and reused — this is
  /// the fast path and is safe for the overwhelming majority of callers, since
  /// generated bridges hold no per-run state and cannot leak between runs.
  ///
  /// Set it to `false` only when you need full isolation between successive
  /// `execute*` runs on the **same** instance: the warm parent and bridged
  /// module environments are then rebuilt fresh on every run, so nothing an
  /// earlier run touched can be observed by a later one. Migrated instances
  /// (those using [providePackage]) still never share state *across instances*
  /// regardless of this flag — it governs reuse *within* an instance and, for
  /// migrated instances, participation in the process-global caches.
  D4rt({this.reuseAcrossRuns = true});

  /// Whether the cross-run bridge caches are reused between `execute*` calls.
  /// See the constructor. `false` forces a fresh warm parent and fresh bridged
  /// module environments on every run for full inter-run isolation.
  final bool reuseAcrossRuns;

  // Step #2 (import-optimization): registries are keyed by library URI so that
  // registering or looking up one URI touches only that URI's bucket
  // (O(matched)) instead of scanning a list of single-entry maps per URI.
  // Top-level declaration names are unique per library, so the inner map is
  // keyed by name. Extensions are the exception (nullable / duplicate unnamed
  // names) and use a per-URI List. Mirrors D4rtRunner in tom_d4rt_ast.
  final Map<String /*uri*/, Map<String /*name*/, LibraryEnum>>
  _bridgedEnumDefinitions = {};
  final Map<String /*uri*/, Map<String /*name*/, LibraryClass>> _bridgedClases =
      {};
  final Map<String /*uri*/, List<LibraryExtension>> _bridgedExtensions = {};

  /// GEN-074: Class aliases - (aliasName, targetName, library) tuples
  final List<({String aliasName, String targetName, String library})>
  _classAliases = [];

  /// GEN-079: Function typedefs (e.g., VoidCallback = void Function()) registered
  /// as environment types so they can be resolved in type annotations
  /// and type arguments.
  final List<({String name, String library})> _functionTypedefs = [];

  /// GEN-107: Bridge re-exports modelled in the runtime.
  ///
  /// Maps a source library URI to the list of libraries it re-exports
  /// (with optional `show` / `hide` filters). The module loader merges
  /// each re-exported library's bridges into the source library's
  /// per-module environment, mirroring Dart's `export …` directives.
  ///
  /// Mirror of the same field on [D4rtRunner] in tom_d4rt_ast — kept in
  /// lockstep so generated bridge code calling `registerLibraryReExport`
  /// works against either interpreter.
  final Map<String, List<({String uri, Set<String>? show, Set<String>? hide})>>
  _libraryReExports = {};

  InterpretedInstance? _interpretedInstance;
  InterpreterVisitor? _visitor;
  // Step #17 — thunk-backed native-type lookup. A registration stores a
  // `Type → thunk` entry without building the BridgedClass; the body is built
  // (and memoized) only when a native value of that type is first wrapped.
  final LazyBridgeRegistry<Type> _bridgedDefLookupByType = LazyBridgeRegistry();
  final Set<Permission> _grantedPermissions = {};

  // ===========================================================================
  // Step 7 (import-optimization plan) — process-global package pool.
  //
  // The pool pays each bridge package's registration cost at most once per
  // process and keys it by the package name passed to [providePackage], so a
  // second interpreter instance for the same package reuses the pooled
  // definitions instead of rebuilding them. Security is enforced per instance
  // via the [_allowedPackages] whitelist: an instance only ever sees the
  // packages it explicitly provided (plus the synthetic [_defaultPackage] used
  // by unmigrated callers, which is never shared into a migrated instance).
  //
  // Mirror of the same machinery on [D4rtRunner] in tom_d4rt_ast — kept in
  // lockstep so embedders that switch between the analyzer-based and
  // analyzer-free entry points see the same `providePackage` surface.
  // ===========================================================================

  /// Synthetic package name for [register*] calls made without an active
  /// [providePackage] context (legacy / unmigrated callers). Every instance
  /// is implicitly allowed this package so today's "everything is exposed"
  /// behaviour is preserved for consumers that have not adopted the
  /// `providePackage`-guarded registration idiom.
  static const String _defaultPackage = '<default>';

  /// Process-global pool of per-package registration payloads, keyed by the
  /// package name passed to [providePackage] (or [_defaultPackage] for
  /// unmigrated callers). Built once per package per process.
  static final Map<String, _PackageBridgeBundle> _packagePool = {};

  /// Per-instance security whitelist: the set of packages this instance has
  /// been granted via [providePackage]. Consumed by the warm-parent build and
  /// the per-module registry merge below.
  final Set<String> _allowedPackages = {};

  /// The package whose bridges are currently being registered, set by
  /// [providePackage] when it returns `false`. [register*] calls accumulate
  /// into [_packagePool] under this package until the next [providePackage]
  /// call (or `null`, in which case they fall back to [_defaultPackage]).
  String? _currentProvidingPackage;

  /// Step 8 — process-global cache of warm parent [Environment]s for
  /// **migrated** instances, keyed by the sorted allowed-set signature
  /// (`(_allowedPackages.toList()..sort()).join('|')`). Two instances granted
  /// the same set of packages share one warm parent: stdlib + the pooled
  /// bridge type baseline for those packages, built once per signature per
  /// process. Cleared together with [_packagePool] by [debugResetPool].
  static final Map<String, Environment> _warmParentCache = {};

  /// Step 8 — per-instance warm parent for **legacy** instances (those with an
  /// empty [_allowedPackages]). Built from this instance's per-instance
  /// registration maps and cached *here*, not in [_warmParentCache]: legacy
  /// registrations all land under [_defaultPackage], so a process-global cache
  /// keyed on the (empty) signature would leak one instance's bridges into
  /// another and collide on same-named classes across tests. A per-instance
  /// field keeps each legacy interpreter's warm parent private while still
  /// building it at most once for that instance.
  Environment? _instanceWarmParent;

  /// Per-instance analogue of [_bridgedModuleEnvCache] for **legacy** instances
  /// (empty [_allowedPackages]) and for the cross-run reuse that
  /// [reuseAcrossRuns] enables by default. A process-global cache cannot be
  /// used for legacy instances — their bridges collapse onto [_defaultPackage],
  /// so the empty signature would substitute one instance's module envs into
  /// another. This per-instance map keeps the bound bridged-module environments
  /// private to the instance while still letting repeated `execute*` calls on
  /// the same instance reuse them. Invalidated by [_bundleFor] whenever a new
  /// registration arrives, so a register-after-execute sequence rebinds. `null`
  /// when [reuseAcrossRuns] is `false` (every run rebuilds for isolation).
  Map<String, Environment>? _instanceBridgedModuleEnvCache;

  /// Step #2 (import-binding optimization) — process-global cache of the
  /// per-bridged-module [Environment]s for **migrated** instances, keyed first
  /// by the sorted allowed-set signature (the same key as [_warmParentCache])
  /// and then by module URI string.
  ///
  /// Building a bridged module's environment (binding its whole transitive
  /// re-export surface — e.g. `package:flutter/material.dart` pulls in ~982
  /// classes) is the dominant `pass2Setup` cost. Before this cache it was
  /// rebuilt on **every** `execute*` because the [ModuleLoader] (and its
  /// per-loader `_bridgedModuleEnvironments`) is recreated each run. The bound
  /// definitions all come from the immutable process-global [_packagePool], so
  /// a module env is identical across executes that share an allowed-set and is
  /// safe to share. It is built with the shared warm parent
  /// ([_warmParentCache] entry) as its `enclosing`, so it carries no
  /// per-execution state. Cleared together with [_packagePool] /
  /// [_warmParentCache] by [debugResetPool].
  ///
  /// Legacy instances (empty [_allowedPackages]) are intentionally excluded:
  /// like the warm parent, their bridges collapse onto [_defaultPackage], so a
  /// process-global cache keyed on the empty signature would leak one
  /// interpreter's bridges into another. They keep the per-loader, per-execute
  /// behavior.
  static final Map<String, Map<String, Environment>> _bridgedModuleEnvCache =
      {};

  /// Step #2 diagnostics — incremented each time a bridged module environment
  /// is *built* (a cache miss in [_bridgedModuleEnvCache]). A reuse leaves it
  /// unchanged. Lets tests assert the cache is hit across executes that share
  /// an allowed-set and rebuilt for a different one.
  static int _debugBridgedModuleEnvBuilds = 0;

  /// Step #2 diagnostics — number of bridged module environments built so far
  /// (process-wide). See [_debugBridgedModuleEnvBuilds].
  static int get debugBridgedModuleEnvBuildCount =>
      _debugBridgedModuleEnvBuilds;

  /// Per-instance, insertion-ordered set of package names for which this
  /// instance registered an extension callback via [registerExtensions].
  /// [finalizeBridges] fires the pooled callbacks for these packages in
  /// registration order, skipping any whose pooled bundle has already fired
  /// in this process (step 11 once-per-package-per-process firing, guarded by
  /// `_PackageBridgeBundle.extensionFired`).
  final Set<String> _extensionPackages = {};

  /// Step 8/9 — cached merged per-module registries for the migrated path,
  /// keyed by the sorted allowed-set signature. Rebuilt when the signature
  /// changes (i.e. a new package is granted between executes). `null` for the
  /// legacy path (which passes the per-instance maps directly).
  String? _mergedRegistriesKey;
  _PackageBridgeBundle? _mergedRegistries;

  /// Step 6: whether [finalizeBridges] has run on this runner.
  bool _bridgesFinalized = false;

  /// Set when the `D4RT_LOG_RELAXER_USAGE` environment variable enabled
  /// [D4.usageLogEnabled] at finalize time. Gates the automatic end-of-run
  /// summary so embedders that flip the flag programmatically manage their own
  /// reporting. This env-var convenience is the VM-only twin divergence — the
  /// web-capable `tom_d4rt_ast` runner has no `dart:io` and enables the flag
  /// directly.
  bool _usageLogFromEnv = false;

  /// Gets the current interpreter visitor instance.
  ///
  /// Returns null if no execution is currently in progress.
  InterpreterVisitor? get visitor => _visitor;

  /// Whether [finalizeBridges] has been called on this runner. Step 6.
  bool get bridgesFinalized => _bridgesFinalized;

  // Library-scoped globals (registered with library path) - added when import is processed
  // Structure matches classes/enums: List of {libraryPath: definition}
  // For functions: use LibraryFunction wrapper that includes sourceUri for deduplication
  // For variables/getters: wrapper classes contain name, value/getter, and sourceUri
  final Map<String /*uri*/, Map<String /*name*/, LibraryFunction>>
  _libraryFunctions = {};
  final Map<String /*uri*/, Map<String /*name*/, LibraryVariable>>
  _libraryVariables = {};
  final Map<String /*uri*/, Map<String /*name*/, LibraryGetter>>
  _libraryGetters = {};
  final Map<String /*uri*/, Map<String /*name*/, LibrarySetter>>
  _librarySetters = {};

  late ModuleLoader _moduleLoader;
  bool _hasExecutedOnce = false;

  /// §U28 / TODO #14 — snapshot of `_moduleLoader.globalEnvironment.values`
  /// keys captured at the end of [_initModule], AFTER stdlib registration
  /// but BEFORE per-library bridge imports are processed during
  /// `execute*`.
  ///
  /// Used by [resetScriptDeclarations] to distinguish entries created
  /// by the script (and per-library bridge imports) from entries
  /// created by [Stdlib.register]. On reset, anything outside this
  /// baseline is evicted; the next `execute*` rebuilds [_moduleLoader]
  /// from scratch via [_initModule], so the eviction is observation-
  /// only and never strands a running execution.
  ///
  /// `null` until the first [_initModule] call.
  Set<String>? _baselineValueKeys;

  /// Step 7 — Grants [packageName] to this instance and reports whether its
  /// bridge definitions are already in the process-global pool.
  ///
  /// Returns `true`  → already pooled; the caller should **skip** registration
  ///                   and the pooled definitions are reused for this instance.
  /// Returns `false` → not pooled; the caller **must** register the package's
  ///                   bridges now. Those `register*` calls accumulate into the
  ///                   pool under [packageName] (because this call sets
  ///                   [_currentProvidingPackage]), so the next instance in the
  ///                   process gets `true`.
  ///
  /// Either way [packageName] is added to this instance's [_allowedPackages]
  /// whitelist — only allowed packages are exposed in the interpreter
  /// environment (consumed by the warm-parent build and the per-module
  /// registry merge).
  ///
  /// Idempotent on [packageName]: calling it again for an already-provided
  /// package returns `true` (it is now pooled) and leaves the grant in place.
  ///
  /// Mirror of [D4rtRunner.providePackage] in tom_d4rt_ast. Canonical call
  /// site:
  /// ```dart
  /// if (d4rt.providePackage('tom_d4rt_flutter') == false) {
  ///   FlutterMaterialBridges.register(d4rt); // first instance pays the cost
  ///   d4rt.registerExtensions('tom_d4rt_flutter', registerOverrides);
  /// }
  /// // here the package is registered AND allowed in this instance
  /// ```
  bool providePackage(String packageName) {
    _allowedPackages.add(packageName);
    // Granting a new package changes the merged-registry / warm-parent
    // signature; drop the per-instance merge cache so it rebuilds.
    _mergedRegistries = null;
    _mergedRegistriesKey = null;
    final alreadyPooled = _packagePool.containsKey(packageName);
    if (alreadyPooled) {
      // Pooled already — the caller skips registration, so no package context
      // is opened. Clear any stale context from a prior provide call.
      _currentProvidingPackage = null;
      Logger.debug(
        '[D4rt.providePackage] "$packageName" already pooled — reusing '
        'pooled definitions.',
      );
      return true;
    }
    // First time this package is seen in the process: open the registration
    // context so the caller's register* calls land in the pool under this
    // package, and create the (empty) bundle now so an extension-only package
    // still has a home.
    _currentProvidingPackage = packageName;
    _bundleFor(packageName);
    Logger.debug(
      '[D4rt.providePackage] "$packageName" not pooled — caller must '
      'register; subsequent register* route into the pool.',
    );
    return false;
  }

  /// Returns the pooled bundle for the currently-providing package, creating
  /// it on first use. Falls back to [_defaultPackage] for `register*` calls
  /// made without an active [providePackage] context (legacy callers).
  ///
  /// This is the single choke point for *every* `register*` call, so it is also
  /// where the per-instance cross-run caches are invalidated: a new
  /// registration may change what the warm parent or a bridged module env
  /// should bind, so any previously-built per-instance caches are stale and
  /// must be rebuilt on the next run. (No-op for the process-global migrated
  /// caches, which are keyed by the immutable pool signature; clearing
  /// per-instance fields here also fixes a latent [_instanceWarmParent]
  /// register-after-execute staleness bug.)
  _PackageBridgeBundle _bundleFor([String? package]) {
    _instanceWarmParent = null;
    _instanceBridgedModuleEnvCache = null;
    return _packagePool.putIfAbsent(
      package ?? _currentProvidingPackage ?? _defaultPackage,
      _PackageBridgeBundle.new,
    );
  }

  /// The packages this instance has been granted via [providePackage]
  /// (its security whitelist). Read-only snapshot.
  Set<String> get allowedPackages => Set.unmodifiable(_allowedPackages);

  /// Diagnostics / test introspection — the set of package names currently in
  /// the process-global pool (including the synthetic [_defaultPackage] once a
  /// legacy `register*` call has run). Read-only; does not expose the bundles.
  static Set<String> get debugPooledPackages => _packagePool.keys.toSet();

  /// Diagnostics / test introspection — the number of bridged classes pooled
  /// under [packageName] across all source URIs (0 if not pooled).
  static int debugPooledClassCount(String packageName) {
    final bundle = _packagePool[packageName];
    if (bundle == null) return 0;
    var count = 0;
    for (final byName in bundle.bridgedClasses.values) {
      count += byName.length;
    }
    return count;
  }

  /// Diagnostics / test introspection — clears the process-global pool and the
  /// step-8 warm-parent cache (the migrated-instance parents are keyed on pool
  /// contents, so they must be evicted together to stay consistent). Used only
  /// by tests that need a pristine pool. Not part of the normal runtime
  /// contract.
  static void debugResetPool() {
    _packagePool.clear();
    _warmParentCache.clear();
    // Step #2 — the cached bridged module envs are keyed on the same allowed-set
    // signatures and built against the (now-cleared) warm parents, so evict
    // them together to stay consistent.
    _bridgedModuleEnvCache.clear();
    _debugBridgedModuleEnvBuilds = 0;
  }

  /// Diagnostics / test introspection — how many warm parents are currently
  /// cached for migrated instances (step 8).
  static int get debugWarmParentCacheSize => _warmParentCache.length;

  /// Step #3 (retention) — number of source modules whose parsed
  /// [CompilationUnit] this instance currently retains (via the live
  /// [_moduleLoader]'s per-loader cache). `0` before the first execute or after
  /// [dispose]. Because every `execute*` builds a fresh [_moduleLoader], this
  /// reflects only the *current* run, never an accumulation of prior runs'
  /// ASTs — the test asserts it stays bounded across N sequential executes.
  int get debugLoadedModuleCount =>
      _hasExecutedOnce ? _moduleLoader.loadedModuleCount : 0;

  /// Step 9 — returns the merged per-module registry bundle for a **migrated**
  /// instance (one that has called [providePackage] at least once), or `null`
  /// for the **legacy** path (which reads the per-instance maps directly).
  ///
  /// Unlike `tom_d4rt_ast`, the analyzer-based [ModuleLoader] reads its bridge
  /// registries by reference (passed at construction) and registers names
  /// per-module at import time. A migrated instance that got `true` from
  /// [providePackage] skipped its own `register*` calls, so its per-instance
  /// maps are incomplete — the authoritative definitions live only in the
  /// pooled bundles. This merges the pooled bundles for the granted packages
  /// (sorted, deterministic) into one combined bundle the [ModuleLoader] and
  /// the [classAliases] / [functionTypedefs] / [libraryReExports] getters read
  /// from. The synthetic [_defaultPackage] is intentionally excluded — the
  /// allowed-set is the security boundary.
  ///
  /// Cached per-instance keyed on the allowed-set signature so it is built at
  /// most once per signature (rebuilt only when [providePackage] grants a new
  /// package between executes).
  _PackageBridgeBundle? _mergedBundleOrNull() {
    if (_allowedPackages.isEmpty) return null;
    final key = (_allowedPackages.toList()..sort()).join('|');
    if (_mergedRegistries != null && _mergedRegistriesKey == key) {
      return _mergedRegistries;
    }
    final merged = _PackageBridgeBundle();
    for (final packageName in _allowedPackages.toList()..sort()) {
      final bundle = _packagePool[packageName];
      if (bundle != null) _mergeBundleInto(merged, bundle);
    }
    _mergedRegistries = merged;
    _mergedRegistriesKey = key;
    return merged;
  }

  /// Step 9 — merges every registry slice of [source] into [target]. Inner
  /// per-URI maps are combined name-by-name (last-write-wins, matching the
  /// per-instance registration behaviour); per-URI extension lists are
  /// appended.
  void _mergeBundleInto(
    _PackageBridgeBundle target,
    _PackageBridgeBundle source,
  ) {
    source.bridgedEnumDefinitions.forEach(
      (uri, byName) =>
          (target.bridgedEnumDefinitions[uri] ??= {}).addAll(byName),
    );
    source.bridgedClasses.forEach(
      (uri, byName) => (target.bridgedClasses[uri] ??= {}).addAll(byName),
    );
    source.bridgedExtensions.forEach(
      (uri, list) => (target.bridgedExtensions[uri] ??= []).addAll(list),
    );
    target.classAliases.addAll(source.classAliases);
    target.functionTypedefs.addAll(source.functionTypedefs);
    source.libraryFunctions.forEach(
      (uri, byName) => (target.libraryFunctions[uri] ??= {}).addAll(byName),
    );
    source.libraryVariables.forEach(
      (uri, byName) => (target.libraryVariables[uri] ??= {}).addAll(byName),
    );
    source.libraryGetters.forEach(
      (uri, byName) => (target.libraryGetters[uri] ??= {}).addAll(byName),
    );
    source.librarySetters.forEach(
      (uri, byName) => (target.librarySetters[uri] ??= {}).addAll(byName),
    );
    // Step #17 — preserve deferred thunks across the bundle merge.
    target.bridgedDefLookupByType.addThunksFrom(source.bridgedDefLookupByType);
    source.libraryReExports.forEach(
      (uri, list) => (target.libraryReExports[uri] ??= []).addAll(list),
    );
  }

  /// Registers a bridged enum definition for use in interpreted code.
  ///
  /// [definition] The enum definition containing the native enum type and its values.
  /// [library] The library identifier where this enum should be available.
  /// [sourceUri] The canonical source URI where this enum is defined.
  ///   Used for deduplication when the same enum is exported through multiple barrels.
  void registerBridgedEnum(
    BridgedEnumDefinition definition,
    String library, {
    String? sourceUri,
  }) {
    final libEnum = LibraryEnum(definition, sourceUri: sourceUri);
    (_bridgedEnumDefinitions[library] ??= {})[libEnum.name] = libEnum;
    // Step 7: dual-write into the process-global pool for the current package
    // (or '<default>' for unmigrated callers).
    final bundle = _bundleFor();
    (bundle.bridgedEnumDefinitions[library] ??= {})[libEnum.name] = libEnum;
  }

  /// Registers a bridged class definition for use in interpreted code.
  ///
  /// This allows native Dart classes to be accessible and instantiable
  /// from within interpreted code, enabling seamless integration between
  /// native and interpreted environments.
  ///
  /// [definition] The class definition containing constructors, methods, and properties.
  /// [library] The library identifier where this class should be available.
  /// [sourceUri] The canonical source URI where this class is defined.
  ///   Used for deduplication when the same class is exported through multiple barrels.
  void registerBridgedClass(
    BridgedClass definition,
    String library, {
    String? sourceUri,
  }) {
    // Eager registration wraps the already-built [definition] as a trivial
    // thunk; the lazy path memoizes it on first lookup (behaviour unchanged).
    registerBridgedClassLazy(
      definition.name,
      definition.nativeType,
      () => definition,
      library,
      sourceUri: sourceUri,
    );
  }

  /// Lazily registers a bridged class: stores [name] / [nativeType] / the
  /// deferred [thunk] without building the [BridgedClass]. The body (member
  /// maps + adapter closures) is built (and memoized) only when [name] or
  /// [nativeType] is first resolved during interpretation.
  ///
  /// This is the substrate the generator's lazy bridge emission targets
  /// (import-optimization plan step #17): a script that touches N of a
  /// package's classes builds ≈N bridges, not all of them. Eager callers go
  /// through [registerBridgedClass], which wraps a built class as `() => obj`.
  void registerBridgedClassLazy(
    String name,
    Type nativeType,
    BridgedClass Function() thunk,
    String library, {
    String? sourceUri,
  }) {
    final libClass = LibraryClass.lazy(
      name,
      nativeType,
      thunk,
      sourceUri: sourceUri,
    );
    (_bridgedClases[library] ??= {})[name] = libClass;
    _bridgedDefLookupByType.putThunk(nativeType, thunk);
    // Step 7: dual-write into the process-global pool (see registerBridgedEnum).
    final bundle = _bundleFor();
    (bundle.bridgedClasses[library] ??= {})[name] = libClass;
    bundle.bridgedDefLookupByType.putThunk(nativeType, thunk);
  }

  /// GEN-074: Registers a type alias for a bridged class.
  ///
  /// Type aliases like `typedef MaterialStateProperty<T> = WidgetStateProperty<T>`
  /// allow the same bridged class to be accessed under multiple names.
  ///
  /// [aliasName] The alias name (e.g., 'MaterialStateProperty').
  /// [targetName] The canonical class name (e.g., 'WidgetStateProperty').
  /// [library] The library identifier where this alias should be available.
  ///
  /// The alias is registered with the module loader's global environment.
  void registerClassAlias(String aliasName, String targetName, String library) {
    final alias = (
      aliasName: aliasName,
      targetName: targetName,
      library: library,
    );
    _classAliases.add(alias);
    // Step 7: dual-write into the process-global pool (see registerBridgedEnum).
    _bundleFor().classAliases.add(alias);
  }

  /// GEN-079: Registers a function typedef so it can be resolved as a type.
  ///
  /// Function typedefs like `typedef VoidCallback = void Function()` are not
  /// classes, but D4rt scripts may reference them as type arguments
  /// (e.g., `ObserverList<VoidCallback>()`). This registers the name
  /// so the runtime can create a `BridgedClass` with `nativeType: Function`
  /// for type resolution.
  ///
  /// [name] The typedef name (e.g., 'VoidCallback').
  /// [library] The library path where this typedef is exported from.
  void registerFunctionTypedef(String name, String library) {
    final typedef = (name: name, library: library);
    _functionTypedefs.add(typedef);
    // Step 7: dual-write into the process-global pool (see registerBridgedEnum).
    _bundleFor().functionTypedefs.add(typedef);
  }

  /// GEN-100: Registered class aliases for module-env registration.
  ///
  /// Exposed so [ModuleLoader._registerBridgesForUriInto] can register
  /// aliases (e.g. MaterialStateProperty → WidgetStateProperty) into
  /// per-module environments.  Mirrors [D4rtRunner.classAliases].
  List<({String aliasName, String targetName, String library})>
  get classAliases => _mergedBundleOrNull()?.classAliases ?? _classAliases;

  /// GEN-100: Registered function typedefs for module-env registration.
  ///
  /// Exposed so [ModuleLoader._registerBridgesForUriInto] can register
  /// function typedef names (e.g. VoidCallback) into per-module environments.
  /// Mirrors [D4rtRunner.functionTypedefs].
  List<({String name, String library})> get functionTypedefs =>
      _mergedBundleOrNull()?.functionTypedefs ?? _functionTypedefs;

  /// GEN-107: Registered library re-exports keyed by source library URI.
  ///
  /// Mirror of [D4rtRunner.libraryReExports] — see that getter for the
  /// full contract. Exposed so the module loader can merge re-export
  /// targets into the source library's per-module environment.
  Map<String, List<({String uri, Set<String>? show, Set<String>? hide})>>
  get libraryReExports =>
      _mergedBundleOrNull()?.libraryReExports ?? _libraryReExports;

  /// GEN-107: Registers a re-export from one library to another.
  ///
  /// Mirrors Dart's `export 'other/library.dart' [show/hide …]` directive:
  /// records that [sourceUri] re-exports symbols from [targetUri], with
  /// optional [show] and [hide] filters.
  ///
  /// The recorded entries are consumed by `ModuleLoader._mergeReExportsGlobal`
  /// when a bridged library is imported. That method loads bridges for every
  /// transitively re-exported target into `globalEnvironment`, so a script
  /// that imports `package:flutter/material.dart` automatically gets `Widget`
  /// (registered under `package:flutter/widgets.dart`) without importing
  /// `widgets.dart` explicitly. This mirrors what
  /// `AstModuleLoader._mergeReExports` does for the AST-based pipeline.
  /// Generated bridge code can call this on either interpreter without
  /// branching.
  ///
  /// [sourceUri] The library doing the re-exporting (e.g.
  /// `package:flutter/services.dart`).
  /// [targetUri] The library being re-exported (e.g. `dart:typed_data`).
  /// [show] Optional set of names to include from [targetUri].
  /// [hide] Optional set of names to exclude from [targetUri].
  void registerLibraryReExport(
    String sourceUri,
    String targetUri, {
    Set<String>? show,
    Set<String>? hide,
  }) {
    final reExport = (uri: targetUri, show: show, hide: hide);
    _libraryReExports.putIfAbsent(sourceUri, () => []).add(reExport);
    // Step 7: dual-write into the process-global pool (see registerBridgedEnum).
    _bundleFor().libraryReExports
        .putIfAbsent(sourceUri, () => [])
        .add(reExport);
  }

  /// Registers a bridged extension for use in interpreted code.
  ///
  /// When the corresponding library is imported in a D4rt script, the extension
  /// is converted to an [InterpretedExtension] and added to the environment,
  /// making its methods/getters/setters discoverable via [findExtensionMember].
  ///
  /// [definition] The extension definition containing methods, getters, and the target type name.
  /// [library] The library identifier where this extension should be available.
  /// [sourceUri] The canonical source URI where this extension is defined.
  void registerBridgedExtension(
    BridgedExtensionDefinition definition,
    String library, {
    String? sourceUri,
  }) {
    final libExt = LibraryExtension(definition, sourceUri: sourceUri);
    (_bridgedExtensions[library] ??= []).add(libExt);
    // Step 7: dual-write into the process-global pool (see registerBridgedEnum).
    (_bundleFor().bridgedExtensions[library] ??= []).add(libExt);
  }

  /// Registers a top-level native function for use in interpreted code.
  ///
  /// [name] The name by which the function will be accessible in interpreted code.
  /// [function] The native function implementation to be called.
  /// [library] The library path (package URI) where this function is exported from.
  ///   The function is only added to the environment when this library is imported.
  /// [sourceUri] The canonical source URI where this function is defined.
  ///   Used for deduplication when the same function is exported through multiple barrels.
  /// [signature] The full signature of the function as a display string.
  void registertopLevelFunction(
    String? name,
    NativeFunctionImpl function,
    String library, {
    String? sourceUri,
    String? signature,
  }) {
    final nativeFunc = NativeFunction(function, name: name, arity: 0);
    final libFunc = LibraryFunction(
      nativeFunc,
      sourceUri: sourceUri,
      signature: signature,
    );
    (_libraryFunctions[library] ??= {})[libFunc.name] = libFunc;
    // Step 7: dual-write into the process-global pool (see registerBridgedEnum).
    (_bundleFor().libraryFunctions[library] ??= {})[libFunc.name] = libFunc;
  }

  /// Registers a global variable for use in interpreted code.
  ///
  /// This allows native Dart objects to be accessible as top-level variables
  /// in interpreted code when the corresponding library is imported.
  ///
  /// [name] The name by which the variable will be accessible in interpreted code.
  /// [value] The value to bind to the variable. Can be any Dart object.
  /// [library] The library path (package URI) where this variable is exported from.
  ///   The variable is only added to the environment when this library is imported.
  /// [sourceUri] The canonical source URI where this variable is defined.
  ///   Used for deduplication when the same variable is exported through multiple barrels.
  ///
  /// ## Example:
  /// ```dart
  /// final interpreter = D4rt();
  /// interpreter.registerGlobalVariable('config', {'debug': true}, 'package:my_app/my_app.dart');
  /// interpreter.registerGlobalVariable('appName', 'MyApp', 'package:my_app/my_app.dart');
  /// ```
  void registerGlobalVariable(
    String name,
    Object? value,
    String library, {
    String? sourceUri,
  }) {
    final libVar = LibraryVariable(name, value, sourceUri: sourceUri);
    (_libraryVariables[library] ??= {})[name] = libVar;
    // Step 7: dual-write into the process-global pool (see registerBridgedEnum).
    (_bundleFor().libraryVariables[library] ??= {})[name] = libVar;
  }

  /// Registers a global getter for use in interpreted code.
  ///
  /// Unlike [registerGlobalVariable], this registers a getter function that
  /// is evaluated each time the variable is accessed. This is useful for
  /// variables whose values may not be available at registration time, or
  /// whose values may change over time.
  ///
  /// [name] The name by which the variable will be accessible in interpreted code.
  /// [getter] A function that returns the current value when called.
  /// [library] The library path (package URI) where this getter is exported from.
  ///   The getter is only added to the environment when this library is imported.
  /// [sourceUri] The canonical source URI where this getter is defined.
  ///   Used for deduplication when the same getter is exported through multiple barrels.
  ///
  /// ## Example:
  /// ```dart
  /// final interpreter = D4rt();
  /// interpreter.registerGlobalGetter('currentTime', () => DateTime.now(), 'package:my_app/my_app.dart');
  /// ```
  void registerGlobalGetter(
    String name,
    Object? Function() getter,
    String library, {
    String? sourceUri,
  }) {
    final libGetter = LibraryGetter(name, getter, sourceUri: sourceUri);
    (_libraryGetters[library] ??= {})[name] = libGetter;
    // Step 7: dual-write into the process-global pool (see registerBridgedEnum).
    (_bundleFor().libraryGetters[library] ??= {})[name] = libGetter;
  }

  /// Registers a global setter for a top-level setter in a specific library.
  ///
  /// This enables assignment to top-level variables that have setter definitions.
  /// The setter is paired with a corresponding getter (registered via
  /// [registerGlobalGetter]) to enable full read-write access.
  ///
  /// [name] The name of the setter (without 'set' keyword).
  /// [setter] A function that receives the assigned value and updates the native state.
  /// [library] The library URI where this setter is defined.
  /// [sourceUri] The canonical source URI where this setter is defined.
  ///   Used for deduplication when the same setter is exported through multiple barrels.
  ///
  /// ## Example:
  /// ```dart
  /// int _counter = 0;
  ///
  /// final interpreter = D4rt();
  /// interpreter.registerGlobalGetter('counter', () => _counter, 'package:my_app/my_app.dart');
  /// interpreter.registerGlobalSetter('counter', (v) => _counter = v as int, 'package:my_app/my_app.dart');
  /// ```
  void registerGlobalSetter(
    String name,
    void Function(Object?) setter,
    String library, {
    String? sourceUri,
  }) {
    final libSetter = LibrarySetter(name, setter, sourceUri: sourceUri);
    (_librarySetters[library] ??= {})[name] = libSetter;
    // Step 7: dual-write into the process-global pool (see registerBridgedEnum).
    (_bundleFor().librarySetters[library] ??= {})[name] = libSetter;
  }

  ModuleLoader _initModule(
    Map<String, String>? sources, {
    String? basePath,
    bool allowFileSystemImports = false,
    bool collectRegistrationErrors = false,
  }) {
    // Step 9 — finalize extensions BEFORE the merged registries and the warm
    // parent are built. Both are snapshots/caches: the migrated path feeds the
    // [ModuleLoader] a cached merged-pool *snapshot* and the warm parent is
    // cached process-wide, so any bridges an extension callback registers must
    // already be in the pool/per-instance maps when we read them here.
    // [finalizeBridges] is idempotent — the later call in [_executeInEnvironment]
    // (and any explicit embedder call) becomes a no-op. Divergence from
    // tom_d4rt_ast, whose `_initEnvironment` does not finalize because its
    // canonical embedder (FlutterD4rt) finalizes via `warmup` before the first
    // execute; tom_d4rt makes the implicit path correct without that
    // requirement.
    final swFinalize = D4rtProfiler.enabled ? (Stopwatch()..start()) : null;
    finalizeBridges();
    if (D4rtProfiler.enabled) {
      D4rtProfiler.record(
        '_initModule.finalizeBridges',
        swFinalize!.elapsedMicroseconds,
      );
    }

    // Step 9 — pick the registries the [ModuleLoader] reads from. Legacy
    // instances pass their per-instance maps directly; migrated instances
    // (those that called [providePackage]) pass the merged pooled bundle,
    // because their own per-instance maps are empty when `providePackage`
    // returned `true`.
    final merged = _mergedBundleOrNull();
    if (merged != null) {
      // Mirror the pooled native-type lookup into the per-instance map so
      // [_bridgeNativeValueToInterpreter] (which reads `_bridgedDefLookupByType`
      // directly) can resolve native types from pooled packages too.
      _bridgedDefLookupByType.addThunksFrom(merged.bridgedDefLookupByType);
    }

    // Step 8 — the stdlib baseline and the type-only bridge lookup live on a
    // shared, immutable warm parent built at most once (see [_warmParent]).
    // Each execute gets a fresh child chained off that parent; name / bridge
    // lookups that miss in the child chain up to the parent.
    final swWarm = D4rtProfiler.enabled ? (Stopwatch()..start()) : null;
    final warmParent = _warmParent();
    final child = Environment(enclosing: warmParent);
    if (D4rtProfiler.enabled) {
      D4rtProfiler.record(
        '_initModule.warmParent',
        swWarm!.elapsedMicroseconds,
      );
    }

    // Step #2 — bridged-module environments are bound once and reused across
    // runs, the single biggest `pass2Setup` win: the transitive bridge surface
    // (e.g. ~982 classes for `package:flutter/material.dart`) is bound once
    // instead of on every execute. Two reuse regimes, both gated by
    // [reuseAcrossRuns]:
    //  * Migrated instances (non-empty allowed-set) share their module envs
    //    process-wide via [_bridgedModuleEnvCache], keyed by the allowed-set
    //    signature — safe to share because the bound definitions come from the
    //    immutable process-global pool.
    //  * Legacy instances (empty allowed-set) reuse a *per-instance*
    //    [_instanceBridgedModuleEnvCache] — never shared across instances, so
    //    their `<default>`-package bridges cannot substitute into another
    //    interpreter, while repeated `execute*` on the same instance still
    //    reuse the bound surface.
    // When [reuseAcrossRuns] is false both stay null → the loader rebuilds the
    // module envs fresh every run for full inter-run isolation.
    Map<String, Environment>? sharedBridgedModuleEnvs;
    Environment? sharedModuleEnclosing;
    if (reuseAcrossRuns) {
      if (_allowedPackages.isNotEmpty) {
        final key = (_allowedPackages.toList()..sort()).join('|');
        sharedBridgedModuleEnvs = _bridgedModuleEnvCache.putIfAbsent(
          key,
          () => {},
        );
      } else {
        sharedBridgedModuleEnvs = _instanceBridgedModuleEnvCache ??= {};
      }
      sharedModuleEnclosing = warmParent;
    }

    final swLoader = D4rtProfiler.enabled ? (Stopwatch()..start()) : null;
    final moduleLoader = ModuleLoader(
      child,
      sources ?? {},
      merged?.bridgedEnumDefinitions ?? _bridgedEnumDefinitions,
      merged?.bridgedClasses ?? _bridgedClases,
      libraryFunctions: merged?.libraryFunctions ?? _libraryFunctions,
      libraryVariables: merged?.libraryVariables ?? _libraryVariables,
      libraryGetters: merged?.libraryGetters ?? _libraryGetters,
      librarySetters: merged?.librarySetters ?? _librarySetters,
      bridgedExtensions: merged?.bridgedExtensions ?? _bridgedExtensions,
      d4rt: this,
      // DFUB1 — thread the filesystem-import config to the loader. Previously
      // these arrived at _initModule but were never forwarded, so relative
      // filesystem imports could not resolve (dead no-op).
      basePath: basePath,
      allowFileSystemImports: allowFileSystemImports,
      collectRegistrationErrors: collectRegistrationErrors,
      sharedBridgedModuleEnvironments: sharedBridgedModuleEnvs,
      sharedModuleEnclosing: sharedModuleEnclosing,
      onBridgedModuleEnvBuilt: () => _debugBridgedModuleEnvBuilds++,
    );
    if (D4rtProfiler.enabled) {
      D4rtProfiler.record(
        '_initModule.moduleLoader',
        swLoader!.elapsedMicroseconds,
      );
    }
    _visitor = InterpreterVisitor(
      globalEnvironment: child,
      moduleLoader: moduleLoader,
    );

    // §U28 / TODO #14 — capture the baseline of the child's `_values` keys for
    // [resetScriptDeclarations]. With the step-8 split the child starts empty
    // (stdlib + bridge type baseline live on the immutable parent), so the
    // baseline is effectively empty and a reset evicts every script-declared /
    // per-import entry the script added to the child.
    _baselineValueKeys = child.values.keys.toSet();

    return moduleLoader;
  }

  /// Step 8 — returns this instance's warm parent [Environment], building it at
  /// most once.
  ///
  /// Two cache regimes, selected by whether the instance has been migrated to
  /// the `providePackage` idiom:
  ///
  ///  * **Migrated** (`_allowedPackages` non-empty): the parent is keyed on the
  ///    sorted allowed-set signature and shared process-wide via
  ///    [_warmParentCache]. It is built from the pooled bridge bundles for the
  ///    granted packages only — the security boundary is the allowed-set.
  ///  * **Legacy** (`_allowedPackages` empty): the parent is built from this
  ///    instance's per-instance registration maps and cached per-instance
  ///    ([_instanceWarmParent]). It is *not* shared, because legacy
  ///    registrations all collapse onto [_defaultPackage]; a process-global
  ///    cache would leak one instance's bridges into another and collide on
  ///    same-named classes across tests.
  ///
  /// Mirror of [D4rtRunner._warmParent] in tom_d4rt_ast, with one deliberate
  /// divergence: tom_d4rt registers only the **type** lookup on the parent
  /// (`registerBridgeType`), not full name bindings (`defineBridge`). The
  /// analyzer-based [ModuleLoader] owns per-module name registration at import
  /// time to preserve module isolation (GEN-100/107); the parent only needs to
  /// answer `toBridgedInstance` type queries for native values returned by
  /// bridge methods before imports are processed.
  Environment _warmParent() {
    // Full inter-run isolation: build a throwaway warm parent every run so no
    // cached state survives between `execute*` calls on this instance.
    if (!reuseAcrossRuns) {
      return _allowedPackages.isEmpty
          ? _buildWarmParentFromInstanceMaps()
          : _buildWarmParentFromPool();
    }
    if (_allowedPackages.isEmpty) {
      return _instanceWarmParent ??= _buildWarmParentFromInstanceMaps();
    }
    final key = (_allowedPackages.toList()..sort()).join('|');
    return _warmParentCache.putIfAbsent(key, _buildWarmParentFromPool);
  }

  /// Builds a warm parent from this instance's per-instance registration maps
  /// (legacy path). Stdlib + the type-only bridge lookup baseline.
  Environment _buildWarmParentFromInstanceMaps() {
    final parent = Environment();
    Stdlib(parent).register();
    for (final byName in _bridgedClases.values) {
      for (final libClass in byName.values) {
        // Step #17 — seed the type baseline deferred; the bridge body is built
        // only if a native value of this type is actually wrapped at runtime.
        parent.registerBridgeTypeLazy(libClass.nativeType, libClass.thunk);
      }
    }
    return parent;
  }

  /// Builds a warm parent from the pooled bridge bundles for this instance's
  /// granted packages (migrated path). Stdlib + the type-only bridge lookup of
  /// the allowed packages only, in sorted package order for determinism.
  Environment _buildWarmParentFromPool() {
    final parent = Environment();
    Stdlib(parent).register();
    for (final packageName in _allowedPackages.toList()..sort()) {
      final bundle = _packagePool[packageName];
      if (bundle == null) continue;
      for (final byName in bundle.bridgedClasses.values) {
        for (final libClass in byName.values) {
          // Step #17 — deferred type baseline (see _buildWarmParentFromInstanceMaps).
          parent.registerBridgeTypeLazy(libClass.nativeType, libClass.thunk);
        }
      }
    }
    return parent;
  }

  /// §U28 / TODO #14 — Evict script-declared entries from the current
  /// [_moduleLoader].`globalEnvironment` so a follower `execute*` /
  /// `executeBundle*` call starts with the same name-set the last
  /// `_initModule` produced.
  ///
  /// Walks `_moduleLoader.globalEnvironment.values` and removes every
  /// key not present in [_baselineValueKeys] (the snapshot captured at
  /// the end of [_initModule]). Bridge registrations
  /// (`_bridgedClasses`, `_bridgedClassesLookupByType`, `_bridgedEnums`)
  /// are NOT touched.
  ///
  /// It additionally clears the process-global native-side accumulator via
  /// [D4.resetNativeAccumulators] — the [D4] `_nativeToInterpreted` Expando
  /// and its registration counter. That Expando is the genuine cross-build
  /// accumulator (OPEN B.12 / §U28): its entries are pinned by framework
  /// objects the embedder keeps alive across `/build` cycles, so unlike the
  /// per-call-fresh `_values` map it does NOT self-clear. Dropping it here is
  /// what makes the reset API more than a no-op for the §U28 wedge.
  ///
  /// ## Architectural note
  ///
  /// As of the 2026‑05‑28 audit (interpreter_unfixable.md §U28),
  /// `execute*` already calls [_initModule] on every invocation, which
  /// constructs a brand-new [ModuleLoader] backed by a brand-new
  /// [Environment]. The previous environment is dropped on the floor
  /// by the next call, so script declarations do NOT accumulate
  /// across executes in `_values`. The `_values` eviction below is
  /// therefore a forward-compatibility hook (frees GC roots earlier;
  /// survives any future change to the per-call fresh-loader invariant).
  /// The native-accumulator clear, by contrast, addresses real
  /// cross-build state — see OPEN B.12.
  ///
  /// No-op on the `_values` half if [_moduleLoader] has not been
  /// initialised yet ([_hasExecutedOnce] is false) or if no baseline was
  /// captured; the native-accumulator clear runs unconditionally.
  void resetScriptDeclarations() {
    // Cross-build native state (OPEN B.12): clear unconditionally — it is
    // process-global and not tied to this instance's module lifecycle.
    D4.resetNativeAccumulators();

    if (!_hasExecutedOnce) return;
    final baseline = _baselineValueKeys;
    if (baseline == null) return;
    final env = _moduleLoader.globalEnvironment;
    final toRemove = <String>[];
    for (final key in env.values.keys) {
      if (!baseline.contains(key)) {
        toRemove.add(key);
      }
    }
    for (final key in toRemove) {
      env.removeLocalValue(key);
    }
    Logger.debug(
      "[D4rt.resetScriptDeclarations] Removed ${toRemove.length} "
      "script-declared entries; ${env.values.length} stdlib entries "
      "preserved; native accumulator cleared.",
    );
  }

  /// Step #3 (retention) — releases the interpreter artifacts retained from the
  /// most recent run so a finished run's parsed [CompilationUnit], interpreted
  /// declarations, and per-run environment become collectable while this
  /// instance is kept alive but idle.
  ///
  /// This addresses the baseline's per-instance AST/`BridgedClass` retention:
  /// an embedder that creates one [D4rt] per script (the pattern that produced
  /// ~88 retained `CompilationUnitImpl` generations) can call [dispose] after a
  /// run to drop that run's AST graph instead of pinning it for the instance's
  /// whole lifetime. (Reusing a *single* instance across scripts is now cheap —
  /// step #2 shares the ~982-class bridge surface process-wide — and is the
  /// preferred pattern; [dispose] covers the per-instance case.)
  ///
  /// What it releases (per-run state only):
  ///  * the script-declared environment entries and the cross-build native
  ///    accumulator, via [resetScriptDeclarations];
  ///  * the parsed-module cache holding this run's [CompilationUnit]s, via
  ///    [ModuleLoader.releaseLoadedModules];
  ///  * the [InterpreterVisitor] ([_visitor]).
  ///
  /// What it preserves (process-global, no per-run state): the package pool,
  /// warm-parent cache, and shared bridged-module env cache. A subsequent
  /// `execute*` rebuilds the per-run loader/visitor via [_initModule] as usual,
  /// so [dispose] is non-destructive — the instance remains fully usable.
  void dispose() {
    resetScriptDeclarations();
    if (_hasExecutedOnce) {
      _moduleLoader.releaseLoadedModules();
    }
    _visitor = null;
  }

  /// Validates all bridge registrations by running the given init script
  /// and collecting all registration errors without aborting on the first one.
  ///
  /// This is useful for checking that all bridges are correctly configured
  /// and there are no duplicate element names across modules.
  ///
  /// Returns a list of registration error messages. An empty list means
  /// all registrations are valid.
  ///
  /// [source] The source code that imports all bridge modules (typically
  ///   all the import statements plus `void main() {}`).
  ///
  /// ## Example:
  /// ```dart
  /// final d4rt = D4rt();
  /// // ... register bridges ...
  /// final errors = d4rt.validateRegistrations(
  ///   source: """
  ///     import 'package:my_pkg/my_pkg.dart';
  ///     import 'package:other_pkg/other_pkg.dart';
  ///     void main() {}
  ///   """,
  /// );
  /// if (errors.isNotEmpty) {
  ///   print('Registration errors:');
  ///   for (final error in errors) {
  ///     print('  - $error');
  ///   }
  /// }
  /// ```
  List<String> validateRegistrations({
    required String source,
    Map<String, String>? sources,
    String? basePath,
    bool allowFileSystemImports = false,
  }) {
    // Initialize module loader in error-collecting mode
    _moduleLoader = _initModule(
      sources,
      basePath: basePath,
      allowFileSystemImports: allowFileSystemImports,
      collectRegistrationErrors: true,
    );

    try {
      // Parse source — this triggers import processing and registration
      final compilationUnit = _parseSource(source: source);

      // Execute main to complete initialization
      final executionEnvironment = _moduleLoader.globalEnvironment;
      _executeInEnvironment(
        compilationUnit: compilationUnit,
        executionEnvironment: executionEnvironment,
        name: 'main',
      );
    } catch (e) {
      // If there are non-registration errors (e.g., parse errors),
      // add them to the accumulated list
      if (_moduleLoader.accumulatedRegistrationErrors.isEmpty) {
        return ['Unexpected error during validation: $e'];
      }
    }

    _hasExecutedOnce = true;
    return List.unmodifiable(_moduleLoader.accumulatedRegistrationErrors);
  }

  /// Called when an error escapes an interpreted callback that the platform
  /// invoked *outside* the script's own future chain.
  ///
  /// A `Stream.listen` callback, a `handleError` handler and a `Timer` body are
  /// all invoked by the platform, not by the script. When one of them throws,
  /// native Dart sends the error to the current [Zone] and lets the enclosing
  /// `main()` return normally — and d4rt matches that. The problem it leaves
  /// behind is that `Zone`, `runZoned` and `runZonedGuarded` are deliberately
  /// unbridged (see `unbridged_reasons.dart`), so an interpreted script has no
  /// way at all to observe its own callback failing. This hook is the
  /// embedder's way in.
  ///
  /// The error handed to the hook is the value the script actually threw. The
  /// interpreter's internal `InternalInterpreterD4rtException` wrapper is
  /// removed first, so this path agrees with the synchronous one, where
  /// [execute] already rethrows the original value.
  ///
  /// **Setting a hook contains the error**: it is reported here and *not*
  /// forwarded to the enclosing zone, which is what makes it usable as a
  /// sandbox boundary by a host that runs untrusted script.
  ///
  /// Errors the caller can already observe are not routed here — anything that
  /// propagates through [execute]'s return value or thrown exception stays on
  /// that path.
  ///
  /// **Set this before calling [execute]**, and understand that setting it
  /// makes d4rt own the *error zone* for the execution. That is what allows the
  /// errors to be caught at all, but it also means a `Future` created by the
  /// embedder *before* [execute] and passed into the script reports its errors
  /// to the embedder's zone rather than to the script — the ordinary
  /// consequence of an error-zone boundary, and the reason this is opt-in.
  /// Leaving it null keeps the pre-existing routing untouched: escapes reach
  /// the enclosing zone, still wrapped in the interpreter's internal exception
  /// type.
  ///
  /// ## Example:
  /// ```dart
  /// final d4rt = D4rt();
  /// d4rt.onUncaughtError = (error, stackTrace) {
  ///   log.warning('script callback failed', error, stackTrace);
  /// };
  /// ```
  void Function(Object error, StackTrace stackTrace)? onUncaughtError;

  /// Enables or disables debug logging for the interpreter.
  ///
  /// When enabled, the interpreter will output detailed information about
  /// execution flow, variable lookups, method calls, and other internal operations.
  ///
  /// [enabled] Whether to enable debug logging.
  void setDebug(bool enabled) => Logger.setDebug(enabled);

  /// Grants a permission for security-sensitive operations.
  ///
  /// This method allows granting specific permissions that are required for
  /// accessing dangerous modules like dart:io, dart:isolate, or performing
  /// file system operations, network access, or process execution.
  ///
  /// [permission] The permission to grant.
  ///
  /// ## Example:
  /// ```dart
  /// final interpreter = D4rt();
  /// interpreter.grant(FilesystemPermission.any);
  /// interpreter.grant(NetworkPermission.any);
  /// ```
  void grant(Permission permission) {
    _grantedPermissions.add(permission);
    Logger.debug("[D4rt.grant] Granted permission: ${permission.description}");
  }

  /// Revokes a previously granted permission.
  ///
  /// [permission] The permission to revoke.
  void revoke(Permission permission) {
    _grantedPermissions.remove(permission);
    Logger.debug("[D4rt.revoke] Revoked permission: ${permission.description}");
  }

  // ===========================================================================
  // Extension hook (Step 6) — mirror of D4rtRunner.registerExtensions /
  // finalizeBridges in tom_d4rt_ast. Bridge packages declare post-bridge
  // wiring up front and the runner controls when it runs, replacing the
  // comment-driven "must run AFTER bridges" rule with an enforced contract.
  // ===========================================================================

  /// Registers a [body] callback that wires additional bridge state
  /// (e.g. `registerRelaxers()`, `registerD4rtRuntimeExtensions()`,
  /// `registerD4rtInterfaceProxyOverrides()`) **after** the main
  /// `registerBridgedClass`/`registerBridgedEnum`/etc. registrations
  /// for [packageName] have happened.
  ///
  /// The body is *not* run immediately — the runner queues it and runs
  /// every queued body in registration order when [finalizeBridges] is
  /// called (or implicitly on the first `execute`/`eval` call that
  /// follows). Mirrors the behaviour of `D4rtRunner.registerExtensions`
  /// in tom_d4rt_ast.
  ///
  /// **Idempotent on package name:** a second call with the same
  /// [packageName] overwrites the previous body — the contract is one
  /// extension callback per bridge package. The body itself must
  /// internally tolerate being run more than once if the embedder
  /// constructs multiple [D4rt] instances in the same process, since the
  /// D4 / BridgedClass registries it touches are static. (Step 5 made
  /// the per-key D4 registries idempotent on factory identity, so this
  /// contract is satisfied for the standard `register*` calls.)
  ///
  /// Throws [StateError] if [finalizeBridges] has already run on this
  /// instance — adding extensions after finalization is a misuse.
  void registerExtensions(String packageName, void Function() body) {
    if (_bridgesFinalized) {
      throw StateError(
        'Cannot registerExtensions("$packageName"): finalizeBridges() has '
        'already been called on this D4rt. Register all extensions '
        'before the first execute*/eval call (or call finalizeBridges() '
        'explicitly after the last registerExtensions).',
      );
    }
    // Step 7/11: the body is stored on the package's pooled bundle rather than
    // an instance map, and this instance records the package in
    // [_extensionPackages] (in registration order) so [finalizeBridges] knows
    // which pooled callbacks to fire and when. Firing is once per package per
    // process — the first interpreter to finalize the package fires it, later
    // interpreters (and later instances granted the already-pooled package)
    // skip it.
    _bundleFor(packageName).extensionCallback = body;
    _extensionPackages.add(packageName);
  }

  /// Runs every extension callback registered via [registerExtensions]
  /// in registration order, then marks the runner as finalized.
  ///
  /// `execute` / `eval` invoke this implicitly on first run if it has
  /// not been called already, so embedders don't have to remember to
  /// call it. Calling it explicitly first is supported and preferred
  /// when an embedder needs deterministic timing (e.g. a constructor
  /// of a Flutter helper that touches bridges before the first script
  /// runs).
  ///
  /// **Idempotent per instance:** repeat calls on the same interpreter
  /// return without re-running any callback — the contract is "run once,
  /// then frozen". After this call returns, [registerExtensions] throws
  /// [StateError].
  ///
  /// **Step 11 — once per package per process.** Extension callbacks live
  /// on the process-global pooled bundles (`_packagePool`). A callback is
  /// fired only the first time *any* interpreter finalizes the package,
  /// guarded by `_PackageBridgeBundle.extensionFired`. A second interpreter
  /// granted the same (already-pooled) package — e.g. via the canonical
  /// `if (providePackage(name) == false) { register…; registerExtensions… }`
  /// idiom, where the second instance skips both — never re-fires it.
  /// Because the callback's effects (relaxers, interface proxies, generic
  /// constructors) land in *static* D4 / BridgedClass registries shared
  /// across instances, firing once is correct and sufficient.
  void finalizeBridges() {
    if (_bridgesFinalized) return;
    _bridgesFinalized = true;
    // Callbacks live on the pooled bundles; fire this instance's registered
    // packages in registration order, but only those not yet fired anywhere
    // in the process (step 11 once-per-package-per-process guard).
    for (final packageName in _extensionPackages) {
      final bundle = _packagePool[packageName];
      final callback = bundle?.extensionCallback;
      if (callback == null) continue;
      if (bundle!.extensionFired) {
        Logger.debugLazy(
          () =>
              '[D4rt.finalizeBridges] Extensions for "$packageName" already '
              'fired in this process — skipping.',
        );
        continue;
      }
      bundle.extensionFired = true;
      Logger.debug(
        '[D4rt.finalizeBridges] Running extensions for "$packageName"',
      );
      callback();
    }
    _maybeEnableUsageLogFromEnv();
  }

  /// OPEN B.11 / U25 — Pre-builds the parser + bridge infrastructure so the
  /// first real build does not cold-start mid-test under host load.
  ///
  /// The first script run after a test harness' `setUpAll` historically
  /// flaked because the analyzer front-end, the bridge/stdlib registration
  /// path ([_initModule] → `Stdlib(...).register()` + bridge-type
  /// registration), and the interpreter all cold-started during that first
  /// build. This pays the cost up front by parsing and executing a trivial
  /// throwaway script (`int main() => 0;`), which JIT-warms the analyzer
  /// parser, the module loader environment, bridge finalization, and the
  /// interpreter call path in one pass.
  ///
  /// **Idempotent and script-neutral:** every real `execute*` rebuilds its
  /// module loader and environment from scratch, so the throwaway warmup
  /// state is discarded. Safe to call once after all bridge registration and
  /// before the first real build. Mirrors `D4rtRunner.warmup` /
  /// `D4rt.warmup` in `tom_d4rt_ast` / `tom_d4rt_exec`.
  void warmup() {
    final swWarmup = D4rtProfiler.enabled ? (Stopwatch()..start()) : null;
    finalizeBridges();
    execute(source: 'int main() => 0;');
    if (D4rtProfiler.enabled) {
      D4rtProfiler.record('warmup', swWarmup!.elapsedMicroseconds);
    }
  }

  /// Enable [D4.usageLogEnabled] when `D4RT_LOG_RELAXER_USAGE` is set to
  /// a truthy value (`1`, `true`, `yes`, `on`, case-insensitive). Resets the
  /// log so each process run starts fresh, and arms the automatic end-of-run
  /// summary. No-op if the env var is unset or the flag is already on.
  void _maybeEnableUsageLogFromEnv() {
    if (_usageLogFromEnv) return;
    final raw = Platform.environment['D4RT_LOG_RELAXER_USAGE'];
    if (raw == null) return;
    const truthy = {'1', 'true', 'yes', 'on'};
    if (!truthy.contains(raw.trim().toLowerCase())) return;
    D4.usageLogEnabled = true;
    D4.resetUsageLog();
    _usageLogFromEnv = true;
  }

  /// Print the [D4.usageLogSummary] at run end when the usage log was
  /// auto-enabled via the environment variable. Embedders that enable the flag
  /// programmatically do their own reporting and are not affected.
  void _maybeEmitUsageLog() {
    if (!_usageLogFromEnv) return;
    // ignore: avoid_print
    print(D4.usageLogSummary());
  }

  // =========================================================================
  // Public user-registration API
  //
  // Thin facade delegates onto the static [D4] sinks, exposed so embedders
  // and bridge packages can register relaxers, interface proxies, and generic
  // constructors for their own (user-project) types without touching the
  // generator. Intended to be called from inside a [registerExtensions] body
  // so the registration runs once at finalize time, in package order, after
  // the standard bridges are wired up. They may also be called directly
  // before the first execute*/eval call.
  // =========================================================================

  /// Registers a relaxer (generic-type-wrapper) factory for [baseTypeName].
  ///
  /// A relaxer converts an interpreted/bridged value into a native instance
  /// of a parameterized (or plain) bridged type when an argument of that type
  /// is required. [baseTypeName] is the *base* type name without type
  /// arguments (e.g. `'ValueListenable'`, `'MyBox'`). Delegates to
  /// [D4.registerGenericTypeWrapper]; registration is idempotent on factory
  /// identity and chains new-first.
  ///
  /// Intended for use inside a [registerExtensions] body.
  void registerRelaxerFactory(
    String baseTypeName,
    GenericTypeWrapperFactory factory,
  ) => D4.registerGenericTypeWrapper(baseTypeName, factory);

  /// Registers an interface-proxy factory for [bridgedTypeName].
  ///
  /// A proxy wraps an [InterpretedInstance] that implements a bridged
  /// abstract interface so it can be passed where the native interface is
  /// required. Delegates to [D4.registerInterfaceProxy]; registration is
  /// idempotent on factory identity.
  ///
  /// Intended for use inside a [registerExtensions] body.
  void registerInterfaceProxy(
    String bridgedTypeName,
    InterfaceProxyFactory factory,
  ) => D4.registerInterfaceProxy(bridgedTypeName, factory);

  /// Registers a generic-constructor factory for [className].[constructorName].
  ///
  /// Used by the interpreter's construction path to build a native instance
  /// of a generic bridged class from interpreted arguments and type
  /// arguments. Use `''` for the unnamed constructor. Delegates to
  /// [D4.registerGenericConstructor]; registration is idempotent on factory
  /// identity and chains new-first.
  ///
  /// Intended for use inside a [registerExtensions] body.
  void registerGenericConstructor(
    String className,
    String constructorName,
    GenericConstructorFactory factory,
  ) => D4.registerGenericConstructor(className, constructorName, factory);

  /// Checks if a specific permission is granted.
  ///
  /// [permission] The permission to check.
  /// Returns true if the permission is granted, false otherwise.
  bool hasPermission(Permission permission) {
    return _grantedPermissions.contains(permission);
  }

  /// Checks if any permission in the granted set allows the given operation.
  ///
  /// [operation] The operation to check permissions for.
  /// Returns true if any granted permission allows the operation.
  bool checkPermission(dynamic operation) {
    for (final permission in _grantedPermissions) {
      if (permission.allows(operation)) {
        return true;
      }
    }
    return false;
  }

  /// Returns a complete configuration snapshot of this interpreter instance.
  ///
  /// This method provides a comprehensive view of the interpreter's current state,
  /// including all registered bridges (classes, enums), permissions, global variables,
  /// and other settings.
  ///
  /// ## Example:
  /// ```dart
  /// final interpreter = D4rt();
  /// interpreter.registerBridgedClass(myClass, 'package:my_lib/my_lib.dart');
  /// interpreter.grant(FilesystemPermission.read);
  /// interpreter.registerGlobalVariable('config', {'debug': true});
  ///
  /// final config = interpreter.getConfiguration();
  /// print(jsonEncode(config.toJson()));
  /// ```
  D4rtConfiguration getConfiguration() {
    // Build imports map from registered bridges
    final importsMap = <String, ImportConfiguration>{};

    // Process bridged classes
    for (final MapEntry(key: importPath, value: byName)
        in _bridgedClases.entries) {
      for (final libClass in byName.values) {
        final bridgedClass = libClass.bridgedClass;

        final classInfo = BridgedClassInfo(
          name: bridgedClass.name,
          nativeTypeName: bridgedClass.nativeType.toString(),
          constructors: bridgedClass.constructors.keys.toList(),
          methods: bridgedClass.methods.keys.toList(),
          getters: bridgedClass.getters.keys.toList(),
          setters: bridgedClass.setters.keys.toList(),
          staticMethods: bridgedClass.staticMethods.keys.toList(),
          staticGetters: bridgedClass.staticGetters.keys.toList(),
          staticSetters: bridgedClass.staticSetters.keys.toList(),
          constructorSignatures: bridgedClass.constructorSignatures,
          methodSignatures: bridgedClass.methodSignatures,
          getterSignatures: bridgedClass.getterSignatures,
          setterSignatures: bridgedClass.setterSignatures,
          staticMethodSignatures: bridgedClass.staticMethodSignatures,
          staticGetterSignatures: bridgedClass.staticGetterSignatures,
          staticSetterSignatures: bridgedClass.staticSetterSignatures,
        );

        if (importsMap.containsKey(importPath)) {
          final existing = importsMap[importPath]!;
          importsMap[importPath] = ImportConfiguration(
            importPath: importPath,
            classes: [...existing.classes, classInfo],
            enums: existing.enums,
          );
        } else {
          importsMap[importPath] = ImportConfiguration(
            importPath: importPath,
            classes: [classInfo],
            enums: [],
          );
        }
      }
    }

    // Process bridged enums
    for (final MapEntry(key: importPath, value: byName)
        in _bridgedEnumDefinitions.entries) {
      for (final libEnum in byName.values) {
        final enumDef = libEnum.enumDefinition;

        final enumInfo = BridgedEnumInfo(
          name: enumDef.name,
          values: enumDef.values.map((e) => e.name).toList(),
        );

        if (importsMap.containsKey(importPath)) {
          final existing = importsMap[importPath]!;
          importsMap[importPath] = ImportConfiguration(
            importPath: importPath,
            classes: existing.classes,
            enums: [...existing.enums, enumInfo],
          );
        } else {
          importsMap[importPath] = ImportConfiguration(
            importPath: importPath,
            classes: [],
            enums: [enumInfo],
          );
        }
      }
    }

    // Build permissions list
    final permissions = _grantedPermissions
        .map((p) => PermissionInfo(type: p.type, description: p.description))
        .toList();

    // Build global variables list from library-scoped variables
    final globalVariables = <GlobalVariableInfo>[];
    for (final MapEntry(key: libraryUri, value: byName)
        in _libraryVariables.entries) {
      for (final variable in byName.values) {
        globalVariables.add(
          GlobalVariableInfo(
            name: variable.name,
            valueType: variable.value?.runtimeType.toString() ?? 'Null',
            libraryUri: libraryUri,
          ),
        );
      }
    }

    // Build global getters list from library-scoped getters
    final globalGetters = <GlobalGetterInfo>[];
    for (final MapEntry(key: libraryUri, value: byName)
        in _libraryGetters.entries) {
      for (final getter in byName.values) {
        globalGetters.add(
          GlobalGetterInfo(name: getter.name, libraryUri: libraryUri),
        );
      }
    }

    // Build global functions list from library-scoped functions
    final globalFunctions = <GlobalFunctionInfo>[];
    final seenFunctions = <String>{};
    for (final MapEntry(key: libraryUri, value: byName)
        in _libraryFunctions.entries) {
      for (final func in byName.values) {
        final name = func.name;
        if (name != '<native>' && !seenFunctions.contains(name)) {
          seenFunctions.add(name);
          globalFunctions.add(
            GlobalFunctionInfo(
              name: name,
              libraryUri: libraryUri,
              signature: func.signature,
            ),
          );
        }
      }
    }

    return D4rtConfiguration(
      imports: importsMap.values.toList(),
      permissions: permissions,
      globalVariables: globalVariables,
      globalGetters: globalGetters,
      globalFunctions: globalFunctions,
      debugEnabled: Logger.debugEnabled,
    );
  }

  /// Returns the current state of the global environment.
  ///
  /// This captures what variables, bridged classes, and bridged enums
  /// are currently defined in the interpreter's global environment.
  /// This is useful for debugging and introspection to see what names
  /// are actually available for use in scripts.
  ///
  /// Returns null if no execution has occurred yet.
  ///
  /// ## Example:
  /// ```dart
  /// final d4rt = D4rt();
  /// d4rt.addBridges(SomeBridges.bridges);
  /// d4rt.execute(source: 'var x = 42;');
  /// final state = d4rt.getEnvironmentState();
  /// print(state?.variables); // Shows 'x' and any registered globals
  /// print(state?.bridgedClasses); // Shows registered bridged classes
  /// ```
  EnvironmentState? getEnvironmentState() {
    if (!_hasExecutedOnce) {
      return null;
    }

    final globalEnv = _moduleLoader.globalEnvironment;

    // Get all variables from the global environment
    final variables = <EnvironmentVariableInfo>[];
    for (final entry in globalEnv.values.entries) {
      variables.add(
        EnvironmentVariableInfo(
          name: entry.key,
          valueType: entry.value?.runtimeType.toString() ?? 'Null',
          isNull: entry.value == null,
        ),
      );
    }

    // Get bridged class names
    final bridgedClasses = globalEnv.bridgedClassNames;

    // Get bridged enum names
    final bridgedEnums = globalEnv.bridgedEnumNames;

    return EnvironmentState(
      variables: variables,
      bridgedClasses: bridgedClasses,
      bridgedEnums: bridgedEnums,
    );
  }

  /// Execute the given source code.
  ///
  /// [source] The source code to execute. If not provided, the main source will be loaded from the given library.
  ///
  /// [name] The name of the function to call. Defaults to 'main'.
  ///
  /// [positionalArgs] The positional arguments to pass to the function.
  ///
  /// [namedArgs] The named arguments to pass to the function.
  ///
  /// [args] @deprecated Use [positionalArgs] instead. Legacy argument passing (will be wrapped in a list).
  ///
  /// [library] The URI of the named function source to load. example: 'package:my_package/main.dart' (if provided, the source parameter will be ignored).
  ///
  /// [sources] The sources to load. example: {'package:my_package/main.dart': 'main() { return "Hello, World!"; }'}
  ///
  /// [basePath] Base directory path for resolving relative imports from the filesystem.
  /// When provided, relative imports (e.g., './utils.dart', '../models/user.dart')
  /// will be resolved against this path.
  ///
  /// [allowFileSystemImports] Whether to allow loading modules from the filesystem.
  /// When true, relative imports and file:// URIs will be resolved and loaded from disk.
  /// Requires FilesystemPermission when using D4rt's permission system.
  ///
  /// ## Example:
  /// ```dart
  /// final d4rt = D4rt();
  ///
  /// // Simple execution
  /// d4rt.execute(source: 'main() => "Hello";');
  ///
  /// // With positional arguments
  /// d4rt.execute(
  ///   source: 'greet(String name, int age) => "Hello \$name, you are \$age";',
  ///   name: 'greet',
  ///   positionalArgs: ['John', 25],
  /// );
  ///
  /// // With named arguments
  /// d4rt.execute(
  ///   source: 'greet({required String name, int age = 0}) => "Hello \$name, \$age";',
  ///   name: 'greet',
  ///   namedArgs: {'name': 'John', 'age': 30},
  /// );
  ///
  /// // Mixed positional and named arguments
  /// d4rt.execute(
  ///   source: 'greet(String greeting, {required String name}) => "\$greeting \$name";',
  ///   name: 'greet',
  ///   positionalArgs: ['Hello'],
  ///   namedArgs: {'name': 'World'},
  /// );
  ///
  /// // With relative imports from filesystem
  /// d4rt.grant(FilesystemPermission.any);
  /// d4rt.execute(
  ///   source: '''
  ///     import './utils.dart';
  ///     main() => greetFromUtils();
  ///   ''',
  ///   basePath: '/path/to/project/lib',
  ///   allowFileSystemImports: true,
  /// );
  /// ```
  dynamic execute({
    String? source,
    String name = 'main',
    List<Object?>? positionalArgs,
    Map<String, Object?>? namedArgs,
    @Deprecated('Use positionalArgs instead') Object? args,
    String? library,
    Map<String, String>? sources,
    String? basePath,
    bool allowFileSystemImports = false,
  }) {
    // Handle deprecated args parameter
    if (args != null && positionalArgs != null) {
      throw ArgumentD4rtException(
        'Cannot use both "args" (deprecated) and "positionalArgs". Use only "positionalArgs".',
      );
    }
    if (args != null) {
      Logger.warn(
        '[D4rt.execute] The "args" parameter is deprecated. Use "positionalArgs" instead.',
      );
      positionalArgs = [args];
    }

    // Initialize a fresh module loader (resets global environment)
    final swInit = D4rtProfiler.enabled ? (Stopwatch()..start()) : null;
    _moduleLoader = _initModule(
      sources,
      basePath: basePath,
      allowFileSystemImports: allowFileSystemImports,
    );
    if (D4rtProfiler.enabled) {
      D4rtProfiler.record('execute._initModule', swInit!.elapsedMicroseconds);
    }

    // Parse the source
    final swParse = D4rtProfiler.enabled ? (Stopwatch()..start()) : null;
    final compilationUnit = _parseSource(source: source, library: library);
    if (D4rtProfiler.enabled) {
      D4rtProfiler.record('execute._parseSource', swParse!.elapsedMicroseconds);
    }

    // Library-scoped globals are registered via ModuleLoader when imports are processed
    final executionEnvironment = _moduleLoader.globalEnvironment;

    // Execute and return result
    return _executeInEnvironment(
      compilationUnit: compilationUnit,
      executionEnvironment: executionEnvironment,
      name: name,
      positionalArgs: positionalArgs,
      namedArgs: namedArgs,
      library: library,
    );
  }

  /// Execute additional source code in the existing global context.
  ///
  /// Unlike [execute], this method does NOT reset the global environment.
  /// It reuses the existing module loader and environment from a previous
  /// [execute] call, allowing you to add more declarations and call functions
  /// while preserving all previously defined variables, functions, and classes.
  ///
  /// **Important**: You must call [execute] at least once before calling
  /// [continuedExecute] to establish the execution context.
  ///
  /// [source] The source code to execute.
  ///
  /// [name] The name of the function to call. Defaults to 'main'.
  ///
  /// [positionalArgs] The positional arguments to pass to the function.
  ///
  /// [namedArgs] The named arguments to pass to the function.
  ///
  /// [library] The URI of the named function source to load.
  ///
  /// ## Example:
  /// ```dart
  /// final d4rt = D4rt();
  ///
  /// // Initial execution sets up context
  /// d4rt.execute(source: 'void main() {}');
  ///
  /// // Add more declarations without resetting
  /// d4rt.continuedExecute(source: '''
  ///   int square(int x) => x * x;
  ///   void main() {}
  /// ''');
  ///
  /// // The square function is now available
  /// final result = d4rt.eval('square(5)'); // Returns 25
  /// ```
  dynamic continuedExecute({
    String? source,
    String name = 'main',
    List<Object?>? positionalArgs,
    Map<String, Object?>? namedArgs,
    String? library,
  }) {
    if (!_hasExecutedOnce) {
      throw RuntimeD4rtException(
        'continuedExecute() requires an existing execution context. Call execute() first.',
      );
    }

    Logger.debug(
      "[D4rt.continuedExecute] Continuing execution in existing context. library: $library",
    );

    // Parse the source (reuses existing module loader for library resolution)
    final compilationUnit = _parseSource(source: source, library: library);

    // Reuse existing environment - don't register globals again
    final executionEnvironment = _moduleLoader.globalEnvironment;

    // Execute and return result
    return _executeInEnvironment(
      compilationUnit: compilationUnit,
      executionEnvironment: executionEnvironment,
      name: name,
      positionalArgs: positionalArgs,
      namedArgs: namedArgs,
      library: library,
    );
  }

  /// Parse source code into a CompilationUnit.
  CompilationUnit _parseSource({String? source, String? library}) {
    if (library != null) {
      Logger.debug(
        "[D4rt._parseSource] Attempting to load source via ModuleLoader for URI: $library",
      );

      // DFUB1 — when filesystem imports are enabled the root library may live
      // on disk rather than in the preloaded sources map, so loadModule reads
      // it via the ModuleLoader's filesystem path. Only require a preloaded
      // source when filesystem imports are disabled.
      if (!_moduleLoader.sources.containsKey(library.toString()) &&
          !_moduleLoader.allowFileSystemImports) {
        final errorMessage =
            "[D4rt._parseSource] The source URI '$library' was not found in sources.";
        Logger.error(errorMessage);
        throw SourceCodeD4rtException(errorMessage);
      }

      if (source?.isNotEmpty ?? false) {
        Logger.warn(
          "[D4rt._parseSource] The 'source' parameter is not empty but 'library' ($library) is used to load from sources. The 'source' string will be ignored.",
        );
      }

      try {
        final loadedRootModule = _moduleLoader.loadModule(Uri.parse(library));
        Logger.debug(
          "[D4rt._parseSource] Source loaded and parsed successfully via ModuleLoader for $library.",
        );
        return loadedRootModule.ast;
      } catch (e) {
        Logger.error(
          "[D4rt._parseSource] Failed to load source $library via ModuleLoader: $e",
        );
        if (e is SourceCodeD4rtException || e is RuntimeD4rtException) {
          rethrow;
        } else {
          throw RuntimeD4rtException(
            "Unexpected failure to load initial module $library: $e",
          );
        }
      }
    } else {
      if (source == null) {
        throw RuntimeD4rtException('Source content must be provided');
      }
      Logger.debug(
        "[D4rt._parseSource] Parsing the provided source string directly (no source URI).",
      );
      // DFUB1 — when a basePath is configured, anchor the parsed unit at
      // `<basePath>/main.dart` so downstream tooling that inspects the unit's
      // path resolves relative filesystem imports against the same base the
      // ModuleLoader uses.
      final basePath = _moduleLoader.basePath;
      final result = parseString(
        content: source,
        throwIfDiagnostics: false,
        path: basePath != null
            ? Directory(basePath).absolute.uri.resolve('main.dart').toFilePath()
            : null,
        featureSet: FeatureSet.fromEnableFlags2(
          sdkLanguageVersion: Version(3, 10, 0),
          flags: [
            'non-nullable',
            'null-aware-elements',
            'triple-shift',
            'spread-collections',
            'control-flow-collections',
            'extension-methods',
            'extension-types',
            'digit-separators',
          ],
        ),
      );

      final errors = result.errors
          .where((e) => e.diagnosticCode.severity == DiagnosticSeverity.ERROR)
          .toList();
      if (errors.isNotEmpty) {
        final errorMessages = errors
            .map((e) {
              final location = result.lineInfo.getLocation(e.offset);
              return "- ${e.message} (line ${location.lineNumber}, column ${location.columnNumber})";
            })
            .join("\n");
        Logger.error("Parsing errors for the direct source:\n$errorMessages");
        throw SourceCodeD4rtException(
          'Fatal parsing errors for the direct source:\n$errorMessages',
          source,
        );
      }
      Logger.debug(
        "[D4rt._parseSource] Direct source string parsed successfully.",
      );
      return result.unit;
    }
  }

  /// Execute a parsed CompilationUnit in the given environment.
  /// Runs the script in a zone d4rt owns, so that errors escaping an
  /// interpreted callback have somewhere to be caught.
  ///
  /// SCC23: a callback the *platform* invokes — a `Stream.listen` handler, a
  /// `handleError` handler, a `Timer` body — is outside the script's future
  /// chain, so an error it throws cannot reach [execute]'s caller. It goes to
  /// the current zone instead, and until this fork existed that meant the
  /// embedder's zone, carrying an interpreter-internal wrapper type.
  ///
  /// The fork is the whole fix, and it is deliberately *one* seam rather than a
  /// guard per adapter: it catches escapes from call sites nobody enumerated,
  /// which is precisely the class of bug that motivated the todo (the escape
  /// was reported against streams and turned out to include timers).
  ///
  /// Note that only *uncaught* errors reach [ZoneSpecification.handleUncaughtError].
  /// A synchronous throw out of [Zone.run] propagates to the caller untouched,
  /// so the error path [execute] already had is unaffected.
  ///
  /// **The zone exists only when [onUncaughtError] is set**, and that is a
  /// constraint rather than a convenience. A zone that specifies
  /// `handleUncaughtError` *is* a new error zone, and Dart deliberately refuses
  /// to deliver an error across an error-zone boundary — `future_impl.dart`,
  /// "Don't cross zone boundaries with errors". Forking unconditionally
  /// therefore stops an ordinary script failure from ever reaching the caller
  /// of [execute]: the awaiting caller registered its listener outside the
  /// zone, so the error is diverted to the uncaught handler and the returned
  /// future simply never completes. F-SCB9-12 caught exactly that. Owning the
  /// error zone is a real change to an embedder's error routing, so it happens
  /// when the embedder asks for it and not otherwise.
  Zone _forkScriptZone() => Zone.current.fork(
    specification: ZoneSpecification(
      handleUncaughtError: (self, parent, zone, error, stackTrace) {
        final scriptError = _unwrapScriptError(error);
        final hook = onUncaughtError;
        if (hook == null) {
          // No embedder hook: behave exactly as before, minus the wrapper.
          parent.handleUncaughtError(zone, scriptError, stackTrace);
          return;
        }
        try {
          hook(scriptError, stackTrace);
        } catch (hookError, hookStack) {
          // An embedder's hook is ordinary code and can be wrong. Losing
          // both errors would be the worst available outcome.
          parent.handleUncaughtError(zone, hookError, hookStack);
        }
      },
    ),
  );

  /// Recovers the value the script actually threw from the interpreter's
  /// internal wrapper.
  ///
  /// This mirrors what [_executeInEnvironment] already does for the
  /// synchronous path, where an `InternalInterpreterD4rtException` is
  /// unwrapped before it is rethrown to the caller. Without it the two paths
  /// hand the host different shapes for the same script failure, and a
  /// *native* error (one the script never touched) would be the only one that
  /// arrived legible.
  static Object _unwrapScriptError(Object error) {
    var value = error;
    if (value is InternalInterpreterD4rtException) {
      value = value.originalThrownValue ?? value;
    }
    // A bridged exception's native object is the thing a host can catch on;
    // the BridgedInstance shell means nothing outside the interpreter.
    if (value is BridgedInstance) return value.nativeObject;
    return value;
  }

  dynamic _executeInEnvironment({
    required CompilationUnit compilationUnit,
    required Environment executionEnvironment,
    required String name,
    List<Object?>? positionalArgs,
    Map<String, Object?>? namedArgs,
    String? library,
  }) {
    run() => _executeInEnvironmentInZone(
      compilationUnit: compilationUnit,
      executionEnvironment: executionEnvironment,
      name: name,
      positionalArgs: positionalArgs,
      namedArgs: namedArgs,
      library: library,
    );

    // No hook, no zone, no behaviour change of any kind. See [_forkScriptZone]
    // for why this is opt-in rather than always on.
    if (onUncaughtError == null) return run();

    final zone = _forkScriptZone();
    final result = zone.run(run);
    if (result is! Future) return result;

    // The script's own failures still belong to the caller, but the caller
    // awaits from *outside* the error zone and Dart will not carry an error
    // across that boundary. Bridge it by hand: listen from inside the zone,
    // where the delivery is legal, and complete a future that belongs to the
    // caller's zone. Without this the returned future would hang and the
    // failure would be misreported to [onUncaughtError] as an escape.
    final bridged = Completer<Object?>();
    zone.run(
      () => result.then(
        bridged.complete,
        onError: (Object error, StackTrace stackTrace) =>
            bridged.completeError(error, stackTrace),
      ),
    );
    return bridged.future;
  }

  dynamic _executeInEnvironmentInZone({
    required CompilationUnit compilationUnit,
    required Environment executionEnvironment,
    required String name,
    List<Object?>? positionalArgs,
    Map<String, Object?>? namedArgs,
    String? library,
  }) {
    // Step 6: bridge packages register post-bridge wiring via
    // [registerExtensions]. Run any queued callbacks now (in registration
    // order) before pass 1 sees any declarations. Idempotent — a no-op
    // if the embedder already called [finalizeBridges] explicitly.
    finalizeBridges();
    Logger.debug("[_executeInEnvironment] Starting Pass 1: Declaration");
    final swPass1 = D4rtProfiler.enabled ? (Stopwatch()..start()) : null;
    final declarationVisitor = DeclarationVisitor(executionEnvironment);
    for (final declaration in compilationUnit.declarations) {
      declaration.accept<void>(declarationVisitor);
    }
    if (D4rtProfiler.enabled) {
      D4rtProfiler.record(
        '_executeInEnvironment.pass1',
        swPass1!.elapsedMicroseconds,
      );
    }
    Logger.debug("[_executeInEnvironment] Finished Pass 1: Declaration");

    final swResolve = D4rtProfiler.enabled ? (Stopwatch()..start()) : null;
    _visitor = InterpreterVisitor(
      globalEnvironment: executionEnvironment,
      moduleLoader: _moduleLoader,
      initiallibrary: library != null
          ? Uri.parse(library)
          // DFUB1 — with filesystem imports enabled and no explicit library,
          // seed the initial library to basePath so relative imports in the
          // root source resolve against it (else "Base URI not defined").
          : (_moduleLoader.allowFileSystemImports &&
                    _moduleLoader.basePath != null
                ? Directory(_moduleLoader.basePath!).absolute.uri
                : null),
    );
    // S1 (plan_3 §9.1): static lexical resolver pass. Populates the visitor's
    // [staticCoords] side-table so the debug depth-assert in
    // visitSimpleIdentifier can validate the scope model. No effect in
    // release builds beyond the (cheap) resolver walk.
    _visitor!.resolveStaticCoordinates(compilationUnit.declarations);
    if (D4rtProfiler.enabled) {
      D4rtProfiler.record(
        '_executeInEnvironment.visitorBuild',
        swResolve!.elapsedMicroseconds,
      );
    }
    Object? functionResult;
    try {
      // Profiler: time the declaration-registration setup (directives +
      // enum/class/extension/function/variable passes) that prepares the
      // environment, ending right before the actual `main()` interpretation.
      final swPass2 = D4rtProfiler.enabled ? (Stopwatch()..start()) : null;
      Logger.debug("[_executeInEnvironment] Starting Pass 2: Interpretation");
      Logger.debug(
        "[_executeInEnvironment] Processing directives (imports, exports, etc.)...",
      );
      for (final directive in compilationUnit.directives) {
        if (directive is ImportDirective) {
          Logger.debug(
            "[_executeInEnvironment]   - Processing ImportDirective: ${directive.uri.stringValue}",
          );
          _visitor!.visitImportDirective(directive);
        } else {
          Logger.debug(
            "[_executeInEnvironment]   - Skipping directive of type: ${directive.runtimeType}",
          );
        }
      }
      Logger.debug("[_executeInEnvironment] Finished processing directives.");

      // RC-4: Process declarations in dependency order (matching ModuleLoader).
      // The DeclarationVisitor (pass 1) only creates class/mixin placeholders
      // with empty constructor maps. We must populate class members before
      // evaluating top-level variable initializers that may reference them
      // (forward-reference problem: const lists using classes defined later).
      Logger.debug(
        "[_executeInEnvironment] Processing declarations in dependency order",
      );

      // 1. Enum declarations first (const variables may reference enum values)
      for (final declaration in compilationUnit.declarations) {
        if (declaration is EnumDeclaration) {
          declaration.accept<Object?>(_visitor!);
        }
      }
      // 2. Class and mixin declarations (populates constructors, methods, etc.)
      //
      // Bug-43 / forward-class-reference FIX (mirrors tom_d4rt_ast): a
      // `static const` initializer can reference another class defined later
      // in source order. Defer every class's static-field block until ALL
      // classes have registered their members, then drain.
      _visitor!.deferStaticFieldInits = true;
      try {
        for (final declaration in compilationUnit.declarations) {
          if (declaration is ClassDeclaration ||
              declaration is MixinDeclaration) {
            declaration.accept<Object?>(_visitor!);
          }
        }
      } finally {
        _visitor!.deferStaticFieldInits = false;
      }
      _visitor!.runDeferredStaticInitializers();
      // 3. Extension declarations
      for (final declaration in compilationUnit.declarations) {
        if (declaration is ExtensionDeclaration) {
          declaration.accept<Object?>(_visitor!);
        }
      }
      // 3b. Extension type declarations (Dart 3.3+). Without this pass the
      //     wrapper class is never registered and `main()` cannot resolve
      //     the constructor — the type appears as Undefined.
      for (final declaration in compilationUnit.declarations) {
        if (declaration is ExtensionTypeDeclaration) {
          declaration.accept<Object?>(_visitor!);
        }
      }
      // 4. Function declarations
      for (final declaration in compilationUnit.declarations) {
        if (declaration is FunctionDeclaration) {
          declaration.accept<Object?>(_visitor!);
        }
      }
      // 5. Top-level variable declarations (initializers can now reference
      //    all classes, enums, functions, and extensions)
      for (final declaration in compilationUnit.declarations) {
        if (declaration is TopLevelVariableDeclaration) {
          declaration.accept<Object?>(_visitor!);
        }
      }
      Logger.debug("[_executeInEnvironment] Finished processing declarations");
      if (D4rtProfiler.enabled) {
        D4rtProfiler.record(
          '_executeInEnvironment.pass2Setup',
          swPass2!.elapsedMicroseconds,
        );
      }
      Logger.debug("[_executeInEnvironment] Looking for $name function");
      final functionCallable = executionEnvironment.get(name);
      if (functionCallable is Callable) {
        List<Object?> interpreterArgs = positionalArgs ?? [];
        final Map<String, Object?> interpreterNamedArgs = namedArgs ?? {};

        // Special handling for 'main' function: if it expects args but none provided,
        // pass an empty list automatically (standard Dart behavior)
        final expectedArity = functionCallable.arity;
        if (name == 'main' &&
            expectedArity > 0 &&
            interpreterArgs.isEmpty &&
            namedArgs?.isEmpty != false) {
          // main expects args but none were provided - pass empty list
          interpreterArgs = [<String>[]];
          Logger.debug(
            "[_executeInEnvironment] 'main' expects arguments but none provided. Passing empty list.",
          );
        }

        // Validate arity (only for positional args, named args are validated by the function itself)
        if (interpreterArgs.length > expectedArity) {
          throw RuntimeD4rtException(
            "'$name' function accepts at most $expectedArity positional argument(s), but ${interpreterArgs.length} were provided.",
          );
        }

        Logger.debug(
          "[_executeInEnvironment] Calling '$name' with positionalArgs: $interpreterArgs, namedArgs: $interpreterNamedArgs",
        );

        functionResult = functionCallable.call(
          _visitor!,
          interpreterArgs,
          interpreterNamedArgs,
        );
      } else {
        throw RuntimeD4rtException(
          "No callable '$name' function found in the test source code.",
        );
      }
      Logger.debug("[_executeInEnvironment] Finished Pass 2: Interpretation");
    } catch (e, s) {
      // SCC27 — the host gets the type the script raised. DFUB13's
      // SourceCodeD4rtException and AmbiguousBridgedNameException, SCB10's four
      // SDK-shaped errors, and the interpreted-`throw` carrier used to be named
      // here one by one; the boundary now states one rule, so a reader no
      // longer has to check a list to predict what crosses it.
      throwAsHostFacingError(e, s);
    }
    if (functionResult is InterpretedInstance) {
      _interpretedInstance = functionResult;
    }
    final resultValue = _bridgeInterpreterValueToNative(functionResult);
    if (resultValue is Future) {
      try {
        _hasExecutedOnce = true;
        return resultValue.then(
          (value) {
            final native = _bridgeInterpreterValueToNative(value);
            _maybeEmitUsageLog();
            return native;
          },
          // SCC27 — an `async main` reports its failure through this future,
          // never through the enclosing try, so the boundary has to be applied
          // here as well. Without it the async half of the API kept relabelling
          // what the sync half had stopped relabelling.
          onError: throwAsHostFacingError,
        );
      } catch (e, s) {
        throwAsHostFacingError(e, s);
      }
    }
    _hasExecutedOnce = true;
    _maybeEmitUsageLog();
    return resultValue;
  }

  // ============================================================================
  // _executeClassic - PRESERVED FOR DEBUGGING REFERENCE
  // ============================================================================
  // DO NOT MODIFY OR DELETE THIS METHOD!
  // This is a backup copy of the original execute() implementation before
  // refactoring. It is kept for reference during debugging in case the
  // refactored version has issues that need comparison with the original logic.
  // ============================================================================
  // TODO: Remove this legacy method once all code uses the new execution path
  // and has been thoroughly tested in production.
  // ignore: unused_element
  dynamic _executeClassic({
    String? source,
    String name = 'main',
    List<Object?>? positionalArgs,
    Map<String, Object?>? namedArgs,
    @Deprecated('Use positionalArgs instead') Object? args,
    String? library,
    Map<String, String>? sources,
    String? basePath,
    bool allowFileSystemImports = false,
  }) {
    // Handle deprecated args parameter
    if (args != null && positionalArgs != null) {
      throw ArgumentD4rtException(
        'Cannot use both "args" (deprecated) and "positionalArgs". Use only "positionalArgs".',
      );
    }
    if (args != null) {
      Logger.warn(
        '[D4rt._executeClassic] The "args" parameter is deprecated. Use "positionalArgs" instead.',
      );
      positionalArgs = [args];
    }
    _moduleLoader = _initModule(
      sources,
      basePath: basePath,
      allowFileSystemImports: allowFileSystemImports,
    );
    Logger.debug(
      "[D4rt._executeClassic] Starting execution. library: $library",
    );
    CompilationUnit compilationUnit;

    if (library != null) {
      Logger.debug(
        "[D4rt._executeClassic] Attempting to load the $name source via ModuleLoader for URI: $library",
      );

      if (!_moduleLoader.sources.containsKey(library.toString())) {
        final errorMessage =
            "[D4rt._executeClassic] The $name source URI '$library' was not found in sources.";
        Logger.error(errorMessage);
        throw SourceCodeD4rtException(errorMessage);
      }

      if (source?.isNotEmpty ?? false) {
        Logger.warn(
          "[D4rt._executeClassic] The 'source' parameter is not empty but 'library' ($library) is used to load from sources. The 'source' string will be ignored.",
        );
      }

      try {
        final loadedRootModule = _moduleLoader.loadModule(Uri.parse(library));
        compilationUnit = loadedRootModule.ast;
        Logger.debug(
          "[D4rt._executeClassic] $name source loaded and parsed successfully via ModuleLoader for $library.",
        );
      } catch (e) {
        Logger.error(
          "[D4rt._executeClassic] Failed to load $name source $library via ModuleLoader: $e",
        );
        if (e is SourceCodeD4rtException || e is RuntimeD4rtException) {
          rethrow;
        } else {
          throw RuntimeD4rtException(
            "Unexpected failure to load initial module $library: $e",
          );
        }
      }
    } else {
      if (source == null) {
        throw RuntimeD4rtException('Source content must be provided');
      }
      Logger.debug(
        "[D4rt._executeClassic] Executing the provided source string directly (no source URI).",
      );
      final result = parseString(
        content: source,
        throwIfDiagnostics: false,
        featureSet: FeatureSet.fromEnableFlags2(
          sdkLanguageVersion: Version(3, 10, 0),
          flags: [
            'non-nullable',
            'null-aware-elements',
            'triple-shift',
            'spread-collections',
            'control-flow-collections',
            'extension-methods',
            'extension-types',
            'digit-separators',
          ],
        ),
      );

      final errors = result.errors
          .where((e) => e.diagnosticCode.severity == DiagnosticSeverity.ERROR)
          .toList();
      if (errors.isNotEmpty) {
        final errorMessages = errors
            .map((e) {
              final location = result.lineInfo.getLocation(e.offset);
              return "- ${e.message} (line ${location.lineNumber}, column ${location.columnNumber})";
            })
            .join("\n");
        Logger.error("Parsing errors for the direct source:\n$errorMessages");
        throw SourceCodeD4rtException(
          'Fatal parsing errors for the direct source:\n$errorMessages',
          source,
        );
      }
      compilationUnit = result.unit;
      Logger.debug(
        "[D4rt._executeClassic] Direct source string parsed successfully.",
      );
    }

    // Library-scoped globals are registered via ModuleLoader when imports are processed
    final Environment executionEnvironment = _moduleLoader.globalEnvironment;

    Logger.debug("[_executeClassic] Starting Pass 1: Declaration");
    final declarationVisitor = DeclarationVisitor(executionEnvironment);
    for (final declaration in compilationUnit.declarations) {
      declaration.accept<void>(declarationVisitor);
    }
    Logger.debug("[_executeClassic] Finished Pass 1: Declaration");

    _visitor = InterpreterVisitor(
      globalEnvironment: executionEnvironment,
      moduleLoader: _moduleLoader,
      initiallibrary: library != null
          ? Uri.parse(library)
          // DFUB1 — with filesystem imports enabled and no explicit library,
          // seed the initial library to basePath so relative imports in the
          // root source resolve against it (else "Base URI not defined").
          : (_moduleLoader.allowFileSystemImports &&
                    _moduleLoader.basePath != null
                ? Directory(_moduleLoader.basePath!).absolute.uri
                : null),
    );
    Object? functionResult;
    try {
      Logger.debug(" [_executeClassic] Starting Pass 2: Interpretation");
      Logger.debug(
        " [_executeClassic] Processing directives (imports, exports, etc.)...",
      );
      for (final directive in compilationUnit.directives) {
        if (directive is ImportDirective) {
          Logger.debug(
            " [_executeClassic]   - Processing ImportDirective: ${directive.uri.stringValue}",
          );
          _visitor!.visitImportDirective(directive);
        } else {
          Logger.debug(
            " [_executeClassic]   - Skipping directive of type: ${directive.runtimeType}",
          );
        }
      }
      Logger.debug(" [_executeClassic] Finished processing directives.");

      // RC-4: Process declarations in dependency order (matching ModuleLoader).
      // See _executeInEnvironment for rationale.
      Logger.debug(
        " [_executeClassic] Processing declarations in dependency order",
      );

      // 1. Enum declarations first
      for (final declaration in compilationUnit.declarations) {
        if (declaration is EnumDeclaration) {
          declaration.accept<Object?>(_visitor!);
        }
      }
      // 2. Class and mixin declarations (populates constructors, methods, etc.)
      // Bug-43 / forward-class-reference FIX (mirrors _executeInEnvironment).
      _visitor!.deferStaticFieldInits = true;
      try {
        for (final declaration in compilationUnit.declarations) {
          if (declaration is ClassDeclaration ||
              declaration is MixinDeclaration) {
            declaration.accept<Object?>(_visitor!);
          }
        }
      } finally {
        _visitor!.deferStaticFieldInits = false;
      }
      _visitor!.runDeferredStaticInitializers();
      // 3. Extension declarations
      for (final declaration in compilationUnit.declarations) {
        if (declaration is ExtensionDeclaration) {
          declaration.accept<Object?>(_visitor!);
        }
      }
      // 3b. Extension type declarations (Dart 3.3+) — see _executeInEnvironment.
      for (final declaration in compilationUnit.declarations) {
        if (declaration is ExtensionTypeDeclaration) {
          declaration.accept<Object?>(_visitor!);
        }
      }
      // 4. Function declarations
      for (final declaration in compilationUnit.declarations) {
        if (declaration is FunctionDeclaration) {
          declaration.accept<Object?>(_visitor!);
        }
      }
      // 5. Top-level variable declarations
      for (final declaration in compilationUnit.declarations) {
        if (declaration is TopLevelVariableDeclaration) {
          declaration.accept<Object?>(_visitor!);
        }
      }
      Logger.debug(" [_executeClassic] Finished processing declarations");
      Logger.debug("[_executeClassic] Looking for $name function");
      final functionCallable = executionEnvironment.get(name);
      if (functionCallable is Callable) {
        List<Object?> interpreterArgs = positionalArgs ?? [];
        final Map<String, Object?> interpreterNamedArgs = namedArgs ?? {};

        // Special handling for 'main' function: if it expects args but none provided,
        // pass an empty list automatically (standard Dart behavior)
        final expectedArity = functionCallable.arity;
        if (name == 'main' &&
            expectedArity > 0 &&
            interpreterArgs.isEmpty &&
            namedArgs?.isEmpty != false) {
          // main expects args but none were provided - pass empty list
          interpreterArgs = [<String>[]];
          Logger.debug(
            "[_executeClassic] 'main' expects arguments but none provided. Passing empty list.",
          );
        }

        // Validate arity (only for positional args, named args are validated by the function itself)
        if (interpreterArgs.length > expectedArity) {
          throw RuntimeD4rtException(
            "'$name' function accepts at most $expectedArity positional argument(s), but ${interpreterArgs.length} were provided.",
          );
        }

        Logger.debug(
          "[_executeClassic] Calling '$name' with positionalArgs: $interpreterArgs, namedArgs: $interpreterNamedArgs",
        );

        functionResult = functionCallable.call(
          _visitor!,
          interpreterArgs,
          interpreterNamedArgs,
        );
      } else {
        throw RuntimeD4rtException(
          "No callable '$name' function found in the test source code.",
        );
      }
      Logger.debug(" [_executeClassic] Finished Pass 2: Interpretation");
    } on InternalInterpreterD4rtException catch (e) {
      if (e.originalThrownValue is RuntimeD4rtException) {
        throw e.originalThrownValue as RuntimeD4rtException;
      } else {
        throw e.originalThrownValue!;
      }
    } catch (e) {
      // DFUB13 — a SourceCodeD4rtException is an EXPECTED, actionable
      // diagnostic (missing import, bad URI). Re-wrapping it as "Unexpected
      // error" discards a message the loader deliberately composed and tells
      // the user they hit an interpreter bug rather than a typo.
      if (e is RuntimeD4rtException || e is SourceCodeD4rtException) {
        rethrow;
      } else {
        throw RuntimeD4rtException('Unexpected error: $e');
      }
    }
    if (functionResult is InterpretedInstance) {
      _interpretedInstance = functionResult;
    }
    final resultValue = _bridgeInterpreterValueToNative(functionResult);
    if (resultValue is Future) {
      try {
        _hasExecutedOnce = true;
        return resultValue.then(
          (value) => _bridgeInterpreterValueToNative(value),
        );
      } on InternalInterpreterD4rtException catch (e) {
        if (e.originalThrownValue is RuntimeD4rtException) {
          throw e.originalThrownValue as RuntimeD4rtException;
        } else {
          throw e.originalThrownValue!;
        }
      } catch (e) {
        // DFUB13 — a SourceCodeD4rtException is an EXPECTED, actionable
        // diagnostic (missing import, bad URI). Re-wrapping it as "Unexpected
        // error" discards a message the loader deliberately composed and tells
        // the user they hit an interpreter bug rather than a typo.
        if (e is RuntimeD4rtException || e is SourceCodeD4rtException) {
          rethrow;
        } else {
          throw RuntimeD4rtException('Unexpected error: $e');
        }
      }
    }
    _hasExecutedOnce = true;
    return resultValue;
  }

  /// Analyzes the given source code and returns introspection information
  /// about all declared functions, classes, variables, enums, and extensions.
  ///
  /// This method parses and processes the source code without executing any function,
  /// allowing you to inspect what declarations are available.
  ///
  /// [source] The source code to analyze.
  ///
  /// [sources] Additional sources for multi-file analysis.
  ///
  /// [includeBuiltins] Whether to include built-in types and functions in the result.
  ///
  /// ## Example:
  /// ```dart
  /// final d4rt = D4rt();
  /// final result = d4rt.analyze(source: '''
  ///   class Person {
  ///     String name;
  ///     int age;
  ///     Person(this.name, this.age);
  ///     String greet() => "Hello, I'm \$name";
  ///   }
  ///
  ///   int add(int a, int b) => a + b;
  ///
  ///   final greeting = "Hello";
  /// ''');
  ///
  /// print(result.classes); // [ClassInfo(Person)]
  /// print(result.functions); // [FunctionInfo(add)]
  /// print(result.variables); // [VariableInfo(greeting)]
  /// ```
  IntrospectionResult analyze({
    required String source,
    Map<String, String>? sources,
    bool includeBuiltins = false,
  }) {
    Logger.debug("[D4rt.analyze] Starting analysis...");

    _moduleLoader = _initModule(sources);

    final parseResult = parseString(
      content: source,
      throwIfDiagnostics: false,
      featureSet: FeatureSet.fromEnableFlags2(
        sdkLanguageVersion: Version(3, 10, 0),
        flags: [
          'non-nullable',
          'null-aware-elements',
          'triple-shift',
          'spread-collections',
          'control-flow-collections',
          'extension-methods',
          'extension-types',
          'digit-separators',
        ],
      ),
    );

    final errors = parseResult.errors
        .where((e) => e.diagnosticCode.severity == DiagnosticSeverity.ERROR)
        .toList();
    if (errors.isNotEmpty) {
      final errorMessages = errors
          .map((e) {
            final location = parseResult.lineInfo.getLocation(e.offset);
            return "- ${e.message} (line ${location.lineNumber}, column ${location.columnNumber})";
          })
          .join("\n");
      throw SourceCodeD4rtException('Parsing errors:\n$errorMessages', source);
    }

    final compilationUnit = parseResult.unit;

    // Library-scoped globals are registered via ModuleLoader when imports are processed
    final Environment executionEnvironment = _moduleLoader.globalEnvironment;

    // Pass 1: Declaration
    final declarationVisitor = DeclarationVisitor(executionEnvironment);
    for (final declaration in compilationUnit.declarations) {
      declaration.accept<void>(declarationVisitor);
    }

    // Pass 2: Process imports and interpret declarations (for variable values)
    _visitor = InterpreterVisitor(
      globalEnvironment: executionEnvironment,
      moduleLoader: _moduleLoader,
    );

    for (final directive in compilationUnit.directives) {
      if (directive is ImportDirective) {
        _visitor!.visitImportDirective(directive);
      }
    }

    for (final declaration in compilationUnit.declarations) {
      declaration.accept<Object?>(_visitor!);
    }

    Logger.debug("[D4rt.analyze] Analysis complete.");
    return IntrospectionBuilder.buildFromEnvironment(
      executionEnvironment,
      includeBuiltins: includeBuiltins,
      compilationUnit: compilationUnit,
    );
  }

  /// Evaluates an expression or statement in the context of previously executed code.
  ///
  /// This method allows you to execute additional code in the same environment
  /// as a previous `execute()` call, similar to a REPL experience.
  ///
  /// **Important**: You must call `execute()` at least once before calling `eval()`
  /// to establish the execution context.
  ///
  /// [expression] The Dart expression or statement to evaluate.
  ///
  /// ## Example:
  /// ```dart
  /// final d4rt = D4rt();
  ///
  /// // First, set up the context
  /// d4rt.execute(source: '''
  ///   var counter = 0;
  ///   void increment() { counter++; }
  ///   int getCounter() => counter;
  /// ''', name: 'getCounter');
  ///
  /// // Now use eval to interact with the established context
  /// d4rt.eval('increment()');
  /// d4rt.eval('increment()');
  /// final result = d4rt.eval('getCounter()'); // Returns 2
  ///
  /// // You can also define new functions
  /// d4rt.eval('int double(int x) => x * 2;');
  /// final doubled = d4rt.eval('double(counter)'); // Returns 4
  /// ```
  dynamic eval(String expression) {
    if (_visitor == null || !_hasExecutedOnce) {
      throw RuntimeD4rtException(
        'eval() requires an existing execution context. Call execute() first.',
      );
    }

    Logger.debug("[D4rt.eval] Evaluating: $expression");
    final executionEnvironment = _moduleLoader.globalEnvironment;

    // First, try to parse as a top-level declaration (function, class, variable)
    final declarationParseResult = parseString(
      content: expression,
      throwIfDiagnostics: false,
      featureSet: FeatureSet.fromEnableFlags2(
        sdkLanguageVersion: Version(3, 10, 0),
        flags: [
          'non-nullable',
          'null-aware-elements',
          'triple-shift',
          'spread-collections',
          'control-flow-collections',
          'extension-methods',
          'extension-types',
          'digit-separators',
        ],
      ),
    );

    // Check if it parses as valid declaration(s)
    final declErrors = declarationParseResult.errors
        .where((e) => e.diagnosticCode.severity == DiagnosticSeverity.ERROR)
        .toList();

    if (declErrors.isEmpty &&
        declarationParseResult.unit.declarations.isNotEmpty) {
      // It's a declaration - process it directly in the global environment
      final compilationUnit = declarationParseResult.unit;

      // Declaration pass
      final declarationVisitor = DeclarationVisitor(executionEnvironment);
      for (final declaration in compilationUnit.declarations) {
        declaration.accept<void>(declarationVisitor);
      }

      // Interpretation pass — RC-4: ordered by type to handle forward references
      for (final declaration in compilationUnit.declarations) {
        if (declaration is EnumDeclaration) {
          declaration.accept<Object?>(_visitor!);
        }
      }
      // Bug-43 / forward-class-reference FIX (mirrors above).
      _visitor!.deferStaticFieldInits = true;
      try {
        for (final declaration in compilationUnit.declarations) {
          if (declaration is ClassDeclaration ||
              declaration is MixinDeclaration) {
            declaration.accept<Object?>(_visitor!);
          }
        }
      } finally {
        _visitor!.deferStaticFieldInits = false;
      }
      _visitor!.runDeferredStaticInitializers();
      for (final declaration in compilationUnit.declarations) {
        if (declaration is! EnumDeclaration &&
            declaration is! ClassDeclaration &&
            declaration is! MixinDeclaration) {
          declaration.accept<Object?>(_visitor!);
        }
      }

      Logger.debug("[D4rt.eval] Processed declaration(s)");
      return null;
    }

    // Check if this looks like multiple statements (contains ; followed by more code)
    // This heuristic helps us choose the right wrapper: statements vs expression
    final trimmedExpr = expression.trim();
    final looksLikeMultiStatement = RegExp(r';\s*\S').hasMatch(trimmedExpr);

    // For single expressions, try wrapping with return to get the value
    if (!looksLikeMultiStatement) {
      final wrappedSource =
          '''
        dynamic __eval__() {
          return $expression;
        }
      ''';

      final parseResult = parseString(
        content: wrappedSource,
        throwIfDiagnostics: false,
        featureSet: FeatureSet.fromEnableFlags2(
          sdkLanguageVersion: Version(3, 10, 0),
          flags: [
            'non-nullable',
            'null-aware-elements',
            'triple-shift',
            'spread-collections',
            'control-flow-collections',
            'extension-methods',
            'extension-types',
            'digit-separators',
          ],
        ),
      );

      if (parseResult.errors.isEmpty) {
        // Execute as expression with return value
        final compilationUnit = parseResult.unit;

        final declarationVisitor = DeclarationVisitor(executionEnvironment);
        for (final declaration in compilationUnit.declarations) {
          declaration.accept<void>(declarationVisitor);
        }

        for (final declaration in compilationUnit.declarations) {
          declaration.accept<Object?>(_visitor!);
        }

        // Call the __eval__ function
        final evalFunc = executionEnvironment.get('__eval__');
        Object? result;
        if (evalFunc is Callable) {
          try {
            result = evalFunc.call(_visitor!, [], {});
          } on InternalInterpreterD4rtException catch (e) {
            if (e.originalThrownValue is RuntimeD4rtException) {
              throw e.originalThrownValue as RuntimeD4rtException;
            }
            throw e.originalThrownValue ?? e;
          }
        }

        final bridgedResult = _bridgeInterpreterValueToNative(result);
        Logger.debug("[D4rt.eval] Result: $bridgedResult");

        if (bridgedResult is Future) {
          return bridgedResult.then(
            (value) => _bridgeInterpreterValueToNative(value),
          );
        }

        return bridgedResult;
      }
    }

    // Try parsing as statement(s) (no return value expected)
    // This is used for multi-statement code or when expression wrapper fails
    final statementSource =
        '''
      void __eval__() {
        $expression
      }
    ''';

    final statementParseResult = parseString(
      content: statementSource,
      throwIfDiagnostics: false,
      featureSet: FeatureSet.fromEnableFlags2(
        sdkLanguageVersion: Version(3, 10, 0),
        flags: [
          'non-nullable',
          'null-aware-elements',
          'triple-shift',
          'spread-collections',
          'control-flow-collections',
          'extension-methods',
          'extension-types',
          'digit-separators',
        ],
      ),
    );

    if (statementParseResult.errors.isEmpty) {
      final compilationUnit = statementParseResult.unit;

      final declarationVisitor = DeclarationVisitor(executionEnvironment);
      for (final declaration in compilationUnit.declarations) {
        declaration.accept<void>(declarationVisitor);
      }

      for (final declaration in compilationUnit.declarations) {
        declaration.accept<Object?>(_visitor!);
      }

      // Call the __eval__ function
      final evalFunc = executionEnvironment.get('__eval__');
      if (evalFunc is Callable) {
        try {
          evalFunc.call(_visitor!, [], {});
        } on InternalInterpreterD4rtException catch (e) {
          if (e.originalThrownValue is RuntimeD4rtException) {
            throw e.originalThrownValue as RuntimeD4rtException;
          }
          throw e.originalThrownValue ?? e;
        }
      }

      Logger.debug("[D4rt.eval] Executed statement");
      return null;
    }

    // All parsing attempts failed
    final errorMessages = declErrors
        .map((e) {
          final location = declarationParseResult.lineInfo.getLocation(
            e.offset,
          );
          return "- ${e.message} (line ${location.lineNumber}, column ${location.columnNumber})";
        })
        .join("\n");
    throw SourceCodeD4rtException(
      'Failed to parse expression:\n$errorMessages',
      expression,
    );
  }

  /// Invoke a property or method on the given instance.
  ///
  /// String name : The name of the property or method to invoke.
  ///
  /// List&lt;Object?&gt; positionalArgs : The positional arguments to pass to the property or method.
  ///
  /// Map&lt;String, Object?&gt; namedArgs = const {} : The named arguments to pass to the property or method.
  ///
  /// Map&lt;String, String&gt;? sources : The sources to load. example: {'package:my_package/main.dart': 'main() { return "Hello, World!"; }'}
  dynamic invoke(
    String name,
    List<Object?> positionalArgs, [
    Map<String, Object?> namedArgs = const {},
    Map<String, String>? sources,
  ]) {
    if (_interpretedInstance == null) {
      throw RuntimeD4rtException(
        "No interpreted instance found. Call setInterpretedInstance first.",
      );
    }
    if (_visitor == null) {
      throw RuntimeD4rtException("No visitor found. Call setVisitor first.");
    }
    final globalEnv = _visitor!.globalEnvironment;
    final instance = _interpretedInstance!;
    final klass = instance.klass;

    InterpretedFunction? interpretedFunction;
    interpretedFunction = klass.findInstanceMethod(name);
    interpretedFunction ??= klass.findInstanceGetter(name);
    interpretedFunction ??= klass.findStaticMethod(name);
    interpretedFunction ??= klass.findStaticGetter(name);
    interpretedFunction ??= klass.findInstanceSetter(name);
    interpretedFunction ??= klass.findStaticSetter(name);
    result() {
      if (interpretedFunction != null) {
        final interpreterPositionalArgs = positionalArgs
            .map((v) => _bridgeNativeValueToInterpreter(v, globalEnv))
            .toList();

        final interpreterNamedArgs = namedArgs.map(
          (key, value) =>
              MapEntry(key, _bridgeNativeValueToInterpreter(value, globalEnv)),
        );
        return _tryFunction(
          () {
            return interpretedFunction!
                .bind(instance)
                .call(
                  _visitor!,
                  interpreterPositionalArgs,
                  interpreterNamedArgs,
                );
          },
          "Error invoking interpreted Method or getter '$name' on '${klass.name}'",
        );
      }

      final bridgedSuperclass = klass.bridgedSuperclass;
      final nativeSuperObject = instance.bridgedSuperObject;

      if (bridgedSuperclass != null) {
        final interpreterPositionalArgs = positionalArgs
            .map((v) => _bridgeNativeValueToInterpreter(v, globalEnv))
            .toList();
        final interpreterNamedArgs = namedArgs.map(
          (key, value) =>
              MapEntry(key, _bridgeNativeValueToInterpreter(value, globalEnv)),
        );

        if (nativeSuperObject != null) {
          final methodAdapter = bridgedSuperclass.findInstanceMethodAdapter(
            name,
          );

          if (methodAdapter != null) {
            return _tryFunction(
              () {
                return methodAdapter.call(
                  _visitor!,
                  nativeSuperObject,
                  interpreterPositionalArgs,
                  interpreterNamedArgs,
                  null,
                );
              },
              "Error invoking bridged method '$name' on superclass '${bridgedSuperclass.name}'",
            );
          }

          final getterAdapter = bridgedSuperclass.findInstanceGetterAdapter(
            name,
          );
          if (getterAdapter != null) {
            return _tryFunction(
              () {
                return getterAdapter.call(_visitor!, nativeSuperObject);
              },
              "Error invoking bridged getter '$name' on superclass '${bridgedSuperclass.name}'",
            );
          }
          final setterAdapter = bridgedSuperclass.findInstanceSetterAdapter(
            name,
          );
          if (setterAdapter != null) {
            return _tryFunction(
              () {
                setterAdapter.call(
                  _visitor!,
                  nativeSuperObject,
                  interpreterPositionalArgs[0],
                );
                return null;
              },
              "Error invoking bridged setter '$name' on superclass '${bridgedSuperclass.name}'",
            );
          }
        }

        final staticMethodAdapter = bridgedSuperclass.findStaticMethodAdapter(
          name,
        );
        if (staticMethodAdapter != null) {
          return _tryFunction(
            () {
              return staticMethodAdapter.call(
                _visitor!,
                interpreterPositionalArgs,
                interpreterNamedArgs,
                null,
              );
            },
            "Error invoking bridged static method '$name' on superclass '${bridgedSuperclass.name}'",
          );
        }

        final getterStaticAdapter = bridgedSuperclass.findStaticGetterAdapter(
          name,
        );
        if (getterStaticAdapter != null) {
          return _tryFunction(
            () {
              return getterStaticAdapter.call(_visitor!);
            },
            "Error invoking bridged static getter '$name' on superclass '${bridgedSuperclass.name}'",
          );
        }

        final staticSetterAdapter = bridgedSuperclass.findStaticSetterAdapter(
          name,
        );
        if (staticSetterAdapter != null) {
          return _tryFunction(
            () {
              staticSetterAdapter.call(_visitor!, interpreterPositionalArgs[0]);
              return null;
            },
            "Error invoking bridged staticsetter '$name' on superclass '${bridgedSuperclass.name}'",
          );
        }
      }

      throw RuntimeD4rtException(
        'Method or getter "$name" not found on instance of class "${klass.name}" or its bridged superclass.',
      );
    }

    return result();
  }

  Object? _bridgeNativeValueToInterpreter(
    Object? nativeValue,
    Environment globalEnv,
  ) {
    if (nativeValue == null ||
        nativeValue is String ||
        nativeValue is num ||
        nativeValue is bool) {
      return nativeValue;
    }
    if (nativeValue is List) {
      return nativeValue
          .map((v) => _bridgeNativeValueToInterpreter(v, globalEnv))
          .toList();
    }
    if (nativeValue is Map) {
      return nativeValue.map(
        (key, value) => MapEntry(
          _bridgeNativeValueToInterpreter(key, globalEnv),
          _bridgeNativeValueToInterpreter(value, globalEnv),
        ),
      );
    }

    final nativeType = nativeValue.runtimeType;
    final bridgedDef = _bridgedDefLookupByType[nativeType];

    if (bridgedDef != null) {
      final bridgedClass = globalEnv.get(bridgedDef.name);
      if (bridgedClass is BridgedClass) {
        return BridgedInstance(bridgedClass, nativeValue);
      } else {
        Logger.warn(
          "BridgedClass '${bridgedDef.name}' not found in global env during bridging.",
        );
        return nativeValue;
      }
    }

    if (nativeValue is Function || nativeValue is Callable) {
      return nativeValue;
    }

    Logger.warn(
      "Passing unknown native type $nativeType directly to interpreter.",
    );
    return nativeValue;
  }

  Object? _bridgeInterpreterValueToNative(Object? interpreterValue) {
    if (interpreterValue == null ||
        interpreterValue is String ||
        interpreterValue is num ||
        interpreterValue is bool) {
      return interpreterValue;
    }
    // Step 4 of the d4rt consolidation plan: delegate the leaf-level
    // BridgedInstance/BridgedEnumValue branches to the shared [D4.unwrapAs]
    // helper. The recursive list/map/record handling below is intentionally
    // *not* delegated — it is a separate native-bridging concern that the
    // [D4.unwrapAs] single-level contract does not cover.
    if (interpreterValue is BridgedInstance ||
        interpreterValue is BridgedEnumValue) {
      return D4.unwrapAs<Object?>(interpreterValue, visitor: _visitor);
    }
    if (interpreterValue is List) {
      return interpreterValue.map(_bridgeInterpreterValueToNative).toList();
    }
    if (interpreterValue is Map) {
      return interpreterValue.map(
        (key, value) => MapEntry(
          _bridgeInterpreterValueToNative(key),
          _bridgeInterpreterValueToNative(value),
        ),
      );
    }
    // Convert InterpretedRecord to native Dart records when possible
    // For positional-only records up to 16 elements, we can create native records
    // For records with named fields or more than 16 positional fields, we return
    // InterpretedRecord with unwrapped field values
    if (interpreterValue is InterpretedRecord) {
      final pos = interpreterValue.positionalFields
          .map(_bridgeInterpreterValueToNative)
          .toList();
      final named = interpreterValue.namedFields;

      // Only convert to native record if there are no named fields
      if (named.isEmpty) {
        switch (pos.length) {
          case 0:
            return ();
          case 1:
            return (pos[0],);
          case 2:
            return (pos[0], pos[1]);
          case 3:
            return (pos[0], pos[1], pos[2]);
          case 4:
            return (pos[0], pos[1], pos[2], pos[3]);
          case 5:
            return (pos[0], pos[1], pos[2], pos[3], pos[4]);
          case 6:
            return (pos[0], pos[1], pos[2], pos[3], pos[4], pos[5]);
          case 7:
            return (pos[0], pos[1], pos[2], pos[3], pos[4], pos[5], pos[6]);
          case 8:
            return (
              pos[0],
              pos[1],
              pos[2],
              pos[3],
              pos[4],
              pos[5],
              pos[6],
              pos[7],
            );
          case 9:
            return (
              pos[0],
              pos[1],
              pos[2],
              pos[3],
              pos[4],
              pos[5],
              pos[6],
              pos[7],
              pos[8],
            );
          case 10:
            return (
              pos[0],
              pos[1],
              pos[2],
              pos[3],
              pos[4],
              pos[5],
              pos[6],
              pos[7],
              pos[8],
              pos[9],
            );
          case 11:
            return (
              pos[0],
              pos[1],
              pos[2],
              pos[3],
              pos[4],
              pos[5],
              pos[6],
              pos[7],
              pos[8],
              pos[9],
              pos[10],
            );
          case 12:
            return (
              pos[0],
              pos[1],
              pos[2],
              pos[3],
              pos[4],
              pos[5],
              pos[6],
              pos[7],
              pos[8],
              pos[9],
              pos[10],
              pos[11],
            );
          case 13:
            return (
              pos[0],
              pos[1],
              pos[2],
              pos[3],
              pos[4],
              pos[5],
              pos[6],
              pos[7],
              pos[8],
              pos[9],
              pos[10],
              pos[11],
              pos[12],
            );
          case 14:
            return (
              pos[0],
              pos[1],
              pos[2],
              pos[3],
              pos[4],
              pos[5],
              pos[6],
              pos[7],
              pos[8],
              pos[9],
              pos[10],
              pos[11],
              pos[12],
              pos[13],
            );
          case 15:
            return (
              pos[0],
              pos[1],
              pos[2],
              pos[3],
              pos[4],
              pos[5],
              pos[6],
              pos[7],
              pos[8],
              pos[9],
              pos[10],
              pos[11],
              pos[12],
              pos[13],
              pos[14],
            );
          case 16:
            return (
              pos[0],
              pos[1],
              pos[2],
              pos[3],
              pos[4],
              pos[5],
              pos[6],
              pos[7],
              pos[8],
              pos[9],
              pos[10],
              pos[11],
              pos[12],
              pos[13],
              pos[14],
              pos[15],
            );
          default:
            // More than 16 positional fields - return InterpretedRecord with unwrapped values
            return InterpretedRecord(pos, {});
        }
      }

      // Has named fields - can't convert to native record, return with unwrapped values
      return InterpretedRecord(
        pos,
        named.map(
          (key, value) => MapEntry(key, _bridgeInterpreterValueToNative(value)),
        ),
      );
    }
    if (interpreterValue is InterpretedInstance ||
        interpreterValue is InterpretedFunction ||
        interpreterValue is NativeFunction ||
        interpreterValue is Callable) {
      return interpreterValue;
    }

    return interpreterValue;
  }

  dynamic _tryFunction(dynamic Function() fn, String error) {
    try {
      final result = fn.call();
      if (result is Future) {
        return result.then((value) => _bridgeInterpreterValueToNative(value));
      }
      return _bridgeInterpreterValueToNative(result);
    } catch (e) {
      if (e is ReturnException) {
        return _bridgeInterpreterValueToNative(e.value);
      }
      if (e is InternalInterpreterD4rtException &&
          e.originalThrownValue != null) {
        throw e.originalThrownValue!;
      }
      throw "$error : $e";
    }
  }
}
