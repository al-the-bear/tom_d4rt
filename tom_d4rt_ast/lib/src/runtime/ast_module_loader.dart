import 'package:tom_d4rt_ast/ast.dart';
import 'package:tom_d4rt_ast/src/runtime/bridge/bridged_types.dart';
import 'package:tom_d4rt_ast/src/runtime/runtime_interfaces.dart' show RuntimeType;
import 'package:tom_d4rt_ast/src/runtime/d4rt_runner.dart';
import 'package:tom_d4rt_ast/src/runtime/declaration_visitor.dart';
import 'package:tom_d4rt_ast/src/runtime/exceptions.dart';
import 'package:tom_d4rt_ast/src/runtime/interpreter_visitor.dart';
import 'package:tom_d4rt_ast/src/runtime/module_context.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/collection.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/convert.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/isolate.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/math.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/stdlib_io.dart'
    if (dart.library.html) 'package:tom_d4rt_ast/src/runtime/stdlib/stdlib_web.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/typed_data.dart';
import 'package:tom_d4rt_ast/src/runtime/utils/logger/logger.dart';

/// Lookup-only module resolver for pre-parsed AST bundles.
///
/// [AstModuleLoader] implements [ModuleContext] to resolve import directives
/// against a pre-loaded map of modules. It performs **no file I/O and no
/// source code parsing** — all modules must already exist in the bundle.
///
/// ## Module Resolution Order
///
/// When [loadModule] is called with a URI:
///
/// 1. **Cache** — return if already loaded
/// 2. **dart:*** — register the corresponding stdlib and return empty module
/// 3. **Bridged libraries** — register native bridges and return empty module
/// 4. **Bundle modules** — look up in [modules], process AST → environment
/// 5. **Error** — throw if URI not found anywhere
///
/// ## Usage
///
/// Typically created internally by [D4rtRunner.executeBundle] — not
/// constructed directly in user code.
///
/// ```dart
/// final loader = AstModuleLoader(
///   modules: bundle.modules,
///   globalEnvironment: env,
///   runner: runner,
/// );
/// ```
class AstModuleLoader implements ModuleContext {
  /// Pre-parsed modules from the bundle, keyed by URI string.
  final Map<String, SCompilationUnit> modules;

  @override
  final Environment globalEnvironment;

  @override
  Uri? currentLibrary;

  /// The [D4rtRunner] that owns this loader — used for bridge lookups
  /// and permission checks.
  final D4rtRunner runner;

  /// Cache of already-loaded modules to avoid reprocessing.
  final Map<Uri, LoadedModule> _moduleCache = {};

  /// Tracks which stdlib modules have been registered to avoid duplicates.
  final Set<String> _registeredStdlibs = {};

  /// Tracks which bridged library URIs have been processed.
  final Set<String> _registeredBridgeUris = {};

  /// Creates an [AstModuleLoader] for resolving imports from a bundle.
  ///
  /// - [modules] — the module map from [AstBundle.modules]
  /// - [globalEnvironment] — shared environment for all modules
  /// - [runner] — the [D4rtRunner] instance for bridge and permission lookups
  AstModuleLoader({
    required this.modules,
    required this.globalEnvironment,
    required this.runner,
  });

  @override
  bool checkPermission(dynamic operation) {
    return runner.checkPermission(operation);
  }

  @override
  LoadedModule loadModule(
    Uri uri, {
    Set<String>? showNames,
    Set<String>? hideNames,
  }) {
    // 1. Check cache
    if (_moduleCache.containsKey(uri)) {
      Logger.debug('[AstModuleLoader] Cache hit for module: $uri');
      return _moduleCache[uri]!;
    }

    Logger.debug(
      '[AstModuleLoader] Loading module: $uri '
      '(show: $showNames, hide: $hideNames)',
    );

    // 2. Handle dart:* stdlib modules (may return null if has bridged content)
    if (uri.isScheme('dart')) {
      final stdlibModule = _loadStdlibModule(uri);
      if (stdlibModule != null) {
        return stdlibModule;
      }
      // Fall through to bridged library handling
    }

    // 3. Handle bridged library URIs
    final bridgedModule = _tryLoadBridgedModule(uri, showNames, hideNames);
    if (bridgedModule != null) {
      return bridgedModule;
    }

    // 4. Lookup in bundle modules
    final uriString = uri.toString();
    final ast = modules[uriString];
    if (ast != null) {
      return _loadBundleModule(uri, ast);
    }

    // 5. Not found
    throw RuntimeD4rtException(
      'Module "$uriString" not found in bundle. '
      'Available: ${modules.keys.join(", ")}',
    );
  }

