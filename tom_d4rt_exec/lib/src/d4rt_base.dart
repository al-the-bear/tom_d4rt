import 'dart:async';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/error/error.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:tom_d4rt_ast/runtime.dart';
import 'package:tom_ast_generator/tom_ast_generator.dart';
import 'package:tom_d4rt_exec/src/module_loader.dart';

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
  final List<Map<String, LibraryEnum>> _bridgedEnumDefinitions = [];
  final List<Map<String, LibraryClass>> _bridgedClases = [];
  final List<Map<String, LibraryExtension>> _bridgedExtensions = [];

  InterpretedInstance? _interpretedInstance;
  InterpreterVisitor? _visitor;
  // Step #17 — thunk-backed native-type lookup (see LazyBridgeRegistry). The
  // exact-type `operator[]` path builds at most one class on demand; the
  // isAssignable supertype fallback (rare) still iterates `.entries`.
  final LazyBridgeRegistry<Type> _bridgedDefLookupByType = LazyBridgeRegistry();
  final Set<Permission> _grantedPermissions = {};

  /// Internal AST converter for parsing source code.
  final AstConverter _converter = AstConverter();

  /// Internal [D4rtRunner] for bundle-based execution.
  ///
  /// All bridge registrations and permissions are forwarded to this runner
  /// so that [executeBundle] works correctly without re-registration.
  final D4rtRunner _runner;

  /// Tracks all library URIs that have bridged registrations.
  ///
  /// Updated on each bridge registration call. Used by [createBundle] and
  /// [createBundleFromSource] to tell the [AstBundler] which imports should
  /// be skipped (handled natively at runtime).
  final Set<String> _bridgedLibraryUris = {};

  /// Gets the current interpreter visitor instance.
  ///
  /// Returns null if no execution has ever been run. The classic
  /// `execute()` path stores its visitor in `_visitor`; the
  /// `executeBundle()` path delegates to the inner [D4rtRunner] which
  /// keeps the visitor on itself. Fall back to the runner's visitor so
  /// embedders that need to finish unwrapping an InterpretedInstance
  /// after `executeBundle` returns (see `FlutterD4rt._unwrap<Widget>`)
  /// can still resolve an interface-proxy factory.
  InterpreterVisitor? get visitor => _visitor ?? _runner.visitor;

  /// The set of library URIs that have been registered as bridged.
  ///
  /// These URIs are skipped by [AstBundler] during import resolution
  /// because they are handled by native bridges at runtime.
  Set<String> get bridgedLibraryUris => Set.unmodifiable(_bridgedLibraryUris);

  // Library-scoped globals (registered with library path) - added when import is processed
  // Structure matches classes/enums: List of {libraryPath: definition}
  // For functions: use LibraryFunction wrapper that includes sourceUri for deduplication
  // For variables/getters: wrapper classes contain name, value/getter, and sourceUri
  final List<Map<String, LibraryFunction>> _libraryFunctions = [];
  final List<Map<String, LibraryVariable>> _libraryVariables = [];
  final List<Map<String, LibraryGetter>> _libraryGetters = [];
  final List<Map<String, LibrarySetter>> _librarySetters = [];

  late ModuleLoader _moduleLoader;
  bool _hasExecutedOnce = false;

  /// Creates a D4rt interpreter instance.
  /// sce43: mirrors the reference's constructor.
  ///
  /// [reuseAcrossRuns] controls the cross-run caches; it is forwarded to the
  /// inner [D4rtRunner], which owns them on this line. The reference declares
  /// the same parameter, so a consumer written against either gets the same
  /// behaviour rather than silently losing the flag on this one.
  D4rt({this.reuseAcrossRuns = true})
    : _runner = D4rtRunner(reuseAcrossRuns: reuseAcrossRuns);

  /// Whether the cross-run bridge caches are reused between runs.
  ///
  /// Mirrors `D4rt.reuseAcrossRuns` on the reference and
  /// [D4rtRunner.reuseAcrossRuns] here.
  final bool reuseAcrossRuns;

  /// Parses source code to an [SCompilationUnit] using the internal converter.
  ///
  /// A syntax error does not throw: the unit comes back with
  /// [SCompilationUnit.hasParseErrors] set, because the expression paths try
  /// several parses in turn and need to inspect a failed one to decide whether
  /// to fall through to the next. Callers with no next strategy — an entry
  /// script — must reject the unit themselves; [_parseExecutableSource] does.
  ///
  /// When [diagnosticsOut] is supplied it receives one formatted line per
  /// error-severity diagnostic, so a caller that does reject can say what was
  /// wrong and where.
  SCompilationUnit _parseSourceToAst(
    String sourceCode, {
    String? path,
    List<String>? diagnosticsOut,
  }) {
    final result = parseString(
      content: sourceCode,
      path: path,
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

    // Check for parse errors
    final errors = result.errors
        .where((e) => e.diagnosticCode.severity == DiagnosticSeverity.ERROR)
        .toList();
    final hasErrors = errors.isNotEmpty;
    if (hasErrors && diagnosticsOut != null) {
      for (final e in errors) {
        final location = result.lineInfo.getLocation(e.offset);
        diagnosticsOut.add(
          '- ${e.message} '
          '(line ${location.lineNumber}, column ${location.columnNumber})',
        );
      }
    }

    // Convert analyzer AST to serializable AST
    final cu = _converter.convertCompilationUnit(result.unit);

    if (hasErrors) {
      return SCompilationUnit(
        offset: cu.offset,
        length: cu.length,
        scriptTag: cu.scriptTag,
        directives: cu.directives,
        declarations: cu.declarations,
        comments: cu.comments,
        hasParseErrors: true,
      );
    }
    return cu;
  }

  /// Parses source that is about to be executed, rejecting source that does
  /// not parse.
  ///
  /// Code on its way to the interpreter — an entry script, or a library the
  /// module loader is resolving — has no fallback strategy the way an
  /// expression does: the declarations the parser salvaged from broken source
  /// are a fragment of something the author never wrote, and running them
  /// would report success for a script that never ran. So a syntax error is
  /// fatal here, and [path] names the compilation unit it was found in.
  SCompilationUnit _parseExecutableSource(String source, {String? path}) {
    final diagnostics = <String>[];
    final unit = _parseSourceToAst(
      source,
      path: path,
      diagnosticsOut: diagnostics,
    );
    if (unit.hasParseErrors) {
      final where = path ?? 'the direct source';
      final detail = diagnostics.join('\n');
      Logger.error('Parsing errors for $where:\n$detail');
      // SCE110/SCE111: one sentence per case, both matching the reference.
      // This method serves two callers — an entry script, where `path` is null,
      // and a module the loader is resolving, where it is the URI — and it used
      // the direct-source phrasing for both. "Fatal parsing errors for
      // package:m/bad.dart" reads oddly because `for the direct source` is the
      // subject that phrasing was written around. The reference says
      // "Parsing errors in module <uri>" from `module_loader.dart`, which is
      // the better sentence and is now the shared one.
      throw SourceCodeD4rtException(
        path == null
            ? 'Fatal parsing errors for $where:\n$detail'
            : 'Parsing errors in module $where:\n$detail',
        source,
      );
    }
    return unit;
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
    _bridgedEnumDefinitions.add({library: libEnum});
    _runner.registerBridgedEnum(definition, library, sourceUri: sourceUri);
    _bridgedLibraryUris.add(library);
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
    registerBridgedClassLazy(
      definition.name,
      definition.nativeType,
      () => definition,
      library,
      sourceUri: sourceUri,
    );
  }

  /// Step #17 — registers a bridged class via a deferred factory [thunk].
  ///
  /// Forwards the thunk to the inner [_runner] (the measured analyzer-free
  /// path) and stores it lazily in the wrapper's local registries so the
  /// [BridgedClass] is built only when first resolved by name or native type.
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
    _bridgedClases.add({library: libClass});
    _bridgedDefLookupByType.putThunk(nativeType, thunk);
    _runner.registerBridgedClassLazy(
      name,
      nativeType,
      thunk,
      library,
      sourceUri: sourceUri,
    );
    _bridgedLibraryUris.add(library);
  }

  /// GEN-074: Registers a class alias (type alias) for use in interpreted code.
  ///
  /// Type aliases like `typedef MaterialStateProperty<T> = WidgetStateProperty<T>`
  /// are registered so that D4rt scripts can use the alias name to reference
  /// the target class.
  ///
  /// [aliasName] The alias name (e.g., 'MaterialStateProperty').
  /// [targetName] The target class name (e.g., 'WidgetStateProperty').
  /// [library] The library path where this alias is exported from.
  void registerClassAlias(String aliasName, String targetName, String library) {
    // sce43: a pure forward. This wrapper used to keep a second list as well,
    // which nothing ever read — `registerFunctionTypedef` beside it already
    // forwarded only, and the [classAliases] getter below reads the runner.
    // A divergent second pool on the wrapper is what this file's own
    // `resetScriptDeclarations` comment warns against.
    _runner.registerClassAlias(aliasName, targetName, library);
  }

  /// Registers a function typedef so it can be used as a type in D4rt scripts.
  ///
  /// Function typedefs like `typedef VoidCallback = void Function()` are not
  /// classes, but D4rt scripts may reference them as type arguments
  /// (e.g., `ObserverList<VoidCallback>()`). This registers the name so type
  /// resolution succeeds.
  ///
  /// [name] The typedef name (e.g., 'VoidCallback').
  /// [library] The library path where this typedef is exported from.
  void registerFunctionTypedef(String name, String library) {
    _runner.registerFunctionTypedef(name, library);
  }

  /// GEN-107: Registered library re-exports keyed by source library URI.
  ///
  /// Each entry maps a source library URI to the list of libraries it
  /// re-exports. Delegates to the inner [D4rtRunner].
  Map<String, List<({String uri, Set<String>? show, Set<String>? hide})>>
  get libraryReExports => _runner.libraryReExports;

  /// GEN-107: Registers a re-export from one library to another.
  ///
  /// Mirrors Dart's `export 'other/library.dart' [show/hide …]` directive:
  /// when [sourceUri] is loaded, the module loader will also merge the
  /// symbols from [targetUri] into the source library's per-module
  /// environment, applying [show] and [hide] filters.
  ///
  /// Generated bridge code calls this once per `export` directive in the
  /// underlying Dart library so re-exports of stdlib types
  /// (e.g. `flutter/services.dart` re-exports `dart:typed_data`) become
  /// reachable through the source library without leaking into the global
  /// environment.
  ///
  /// [sourceUri] The library doing the re-exporting.
  /// [targetUri] The library being re-exported.
  /// [show] Optional set of names to include from [targetUri].
  /// [hide] Optional set of names to exclude from [targetUri].
  void registerLibraryReExport(
    String sourceUri,
    String targetUri, {
    Set<String>? show,
    Set<String>? hide,
  }) {
    _runner.registerLibraryReExport(
      sourceUri,
      targetUri,
      show: show,
      hide: hide,
    );
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
    _bridgedExtensions.add({library: libExt});
    _runner.registerBridgedExtension(definition, library, sourceUri: sourceUri);
    _bridgedLibraryUris.add(library);
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
    _libraryFunctions.add({library: libFunc});
    _runner.registerTopLevelFunction(
      name,
      function,
      library,
      sourceUri: sourceUri,
      signature: signature,
    );
    _bridgedLibraryUris.add(library);
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
    _libraryVariables.add({
      library: LibraryVariable(name, value, sourceUri: sourceUri),
    });
    _runner.registerGlobalVariable(name, value, library, sourceUri: sourceUri);
    _bridgedLibraryUris.add(library);
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
    _libraryGetters.add({
      library: LibraryGetter(name, getter, sourceUri: sourceUri),
    });
    _runner.registerGlobalGetter(name, getter, library, sourceUri: sourceUri);
    _bridgedLibraryUris.add(library);
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
    _librarySetters.add({
      library: LibrarySetter(name, setter, sourceUri: sourceUri),
    });
    _runner.registerGlobalSetter(name, setter, library, sourceUri: sourceUri);
    _bridgedLibraryUris.add(library);
  }

  ModuleLoader _initModule(
    Map<String, String>? sources, {
    String? basePath,
    bool allowFileSystemImports = false,
    bool collectRegistrationErrors = false,
  }) {
    final moduleLoader = ModuleLoader(
      Environment(),
      sources ?? {},
      _bridgedEnumDefinitions,
      _bridgedClases,
      libraryFunctions: _libraryFunctions,
      libraryVariables: _libraryVariables,
      libraryGetters: _libraryGetters,
      librarySetters: _librarySetters,
      bridgedExtensions: _bridgedExtensions,
      d4rt: this,
      collectRegistrationErrors: collectRegistrationErrors,
      parseSourceCallback: (sourceCode, uri) =>
          _parseExecutableSource(sourceCode, path: uri.toString()),
      // DGUB3 — both were accepted here and then dropped, so `execute()` has
      // always advertised filesystem imports it could not perform. The loader
      // is the component that honours them.
      basePath: basePath,
      allowFileSystemImports: allowFileSystemImports,
    );
    _visitor = InterpreterVisitor(
      globalEnvironment: moduleLoader.globalEnvironment,
      moduleContext: moduleLoader,
    );
    Stdlib(moduleLoader.globalEnvironment).register();
    return moduleLoader;
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
    _runner.grant(permission);
    Logger.debug("[D4rt.grant] Granted permission: ${permission.description}");
  }

  /// Revokes a previously granted permission.
  ///
  /// [permission] The permission to revoke.
  void revoke(Permission permission) {
    _grantedPermissions.remove(permission);
    _runner.revoke(permission);
    Logger.debug("[D4rt.revoke] Revoked permission: ${permission.description}");
  }

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

  // ============================================================================
  // Step 6 — Extension hook (forwards to inner D4rtRunner)
  // ============================================================================

  /// Whether [finalizeBridges] has been called. Step 6.
  ///
  /// State lives on the inner [D4rtRunner]; both the bundle and classic
  /// (`execute()`) execution paths consult it.
  bool get bridgesFinalized => _runner.bridgesFinalized;

  /// Registers a [body] callback that runs additional bridge wiring (e.g.
  /// `registerRelaxers()`, `registerD4rtRuntimeExtensions()`,
  /// `registerD4rtInterfaceProxyOverrides()`) **after** the main bridge
  /// registrations for [packageName].
  ///
  /// The body is queued, not run immediately. It runs when
  /// [finalizeBridges] is called (or implicitly on the first execute
  /// call). See [D4rtRunner.registerExtensions] for the full contract.
  ///
  /// **Idempotent on package name:** repeated calls with the same
  /// [packageName] overwrite the body.
  ///
  /// Throws [StateError] if [finalizeBridges] has already run.
  void registerExtensions(String packageName, void Function() body) =>
      _runner.registerExtensions(packageName, body);

  /// Runs every queued extension callback (in registration order) and
  /// freezes the runner. Step 6.
  ///
  /// Both [executeBundle] and the classic [execute] path call this
  /// implicitly on first invocation, so embedders rarely need to call
  /// it directly. Calling it explicitly is supported and lets you
  /// trigger the wiring at a deterministic moment (e.g. before the
  /// first script).
  ///
  /// **Idempotent:** repeat calls return without re-running anything.
  void finalizeBridges() => _runner.finalizeBridges();

  /// OPEN B.11 / U25 — Pre-builds the parser + bridge infrastructure so the
  /// first real build does not cold-start mid-test under host load.
  ///
  /// The first script run after a test harness' `setUpAll` historically
  /// flaked because the analyzer front-end, the AST converter, and the
  /// bridge/stdlib registration path all cold-started during that first
  /// build. This pays the cost up front:
  ///
  /// 1. [D4rtRunner.warmup] on the inner runner — finalizes bridge
  ///    extensions and warms the stdlib + bridged-definition registration
  ///    used by the [executeBundle] path.
  /// 2. A trivial throwaway [execute] of `int main() => 0;`, which JIT-warms
  ///    the analyzer parser, the [AstConverter], the classic module-loader
  ///    environment, and the interpreter call path.
  ///
  /// **Idempotent and script-neutral:** every real [execute]/[executeBundle]
  /// rebuilds its environment from scratch, so the throwaway warmup state is
  /// discarded. Safe to call once after all bridge registration and before
  /// the first real build.
  void warmup() {
    _runner.warmup();
    execute(source: 'int main() => 0;');
  }

  /// §U28 / TODO #14 — Evict script-declared entries from the inner
  /// [D4rtRunner]'s global environment so a follower `executeBundle`
  /// call starts with the same name-set the first build saw.
  ///
  /// Forwards to [D4rtRunner.resetScriptDeclarations]. See that
  /// method for the full contract and the architectural caveat
  /// (the runner already constructs a fresh [Environment] per
  /// [executeBundle] call, so this API is a forward-compatibility
  /// hook rather than the §U28 wedge fix).
  ///
  /// This method does NOT walk the classic [execute]-path's
  /// `_moduleLoader.globalEnvironment`. Callers that mix [execute]
  /// (source-direct) with [executeBundle] (AST-driven) and need
  /// both flushed should call this followed by re-instantiating
  /// the D4rt host (or open a follow-up issue if that becomes a
  /// real use case).
  void resetScriptDeclarations() => _runner.resetScriptDeclarations();

  // ==========================================================================
  // sce43 — members the reference's `D4rt` declares and this facade did not
  // ==========================================================================
  //
  // All of them already existed on [D4rtRunner], so the capability was present
  // on this line the whole time and only the facade omitted it: a consumer
  // reached them by going around the facade, or could not reach them at all.
  // `dispose` is the one that mattered most — `tom_d4rt`'s testing guideline
  // tells readers to write `tearDown(() => interpreter.dispose())`, so the
  // documented pattern did not compile here.
  //
  // `F-SCD10-5` in `test/front_end_parity_test.dart` compares the two class
  // surfaces with the analyzer and fails when they diverge again.

  /// Releases the interpreter artifacts retained from the most recent run.
  ///
  /// Mirrors `D4rt.dispose` on the reference. Non-destructive: process-global
  /// state (the package pool, warm parent, shared bridged-module envs) is
  /// preserved and a subsequent `execute*` rebuilds the per-run loader and
  /// visitor, so the instance stays usable.
  ///
  /// This line has TWO execution paths and each keeps its own per-run state:
  /// the classic `execute()` path on this wrapper, and the bundle path on the
  /// inner runner. Both are released here — forwarding alone would have left
  /// this wrapper's `CompilationUnit`s pinned, which is the retention
  /// `dispose` exists to end.
  void dispose() {
    if (_hasExecutedOnce) {
      _moduleLoader.releaseLoadedModules();
    }
    _visitor = null;
    // Also performs the script-declaration reset this wrapper forwards.
    _runner.dispose();
  }

  /// Registered class aliases, for module-env registration.
  ///
  /// Mirrors `D4rt.classAliases` on the reference and
  /// [D4rtRunner.classAliases] here. The runner is the single source: every
  /// [registerClassAlias] forwards to it.
  List<({String aliasName, String targetName, String library})>
  get classAliases => _runner.classAliases;

  /// Registered function typedefs, for module-env registration.
  ///
  /// Mirrors `D4rt.functionTypedefs` on the reference and
  /// [D4rtRunner.functionTypedefs] here.
  /// NOTE — this record is NARROWER than the reference's, which also carries
  /// `requiredPositional` and `maxPositional`. That is a real divergence
  /// between the lines, not an omission here: the `tom_d4rt_ast` this package
  /// RESOLVES declares two fields. (The AST working tree already carries four,
  /// so this widens on the next publish — DGUC6: what exec compiles against is
  /// the published interpreter, not the tree beside it.) The parity guard
  /// compares member NAMES, so it stays green either way.
  List<({String name, String library})> get functionTypedefs =>
      _runner.functionTypedefs;

  /// Number of source modules whose parsed unit this instance currently
  /// retains. `0` before the first execute or after [dispose].
  ///
  /// Mirrors `D4rt.debugLoadedModuleCount` on the reference, and reports this
  /// wrapper's own loader for the same reason [dispose] releases it.
  int get debugLoadedModuleCount =>
      _hasExecutedOnce ? _moduleLoader.loadedModuleCount : 0;

  /// Diagnostics — how many bridged-module environments have been built.
  ///
  /// Mirrors `D4rt.debugBridgedModuleEnvBuildCount` on the reference. The
  /// counter is process-global and lives on [D4rtRunner] on this line.
  static int get debugBridgedModuleEnvBuildCount =>
      D4rtRunner.debugBridgedModuleEnvBuildCount;

  /// Registers a relaxer factory for [baseTypeName] (RC-2 generics).
  ///
  /// Mirrors `D4rt.registerRelaxerFactory` on the reference.
  void registerRelaxerFactory(
    String baseTypeName,
    GenericTypeWrapperFactory factory,
  ) => _runner.registerRelaxerFactory(baseTypeName, factory);

  /// Registers an interface-proxy factory for [bridgedTypeName].
  ///
  /// Mirrors `D4rt.registerInterfaceProxy` on the reference.
  void registerInterfaceProxy(
    String bridgedTypeName,
    InterfaceProxyFactory factory,
  ) => _runner.registerInterfaceProxy(bridgedTypeName, factory);

  /// Registers a generic-constructor factory for
  /// [className].[constructorName]. Use `''` for the unnamed constructor.
  ///
  /// Mirrors `D4rt.registerGenericConstructor` on the reference.
  void registerGenericConstructor(
    String className,
    String constructorName,
    GenericConstructorFactory factory,
  ) => _runner.registerGenericConstructor(className, constructorName, factory);

  // ============================================================================
  // Step 7/8 — package pool + warm parent (forwards to inner D4rtRunner)
  // ============================================================================

  /// Declares that the bridges for [packageName] are about to be (or have
  /// already been) registered, and reports whether the caller may **skip**
  /// re-registering them. Steps 7–8.
  ///
  /// Pure forward to [D4rtRunner.providePackage] — the inner runner owns the
  /// process-global package pool, the per-instance allowed-set, and the
  /// warm-parent cache. Keeping a single source of truth on the runner avoids
  /// a divergent second pool on this wrapper.
  ///
  /// Returns `false` the first time [packageName] is seen in the process (the
  /// caller must register its bridges) and `true` once the package is pooled
  /// (the caller may skip registration). Either way [packageName] is added to
  /// this instance's allowed-set.
  ///
  /// ```dart
  /// if (d4rt.providePackage('tom_d4rt_flutter') == false) {
  ///   registerFlutterBridges(d4rt); // first instance only
  /// }
  /// ```
  ///
  /// **Caveat — classic `execute()` path is not pool-backed.** The pool and
  /// warm-parent reuse only benefit the [executeBundle] path (the canonical
  /// [FlutterD4rt] path), which runs entirely against the inner runner. This
  /// wrapper's classic [execute] path uses *per-instance* local registries
  /// ([registerBridgedClass] et al. dual-write to those local lists). A
  /// migrated second instance that calls `providePackage` and then skips
  /// registration would leave those local lists empty — so consumers that
  /// rely on the classic [execute] path must register their bridges
  /// unconditionally (ignore the skip), or use [executeBundle].
  bool providePackage(String packageName) =>
      _runner.providePackage(packageName);

  /// The packages this instance has been granted via [providePackage]
  /// (process-global pool membership is independent). Step 7.
  ///
  /// Forwards to [D4rtRunner.allowedPackages].
  Set<String> get allowedPackages => _runner.allowedPackages;

  /// The names of every package currently pooled process-wide. Step 7.
  ///
  /// Forwards to [D4rtRunner.debugPooledPackages]. Test/diagnostic only.
  static Set<String> get debugPooledPackages => D4rtRunner.debugPooledPackages;

  /// The number of bridged classes pooled under [packageName]. Step 7.
  ///
  /// Forwards to [D4rtRunner.debugPooledClassCount]. Test/diagnostic only.
  static int debugPooledClassCount(String packageName) =>
      D4rtRunner.debugPooledClassCount(packageName);

  /// The number of distinct warm parents cached for migrated instances. Step 8.
  ///
  /// Forwards to [D4rtRunner.debugWarmParentCacheSize]. Test/diagnostic only.
  static int get debugWarmParentCacheSize =>
      D4rtRunner.debugWarmParentCacheSize;

  /// Clears the process-global package pool and warm-parent cache. Step 7/8.
  ///
  /// Forwards to [D4rtRunner.debugResetPool]. Test/diagnostic only — call in
  /// `setUp`/`tearDown` to keep pool-size assertions order-independent.
  static void debugResetPool() => D4rtRunner.debugResetPool();

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
  /// interpreter.registerGlobalVariable(
  ///     'config', {'debug': true}, 'package:my_lib/my_lib.dart');
  ///
  /// final config = interpreter.getConfiguration();
  /// print(jsonEncode(config.toJson()));
  /// ```
  D4rtConfiguration getConfiguration() {
    // Build imports map from registered bridges
    final importsMap = <String, ImportConfiguration>{};

    // Process bridged classes
    for (final entry in _bridgedClases) {
      for (final MapEntry(:key, :value) in entry.entries) {
        final importPath = key;
        final libClass = value;
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
    for (final entry in _bridgedEnumDefinitions) {
      for (final MapEntry(:key, :value) in entry.entries) {
        final importPath = key;
        final libEnum = value;
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
    for (final entry in _libraryVariables) {
      for (final MapEntry(key: libraryUri, value: variable) in entry.entries) {
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
    for (final entry in _libraryGetters) {
      for (final MapEntry(key: libraryUri, value: getter) in entry.entries) {
        globalGetters.add(
          GlobalGetterInfo(name: getter.name, libraryUri: libraryUri),
        );
      }
    }

    // Build global functions list from library-scoped functions
    final globalFunctions = <GlobalFunctionInfo>[];
    final seenFunctions = <String>{};
    for (final entry in _libraryFunctions) {
      for (final MapEntry(key: libraryUri, value: func) in entry.entries) {
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
    InterpretedFunction.clearParentMap();
    _moduleLoader = _initModule(
      sources,
      basePath: basePath,
      allowFileSystemImports: allowFileSystemImports,
    );

    // Parse the source
    final compilationUnit = _parseSource(source: source, library: library);

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

  /// The URI the interpreter seeds its initial library with, against which
  /// relative imports in the ROOT source resolve.
  ///
  /// An explicit [library] always wins. DGUB3 — otherwise, when filesystem
  /// imports are enabled, fall back to the loader's basePath so a relative
  /// import in an inline `source:` has a base to resolve against; `null` when
  /// there is neither (relative root imports then fail, as before).
  Uri? _initialLibraryUri(String? library) => library != null
      ? Uri.parse(library)
      : _moduleLoader.initialFileSystemLibraryUri;

  /// Parse source code into a SCompilationUnit.
  SCompilationUnit _parseSource({String? source, String? library}) {
    if (library != null) {
      Logger.debug(
        "[D4rt._parseSource] Attempting to load source via ModuleLoader for URI: $library",
      );

      // DGUB3 (mirrors tom_d4rt DFUB1) — when filesystem imports are enabled
      // the root library may live on disk rather than in the preloaded sources
      // map, so loadModule reads it via the ModuleLoader's filesystem path.
      // Only require a preloaded source when filesystem imports are disabled.
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
      final unit = _parseExecutableSource(source);
      Logger.debug(
        "[D4rt._parseSource] Direct source string parsed successfully.",
      );
      return unit;
    }
  }

  /// Execute a parsed SCompilationUnit in the given environment.
  /// Called when an error escapes an interpreted callback that the *platform*
  /// invoked, rather than the script's own future chain.
  ///
  /// **This forwards to BOTH execution paths, and that is the point.** `D4rt`
  /// here is a facade: `executeBundle` delegates to the inner `D4rtRunner`,
  /// while the classic `execute()` carries its own copy of the execution seam
  /// (three copies exist — `tom_d4rt`, `tom_d4rt_ast`, and this one). A hook
  /// wired to only one of them would be a public API that looks covered and is
  /// not, which is the failure SCD74 was filed to avoid. The setter assigns the
  /// runner's hook as well, so one assignment covers both.
  ///
  /// The error handed to the hook is the value the script actually threw: the
  /// interpreter's internal wrapper and any `BridgedInstance` shell are removed
  /// first, so a host can `catch` on the real type.
  ///
  /// **Setting a hook contains the error**: it is reported here and *not*
  /// forwarded to the enclosing zone, which is what makes it usable as a
  /// sandbox boundary by a host that runs untrusted script. Errors the caller
  /// can already observe are not routed here.
  ///
  /// **Set this before calling [execute] or `executeBundle`.** Setting it makes
  /// d4rt own the *error zone* for the execution, which is why it is opt-in; see
  /// `_forkScriptZone` for what that costs and why the zone is nevertheless
  /// always forked.
  ///
  /// ## Example:
  /// ```dart
  /// final d4rt = D4rt();
  /// d4rt.onUncaughtError = (error, stackTrace) {
  ///   log.warning('script callback failed', error, stackTrace);
  /// };
  /// ```
  void Function(Object error, StackTrace stackTrace)? get onUncaughtError =>
      _onUncaughtError;

  set onUncaughtError(
    void Function(Object error, StackTrace stackTrace)? hook,
  ) {
    _onUncaughtError = hook;
    // The bundle path runs inside the inner runner's own zone seam, so the hook
    // has to reach it too. Whatever unwrapping that path performs is the
    // resolved `tom_d4rt_ast`'s, not this file's — see `conformance_drift_test`.
    _runner.onUncaughtError = hook;
  }

  void Function(Object error, StackTrace stackTrace)? _onUncaughtError;

  /// Recovers the value the script actually threw from the interpreter's
  /// internal wrappers.
  ///
  /// **A deliberate fourth copy, and a temporary one.** `tom_d4rt_ast` exposes
  /// this as a public top-level `unwrapScriptError` from 0.82.0, but this
  /// package resolves that one from pub.dev (DGUC6) and is currently on 0.65.0,
  /// where it is private. It cannot be re-exported publicly from here either:
  /// `d4rt.dart` re-exports `package:tom_d4rt_ast/runtime.dart`, so a public
  /// top-level of the same name would become an ambiguous export the day the
  /// publish lands. So it is private, and sce119 deletes it in favour of the
  /// published one once the constraint is raised.
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
  /// **The zone is always forked; the ERROR zone is only taken over when
  /// [onUncaughtError] is set.** The distinction is the whole of SCD73 and is
  /// easy to collapse by accident. A zone that specifies `handleUncaughtError`
  /// *is* a new error zone, and Dart deliberately refuses to deliver an error
  /// across an error-zone boundary — `future_impl.dart`, "Don't cross zone
  /// boundaries with errors". Taking over the error zone unconditionally
  /// therefore stops an ordinary script failure from ever reaching the caller
  /// of [execute]: the awaiting caller registered its listener outside the
  /// zone, so the error is diverted to the uncaught handler and the returned
  /// future simply never completes. F-SCB9-12 caught exactly that. Owning the
  /// error zone is a real change to an embedder's error routing, so it happens
  /// when the embedder asks for it and not otherwise.
  ///
  /// A zone that specifies only the `register*Callback` hooks is **not** an
  /// error zone (`Zone.errorZone` still resolves to the parent's), so those
  /// hooks are installed unconditionally. They are what unwraps the
  /// interpreter's internal types on the no-hook path: an escaping error has to
  /// be *observed* to be unwrapped, and a callback can be observed by wrapping
  /// it at registration instead of by handling the error it throws. SCD73 was
  /// filed believing no such seam existed.
  ///
  /// They run on every callback registered while a script executes, including
  /// callbacks belonging to native code a bridge called — so the transform has
  /// to leave anything that is not an interpreter type byte-identical, which
  /// [_unwrapScriptError] does. That it is safe to apply here at all was
  /// measured rather than assumed: a `Future.then` callback that throws is the
  /// one registered-callback escape an interpreted `catch` can still receive,
  /// and its `catch`, `on`-clause matching, member access and `rethrow` were
  /// all checked unchanged.
  Zone _forkScriptZone() =>
      Zone.current.fork(specification: _scriptZoneSpecification());

  /// The specification behind [_forkScriptZone], split out because its two
  /// halves answer to different constraints.
  ZoneSpecification _scriptZoneSpecification() {
    // Unconditional: shed the wrapper as the callback throws, which needs no
    // error zone. `errorCallback` below covers the one shape these cannot
    // reach; see [_unwrapScriptError], which stays the documented remedy for a
    // value that reaches an embedder by some route neither seam sees.
    R Function() registerCallback<R>(
      Zone self,
      ZoneDelegate parent,
      Zone zone,
      R Function() callback,
    ) => parent.registerCallback(zone, () {
      try {
        return callback();
      } catch (error, stackTrace) {
        Error.throwWithStackTrace(_unwrapScriptError(error), stackTrace);
      }
    });

    R Function(T) registerUnaryCallback<R, T>(
      Zone self,
      ZoneDelegate parent,
      Zone zone,
      R Function(T) callback,
    ) => parent.registerUnaryCallback(zone, (T arg) {
      try {
        return callback(arg);
      } catch (error, stackTrace) {
        Error.throwWithStackTrace(_unwrapScriptError(error), stackTrace);
      }
    });

    R Function(T1, T2) registerBinaryCallback<R, T1, T2>(
      Zone self,
      ZoneDelegate parent,
      Zone zone,
      R Function(T1, T2) callback,
    ) => parent.registerBinaryCallback(zone, (T1 a, T2 b) {
      try {
        return callback(a, b);
      } catch (error, stackTrace) {
        Error.throwWithStackTrace(_unwrapScriptError(error), stackTrace);
      }
    });

    // SCE117: the one escape route the register hooks cannot reach.
    //
    // A `handleError` handler is invoked by the SDK with NO zone registration
    // at all, so there is no `register*Callback` seam to wrap — measured, and
    // adding `runUnary`/`runBinary` to this specification changed nothing
    // except double-wrapping the `Stream.listen` case. `errorCallback` DOES
    // fire for that shape, and it is not an error-zone hook: specifying it
    // leaves `Zone.errorZone` resolving to the parent's, so the property
    // F-SCD73-6 and F-SCB9-12 hold — an awaiting caller outside the zone still
    // receives an ordinary script failure — is untouched.
    //
    // BLAST RADIUS WAS MEASURED, NOT REASONED. `errorCallback` is consulted
    // for errors entering futures generally, so the concern was that an
    // interpreted `catch` would start seeing a different value. A thirteen-row
    // matrix of in-script shapes — `catch`, `on`-clause matching on native and
    // script-declared types, `.message` access, `rethrow`, `catchError`,
    // `await for`, and in-callback `try`/`catch` inside timers and stream
    // handlers — is byte-identical with and without it. It is a standing test
    // now rather than a one-off: `sce117_handle_error_unwrapping_test.dart`.
    //
    // It delegates when there is nothing to unwrap, so a non-interpreter error
    // keeps whatever the parent zone decides about it.
    AsyncError? errorCallback(
      Zone self,
      ZoneDelegate parent,
      Zone zone,
      Object error,
      StackTrace? stackTrace,
    ) {
      final unwrapped = _unwrapScriptError(error);
      if (identical(unwrapped, error)) {
        return parent.errorCallback(zone, error, stackTrace);
      }
      return AsyncError(unwrapped, stackTrace ?? StackTrace.current);
    }

    // Conditional: this is the error-zone half.
    if (onUncaughtError == null) {
      return ZoneSpecification(
        registerCallback: registerCallback,
        registerUnaryCallback: registerUnaryCallback,
        registerBinaryCallback: registerBinaryCallback,
        errorCallback: errorCallback,
      );
    }
    return ZoneSpecification(
      registerCallback: registerCallback,
      registerUnaryCallback: registerUnaryCallback,
      registerBinaryCallback: registerBinaryCallback,
      errorCallback: errorCallback,
      handleUncaughtError: (self, parent, zone, error, stackTrace) {
        final scriptError = _unwrapScriptError(error);
        final hook = onUncaughtError;
        if (hook == null) {
          // The field was cleared after the fork. Behave as the no-hook path.
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
    );
  }

  dynamic _executeInEnvironment({
    required SCompilationUnit compilationUnit,
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

    // The zone is always forked — its `register*Callback` half sheds the
    // interpreter's internal wrapper and costs no change in error routing. The
    // error-zone half is opt-in; see [_forkScriptZone].
    final zone = _forkScriptZone();
    final result = zone.run(run);
    if (onUncaughtError == null) return result;
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
    required SCompilationUnit compilationUnit,
    required Environment executionEnvironment,
    required String name,
    List<Object?>? positionalArgs,
    Map<String, Object?>? namedArgs,
    String? library,
  }) {
    // Step 6: implicit finalize on first execution. Same hook as the
    // [D4rtRunner._executeInEnvironment] path — the classic `execute()`
    // path bypasses the runner's execute*, so we ensure the extension
    // callbacks fire here too. No-op if the embedder already called
    // [finalizeBridges] explicitly.
    _runner.finalizeBridges();
    Logger.debug("[_executeInEnvironment] Starting Pass 1: Declaration");
    final declarationVisitor = DeclarationVisitor(executionEnvironment);
    for (final declaration in compilationUnit.declarations) {
      declaration.accept<void>(declarationVisitor);
    }
    Logger.debug("[_executeInEnvironment] Finished Pass 1: Declaration");

    _visitor = InterpreterVisitor(
      globalEnvironment: executionEnvironment,
      moduleContext: _moduleLoader,
      initialLibrary: _initialLibraryUri(library),
    );
    Object? functionResult;
    try {
      Logger.debug("[_executeInEnvironment] Starting Pass 2: Interpretation");
      Logger.debug(
        "[_executeInEnvironment] Processing directives (imports, exports, etc.)...",
      );
      for (final directive in compilationUnit.directives) {
        if (directive is SImportDirective) {
          Logger.debug(
            "[_executeInEnvironment]   - Processing SImportDirective: ${(directive.uri is SSimpleStringLiteral) ? (directive.uri as SSimpleStringLiteral).value : null}",
          );
          _visitor!.visitImportDirective(directive);
        } else {
          Logger.debug(
            "[_executeInEnvironment]   - Skipping directive of type: ${directive.runtimeType}",
          );
        }
      }
      Logger.debug("[_executeInEnvironment] Finished processing directives.");

      Logger.debug(
        "[_executeInEnvironment] Processing ALL declarations sequentially",
      );

      Logger.debug(
        "[_executeInEnvironment] Top-level declarations for Pass 2:",
      );
      for (final declaration in compilationUnit.declarations) {
        Logger.debug("[_executeInEnvironment]   - ${declaration.runtimeType}");
      }

      for (final declaration in compilationUnit.declarations) {
        declaration.accept<Object?>(_visitor!);
      }
      Logger.debug("[_executeInEnvironment] Finished processing declarations");
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
      // SCD101: the hand-rolled `on InternalInterpreterD4rtException` unwrap
      // that used to sit here is gone. It was exec's own third copy of a rule
      // the two interpreters already own — `throwAsHostFacingError` peels that
      // carrier as its FIRST branch — and being a copy is what let it drift:
      // it peeled once where the shared helper now peels twice (SCD96), so a
      // script's `throw FormatException(...)` reached an exec caller as a
      // `BridgedInstance` shell it could not `catch` on, long after both twins
      // had stopped doing that. A clause that runs BEFORE the general one and
      // reimplements part of it cannot inherit a fix.
    } catch (e, s) {
      // SCC27 — the host gets the type the script raised. This clause used to
      // enumerate the types allowed to escape (DFUB13's SourceCodeD4rtException
      // and AmbiguousBridgedNameException, plus `isSdkShapedError`'s four SDK
      // shapes) and relabel everything else as "Unexpected error". That list is
      // now redundant: every D4rtException implements Exception, so the general
      // rule — anything that is an `Error` or an `Exception` escapes as
      // itself — lets exactly those through and needs no maintenance when a new
      // diagnostic type is added. `isSdkShapedError` was deleted upstream for
      // precisely this reason; see `sdk_errors.dart`.
      //
      // It also fixes a case the list could not express: a native callee's
      // error arrives wrapped in a `RuntimeD4rtException`, and the old code
      // rethrew the *wrapper*, so `on FormatException` matched inside a script
      // but not at the call site that ran it. `throwAsHostFacingError` unwraps
      // it.
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
          (value) => _bridgeInterpreterValueToNative(value),
          // SCC27/SCD84 — an `async main` reports its failure through this
          // future, never through the enclosing try, so the boundary has to be
          // applied here as well. Without it the async half of the API kept
          // relabelling what the sync half had stopped relabelling:
          // `main() async => int.parse("zz")` completed with
          // `RuntimeD4rtException: Native error during static bridged method
          // call 'parse' on int: FormatException …` where the synchronous path
          // already handed back the `FormatException` itself.
          onError: throwAsHostFacingError,
        );
        // SCD101: same deletion as the synchronous boundary above — one rule,
        // one implementation.
      } catch (e, s) {
        // SCC27 — same rule as the synchronous boundary above. See the comment
        // there for why the explicit type list is gone.
        throwAsHostFacingError(e, s);
      }
    }
    _hasExecutedOnce = true;
    return resultValue;
  }

  // ===========================================================================
  // Bundle API (Phase 4 — AstBundler → D4rtRunner)
  // ===========================================================================

  /// Creates a distributable [AstBundle] from a source code string.
  ///
  /// The source is parsed and all imports are recursively resolved:
  /// - `dart:*` imports are skipped (stdlib, always available at runtime)
  /// - Bridged library imports are skipped (handled by native bridges)
  /// - Imports in [explicitSources] are included verbatim
  /// - Relative and same-package imports are auto-included from disk
  /// - Other `package:*` imports cause an error
  ///
  /// [source] The Dart source code to bundle.
  /// [sourcePath] Logical path for the entry point (default: `'main.dart'`).
  /// [explicitSources] Additional sources keyed by URI for imports not on disk.
  /// [bundlerConfig] Configuration for import resolution behavior.
  ///
  /// ## Example
  /// ```dart
  /// final d4rt = D4rt();
  /// d4rt.registerBridgedClass(myBridge, 'package:my_lib/my_lib.dart');
  ///
  /// final bundle = await d4rt.createBundleFromSource('''
  ///   import 'package:my_lib/my_lib.dart';
  ///   void main() => print('Hello');
  /// ''');
  ///
  /// bundle.saveToFile('my_app.d4rtbundle');
  /// ```
  Future<AstBundle> createBundleFromSource(
    String source, {
    String sourcePath = 'main.dart',
    Map<String, String>? explicitSources,
    AstBundlerConfig? bundlerConfig,
  }) async {
    final bundler = AstBundler(
      bridgedLibraries: _bridgedLibraryUris,
      explicitSources: explicitSources ?? const {},
      config: bundlerConfig ?? const AstBundlerConfig(),
      fileAccessValidator: _buildFileAccessValidator(),
    );
    return bundler.createFromSource(source, sourcePath: sourcePath);
  }

  /// Creates a distributable [AstBundle] from a file path.
  ///
  /// The file is read and all imports are recursively resolved using
  /// the same rules as [createBundleFromSource]. The file system is
  /// used to resolve relative and same-package imports.
  ///
  /// [entryPointPath] Path to the entry point Dart file.
  /// [explicitSources] Additional sources keyed by URI for imports not on disk.
  /// [packageName] The package name (auto-detected from pubspec.yaml if not given).
  /// [projectRoot] The project root directory (auto-detected if not given).
  /// [bundlerConfig] Configuration for import resolution behavior.
  ///
  /// ## Example
  /// ```dart
  /// final d4rt = D4rt();
  /// d4rt.registerBridgedClass(myBridge, 'package:my_lib/my_lib.dart');
  ///
  /// final bundle = await d4rt.createBundle(
  ///   'bin/my_app.dart',
  ///   packageName: 'my_app',
  /// );
  /// bundle.saveToFile('my_app.d4rtbundle');
  /// ```
  Future<AstBundle> createBundle(
    String entryPointPath, {
    Map<String, String>? explicitSources,
    String? packageName,
    String? projectRoot,
    AstBundlerConfig? bundlerConfig,
  }) async {
    final bundler = AstBundler(
      bridgedLibraries: _bridgedLibraryUris,
      explicitSources: explicitSources ?? const {},
      packageName: packageName,
      projectRoot: projectRoot,
      config: bundlerConfig ?? const AstBundlerConfig(),
      fileAccessValidator: _buildFileAccessValidator(),
    );
    return bundler.createFromFile(entryPointPath);
  }

  /// Builds a [FileAccessValidator] from the granted [FilesystemPermission]s.
  ///
  /// Returns `null` (unrestricted) if no [FilesystemPermission]s have been
  /// granted at all — this preserves backward compatibility: when no
  /// permissions are configured, the bundler can read any file.
  ///
  /// When at least one [FilesystemPermission] is granted:
  /// - [FilesystemPermission.read] or [FilesystemPermission.any] → allows all
  /// - [FilesystemPermission.readPath(path)] → allows only under that path
  /// - Multiple path-scoped permissions are OR-combined
  FileAccessValidator? _buildFileAccessValidator() {
    final fsPermissions = _grantedPermissions
        .whereType<FilesystemPermission>()
        .toList(growable: false);

    // No filesystem permissions configured at all → unrestricted (backward compat)
    if (fsPermissions.isEmpty) return null;

    // Build the validator: at least one permission must approve the read
    return (String canonicalPath) {
      final operation = <String, dynamic>{
        'type': 'filesystem',
        'path': canonicalPath,
        'read': true,
        'write': false,
        'execute': false,
      };
      for (final permission in fsPermissions) {
        if (permission.allows(operation)) return true;
      }
      return false;
    };
  }

  /// Executes a pre-made [AstBundle] using [D4rtRunner].
  ///
  /// This method does **not** require the Dart analyzer at runtime — all
  /// source code has already been parsed and bundled. The bundle is executed
  /// through the internal [D4rtRunner] which has all registered bridges
  /// and permissions.
  ///
  /// [bundle] The bundle to execute.
  /// [entryPoint] Override the bundle's entry point URI.
  /// [name] The function to call (default: `'main'`).
  /// [positionalArgs] Positional arguments for the function.
  /// [namedArgs] Named arguments for the function.
  ///
  /// ## Example
  /// ```dart
  /// // Load a pre-built bundle (no analyzer needed)
  /// final bundle = AstBundle.fromFile('my_app.d4rtbundle');
  ///
  /// final d4rt = D4rt();
  /// d4rt.registerBridgedClass(myBridge, 'package:my_lib/my_lib.dart');
  /// final result = d4rt.executeBundle(bundle);
  /// ```
  dynamic executeBundle(
    AstBundle bundle, {
    String? entryPoint,
    String name = 'main',
    List<Object?>? positionalArgs,
    Map<String, Object?>? namedArgs,
  }) {
    Logger.debug(
      '[D4rt.executeBundle] Delegating to D4rtRunner '
      '(${bundle.modules.length} modules, entry: ${entryPoint ?? bundle.entryPointUri})',
    );
    return _runner.executeBundle(
      bundle,
      entryPoint: entryPoint,
      name: name,
      positionalArgs: positionalArgs,
      namedArgs: namedArgs,
    );
  }

  /// Execute [bundle] and unwrap the result to type [T].
  ///
  /// Forwards to [D4rtRunner.executeBundleAs] so the unwrap path is identical
  /// to the analyzer-free runner — callers get either a plain [T] or a
  /// [D4UnwrapException] (which extends [D4rtException] and auto-registers
  /// with [ErrorReporter]).
  ///
  /// Use [executeBundleAsAsync] for `async` entry points that return a
  /// [Future].
  ///
  /// Step 2 of `tom_d4rt_flutterm/doc/d4rt_consolidation_plan.md`.
  T executeBundleAs<T>(
    AstBundle bundle, {
    String? entryPoint,
    String name = 'main',
    List<Object?>? positionalArgs,
    Map<String, Object?>? namedArgs,
  }) {
    Logger.debug(
      '[D4rt.executeBundleAs<$T>] Delegating to D4rtRunner.executeBundleAs '
      '(${bundle.modules.length} modules, entry: ${entryPoint ?? bundle.entryPointUri})',
    );
    return _runner.executeBundleAs<T>(
      bundle,
      entryPoint: entryPoint,
      name: name,
      positionalArgs: positionalArgs,
      namedArgs: namedArgs,
    );
  }

  /// Async variant of [executeBundleAs] — awaits the result if it is a
  /// [Future] before unwrapping to [T].
  Future<T> executeBundleAsAsync<T>(
    AstBundle bundle, {
    String? entryPoint,
    String name = 'main',
    List<Object?>? positionalArgs,
    Map<String, Object?>? namedArgs,
  }) {
    Logger.debug(
      '[D4rt.executeBundleAsAsync<$T>] Delegating to D4rtRunner.executeBundleAsAsync '
      '(${bundle.modules.length} modules, entry: ${entryPoint ?? bundle.entryPointUri})',
    );
    return _runner.executeBundleAsAsync<T>(
      bundle,
      entryPoint: entryPoint,
      name: name,
      positionalArgs: positionalArgs,
      namedArgs: namedArgs,
    );
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

    final compilationUnit = _parseExecutableSource(source);

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
      moduleContext: _moduleLoader,
    );

    for (final directive in compilationUnit.directives) {
      if (directive is SImportDirective) {
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
    final declarationParseResult = _parseSourceToAst(expression);

    // Only treat as declarations if there are no parse errors.
    // The analyzer's error recovery may produce declarations from bare
    // expressions (e.g., "true" → TopLevelVariableDeclaration), which would
    // incorrectly return null instead of the expression's value.
    if (!declarationParseResult.hasParseErrors &&
        declarationParseResult.declarations.isNotEmpty) {
      // It's a declaration - process it directly in the global environment
      final compilationUnit = declarationParseResult;

      // Declaration pass
      final declarationVisitor = DeclarationVisitor(executionEnvironment);
      for (final declaration in compilationUnit.declarations) {
        declaration.accept<void>(declarationVisitor);
      }

      // Interpretation pass
      for (final declaration in compilationUnit.declarations) {
        declaration.accept<Object?>(_visitor!);
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

      final parseResult = _parseSourceToAst(wrappedSource);

      {
        // Execute as expression with return value
        final compilationUnit = parseResult;

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
          } on InternalInterpreterD4rtException catch (e, s) {
            // SCD101: `eval` is a host boundary too, so it answers to the same
            // rule `execute` does. It carried its own peel, which is how it
            // came to differ from the shared helper by one level (SCD96).
            throwAsHostFacingError(e, s);
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

    final statementParseResult = _parseSourceToAst(statementSource);

    {
      final compilationUnit = statementParseResult;

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
        } on InternalInterpreterD4rtException catch (e, s) {
          // SCD101: same rule as the other `eval` site above.
          throwAsHostFacingError(e, s);
        }
      }

      Logger.debug("[D4rt.eval] Executed statement");
      return null;
    }
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
    var bridgedDef = _bridgedDefLookupByType[nativeType];

    // If exact type lookup failed, try to find a bridge for a supertype
    // This handles cases like Curves.linear returning a _Linear (private class)
    // that should be bridged using the Curve (public supertype) bridge.
    if (bridgedDef == null) {
      for (final entry in _bridgedDefLookupByType.entries) {
        final def = entry.value;
        if (def.isAssignable != null && def.isAssignable!(nativeValue)) {
          bridgedDef = def;
          break;
        }
      }
    }

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
    if (interpreterValue is BridgedInstance) {
      return interpreterValue.nativeObject;
    }

    if (interpreterValue is BridgedEnumValue) {
      return interpreterValue.nativeValue;
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
