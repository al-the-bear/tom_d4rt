import 'dart:convert';
import 'dart:io';

import 'package:tom_d4rt_ast/ast.dart';
import 'package:tom_d4rt_ast/src/runtime/ast_bundle.dart';
import 'package:tom_d4rt_ast/src/runtime/ast_module_loader.dart';
import 'package:tom_d4rt_ast/src/runtime/bridge/bridged_enum.dart';
import 'package:tom_d4rt_ast/src/runtime/bridge/bridged_types.dart';
import 'package:tom_d4rt_ast/src/runtime/bridge/registration.dart';
import 'package:tom_d4rt_ast/src/runtime/callable.dart';
import 'package:tom_d4rt_ast/src/runtime/declaration_visitor.dart';
import 'package:tom_d4rt_ast/src/runtime/environment.dart';
import 'package:tom_d4rt_ast/src/runtime/exceptions.dart';
import 'package:tom_d4rt_ast/src/runtime/generator/d4.dart';
import 'package:tom_d4rt_ast/src/runtime/interpreter_visitor.dart';
import 'package:tom_d4rt_ast/src/runtime/module_context.dart';
import 'package:tom_d4rt_ast/src/runtime/runtime_types.dart';
import 'package:tom_d4rt_ast/src/runtime/security/permissions.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/stdlib.dart';
import 'package:tom_d4rt_ast/src/runtime/utils/logger/logger.dart';

/// Wrapper class for library-scoped variables.
class LibraryVariable {
  final String name;
  final Object? value;
  final String? sourceUri;

  const LibraryVariable(this.name, this.value, {this.sourceUri});
}

/// Wrapper class for library-scoped getters.
class LibraryGetter {
  final String name;
  final Object? Function() getter;
  final String? sourceUri;

  const LibraryGetter(this.name, this.getter, {this.sourceUri});
}

/// Wrapper class for library-scoped setters.
class LibrarySetter {
  final String name;
  final void Function(Object? value) setter;
  final String? sourceUri;

  const LibrarySetter(this.name, this.setter, {this.sourceUri});
}

/// Wrapper class for library-scoped functions.
class LibraryFunction {
  final NativeFunction function;
  final String? sourceUri;
  final String? signature;

  const LibraryFunction(this.function, {this.sourceUri, this.signature});
  String get name => function.name;
}

/// Wrapper class for library-scoped bridged classes.
class LibraryClass {
  final BridgedClass bridgedClass;
  final String? sourceUri;

  const LibraryClass(this.bridgedClass, {this.sourceUri});
  String get name => bridgedClass.name;
}

/// Wrapper class for library-scoped bridged enums.
class LibraryEnum {
  final BridgedEnumDefinition enumDefinition;
  final String? sourceUri;

  const LibraryEnum(this.enumDefinition, {this.sourceUri});
  String get name => enumDefinition.name;
}

/// Wrapper class for library-scoped bridged extensions.
class LibraryExtension {
  final BridgedExtensionDefinition extensionDefinition;
  final String? sourceUri;

  const LibraryExtension(this.extensionDefinition, {this.sourceUri});
  String? get name => extensionDefinition.name;
}

/// D4rtRunner - Execute pre-parsed AST trees without analyzer dependency.
///
/// This class provides the core interpreter functionality for executing
/// SAstNode trees. Unlike the full D4rt class in tom_d4rt_exec, D4rtRunner
/// works exclusively with pre-parsed AST and does not require the analyzer.
///
/// ## Use Cases
/// - Execute AST loaded from JSON files
/// - Execute AST from precompiled scripts
/// - Embedded interpreter without heavy analyzer dependency
///
/// ## Example:
/// ```dart
/// // From JSON string
/// final runner = D4rtRunner();
/// final ast = runner.parseJson(jsonString);
/// final result = runner.execute(ast: ast);
///
/// // From JSON file
/// final result = await runner.executeFromJsonFile('script.ast.json');
/// ```
///
/// For source code parsing and execution, use the D4rt class from
/// tom_d4rt_exec which provides full integration with tom_ast_generator.
class D4rtRunner {
  final List<Map<String, LibraryEnum>> _bridgedEnumDefinitions = [];
  final List<Map<String, LibraryClass>> _bridgedClasses = [];
  final List<Map<String, LibraryExtension>> _bridgedExtensions = [];

  /// GEN-074: Class aliases (type aliases) for alias name → target class name mapping.
  final List<({String aliasName, String targetName, String library})>
  _classAliases = [];

  /// Function typedefs (e.g., VoidCallback = void Function()) registered
  /// as environment types so they can be resolved in type annotations
  /// and type arguments.
  final List<({String name, String library})> _functionTypedefs = [];

  final List<Map<String, LibraryFunction>> _libraryFunctions = [];
  final List<Map<String, LibraryVariable>> _libraryVariables = [];
  final List<Map<String, LibraryGetter>> _libraryGetters = [];
  final List<Map<String, LibrarySetter>> _librarySetters = [];
  final Map<Type, BridgedClass> _bridgedDefLookupByType = {};
  final Set<Permission> _grantedPermissions = {};