  // ===========================================================================
  // Stdlib Loading
  // ===========================================================================

  /// Known stdlib modules and their registration functions.
  ///
  /// Maps `dart:xxx` path names to their registration callbacks.
  /// `null` means the module is handled by [Stdlib.register] at init time
  /// (core, async) and requires no additional registration.
  static final Map<String, void Function(Environment)?> _stdlibRegistrars = {
    'core': null, // Registered at environment init
    'async': null, // Registered at environment init
    'math': (env) => MathStdlib.register(env),
    'convert': (env) => ConvertStdlib.register(env),
    'io': (env) => StdlibIo.register(env),
    'collection': (env) => CollectionStdlib.register(env),
    'typed_data': (env) => TypedDataStdlib.register(env),
    'isolate': (env) => IsolateStdlib.register(env),
  };

  /// Per-stdlib isolated environments (GEN-101 design, restored in GEN-107
  /// Phase 3).
  ///
  /// Every stdlib with an explicit registrar gets its own environment
  /// nested under [globalEnvironment]. Stdlib symbols never leak into the
  /// global scope, so scripts that define fields named `min`, `max`,
  /// `Stream`, … never collide with stdlib functions. Transitive reach
  /// (e.g. `ByteData` through `flutter/services.dart`) is handled by the
  /// GEN-107 re-export merge in [_mergeReExports], not by global leakage.
  ///
  /// `dart:core` and `dart:async` keep `null` registrars in
  /// [_stdlibRegistrars] — they are pre-registered into [globalEnvironment]
  /// at runner construction (because they are unconditional ambient names
  /// in Dart) and therefore stay shared.
  final Map<String, Environment> _stdlibEnvironments = {};

  /// Loads a `dart:*` stdlib module by registering its definitions.
  ///
  /// Returns `null` if the library is not a known stdlib and has no bridged
  /// content, allowing the caller to check bundle modules or throw an error.
  LoadedModule? _loadStdlibModule(Uri uri) {
    final libName = uri.path;
    final uriString = uri.toString();

    // Check if it's a known stdlib
    if (_stdlibRegistrars.containsKey(libName)) {
      final registrar = _stdlibRegistrars[libName];

      // GEN-107 Phase 3: every stdlib with an explicit registrar is
      // isolated. The math-only band-aid is gone — re-export merging now
      // carries stdlib symbols into the libraries that re-export them
      // (e.g. dart:typed_data → flutter/services.dart), so scripts no
      // longer rely on a global leak to reach them transitively.
      if (registrar != null) {
        Environment stdlibEnv;
        if (_stdlibEnvironments.containsKey(libName)) {
          stdlibEnv = _stdlibEnvironments[libName]!;
        } else {
          stdlibEnv = Environment(enclosing: globalEnvironment);
          registrar(stdlibEnv);
          // Mirror the per-stdlib bridges' native-type lookup into
          // globalEnvironment so that `toBridgedInstance(rawNative)` can
          // discover them when a script passes a native subtype (e.g.
          // `_Random` from `math.Random()`) through an interpreted
          // function. The lexical name (e.g. `Random`) stays isolated
          // in stdlibEnv — only the type→bridge mapping is propagated.
          stdlibEnv.propagateBridgeTypesTo(globalEnvironment);
          _stdlibEnvironments[libName] = stdlibEnv;
          _registeredStdlibs.add(libName);
          Logger.debug(
            '[AstModuleLoader] Registered isolated stdlib dart:$libName',
          );
        }

        final emptyAst = SCompilationUnit(offset: 0, length: 0);
        final module = LoadedModule(
          ast: emptyAst,
          exportedEnvironment: stdlibEnv,
          uri: uri,
        );
        _moduleCache[uri] = module;
        return module;
      }

      // dart:core / dart:async: registrar is null because they are
      // pre-registered into globalEnvironment at runner construction.
      // They stay shared so unprefixed names like `Object`, `String`,
      // `Future`, `Stream` resolve without an explicit import.
      final emptyAst = SCompilationUnit(offset: 0, length: 0);
      final module = LoadedModule(
        ast: emptyAst,
        exportedEnvironment: globalEnvironment,
        uri: uri,
      );
      _moduleCache[uri] = module;
      return module;
    }

    // Not a known stdlib — check if there are bridges registered for this dart: URI
    if (_hasBridgedContent(uriString)) {
      Logger.debug(
        '[AstModuleLoader] dart:$libName has bridged content, loading as bridged module',
      );
      return null; // Let caller handle via _tryLoadBridgedModule
    }

    // No stdlib and no bridges — this dart: library is not supported
    throw RuntimeD4rtException(
      "Dart library 'dart:$libName' is not supported.",
    );
  }

  // ===========================================================================
  // Bridged Library Loading
  // ===========================================================================

  /// Module-specific environments for bridged libraries.
  /// Each bridged module gets its own environment containing only its symbols,
  /// preventing same-named symbols from different modules from overwriting
  /// each other in globalEnvironment.
  /// GEN-100 FIX: Use per-module environments for bridge isolation.
  final Map<String, Environment> _bridgedModuleEnvironments = {};

  /// Attempts to load a bridged library by registering its definitions.
  ///
  /// Returns `null` if the URI has no bridged content registered in the runner.
  ///
  /// GEN-100 FIX: Creates a module-specific environment for each bridged library
  /// instead of registering all bridges into globalEnvironment. This prevents
  /// same-named classes (e.g., dart:ui.TextStyle vs painting.TextStyle) from
  /// overwriting each other.
  LoadedModule? _tryLoadBridgedModule(
    Uri uri,
    Set<String>? showNames,
    Set<String>? hideNames,
  ) {
    final uriString = uri.toString();

    // Check if any bridges are registered for this URI
    if (!_hasBridgedContent(uriString)) {
      return null;
    }

    // Check cache first
    if (_moduleCache.containsKey(uri)) {
      return _moduleCache[uri];
    }

    // GEN-100 FIX: Create a module-specific environment for this bridged library.
    // The environment encloses globalEnvironment so standard library and other
    // pre-registered symbols are still accessible, but this module's bridges
    // are isolated in its own environment.
    Environment moduleEnv;
    if (_bridgedModuleEnvironments.containsKey(uriString)) {
      moduleEnv = _bridgedModuleEnvironments[uriString]!;
    } else {
      // GEN-100 FIX: Build the module env with show=null/hide=null so it
      // contains ALL symbols the module transitively exports.  The per-import
      // show/hide filter is applied later in importEnvironment() at the call
      // site — it must NOT be baked into the cached module env, which is
      // shared across every import of this URI.
      moduleEnv = Environment(enclosing: globalEnvironment);
      _registerBridgesForUriInto(uriString, null, null, moduleEnv);
      // GEN-107: Merge re-exported libraries into this module's environment.
      _mergeReExports(uriString, moduleEnv, null, null, <String, Set<String>?>{});
      _bridgedModuleEnvironments[uriString] = moduleEnv;
      _registeredBridgeUris.add(uriString);
    }

    // Return module with its own environment as exportedEnvironment
    final emptyAst = SCompilationUnit(offset: 0, length: 0);
    final module = LoadedModule(
      ast: emptyAst,
      exportedEnvironment: moduleEnv,
      uri: uri,
    );
    _moduleCache[uri] = module;
    return module;
  }