  /// GEN-107: Bridge re-exports modelled in the runtime.
  ///
  /// Maps a source library URI to the list of libraries it re-exports
  /// (with optional `show` / `hide` filters). The module loader consults
  /// this map after registering a library's own bridges and merges each
  /// re-exported library's symbols into the source library's per-module
  /// environment, mirroring how Dart's `export 'other/library.dart'
  /// [show/hide …]` directives publish another library's symbols under
  /// the source library's URI.
  ///
  /// Without this, scripts that legitimately reach a stdlib type via a
  /// transitive re-export chain in real Dart (e.g.
  /// `flutter/services.dart → dart:typed_data → ByteData`) fail at
  /// interpret time with "Undefined variable: …" once per-module bridge
  /// isolation is in place — the workaround being the historical
  /// `_isolatedStdlibs = {'math'}` band-aid that lets every other stdlib
  /// leak into `globalEnvironment`.
  final Map<String,
          List<({String uri, Set<String>? show, Set<String>? hide})>>
      _libraryReExports = {};

  InterpreterVisitor? _visitor;
  Environment? _globalEnvironment;
  bool _hasExecutedOnce = false;

  /// §U28 / TODO #14 — snapshot of [_globalEnvironment].`values` keys
  /// captured at the end of [_initEnvironment], i.e. AFTER stdlib +
  /// bridge registration but BEFORE the DeclarationVisitor visits the
  /// script's top-level declarations.
  ///
  /// Used by [resetScriptDeclarations] to distinguish entries created
  /// by the script from entries created by the runner's own bridge /
  /// stdlib registration. The former are evicted on reset; the latter
  /// are preserved.
  ///
  /// Refreshed on every [_initEnvironment] call (the bridge / stdlib
  /// surface is identical per call, but capturing every time keeps the
  /// snapshot trivially consistent with the current environment).
  Set<String>? _baselineValueKeys;

  /// Step 6: extension callbacks registered by bridge packages, keyed by
  /// package name. Insertion order is preserved (Dart `Map` literals are
  /// `LinkedHashMap`) so [finalizeBridges] runs callbacks deterministically.
  ///
  /// Re-registering with the same `packageName` overwrites the previous
  /// body — the contract is one extension callback per bridge package,
  /// which makes the call idempotent if a process spins up multiple
  /// runners that each fire the same package's `register*` shape.
  final Map<String, void Function()> _extensionCallbacks = {};

  /// Step 6: whether [finalizeBridges] has run on this runner.
  bool _bridgesFinalized = false;

  /// Creates a D4rtRunner instance for executing pre-parsed AST.
  D4rtRunner();

  /// Gets the current interpreter visitor instance.
  InterpreterVisitor? get visitor => _visitor;

  /// Whether [finalizeBridges] has been called on this runner. Step 6.
  bool get bridgesFinalized => _bridgesFinalized;

  // =========================================================================
  // Bridge Data Access (for AstModuleLoader)
  // =========================================================================

  /// Registered bridged enum definitions keyed by library URI.
  List<Map<String, LibraryEnum>> get bridgedEnumDefinitions =>
      _bridgedEnumDefinitions;

  /// Registered bridged class definitions keyed by library URI.
  List<Map<String, LibraryClass>> get bridgedClasses => _bridgedClasses;

  /// Registered bridged extension definitions keyed by library URI.
  List<Map<String, LibraryExtension>> get bridgedExtensions =>
      _bridgedExtensions;

  /// Registered library functions keyed by library URI.
  List<Map<String, LibraryFunction>> get libraryFunctions => _libraryFunctions;

  /// Registered library variables keyed by library URI.
  List<Map<String, LibraryVariable>> get libraryVariables => _libraryVariables;

  /// Registered library getters keyed by library URI.
  List<Map<String, LibraryGetter>> get libraryGetters => _libraryGetters;

  /// Registered library setters keyed by library URI.
  List<Map<String, LibrarySetter>> get librarySetters => _librarySetters;

  /// The set of library URIs that have at least one registered bridge
  /// (class, enum, extension, function, variable, getter, or setter).
  ///
  /// This is the public-barrel set the host-side `AstBundler` needs in order
  /// to *skip* bridged imports when compiling a script's source into an
  /// [AstBundle] (those libraries are handled natively at runtime, not
  /// bundled). The runner already records the library URI as the map key on
  /// every registration, so this getter simply aggregates those keys — no
  /// extra bookkeeping is required. Lives here (zero-dependency core) so the
  /// host parser can be any analyzer front-end without coupling the runtime
  /// to it.
  Set<String> get bridgedLibraryUris {
    final uris = <String>{};
    void addKeys<V>(List<Map<String, V>> registries) {
      for (final entry in registries) {
        uris.addAll(entry.keys);
      }
    }

    addKeys(_bridgedClasses);
    addKeys(_bridgedEnumDefinitions);
    addKeys(_bridgedExtensions);
    addKeys(_libraryFunctions);
    addKeys(_libraryVariables);
    addKeys(_libraryGetters);
    addKeys(_librarySetters);
    return uris;
  }

  // =========================================================================
  // Bridge Registration
  // =========================================================================

  /// Registers a bridged enum definition.
  void registerBridgedEnum(
    BridgedEnumDefinition definition,
    String library, {
    String? sourceUri,
  }) {
    final libEnum = LibraryEnum(definition, sourceUri: sourceUri);
    _bridgedEnumDefinitions.add({library: libEnum});
  }

  /// Registers a bridged class definition.
  void registerBridgedClass(
    BridgedClass definition,
    String library, {
    String? sourceUri,
  }) {
    final libClass = LibraryClass(definition, sourceUri: sourceUri);
    _bridgedClasses.add({library: libClass});
    _bridgedDefLookupByType[definition.nativeType] = definition;
  }