  /// Checks if the runner has any bridged content for the given URI.
  ///
  /// Step 1 (import-optimization plan): the registries are now URI-keyed,
  /// so this is an O(1) `containsKey` per registry instead of scanning the
  /// whole list.
  bool _hasBridgedContent(String uriString) {
    return runner.bridgedEnumDefinitions.containsKey(uriString) ||
        runner.bridgedClasses.containsKey(uriString) ||
        runner.bridgedExtensions.containsKey(uriString) ||
        runner.libraryFunctions.containsKey(uriString) ||
        runner.libraryVariables.containsKey(uriString) ||
        runner.libraryGetters.containsKey(uriString) ||
        runner.librarySetters.containsKey(uriString);
  }

  /// Registers all bridged definitions for a URI into a target environment.
  ///
  /// GEN-100 FIX: Changed to accept a target environment parameter instead of
  /// always using globalEnvironment. This enables per-module bridge isolation.
  void _registerBridgesForUriInto(
    String uriString,
    Set<String>? showNames,
    Set<String>? hideNames,
    Environment targetEnvironment,
  ) {
    // Register bridged enums (Step 1: direct O(matched) URI lookup).
    for (final libEnum
        in runner.bridgedEnumDefinitions[uriString]?.values ??
            const <LibraryEnum>[]) {
      final name = libEnum.enumDefinition.name;
      if (!_shouldInclude(name, showNames, hideNames)) continue;

      final bridgedEnum = libEnum.enumDefinition.buildBridgedEnum();
      targetEnvironment.defineBridgedEnum(bridgedEnum);
      Logger.debugLazy(
        () => '[AstModuleLoader] Registered bridged enum: $name from $uriString',
      );
    }

    // Register bridged classes (Step 1: direct O(matched) URI lookup).
    for (final libClass
        in runner.bridgedClasses[uriString]?.values ??
            const <LibraryClass>[]) {
      final name = libClass.bridgedClass.name;
      if (!_shouldInclude(name, showNames, hideNames)) continue;

      targetEnvironment.defineBridge(libClass.bridgedClass);
      Logger.debugLazy(
        () => '[AstModuleLoader] Registered bridged class: $name from $uriString',
      );
    }

    // GEN-078: Register class aliases so deprecated names resolve to the
    // canonical bridged class (e.g., MaterialStateProperty -> WidgetStateProperty).
    for (final alias in runner.classAliases) {
      if (alias.library != uriString) continue;
      if (!_shouldInclude(alias.aliasName, showNames, hideNames)) continue;

      targetEnvironment.defineBridgeAlias(alias.aliasName, alias.targetName);
      Logger.debugLazy(
        () => '[AstModuleLoader] Registered class alias: '
            '${alias.aliasName} -> ${alias.targetName} from $uriString',
      );
    }

    // Register function typedefs as BridgedClass(nativeType: Function)
    // so they can be resolved in type annotations and type arguments.
    for (final typedef in runner.functionTypedefs) {
      if (typedef.library != uriString) continue;
      if (!_shouldInclude(typedef.name, showNames, hideNames)) continue;

      targetEnvironment.defineBridge(
        BridgedClass(nativeType: Function, name: typedef.name),
      );
      Logger.debugLazy(
        () => '[AstModuleLoader] Registered function typedef: '
            '${typedef.name} from $uriString',
      );
    }

    // Register bridged extensions.
    //
    // Bug-44 FIX: this loop used to be a no-op (the trailing comment claimed
    // "Extensions register themselves into the environment via their
    // methods" but they never did). Bridged extensions like
    // `extension StringCharacters on String { Characters get characters }`
    // were registered against the runner via registerBridgedExtension, but
    // never actually wired into the script's lookup environment, so any
    // call like `someString.characters` failed with
    //   "Undefined property or method 'characters' on bridged instance of
    //    'String'."
    //
    // We now resolve the on-type, build an InterpretedExtension via
    // BridgedExtensionDefinition.buildInterpretedExtension, and register it
    // in the target environment (named extensions also get a value entry
    // so explicit `MyExt(value).method()` syntax can resolve them).
    for (final libExt
        in runner.bridgedExtensions[uriString] ??
            const <LibraryExtension>[]) {
      final extDef = libExt.extensionDefinition;
      final name = extDef.name;
      if (name != null && !_shouldInclude(name, showNames, hideNames)) continue;

      // Resolve onTypeName against the target environment. Most extension
      // on-types are bridged (BridgedClass), but interpreted classes are
      // also valid.
      RuntimeType? onType;
      try {
        final resolved = targetEnvironment.get(extDef.onTypeName);
        if (resolved is RuntimeType) {
          onType = resolved;
        }
      } on RuntimeD4rtException {
        onType = null;
      }
      if (onType == null) {
        Logger.warn(
          '[AstModuleLoader] Bridged extension on unknown type '
          "'${extDef.onTypeName}' from $uriString — skipping. "
          '(Extension getter/method calls on values of this type will fail '
          'at runtime.)',
        );
        continue;
      }

      final interpretedExt = extDef.buildInterpretedExtension(onType);
      // Unnamed and named extensions are both reachable through the
      // implicit-extension-member lookup walk, so always add to the
      // unnamed-extension list. Named extensions additionally get a
      // value binding so `Name(value).member` syntax can resolve them.
      targetEnvironment.addUnnamedExtension(interpretedExt);
      if (name != null) {
        targetEnvironment.define(name, interpretedExt);
      }
      Logger.debugLazy(
        () => '[AstModuleLoader] Registered bridged extension '
            "'${name ?? '<unnamed>'}' on ${extDef.onTypeName} from $uriString",
      );
    }

    // Register library functions (Step 1: direct O(matched) URI lookup).
    for (final libFunc
        in runner.libraryFunctions[uriString]?.values ??
            const <LibraryFunction>[]) {
      final name = libFunc.function.name;
      if (name == '<native>') continue; // Skip unnamed functions
      if (!_shouldInclude(name, showNames, hideNames)) continue;

      targetEnvironment.define(name, libFunc.function);
      Logger.debugLazy(
        () =>
            '[AstModuleLoader] Registered library function: $name from $uriString',
      );
    }

    // Register library variables (Step 1: direct O(matched) URI lookup).
    for (final libVar
        in runner.libraryVariables[uriString]?.values ??
            const <LibraryVariable>[]) {
      if (!_shouldInclude(libVar.name, showNames, hideNames)) continue;

      targetEnvironment.define(libVar.name, libVar.value);
      Logger.debugLazy(
        () => '[AstModuleLoader] Registered library variable: '
            '${libVar.name} from $uriString',
      );
    }

    // Register library getters (paired with optional setters)
    final settersByName = <String, LibrarySetter>{};
    for (final libSetter
        in runner.librarySetters[uriString]?.values ??
            const <LibrarySetter>[]) {
      settersByName[libSetter.name] = libSetter;
    }

    for (final libGetter
        in runner.libraryGetters[uriString]?.values ??
            const <LibraryGetter>[]) {
      if (!_shouldInclude(libGetter.name, showNames, hideNames)) continue;

      final setter = settersByName.remove(libGetter.name);
      targetEnvironment.define(
        libGetter.name,
        GlobalGetter(libGetter.getter, setter: setter?.setter),
      );
      Logger.debugLazy(
        () => '[AstModuleLoader] Registered library getter: '
            '${libGetter.name} from $uriString',
      );
    }

    // Register any remaining standalone setters
    for (final entry in settersByName.entries) {
      if (!_shouldInclude(entry.key, showNames, hideNames)) continue;

      targetEnvironment.define(
        entry.key,
        GlobalGetter(
          () =>
              throw RuntimeD4rtException('Property ${entry.key} is write-only'),
          setter: entry.value.setter,
        ),
      );
    }
  }

  /// Checks if a name passes show/hide filters.
  bool _shouldInclude(
    String name,
    Set<String>? showNames,
    Set<String>? hideNames,
  ) {
    if (hideNames != null && hideNames.contains(name)) return false;
    if (showNames != null && !showNames.contains(name)) return false;
    return true;
  }

  /// GEN-107: Merge re-exported libraries' bridged content into [moduleEnv].
  ///
  /// Looks up [sourceUri] in [D4rtRunner.libraryReExports] and, for each
  /// recorded re-export, registers the target library's bridges into the
  /// source library's per-module environment under the combined `show`/`hide`
  /// filters. Recurses to handle transitive re-exports
  /// (e.g. `flutter/material.dart → flutter/widgets.dart → flutter/foundation.dart
  /// → dart:typed_data`).
  ///
  /// [outerShow] / [outerHide] are the filters originally applied to the
  /// import of [sourceUri]; per-re-export filters are intersected/unioned
  /// with them so a hidden symbol stays hidden through the chain.
  ///
  /// [visited] guards against import cycles (a → b → a). Each URI is only
  /// merged once per top-level merge call.
  void _mergeReExports(
    String sourceUri,
    Environment moduleEnv,
    Set<String>? outerShow,
    Set<String>? outerHide,
    Map<String, Set<String>?> visitedShows,
  ) {
    // GEN-100 FIX: Use a Map<uri → broadestShowSeen> instead of a simple
    // "ever visited" Set.  See module_loader.dart for the full explanation.
    if (visitedShows.containsKey(sourceUri)) {
      final prevShow = visitedShows[sourceUri];
      if (prevShow == null) return; // null = all symbols already covered
      if (outerShow != null && outerShow.difference(prevShow).isEmpty) return;
      if (outerShow == null) {
        visitedShows[sourceUri] = null;
      } else {
        prevShow.addAll(outerShow);
      }
    } else {
      visitedShows[sourceUri] = outerShow != null ? Set.of(outerShow) : null;
    }

    final reExports = runner.libraryReExports[sourceUri];
    if (reExports == null || reExports.isEmpty) return;

    for (final re in reExports) {
      final effectiveShow = _intersectShow(outerShow, re.show);
      final effectiveHide = _unionHide(outerHide, re.hide);

      // For dart: targets, load the stdlib (Phase 3: now always isolated
      // when there's an explicit registrar) and import its symbols into
      // the source library's per-module environment. This is what makes
      // `ByteData` reachable through `flutter/services.dart` even though
      // typed_data no longer leaks into globalEnvironment.
      final targetUri = Uri.parse(re.uri);
      if (targetUri.scheme == 'dart') {
        try {
          final stdlibModule = _loadStdlibModule(targetUri);
          if (stdlibModule != null) {
            moduleEnv.importEnvironment(
              stdlibModule.exportedEnvironment,
              show: effectiveShow,
              hide: effectiveHide,
            );
          }
        } on RuntimeD4rtException {
          // Ignored: re-export of an unknown dart: library is the user's
          // bridge configuration problem, surfaced when they import it.
        }
      }

      // Merge any bridged content registered against the target URI into
      // the source library's per-module environment, applying the
      // combined show/hide filters.
      _registerBridgesForUriInto(
        re.uri,
        effectiveShow,
        effectiveHide,
        moduleEnv,
      );

      // Recurse for transitive re-exports.
      _mergeReExports(re.uri, moduleEnv, effectiveShow, effectiveHide, visitedShows);
    }
  }