  /// GEN-074: Registers a class alias (type alias).
  ///
  /// Type aliases like `typedef MaterialStateProperty<T> = WidgetStateProperty<T>`
  /// are registered so that D4rt scripts can use the alias name.
  ///
  /// [aliasName] The alias name (e.g., 'MaterialStateProperty').
  /// [targetName] The target class name (e.g., 'WidgetStateProperty').
  /// [library] The library path where this alias is exported from.
  void registerClassAlias(String aliasName, String targetName, String library) {
    _classAliases.add((
      aliasName: aliasName,
      targetName: targetName,
      library: library,
    ));
  }

  /// Registered class aliases keyed by library URI.
  List<({String aliasName, String targetName, String library})>
  get classAliases => _classAliases;

  /// Registers a function typedef so it can be resolved as a type.
  ///
  /// Function typedefs like `typedef VoidCallback = void Function()` are not
  /// classes, but D4rt scripts may reference them as type arguments
  /// (e.g., `ObserverList<VoidCallback>()`). This registers the name
  /// as a `BridgedClass` with `nativeType: Function` so type resolution
  /// succeeds.
  ///
  /// [name] The typedef name (e.g., 'VoidCallback').
  /// [library] The library path where this typedef is exported from.
  void registerFunctionTypedef(String name, String library) {
    _functionTypedefs.add((name: name, library: library));
  }

  /// Registered function typedefs.
  List<({String name, String library})> get functionTypedefs =>
      _functionTypedefs;

  /// GEN-107: Registered library re-exports keyed by source library URI.
  ///
  /// Each entry maps a source library URI to the list of libraries it
  /// re-exports. The module loader merges each re-exported library's
  /// symbols into the source library's per-module environment.
  Map<String, List<({String uri, Set<String>? show, Set<String>? hide})>>
      get libraryReExports => _libraryReExports;