  /// Intersect two optional show-filters.
  ///
  /// `null` means "show everything"; the intersection of `null` and any
  /// set is that set; the intersection of two sets is the usual
  /// set intersection.
  Set<String>? _intersectShow(Set<String>? outer, Set<String>? inner) {
    if (outer == null) return inner;
    if (inner == null) return outer;
    return outer.intersection(inner);
  }

  /// Union two optional hide-filters.
  ///
  /// `null` means "hide nothing"; the union with `null` is the other set;
  /// the union of two sets is the usual set union.
  Set<String>? _unionHide(Set<String>? outer, Set<String>? inner) {
    if (outer == null && inner == null) return null;
    return {...?outer, ...?inner};
  }

  // ===========================================================================
  // Bundle Module Loading
  // ===========================================================================

  /// Loads a module from the bundle by processing its AST.
  ///
  /// This performs the full module loading sequence:
  /// 1. Create module environment (enclosing global)
  /// 2. Process import directives recursively
  /// 3. Run declaration visitor (populate names)
  /// 4. Run interpreter visitor (initialize values)
  /// 5. Build exported environment
  /// 6. Cache and return
  LoadedModule _loadBundleModule(Uri uri, SCompilationUnit ast) {
    // Save and set current library for relative import resolution
    final previousLibrary = currentLibrary;
    currentLibrary = uri;

    Logger.debug('[AstModuleLoader] Processing bundle module: $uri');

    // Module-local environment enclosing global
    final moduleEnv = Environment(enclosing: globalEnvironment);

    // Process import directives first (before declarations)
    _processImports(uri, ast, moduleEnv);

    // Declaration pass — populate environment with names
    final declVisitor = DeclarationVisitor(moduleEnv);
    for (final decl in ast.declarations) {
      decl.accept<void>(declVisitor);
    }

    // Interpretation pass — initialize values, process class/enum bodies
    final interpreter = InterpreterVisitor(
      globalEnvironment: moduleEnv,
      moduleContext: this,
      initialLibrary: uri,
    );

    // Order matters: enums → classes/mixins → functions → extensions → variables
    _interpretDeclarations(ast, interpreter);

    // Build exported environment
    final exportedEnv = Environment(enclosing: globalEnvironment);
    exportedEnv.importEnvironment(moduleEnv);

    // Process export directives
    _processExports(uri, ast, exportedEnv);

    // Cache and return
    final module = LoadedModule(
      ast: ast,
      exportedEnvironment: exportedEnv,
      uri: uri,
    );
    _moduleCache[uri] = module;

    // Restore previous library context
    currentLibrary = previousLibrary;

    Logger.debug('[AstModuleLoader] Finished loading bundle module: $uri');
    return module;
  }

  /// Processes import directives of a module, loading referenced modules
  /// and importing their environments.
  void _processImports(
    Uri moduleUri,
    SCompilationUnit ast,
    Environment moduleEnv,
  ) {
    for (final directive in ast.directives) {
      if (directive is! SImportDirective) continue;

      final uriLiteral = directive.uri;
      if (uriLiteral is! SSimpleStringLiteral) continue;
      final importUriString = uriLiteral.value;

      final importUri = Uri.parse(importUriString);
      final resolvedUri = _resolveUri(importUri, moduleUri);

      // Extract show/hide/prefix
      Set<String>? showNames;
      Set<String>? hideNames;
      final prefix = directive.prefix?.name;

      for (final combinator in directive.combinators) {
        if (combinator is SShowCombinator) {
          showNames ??= {};
          showNames.addAll(combinator.shownNames.map((id) => id.name));
        } else if (combinator is SHideCombinator) {
          hideNames ??= {};
          hideNames.addAll(combinator.hiddenNames.map((id) => id.name));
        }
      }

      Logger.debug(
        '[AstModuleLoader] Import: $importUriString → $resolvedUri '
        '(prefix: $prefix, show: $showNames, hide: $hideNames)',
      );

      final loaded = loadModule(
        resolvedUri,
        showNames: showNames,
        hideNames: hideNames,
      );

      if (prefix != null) {
        final filteredEnv = loaded.exportedEnvironment.shallowCopyFiltered(
          showNames: showNames,
          hideNames: hideNames,
        );
        moduleEnv.definePrefixedImport(prefix, filteredEnv);
      } else {
        moduleEnv.importEnvironment(
          loaded.exportedEnvironment,
          show: showNames,
          hide: hideNames,
        );
      }
    }
  }