  /// GEN-107: Registers a re-export from one library to another.
  ///
  /// This mirrors Dart's `export 'other/library.dart' [show/hide …]`
  /// directive: when [sourceUri] is loaded, the module loader will also
  /// merge the symbols from [targetUri] into the source library's
  /// per-module environment, applying [show] and [hide] filters.
  ///
  /// Generated bridge code calls this once per `export` directive in the
  /// underlying Dart library so re-exports of stdlib types
  /// (e.g. `flutter/services.dart` re-exports `dart:typed_data`) become
  /// reachable through the source library without leaking into the
  /// global environment.
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
    _libraryReExports.putIfAbsent(sourceUri, () => []).add((
      uri: targetUri,
      show: show,
      hide: hide,
    ));
  }

  /// Registers a bridged extension.
  void registerBridgedExtension(
    BridgedExtensionDefinition definition,
    String library, {
    String? sourceUri,
  }) {
    final libExt = LibraryExtension(definition, sourceUri: sourceUri);
    _bridgedExtensions.add({library: libExt});
  }

  /// Registers a top-level native function.
  void registerTopLevelFunction(
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
    _libraryFunctions.add({library: libFunc});
  }

  /// Lower-case alias for [registerTopLevelFunction].
  ///
  /// The D4rt bridge generator emits `interpreter.registertopLevelFunction(...)`
  /// (note the lower-case `t`). The analyzer-based `D4rt` front-ends in
  /// `tom_d4rt` and `tom_d4rt_exec` carry the same alias so generated bridge
  /// files compile against them. This alias lets the generated Flutter bridges
  /// target `D4rtRunner` directly (via `package:tom_d4rt_ast/d4rt.dart`),
  /// keeping `tom_d4rt_ast` free of any dependency on `tom_d4rt_exec`.
  void registertopLevelFunction(
    String? name,
    NativeFunctionImpl function,
    String library, {
    String? sourceUri,
    String? signature,
  }) =>
      registerTopLevelFunction(
        name,
        function,
        library,
        sourceUri: sourceUri,
        signature: signature,
      );

  /// Registers a global variable.
  void registerGlobalVariable(
    String name,
    Object? value,
    String library, {
    String? sourceUri,
  }) {
    _libraryVariables.add({
      library: LibraryVariable(name, value, sourceUri: sourceUri),
    });
  }

  /// Registers a global getter.
  void registerGlobalGetter(
    String name,
    Object? Function() getter,
    String library, {
    String? sourceUri,
  }) {
    _libraryGetters.add({
      library: LibraryGetter(name, getter, sourceUri: sourceUri),
    });
  }

  /// Registers a global setter.
  void registerGlobalSetter(
    String name,
    void Function(Object?) setter,
    String library, {
    String? sourceUri,
  }) {
    _librarySetters.add({
      library: LibrarySetter(name, setter, sourceUri: sourceUri),
    });
  }

  // =========================================================================
  // Permissions
  // =========================================================================

  /// Enables or disables debug logging.
  void setDebug(bool enabled) => Logger.setDebug(enabled);

  /// Grants a permission.
  void grant(Permission permission) {
    _grantedPermissions.add(permission);
    Logger.debug(
      "[D4rtRunner.grant] Granted permission: ${permission.description}",
    );
  }

  /// Revokes a permission.
  void revoke(Permission permission) {
    _grantedPermissions.remove(permission);
    Logger.debug(
      "[D4rtRunner.revoke] Revoked permission: ${permission.description}",
    );
  }

  /// Checks if a specific permission is granted.
  bool hasPermission(Permission permission) {
    return _grantedPermissions.contains(permission);
  }

  /// Checks if any permission allows the given operation.
  bool checkPermission(dynamic operation) {
    for (final permission in _grantedPermissions) {
      if (permission.allows(operation)) {
        return true;
      }
    }
    return false;
  }

  // =========================================================================
  // Step 6 — Extension hook
  // =========================================================================

  /// Registers a [body] callback that wires additional bridge state
  /// (e.g. `registerRelaxers()`, `registerD4rtRuntimeExtensions()`,
  /// `registerD4rtInterfaceProxyOverrides()`) **after** the main
  /// `registerBridgedClass`/`registerBridgedEnum`/etc. registrations
  /// for [packageName] have happened.
  ///
  /// The body is *not* run immediately — the runner queues it and runs
  /// every queued body in registration order when [finalizeBridges] is
  /// called (or implicitly on the first `execute*`/`executeBundle*` call
  /// that follows). This replaces the comment-driven "must run AFTER
  /// bridges" rule (formerly enforced by code ordering inside
  /// `FlutterD4rt._registerBridges`) with an enforced mechanism: bridge
  /// packages declare their wiring up front, and the runner controls
  /// when it runs.
  ///
  /// **Idempotent on package name:** a second call with the same
  /// [packageName] overwrites the previous body — the contract is one
  /// extension callback per bridge package. The body itself must
  /// internally tolerate being run more than once if the embedder
  /// constructs multiple [D4rtRunner] instances in the same process,
  /// since the D4 / BridgedClass registries it touches are static.
  /// (Step 5 made all the per-key D4 registries idempotent on factory
  /// identity, so this contract is satisfied for the standard
  /// `register*` calls.)
  ///
  /// Throws [StateError] if [finalizeBridges] has already run on this
  /// runner — adding extensions after finalization is a misuse.
  void registerExtensions(String packageName, void Function() body) {
    if (_bridgesFinalized) {
      throw StateError(
        'Cannot registerExtensions("$packageName"): finalizeBridges() has '
        'already been called on this D4rtRunner. Register all extensions '
        'before the first execute*/executeBundle* call (or call '
        'finalizeBridges() explicitly after the last registerExtensions).',
      );
    }
    _extensionCallbacks[packageName] = body;
  }

  /// Runs every extension callback registered via [registerExtensions]
  /// in registration order, then marks the runner as finalized.
  ///
  /// `execute*`/`executeBundle*` invoke this implicitly on first run if
  /// it has not been called already, so embedders don't have to
  /// remember to call it. Calling it explicitly first is supported and
  /// preferred when an embedder needs deterministic timing (e.g. a
  /// constructor of a Flutter helper that touches bridges before the
  /// first script runs).
  ///
  /// **Idempotent:** repeat calls return without re-running any
  /// callback — the contract is "run once, then frozen". After this
  /// call returns, [registerExtensions] throws [StateError].
  void finalizeBridges() {
    if (_bridgesFinalized) return;
    _bridgesFinalized = true;
    for (final entry in _extensionCallbacks.entries) {
      Logger.debug(
        '[D4rtRunner.finalizeBridges] Running extensions for "${entry.key}"',
      );
      entry.value();
    }
  }

  /// OPEN B.11 / U25 — Pre-builds the bridge + stdlib infrastructure so the
  /// first real [execute]/[executeBundle] call does not cold-start mid-test.
  ///
  /// ## Why this exists
  ///
  /// The first script run after a test harness' `setUpAll` historically
  /// flaked under host load because the interpreter infrastructure
  /// (extension finalization, the ~30 stdlib bridges, and the registered
  /// bridged-class/enum definitions) cold-started during that first build.
  /// The shipped reset API ([resetScriptDeclarations]) does not warm
  /// anything — it only evicts script declarations. This method pays that
  /// cold-start cost *up front*, before the first real build, so the first
  /// build behaves like a warm one.
  ///
  /// ## What it warms
  ///
  /// 1. [finalizeBridges] — fires every queued extension callback
  ///    (relaxers, interface proxies, generic constructors) and freezes the
  ///    runner. After this the bridge surface is fully wired.
  /// 2. A throwaway global [Environment] built via [_initEnvironment], which
  ///    exercises the full `Stdlib(...).register()` + bridged-definition
  ///    registration path that every build would otherwise pay on first run.
  ///
  /// The runner has no Dart source parser (that lives in `tom_d4rt_exec`'s
  /// `D4rt`, which warms the analyzer front-end in its own `warmup`), so
  /// this warms only the bridge/stdlib half — which is the portion the
  /// parser-less Flutter runtime (and the test app's `/warmup` endpoint)
  /// shares.
  ///
  /// **Idempotent and script-neutral:** the warmup environment is discarded;
  /// it leaves no script declarations behind. The next real
  /// [execute]/[executeBundle] rebuilds a fresh environment as usual.
  void warmup() {
    finalizeBridges();
    // Build (and discard) an environment to pay the stdlib + bridged
    // definition registration cost before the first real build. The next
    // execute*/executeBundle* call constructs its own fresh environment.
    _initEnvironment();
    Logger.debug(
      '[D4rtRunner.warmup] Warmed bridge + stdlib infrastructure '
      '(${_globalEnvironment?.values.length ?? 0} baseline entries).',
    );
  }

  // =========================================================================
  // P&R#3 — Public user-registration API
  //
  // Thin facade delegates onto the static [D4] sinks, exposed so embedders
  // and bridge packages can register relaxers, interface proxies, and generic
  // constructors for their own (user-project) types without touching the
  // generator. Intended to be called from inside a [registerExtensions] body
  // so the registration runs once at finalize time, in package order, after
  // the standard bridges are wired up. They may also be called directly
  // before the first execute*/executeBundle* call.
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

  // =========================================================================
  // JSON Parsing
  // =========================================================================

  /// Parses an AST from a JSON string.
  ///
  /// The JSON should be in the format produced by tom_ast_generator's
  /// AstConverter.toJson() method.
  SCompilationUnit parseJson(String jsonString) {
    final json = jsonDecode(jsonString);
    if (json is! Map<String, dynamic>) {
      throw ArgumentD4rtException('Invalid AST JSON: expected object');
    }
    return SCompilationUnit.fromJson(json);
  }

  /// Parses an AST from a JSON file.
  ///
  /// Supports both plain .json and gzipped .json.gz files.
  Future<SCompilationUnit> parseJsonFile(String path) async {
    final file = File(path);
    if (!file.existsSync()) {
      throw ArgumentD4rtException('AST file not found: $path');
    }

    List<int> bytes = await file.readAsBytes();

    // Decompress if gzipped
    if (path.endsWith('.gz')) {
      bytes = gzip.decode(bytes);
    }

    final jsonString = utf8.decode(bytes);
    return parseJson(jsonString);
  }

  // =========================================================================
  // Execution
  // =========================================================================

  /// Initializes the execution environment.
  Environment _initEnvironment() {
    final globalEnv = Environment();
    _globalEnvironment = globalEnv;

    // Register standard library
    Stdlib(globalEnv).register();

    // Register bridged definitions into global environment.
    // This pre-populates all bridges for type-based resolution (toBridgedInstance)
    // and provides a baseline for name resolution. Import directives will later
    // overwrite specific entries when libraries are explicitly imported.
    _registerBridgedDefinitions(globalEnv);

    // §U28 / TODO #14 — capture the post-registration baseline of
    // `_values` keys so [resetScriptDeclarations] can later distinguish
    // bridge / stdlib entries from script-declared ones added during
    // pass 1 (DeclarationVisitor) and pass 2 (import processing).
    _baselineValueKeys = globalEnv.values.keys.toSet();

    return globalEnv;
  }

  /// §U28 / TODO #14 — Evict script-declared entries from the current
  /// global environment so a follower `executeBundle` call starts with
  /// the same name-set the first build saw.
  ///
  /// Walks [_globalEnvironment].`values` and removes any key not present
  /// in [_baselineValueKeys] (the snapshot captured at the end of the
  /// last [_initEnvironment]). Bridge registrations (`_bridgedClasses`,
  /// `_bridgedClassesLookupByType`, `_bridgedEnums`) are NOT touched.
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
  /// [executeBundle] and [execute] already call [_initEnvironment] on
  /// every invocation, which constructs a brand-new [Environment]. The
  /// previous environment is dropped on the floor by the next build,
  /// so script declarations do NOT accumulate across `/build` cycles
  /// in `_values`. The `_values` eviction below is therefore a
  /// forward-compatibility hook (frees GC roots earlier; survives any
  /// future change to the per-call fresh-environment invariant). The
  /// native-accumulator clear, by contrast, addresses real cross-build
  /// state — see OPEN B.12.
  ///
  /// No-op on the `_values` half if no execution has happened yet (no
  /// global environment to walk) or if no baseline was captured; the
  /// native-accumulator clear runs unconditionally.
  void resetScriptDeclarations() {
    // Cross-build native state (OPEN B.12): clear unconditionally — it is
    // process-global and not tied to this runner's environment lifecycle.
    D4.resetNativeAccumulators();

    final env = _globalEnvironment;
    final baseline = _baselineValueKeys;
    if (env == null || baseline == null) return;
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
      "[D4rtRunner.resetScriptDeclarations] Removed ${toRemove.length} "
      "script-declared entries; ${env.values.length} bridge/stdlib "
      "entries preserved; native accumulator cleared.",
    );
  }

  /// Registers all bridged definitions into the environment.
  void _registerBridgedDefinitions(Environment env) {
    // Register bridged enums
    for (final entry in _bridgedEnumDefinitions) {
      for (final e in entry.entries) {
        final bridgedEnum = e.value.enumDefinition.buildBridgedEnum();
        env.defineBridgedEnum(bridgedEnum);
      }
    }

    // Register bridged classes
    for (final entry in _bridgedClasses) {
      for (final e in entry.entries) {
        env.defineBridge(e.value.bridgedClass);
      }
    }

    // Register function typedefs as BridgedClass(nativeType: Function)
    // so they can be resolved in type annotations and type arguments.
    for (final typedef in _functionTypedefs) {
      env.defineBridge(
        BridgedClass(nativeType: Function, name: typedef.name),
      );
    }

    // Register library functions
    for (final entry in _libraryFunctions) {
      for (final e in entry.entries) {
        final name = e.value.function.name;
        // Skip default "<native>" names - only define named functions
        if (name != '<native>') {
          env.define(name, e.value.function);
        }
      }
    }

    // Register library variables
    for (final entry in _libraryVariables) {
      for (final e in entry.entries) {
        env.define(e.value.name, e.value.value);
      }
    }

    // Register library getters (with optional setters)
    // Match getter and setter by name
    final setterMap = <String, LibrarySetter>{};
    for (final entry in _librarySetters) {
      for (final e in entry.entries) {
        setterMap[e.value.name] = e.value;
      }
    }

    for (final entry in _libraryGetters) {
      for (final e in entry.entries) {
        final getter = e.value;
        final setter = setterMap[getter.name];
        env.define(
          getter.name,
          GlobalGetter(getter.getter, setter: setter?.setter),
        );
      }
    }

    // Register any remaining setters without corresponding getters
    // (These would be write-only properties, which is unusual but supported)
    final registeredGetterNames = <String>{};
    for (final entry in _libraryGetters) {
      for (final e in entry.entries) {
        registeredGetterNames.add(e.value.name);
      }
    }
    for (final entry in _librarySetters) {
      for (final e in entry.entries) {
        if (!registeredGetterNames.contains(e.value.name)) {
          // Write-only property - use a GlobalGetter with null getter
          env.define(
            e.value.name,
            GlobalGetter(
              () => throw RuntimeD4rtException(
                'Property ${e.value.name} is write-only',
              ),
              setter: e.value.setter,
            ),
          );
        }
      }
    }
  }

  /// Execute an AST.
  ///
  /// [ast] The parsed SCompilationUnit to execute.
  /// [name] The function to call (default: 'main').
  /// [positionalArgs] Positional arguments to pass to the function.
  /// [namedArgs] Named arguments to pass to the function.
  ///
  /// Returns the result of the function call.
  dynamic execute({
    required SCompilationUnit ast,
    String name = 'main',
    List<Object?>? positionalArgs,
    Map<String, Object?>? namedArgs,
  }) {
    // Initialize fresh environment
    InterpretedFunction.clearParentMap();
    final executionEnvironment = _initEnvironment();

    // Create module context with permission checking
    final moduleContext = NoOpModuleContext(
      globalEnvironment: executionEnvironment,
      permissionChecker: checkPermission,
    );

    // Execute
    return _executeInEnvironment(
      compilationUnit: ast,
      executionEnvironment: executionEnvironment,
      moduleContext: moduleContext,
      name: name,
      positionalArgs: positionalArgs,
      namedArgs: namedArgs,
    );
  }

  /// Execute from a JSON string.
  ///
  /// Convenience method that parses JSON and executes.
  dynamic executeFromJson({
    required String jsonString,
    String name = 'main',
    List<Object?>? positionalArgs,
    Map<String, Object?>? namedArgs,
  }) {
    final ast = parseJson(jsonString);
    return execute(
      ast: ast,
      name: name,
      positionalArgs: positionalArgs,
      namedArgs: namedArgs,
    );
  }

  /// Execute from a JSON file.
  ///
  /// Convenience method that loads and parses a JSON file and executes.
  /// Supports both plain .json and gzipped .json.gz files.
  Future<dynamic> executeFromJsonFile({
    required String path,
    String name = 'main',
    List<Object?>? positionalArgs,
    Map<String, Object?>? namedArgs,
  }) async {
    final ast = await parseJsonFile(path);
    return execute(
      ast: ast,
      name: name,
      positionalArgs: positionalArgs,
      namedArgs: namedArgs,
    );
  }

  /// Execute an [AstBundle] with full import resolution.
  ///
  /// Unlike [execute], this method supports cross-module imports by creating
  /// an [AstModuleLoader] that resolves imports from the bundle's module map.
  ///
  /// The entry point module is determined by:
  /// 1. The [entryPoint] parameter (if provided)
  /// 2. The bundle's [AstBundle.entryPointUri]
  ///
  /// ## Example
  /// ```dart
  /// final runner = D4rtRunner();
  /// // register bridges...
  /// final bundle = AstBundle.fromFile('app.d4rtbundle');
  /// final result = runner.executeBundle(bundle);
  /// ```
  dynamic executeBundle(
    AstBundle bundle, {
    String? entryPoint,
    String name = 'main',
    List<Object?>? positionalArgs,
    Map<String, Object?>? namedArgs,
  }) {
    // Determine entry point URI
    final entryUri = entryPoint ?? bundle.entryPointUri;
    final entryAst = bundle.modules[entryUri];
    if (entryAst == null) {
      throw ArgumentD4rtException(
        'Entry point "$entryUri" not found in bundle. '
        'Available: ${bundle.modules.keys.join(", ")}',
      );
    }

    // Initialize environment
    InterpretedFunction.clearParentMap();
    final executionEnvironment = _initEnvironment();

    // Create AstModuleLoader for import resolution
    final moduleLoader = AstModuleLoader(
      modules: bundle.modules,
      globalEnvironment: executionEnvironment,
      runner: this,
    );
    moduleLoader.currentLibrary = Uri.parse(entryUri);

    Logger.debug(
      '[D4rtRunner.executeBundle] Entry point: $entryUri '
      '(${bundle.modules.length} modules in bundle)',
    );

    // Execute with full module context
    return _executeInEnvironment(
      compilationUnit: entryAst,
      executionEnvironment: executionEnvironment,
      moduleContext: moduleLoader,
      name: name,
      positionalArgs: positionalArgs,
      namedArgs: namedArgs,
    );
  }

  /// Execute [bundle] and unwrap the result to type [T] via [D4.unwrapAs].
  ///
  /// This is the typed entry point that consolidates the unwrap path —
  /// callers don't need to know about [BridgedInstance], [BridgedEnumValue],
  /// or [InterpretedInstance]; they get a plain [T] back (or a
  /// [D4UnwrapException] if the result can't be coerced).
  ///
  /// For results that may be a [Future] (i.e. from `async` entry points),
  /// use [executeBundleAsAsync] instead.
  ///
  /// Step 2 of `tom_d4rt_flutterm/doc/d4rt_consolidation_plan.md`.
  T executeBundleAs<T>(
    AstBundle bundle, {
    String? entryPoint,
    String name = 'main',
    List<Object?>? positionalArgs,
    Map<String, Object?>? namedArgs,
  }) {
    final raw = executeBundle(
      bundle,
      entryPoint: entryPoint,
      name: name,
      positionalArgs: positionalArgs,
      namedArgs: namedArgs,
    );
    return D4.unwrapAs<T>(raw, visitor: _visitor);
  }

  /// Async variant of [executeBundleAs] — awaits the result if it is a
  /// [Future] before unwrapping to [T].
  ///
  /// Use this when the bundle's entry point is `async` (or otherwise
  /// returns a Future). When the bundle is synchronous the awaited
  /// value is the raw return — both paths converge on
  /// [D4.unwrapAs] for the cast.
  Future<T> executeBundleAsAsync<T>(
    AstBundle bundle, {
    String? entryPoint,
    String name = 'main',
    List<Object?>? positionalArgs,
    Map<String, Object?>? namedArgs,
  }) async {
    final raw = executeBundle(
      bundle,
      entryPoint: entryPoint,
      name: name,
      positionalArgs: positionalArgs,
      namedArgs: namedArgs,
    );
    final resolved = raw is Future ? await raw : raw;
    return D4.unwrapAs<T>(resolved, visitor: _visitor);
  }

  /// Evaluate an expression in the current context.
  ///
  /// Requires a previous call to [execute] to establish the context.
  /// This is useful for REPL-style execution.
  dynamic eval(String expression) {
    if (!_hasExecutedOnce || _visitor == null || _globalEnvironment == null) {
      throw RuntimeD4rtException(
        'eval() requires an established execution context. Call execute() first.',
      );
    }

    // The expression needs to be parsed - but we don't have a parser here
    // This would need a parseSourceCallback or work with pre-parsed expressions
    throw UnsupportedError(
      'eval() is not supported in D4rtRunner. '
      'Use D4rt from tom_d4rt_exec for source code evaluation.',
    );
  }

  /// Execute in the given environment.
  dynamic _executeInEnvironment({
    required SCompilationUnit compilationUnit,
    required Environment executionEnvironment,
    required ModuleContext moduleContext,
    required String name,
    List<Object?>? positionalArgs,
    Map<String, Object?>? namedArgs,
  }) {
    // Step 6: implicit finalize on first execution. Any callbacks
    // registered via [registerExtensions] run here in registration
    // order before pass 1, so bridges are fully wired before the
    // declaration visitor sees a single line of script. No-op if the
    // embedder already called [finalizeBridges] explicitly.
    finalizeBridges();
    Logger.debug("[_executeInEnvironment] Starting Pass 1: Declaration");
    final declarationVisitor = DeclarationVisitor(executionEnvironment);
    for (final declaration in compilationUnit.declarations) {
      declaration.accept<void>(declarationVisitor);
    }
    Logger.debug("[_executeInEnvironment] Finished Pass 1: Declaration");

    _visitor = InterpreterVisitor(
      globalEnvironment: executionEnvironment,
      moduleContext: moduleContext,
    );

    // S1 (perf plan_3 §9.1): populate the static-resolution side-table before
    // Pass 2 so the validation assert in visitSimpleIdentifier can cross-check
    // every resolved coordinate against the live environment depth.
    _visitor!.resolveStaticCoordinates(compilationUnit.declarations);

    Object? functionResult;
    try {
      Logger.debug("[_executeInEnvironment] Starting Pass 2: Interpretation");

      // Process import directives through the module context
      for (final directive in compilationUnit.directives) {
        if (directive is SImportDirective) {
          if (moduleContext is NoOpModuleContext) {
            Logger.warn(
              "[_executeInEnvironment] Import directive found but "
              "this execution context doesn't support imports. "
              "Use executeBundle() or D4rt from tom_d4rt_exec.",
            );
          } else {
            directive.accept<Object?>(_visitor!);
          }
        }
      }

      Logger.debug("[_executeInEnvironment] Processing declarations");
      // RC-4: Process declarations in dependency order (matching AstModuleLoader).
      // The DeclarationVisitor (pass 1) only creates class/mixin placeholders
      // with empty constructor maps. We must populate class members before
      // evaluating top-level variable initializers that may reference them
      // (forward-reference problem: const lists using classes defined later).
      for (final declaration in compilationUnit.declarations) {
        if (declaration is SEnumDeclaration) {
          declaration.accept<Object?>(_visitor!);
        }
      }
      // Bug-43 / forward-class-reference FIX: a `static const` initializer
      // can reference another class defined later in source order (e.g.
      //   class _ComparisonTable {
      //     static const _rows = [_CompareRow(...), ...];
      //   }
      //   class _CompareRow { const _CompareRow({required this.x}); }
      // ). Previously the interpreter processed class bodies sequentially,
      // evaluating static field initializers inline, so by the time
      // _ComparisonTable's static initializers ran _CompareRow's
      // constructors had not been registered yet and the call failed
      // with "does not have an unnamed constructor that accepts arguments".
      //
      // We now defer every class's static-field initializer block until
      // ALL class/mixin declarations have been visited, then drain the
      // queue. Members (constructors/methods/fields) are still registered
      // during the main class-pass, so forward-referenced constructors are
      // available when the deferred initializers finally run.
      _visitor!.deferStaticFieldInits = true;
      try {
        for (final declaration in compilationUnit.declarations) {
          if (declaration is SClassDeclaration ||
              declaration is SMixinDeclaration) {
            declaration.accept<Object?>(_visitor!);
          }
        }
      } finally {
        _visitor!.deferStaticFieldInits = false;
      }
      _visitor!.runDeferredStaticInitializers();
      for (final declaration in compilationUnit.declarations) {
        if (declaration is SFunctionDeclaration) {
          declaration.accept<Object?>(_visitor!);
        }
      }
      for (final declaration in compilationUnit.declarations) {
        if (declaration is SExtensionDeclaration) {
          declaration.accept<Object?>(_visitor!);
        }
      }
      // Cluster EXTTYPE: Extension type declarations (Dart 3.3+). Without
      // this pass the wrapper class is never registered and `main()`
      // cannot resolve the constructor.
      for (final declaration in compilationUnit.declarations) {
        if (declaration is SExtensionTypeDeclaration) {
          declaration.accept<Object?>(_visitor!);
        }
      }
      for (final declaration in compilationUnit.declarations) {
        if (declaration is STopLevelVariableDeclaration) {
          declaration.accept<Object?>(_visitor!);
        }
      }
      Logger.debug("[_executeInEnvironment] Finished processing declarations");

      Logger.debug("[_executeInEnvironment] Looking for $name function");
      final functionCallable = executionEnvironment.get(name);
      if (functionCallable is Callable) {
        List<Object?> interpreterArgs = positionalArgs ?? [];
        final Map<String, Object?> interpreterNamedArgs = namedArgs ?? {};

        // Special handling for 'main' function
        final expectedArity = functionCallable.arity;
        if (name == 'main' &&
            expectedArity > 0 &&
            interpreterArgs.isEmpty &&
            namedArgs?.isEmpty != false) {
          interpreterArgs = [<String>[]];
          Logger.debug(
            "[_executeInEnvironment] 'main' expects arguments but none provided. Passing empty list.",
          );
        }

        // Validate arity
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
          "No callable '$name' function found in the AST.",
        );
      }
      Logger.debug("[_executeInEnvironment] Finished Pass 2: Interpretation");
    } on InternalInterpreterD4rtException catch (e) {
      if (e.originalThrownValue is RuntimeD4rtException) {
        throw e.originalThrownValue as RuntimeD4rtException;
      } else {
        throw e.originalThrownValue!;
      }
    }

    _hasExecutedOnce = true;
    // Step 4 (recursive sync) of `tom_d4rt_flutterm/doc/d4rt_consolidation_plan.md`:
    // mirror the recursive interpreter→native unwrap that
    // `tom_d4rt/lib/src/d4rt_base.dart` already performs at the equivalent
    // entry point. tom_d4rt_ast was forked from tom_d4rt and the recursion
    // (List/Map/InterpretedRecord with native-record creation up to 16
    // positional fields) was missed during the port. Without this, callers
    // of [executeBundle] received raw `BridgedInstance` / `InterpretedRecord`
    // values inside lists/maps/records, and `executeBundleAs<T>` could not
    // unwrap them because [D4.unwrapAs] is intentionally single-level. Doing
    // the recursion here propagates fully native values to both the untyped
    // [executeBundle] and the typed [executeBundleAs] / [executeBundleAsAsync]
    // entry points.
    if (functionResult is Future) {
      return functionResult.then(_bridgeInterpreterValueToNative);
    }
    return _bridgeInterpreterValueToNative(functionResult);
  }

  /// Recursively convert interpreter-side values into their native Dart
  /// equivalents at the script→host boundary.
  ///
  /// Mirrors `_bridgeInterpreterValueToNative` in
  /// `tom_d4rt/lib/src/d4rt_base.dart` (line ~1938). Same body, same record
  /// arity ladder (0..16 positional). Leaf-level
  /// [BridgedInstance]/[BridgedEnumValue] cases delegate to [D4.unwrapAs] —
  /// matching the leaf-level twins in this package's [InterpreterVisitor]
  /// and in `tom_d4rt`'s `_bridgeInterpreterValueToNative` (Step 4 of the
  /// consolidation plan).
  ///
  /// The recursion is intentionally outside [D4.unwrapAs]: that helper's
  /// contract is single-level (the `unwrapInterpreterValue` docstring
  /// explicitly notes that recursing through Lists/Maps would destroy
  /// reified generics). The top-level script-return unwrap is a separate
  /// concern — flat callers want native records and unwrapped collection
  /// elements.
  Object? _bridgeInterpreterValueToNative(Object? interpreterValue) {
    if (interpreterValue == null ||
        interpreterValue is String ||
        interpreterValue is num ||
        interpreterValue is bool) {
      return interpreterValue;
    }
    if (interpreterValue is BridgedInstance ||
        interpreterValue is BridgedEnumValue) {
      return D4.unwrapAs<Object?>(interpreterValue, visitor: _visitor);
    }
    if (interpreterValue is List) {
      return interpreterValue.map(_bridgeInterpreterValueToNative).toList();
    }
    if (interpreterValue is Map) {
      return interpreterValue.map((key, value) => MapEntry(
          _bridgeInterpreterValueToNative(key),
          _bridgeInterpreterValueToNative(value)));
    }
    // Convert InterpretedRecord to native Dart records when possible.
    // For positional-only records up to 16 elements, we can create native
    // records. For records with named fields or more than 16 positional
    // fields, we return InterpretedRecord with unwrapped field values.
    if (interpreterValue is InterpretedRecord) {
      final pos = interpreterValue.positionalFields
          .map(_bridgeInterpreterValueToNative)
          .toList();
      final named = interpreterValue.namedFields;

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
              pos[7]
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
              pos[8]
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
              pos[9]
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
              pos[10]
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
              pos[11]
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
              pos[12]
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
              pos[13]
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
              pos[14]
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
              pos[15]
            );
          default:
            // More than 16 positional fields — return InterpretedRecord with
            // unwrapped values.
            return InterpretedRecord(pos, {});
        }
      }

      // Has named fields — can't convert to native record, return with
      // unwrapped values.
      return InterpretedRecord(
        pos,
        named.map((key, value) =>
            MapEntry(key, _bridgeInterpreterValueToNative(value))),
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
}