  /// Processes export directives, merging exported modules into [exportedEnv].
  void _processExports(
    Uri moduleUri,
    SCompilationUnit ast,
    Environment exportedEnv,
  ) {
    for (final directive in ast.directives) {
      if (directive is! SExportDirective) continue;

      final uriLiteral = directive.uri;
      if (uriLiteral is! SSimpleStringLiteral) continue;
      final exportUriString = uriLiteral.value;

      final exportUri = Uri.parse(exportUriString);
      final resolvedUri = _resolveUri(exportUri, moduleUri);

      Set<String>? showNames;
      Set<String>? hideNames;

      for (final combinator in directive.combinators) {
        if (combinator is SShowCombinator) {
          showNames ??= {};
          showNames.addAll(combinator.shownNames.map((id) => id.name));
        } else if (combinator is SHideCombinator) {
          hideNames ??= {};
          hideNames.addAll(combinator.hiddenNames.map((id) => id.name));
        }
      }

      Logger.debug('[AstModuleLoader] Export: $exportUriString → $resolvedUri');

      final loaded = loadModule(resolvedUri);
      // Cluster EXPORT (I-MISC-40/41): pass errorOnConflict: true so that a
      // library that re-publishes two different definitions of the same name
      // (local vs re-export, or two re-exports) raises immediately instead of
      // silently overwriting.
      exportedEnv.importEnvironment(
        loaded.exportedEnvironment,
        show: showNames,
        hide: hideNames,
        errorOnConflict: true,
      );
    }
  }

  /// Resolves an import/export URI relative to its containing module.
  Uri _resolveUri(Uri importUri, Uri moduleUri) {
    if (importUri.isScheme('dart') || importUri.isScheme('package')) {
      return importUri;
    }
    return moduleUri.resolveUri(importUri);
  }

  /// Runs the interpreter visitor across declarations in the correct order.
  ///
  /// Order:
  /// 1. Enums (so const values referencing enums work)
  /// 2. Classes and mixins (so constructor bodies are populated)
  /// 3. Functions (so top-level function bodies are ready)
  /// 4. Extensions (so extension methods are available)
  /// 5. Top-level variables (may reference any of the above)
  void _interpretDeclarations(
    SCompilationUnit ast,
    InterpreterVisitor interpreter,
  ) {
    for (final decl in ast.declarations) {
      if (decl is SEnumDeclaration) decl.accept<Object?>(interpreter);
    }
    // Bug-43 / forward-class-reference FIX (mirrors D4rtRunner): defer
    // every class's static-field initializer evaluation until ALL class and
    // mixin members have been registered. Without this, a `static const`
    // list that uses a class defined later in source order fails with
    // "does not have an unnamed constructor that accepts arguments" because
    // the referenced class's constructors have not been populated yet.
    interpreter.deferStaticFieldInits = true;
    try {
      for (final decl in ast.declarations) {
        if (decl is SClassDeclaration || decl is SMixinDeclaration) {
          decl.accept<Object?>(interpreter);
        }
      }
    } finally {
      interpreter.deferStaticFieldInits = false;
    }
    interpreter.runDeferredStaticInitializers();
    for (final decl in ast.declarations) {
      if (decl is SFunctionDeclaration) decl.accept<Object?>(interpreter);
    }
    for (final decl in ast.declarations) {
      if (decl is SExtensionDeclaration) decl.accept<Object?>(interpreter);
    }
    // Cluster EXTTYPE: Extension type declarations (Dart 3.3+). Without
    // this pass the wrapper class is never registered for imported
    // modules — consumers see "Undefined variable" when invoking the
    // constructor.
    for (final decl in ast.declarations) {
      if (decl is SExtensionTypeDeclaration) {
        decl.accept<Object?>(interpreter);
      }
    }
    for (final decl in ast.declarations) {
      if (decl is STopLevelVariableDeclaration) {
        decl.accept<Object?>(interpreter);
      }
    }
  }
}
