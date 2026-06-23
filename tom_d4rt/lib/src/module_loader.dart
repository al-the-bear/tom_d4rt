import 'package:analyzer/dart/ast/ast.dart';
import 'package:tom_d4rt/d4rt.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/analysis/features.dart';
import 'package:tom_d4rt/src/stdlib/convert.dart';
import 'package:tom_d4rt/src/stdlib/isolate.dart';
import 'package:tom_d4rt/src/stdlib/math.dart';
import 'package:tom_d4rt/src/stdlib/collection.dart';
import 'package:tom_d4rt/src/stdlib/typed_data.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:analyzer/error/error.dart';
import 'package:tom_d4rt/src/stdlib/stdlib_io.dart'
    if (dart.library.html) 'package:tom_d4rt/src/stdlib/stdlib_web.dart';

// Represent an module of source code loaded and parsed.
class LoadedModule {
  final Uri uri; // The canonical URI of the module
  final CompilationUnit ast; // The AST of the module
  final Environment environment; // The environment of this module
  final Environment
      exportedEnvironment; // The environment of the exported symbols

  LoadedModule(this.uri, this.ast, this.environment, this.exportedEnvironment);
}

class ModuleLoader {
  final Environment globalEnvironment;
  final Map<String, String> sources;
  final Map<Uri, LoadedModule> _moduleCache = {};
  // Step #2 (import-optimization): URI-keyed registries — see the matching
  // fields on [D4rt] in d4rt_base.dart. Per-URI lookup is O(1); the inner map
  // is keyed by declaration name (unique per library). Extensions use a
  // per-URI List (nullable / duplicate unnamed names). Mirrors AstModuleLoader.
  final Map<String /*uri*/, Map<String /*name*/, LibraryEnum>>
      bridgedEnumDefinitions;
  final Map<String /*uri*/, Map<String /*name*/, LibraryClass>> bridgedClases;
  final D4rt? d4rt; // Reference to D4rt instance for permission checking
  Uri?
      currentlibrary; // Keep for the initial relative URI resolution in _fetchModuleSource and for relative imports

  // Library-scoped globals (registered with library path) - added when import is processed
  // LibraryFunction wrapper includes sourceUri for deduplication across re-exports
  final Map<String /*uri*/, Map<String /*name*/, LibraryFunction>>
      libraryFunctions;
  final Map<String /*uri*/, Map<String /*name*/, LibraryVariable>>
      libraryVariables;
  final Map<String /*uri*/, Map<String /*name*/, LibraryGetter>> libraryGetters;
  final Map<String /*uri*/, Map<String /*name*/, LibrarySetter>> librarySetters;
  final Map<String /*uri*/, List<LibraryExtension>> bridgedExtensions;

  // Track which globals have been registered and from which source library
  // Maps global name -> canonical source library URI (not import barrel URI)
  final Map<String, String> _registeredFunctions = {};
  final Map<String, String> _registeredVariables = {};
  final Map<String, String> _registeredGetters = {};
  final Map<String, String> _registeredSetters = {};
  // Track registered classes and enums by sourceUri for deduplication
  final Map<String, String> _registeredClasses = {};
  final Map<String, String> _registeredEnums = {};
  final Map<String, String> _registeredExtensions = {};

  // GEN-100 sync with tom_d4rt_ast: per-module environments for bridge isolation.
  // Each bridged library URI gets its own Environment containing only its bridges.
  // This prevents same-named classes from different modules (e.g. dart:ui.TextStyle
  // vs painting.TextStyle) from conflicting in globalEnvironment.
  final Map<String, Environment> _bridgedModuleEnvironments = {};

  // GEN-100 sync: per-stdlib isolated environments for non-ambient stdlib modules.
  // dart:core and dart:async stay in globalEnvironment (ambient/unconditional);
  // dart:math, dart:convert, dart:io etc. each get their own env.
  final Map<String, Environment> _stdlibEnvironments = {};

  /// When true, registration errors are collected instead of thrown.
  ///
  /// Use this with [accumulatedRegistrationErrors] to validate all bridge
  /// registrations in a single run without aborting on the first error.
  bool collectRegistrationErrors;

  /// Accumulated registration errors when [collectRegistrationErrors] is true.
  ///
  /// These errors are collected across all import processing rather than
  /// being thrown immediately. Check this list after [D4rt.execute] completes
  /// to see all registration issues at once.
  final List<String> accumulatedRegistrationErrors = [];

  /// Set of stdlib module paths that have been auto-loaded for extension
  /// on-type resolution. Prevents redundant loading and avoids re-registration
  /// warnings when a module is later explicitly imported.
  final Set<String> _autoLoadedStdlibs = {};

  ModuleLoader(this.globalEnvironment, this.sources,
      this.bridgedEnumDefinitions, this.bridgedClases,
      {this.d4rt,
      this.libraryFunctions = const {},
      this.libraryVariables = const {},
      this.libraryGetters = const {},
      this.librarySetters = const {},
      this.bridgedExtensions = const {},
      this.collectRegistrationErrors = false}) {
    Logger.debug(
        "[ModuleLoader] Initialized with ${sources.length} preloaded sources.");
  }

  /// Checks if the given URI requires special permissions and verifies they are granted.
  void _checkModulePermissions(Uri uri) {
    if (d4rt == null) return; // No permission checking if no D4rt instance

    final uriString = uri.toString();

    // Define dangerous modules that require permissions
    if (uriString == 'dart:io') {
      if (!d4rt!.checkPermission({'type': 'filesystem'})) {
        throw RuntimeD4rtException(
            'Access to dart:io requires FilesystemPermission. '
            'Use d4rt.grant(FilesystemPermission.any) to allow filesystem access.');
      }
    } else if (uriString == 'dart:isolate') {
      if (!d4rt!.checkPermission({'type': 'isolate'})) {
        throw RuntimeD4rtException(
            'Access to dart:isolate requires IsolatePermission. '
            'Use d4rt.grant(IsolatePermission.any) to allow isolate operations.');
      }
    }
    // Add more dangerous modules as needed
  }

  /// Checks if there are bridges registered for a specific URI.
  bool _hasBridgedContentForUri(String uriString) {
    return bridgedEnumDefinitions.containsKey(uriString) ||
        bridgedClases.containsKey(uriString) ||
        libraryFunctions.containsKey(uriString) ||
        libraryVariables.containsKey(uriString) ||
        libraryGetters.containsKey(uriString) ||
        librarySetters.containsKey(uriString) ||
        bridgedExtensions.containsKey(uriString);
  }

  // ===========================================================================
  // GEN-100: Per-module / per-stdlib environment loading
  // Mirrors AstModuleLoader._loadStdlibModule and _tryLoadBridgedModule.
  // ===========================================================================

  /// Known non-ambient stdlib modules and their registration functions.
  /// dart:core and dart:async are pre-registered into globalEnvironment and
  /// are NOT listed here (they stay ambient/unconditional).
  static final Map<String, void Function(Environment)> _stdlibRegistrars = {
    'math': MathStdlib.register,
    'convert': ConvertStdlib.register,
    'io': StdlibIo.register,
    'collection': CollectionStdlib.register,
    'typed_data': TypedDataStdlib.register,
    'isolate': IsolateStdlib.register,
  };

  /// Loads a `dart:*` stdlib module into an isolated per-stdlib [Environment].
  ///
  /// Returns `null` if the library has bridged content (caller falls through
  /// to [_tryLoadBridgedModule]) or is truly unsupported (caller throws).
  /// Returns a [LoadedModule] with the stdlib's isolated env otherwise.
  LoadedModule? _loadStdlibModule(Uri uri) {
    final libName = uri.path;
    final uriString = uri.toString();

    final registrar = _stdlibRegistrars[libName];
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
        // `_Random` from `math.Random()`) through an interpreted function.
        // The lexical name (e.g. `Random`) stays isolated in stdlibEnv —
        // only the type→bridge mapping is propagated.
        stdlibEnv.propagateBridgeTypesTo(globalEnvironment);
        _stdlibEnvironments[libName] = stdlibEnv;
        Logger.debug(
            '[ModuleLoader] GEN-100: Registered isolated stdlib dart:$libName');
      }
      final emptyAst = _parseSource(uri, '');
      final module = LoadedModule(uri, emptyAst, stdlibEnv, stdlibEnv);
      _moduleCache[uri] = module;
      return module;
    }

    // dart:core / dart:async are ambient — pre-registered into globalEnvironment.
    if (libName == 'core' || libName == 'async') {
      final emptyAst = _parseSource(uri, '');
      final module =
          LoadedModule(uri, emptyAst, globalEnvironment, globalEnvironment);
      _moduleCache[uri] = module;
      return module;
    }

    // Check if there are bridges for this dart: URI (e.g. dart:ui).
    if (_hasBridgedContentForUri(uriString)) {
      return null; // Let _tryLoadBridgedModule handle it.
    }

    // Truly unsupported dart: library.
    throw SourceCodeD4rtException(
        "Dart library '$uriString' not supported.", uriString);
  }

  /// Loads a bridged library URI into an isolated per-module [Environment].
  ///
  /// Creates the module env on first call; returns the cached env on
  /// subsequent calls. Merges re-exported bridged content via [_mergeReExports].
  LoadedModule _tryLoadBridgedModule(
      Uri uri, Set<String>? showNames, Set<String>? hideNames) {
    final uriString = uri.toString();

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
      _mergeReExports(
          uriString, moduleEnv, null, null, <String, Set<String>?>{});
      _bridgedModuleEnvironments[uriString] = moduleEnv;
      Logger.debug(
          '[ModuleLoader] GEN-100: Created per-module env for $uriString');
    }

    final emptyAst = _parseSource(uri, '');
    final module = LoadedModule(uri, emptyAst, moduleEnv, moduleEnv);
    _moduleCache[uri] = module;
    return module;
  }

  /// Registers all bridged definitions for [uriString] into [targetEnvironment].
  ///
  /// GEN-100 sync with [AstModuleLoader._registerBridgesForUriInto]:
  /// registers into a module-specific env instead of [globalEnvironment].
  /// Show/hide filters are applied at registration time.
  void _registerBridgesForUriInto(
    String uriString,
    Set<String>? showNames,
    Set<String>? hideNames,
    Environment targetEnvironment,
  ) {
    // Bridged enums
    for (final libEnum
        in bridgedEnumDefinitions[uriString]?.values ?? const <LibraryEnum>[]) {
      final name = libEnum.enumDefinition.name;
      if (!_shouldRegisterName(name,
          showNames: showNames, hideNames: hideNames)) {
        continue;
      }
      try {
        final bridgedEnum = libEnum.enumDefinition.buildBridgedEnum();
        targetEnvironment.defineBridgedEnum(bridgedEnum);
        Logger.debugLazy(() =>
            ' [ModuleLoader] GEN-100: Registered bridged enum: $name from $uriString');
      } catch (e) {
        Logger.error("registering bridged enum '$name' into module env: $e");
      }
    }

    // Bridged classes
    for (final libClass
        in bridgedClases[uriString]?.values ?? const <LibraryClass>[]) {
      final name = libClass.name;
      if (!_shouldRegisterName(name,
          showNames: showNames, hideNames: hideNames)) {
        continue;
      }
      try {
        // Step #17 — transfer the deferred thunk so the BridgedClass is only
        // built if the importing module actually resolves the class.
        targetEnvironment.defineBridgeLazy(
            libClass.name, libClass.nativeType, libClass.thunk);
        Logger.debugLazy(() =>
            ' [ModuleLoader] GEN-100: Registered bridged class: $name from $uriString');
      } catch (e) {
        Logger.error("registering bridged class '$name' into module env: $e");
      }
    }

    // GEN-078: class aliases (e.g. MaterialStateProperty → WidgetStateProperty)
    if (d4rt != null) {
      for (final alias in d4rt!.classAliases) {
        if (alias.library != uriString) continue;
        if (!_shouldRegisterName(alias.aliasName,
            showNames: showNames, hideNames: hideNames)) {
          continue;
        }
        try {
          targetEnvironment.defineBridgeAlias(
              alias.aliasName, alias.targetName);
          Logger.debugLazy(() =>
              ' [ModuleLoader] GEN-100: Registered alias: ${alias.aliasName} → ${alias.targetName} from $uriString');
        } catch (e) {
          Logger.error(
              "registering alias '${alias.aliasName}' into module env: $e");
        }
      }
      // GEN-079: function typedefs as BridgedClass(nativeType: Function)
      for (final typedef in d4rt!.functionTypedefs) {
        if (typedef.library != uriString) continue;
        if (!_shouldRegisterName(typedef.name,
            showNames: showNames, hideNames: hideNames)) {
          continue;
        }
        try {
          targetEnvironment.defineBridge(
              BridgedClass(nativeType: Function, name: typedef.name));
          Logger.debugLazy(() =>
              ' [ModuleLoader] GEN-100: Registered function typedef: ${typedef.name} from $uriString');
        } catch (e) {
          Logger.error(
              "registering function typedef '${typedef.name}' into module env: $e");
        }
      }
    }

    // Library functions
    for (final libFunc
        in libraryFunctions[uriString]?.values ?? const <LibraryFunction>[]) {
      final name = libFunc.function.name;
      if (name == '<native>') continue;
      if (!_shouldRegisterName(name,
          showNames: showNames, hideNames: hideNames)) {
        continue;
      }
      try {
        targetEnvironment.define(name, libFunc.function);
        Logger.debugLazy(() =>
            ' [ModuleLoader] GEN-100: Registered library function: $name from $uriString');
      } catch (e) {
        Logger.error(
            "registering library function '$name' into module env: $e");
      }
    }

    // Library variables
    for (final libVar
        in libraryVariables[uriString]?.values ?? const <LibraryVariable>[]) {
      if (!_shouldRegisterName(libVar.name,
          showNames: showNames, hideNames: hideNames)) {
        continue;
      }
      try {
        targetEnvironment.define(libVar.name, libVar.value);
        Logger.debugLazy(() =>
            ' [ModuleLoader] GEN-100: Registered library variable: ${libVar.name} from $uriString');
      } catch (e) {
        Logger.error(
            "registering library variable '${libVar.name}' into module env: $e");
      }
    }

    // Library getters + setters (paired)
    final settersByName = <String, LibrarySetter>{};
    for (final libSetter
        in librarySetters[uriString]?.values ?? const <LibrarySetter>[]) {
      settersByName[libSetter.name] = libSetter;
    }
    for (final libGetter
        in libraryGetters[uriString]?.values ?? const <LibraryGetter>[]) {
      if (!_shouldRegisterName(libGetter.name,
          showNames: showNames, hideNames: hideNames)) {
        continue;
      }
      final setter = settersByName.remove(libGetter.name);
      try {
        targetEnvironment.define(libGetter.name,
            GlobalGetter(libGetter.getter, setter: setter?.setter));
        Logger.debugLazy(() =>
            ' [ModuleLoader] GEN-100: Registered library getter: ${libGetter.name} from $uriString');
      } catch (e) {
        Logger.error(
            "registering library getter '${libGetter.name}' into module env: $e");
      }
    }
    // Remaining standalone setters
    for (final entry in settersByName.entries) {
      if (!_shouldRegisterName(entry.key,
          showNames: showNames, hideNames: hideNames)) {
        continue;
      }
      try {
        targetEnvironment.define(
            entry.key,
            GlobalGetter(
              () => throw RuntimeD4rtException(
                  'Property ${entry.key} is write-only'),
              setter: entry.value.setter,
            ));
      } catch (e) {
        Logger.error(
            "registering standalone setter '${entry.key}' into module env: $e");
      }
    }

    // Bridged extensions
    for (final libExt
        in bridgedExtensions[uriString] ?? const <LibraryExtension>[]) {
      final definition = libExt.extensionDefinition;
      final extName = definition.name ?? '<unnamed>';
      if (definition.name != null &&
          !_shouldRegisterName(definition.name!,
              showNames: showNames, hideNames: hideNames)) {
        continue;
      }
      try {
        RuntimeType? onType;
        try {
          final typeObj = targetEnvironment.get(definition.onTypeName);
          if (typeObj is RuntimeType) onType = typeObj;
        } on RuntimeD4rtException {
          onType = null;
        }
        onType ??= _resolveTypeForExtension(definition.onTypeName);
        if (onType == null) {
          Logger.warn(' [ModuleLoader] GEN-100: Could not resolve type '
              "'${definition.onTypeName}' for extension '$extName' from $uriString — skipping.");
          // GEN-056d FIX: surface the unresolved-onType case via the same
          // error-collection channel used by the legacy registration branch
          // at line ~1286 below. Previously this path silently dropped the
          // error, so `D4rt.validateRegistrations()` returned an empty list
          // even when an extension targeted an unknown type.
          if (collectRegistrationErrors) {
            accumulatedRegistrationErrors.add(
                "Could not resolve type '${definition.onTypeName}' for extension '$extName'.");
          }
          continue;
        }
        final interpretedExt = definition.buildInterpretedExtension(onType);
        targetEnvironment.addUnnamedExtension(interpretedExt);
        if (definition.name != null) {
          targetEnvironment.define(definition.name!, interpretedExt);
        }
        Logger.debugLazy(() =>
            ' [ModuleLoader] GEN-100: Registered extension "$extName" on '
            '${definition.onTypeName} from $uriString');
      } catch (e) {
        Logger.error("registering extension '$extName' into module env: $e");
      }
    }
  }

  /// GEN-100 sync: Merge re-exported libraries' bridged content into [moduleEnv].
  ///
  /// Replaces [_mergeReExportsGlobal]. Walks [d4rt.libraryReExports[sourceUri]]
  /// and registers each target's bridges into the source library's per-module
  /// environment. Recurses for transitive re-exports. [visited] guards cycles.
  void _mergeReExports(
    String sourceUri,
    Environment moduleEnv,
    Set<String>? outerShow,
    Set<String>? outerHide,
    Map<String, Set<String>?> visitedShows,
  ) {
    // GEN-100 FIX: Use a Map<uri → broadestShowSeen> instead of a simple
    // "ever visited" Set.  A permanent Set blocked legitimate re-processing:
    // material.dart reaches painting.dart via 100+ intermediate libs that
    // each carry their own show-filter.  The first arrival with a restrictive
    // filter (e.g. {Widget,...}) computed intersect({Widget}, {Color,...}) = {},
    // registering nothing from dart:ui.  The direct painting.dart path
    // (show=null, broader) was then blocked by the permanent mark and
    // Color/FontWeight stayed missing.
    //
    // With Map semantics:
    //   • visitedShows[uri] absent   → never visited, process now.
    //   • visitedShows[uri] = null   → already covered with show=null (all
    //                                   symbols); nothing new can arrive, skip.
    //   • visitedShows[uri] = prevSet → covered by prevSet so far; re-process
    //                                   only if outerShow brings new symbols
    //                                   (i.e. outerShow ⊄ prevSet).
    //
    // Because the call site now passes outerShow=null (see _tryLoadBridgedModule),
    // the very first call always reaches every URI with show=null, which sets
    // visitedShows[uri]=null and prevents any second visit — giving O(V+E)
    // traversal identical to the old permanent-Set approach, but correct.
    if (visitedShows.containsKey(sourceUri)) {
      final prevShow = visitedShows[sourceUri];
      if (prevShow == null) return; // null = all symbols already covered
      // outerShow=null means all symbols → definitely broader than prevShow
      if (outerShow != null && outerShow.difference(prevShow).isEmpty) return;
      // Expand prevShow to the union of prevShow and outerShow.
      if (outerShow == null) {
        visitedShows[sourceUri] = null;
      } else {
        prevShow.addAll(outerShow); // mutate in place
      }
    } else {
      visitedShows[sourceUri] = outerShow != null ? Set.of(outerShow) : null;
    }

    final reExports = d4rt?.libraryReExports[sourceUri];
    if (reExports == null || reExports.isEmpty) return;

    for (final re in reExports) {
      final effectiveShow = _intersectShow(outerShow, re.show);
      final effectiveHide = _unionHide(outerHide, re.hide);

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
        } on SourceCodeD4rtException {
          // Re-export of an unsupported dart: lib — ignore.
        }
      }

      _registerBridgesForUriInto(
          re.uri, effectiveShow, effectiveHide, moduleEnv);
      _mergeReExports(
          re.uri, moduleEnv, effectiveShow, effectiveHide, visitedShows);
    }
  }

  /// Intersection of two optional show-filters (null = show everything).
  Set<String>? _intersectShow(Set<String>? outer, Set<String>? inner) {
    if (outer == null) return inner;
    if (inner == null) return outer;
    return outer.intersection(inner);
  }

  /// Union of two optional hide-filters (null = hide nothing).
  Set<String>? _unionHide(Set<String>? outer, Set<String>? inner) {
    if (outer == null && inner == null) return null;
    return {...?outer, ...?inner};
  }

  LoadedModule loadModule(Uri uri,
      {Set<String>? showNames, Set<String>? hideNames}) {
    // Check permissions for dangerous modules
    _checkModulePermissions(uri);

    // Save the current source URI for resolving relative exports of this module
    Uri? previouslibraryForRecursiveLoad = currentlibrary;
    currentlibrary = uri;
    Logger.debug(
        "[ModuleLoader loadModule for $uri] Setting currentlibrary to: $uri (show: $showNames, hide: $hideNames)");

    if (_moduleCache.containsKey(uri)) {
      Logger.debug(
          "[ModuleLoader loadModule for $uri] Module '${uri.toString()}' found in cache.");
      // Restore the source URI before returning for parent calls
      currentlibrary = previouslibraryForRecursiveLoad;
      return _moduleCache[uri]!;
    }
    Logger.debug(
        "[ModuleLoader loadModule for $uri] Loading module: ${uri.toString()}");

    // GEN-100: Handle stdlib and bridged modules with per-module environments
    // BEFORE falling through to source-code parsing. This mirrors the
    // AstModuleLoader flow: stdlib → bridged → bundle source.
    if (uri.scheme == 'dart') {
      final stdlibModule = _loadStdlibModule(uri);
      if (stdlibModule != null) {
        currentlibrary = previouslibraryForRecursiveLoad;
        return stdlibModule;
      }
      // dart: URI with bridged content falls through to _tryLoadBridgedModule.
    }
    if (_hasBridgedContentForUri(uri.toString())) {
      final bridgedModule = _tryLoadBridgedModule(uri, showNames, hideNames);
      currentlibrary = previouslibraryForRecursiveLoad;
      return bridgedModule;
    }

    String sourceCode = _fetchModuleSource(uri,
        showNames: showNames,
        hideNames: hideNames); // Pass show/hide to filter bridged registrations
    CompilationUnit ast = _parseSource(uri, sourceCode);

    Environment moduleEnvironment = Environment(enclosing: globalEnvironment);

    // Bug-72 FIX: Process import directives BEFORE declarations
    // This ensures imported classes/mixins are available when class declarations are visited
    Logger.debug(
        "[ModuleLoader loadModule for $uri] Processing import directives first...");
    for (final directive in ast.directives) {
      if (directive is ImportDirective) {
        final importedUriString = directive.uri.stringValue;
        if (importedUriString == null) {
          Logger.warn(
              "[ModuleLoader loadModule for $uri] Import directive with null URI string in ${uri.toString()}");
          continue;
        }
        try {
          Uri resolvedImportUri = uri.resolve(
              importedUriString); // Resolve relative to the current module's URI
          Logger.debug(
              "[ModuleLoader loadModule for $uri]   Importing from ${uri.toString()}: URI '$importedUriString', resolved to '${resolvedImportUri.toString()}'");
          LoadedModule importedModule = loadModule(
              resolvedImportUri); // Recursive call - this will check permissions

          // Get the show/hide combinators and prefix
          Set<String>? showNames;
          Set<String>? hideNames;
          String? prefix = directive.prefix?.name;

          for (final combinator in directive.combinators) {
            if (combinator is ShowCombinator) {
              showNames ??= {};
              showNames.addAll(combinator.shownNames.map((id) => id.name));
              Logger.debug(
                  "[ModuleLoader loadModule for $uri]   Import combinator: show ${combinator.shownNames.map((id) => id.name).join(', ')}");
            } else if (combinator is HideCombinator) {
              hideNames ??= {};
              hideNames.addAll(combinator.hiddenNames.map((id) => id.name));
              Logger.debug(
                  "[ModuleLoader loadModule for $uri]   Import combinator: hide ${combinator.hiddenNames.map((id) => id.name).join(', ')}");
            }
          }

          // Import the environment of the imported module into the current module environment
          if (prefix != null) {
            // For prefixed imports, create a filtered environment and define it with the prefix
            Environment prefixedEnv =
                importedModule.exportedEnvironment.shallowCopyFiltered(
              showNames: showNames,
              hideNames: hideNames,
            );
            moduleEnvironment.definePrefixedImport(prefix, prefixedEnv);
            Logger.debug(
                "[ModuleLoader loadModule for $uri]   Successfully defined prefixed import '$prefix' from ${resolvedImportUri.toString()} into ${uri.toString()} (show: ${showNames?.join(", ")}, hide: ${hideNames?.join(", ")}).");
          } else {
            // For regular imports, import directly into the module environment
            moduleEnvironment.importEnvironment(
              importedModule.exportedEnvironment,
              show: showNames,
              hide: hideNames,
            );
            Logger.debug(
                "[ModuleLoader loadModule for $uri]   Successfully imported environment from ${resolvedImportUri.toString()} into ${uri.toString()} (show: ${showNames?.join(", ")}, hide: ${hideNames?.join(", ")}).");
          }
        } catch (e, s) {
          Logger.error(
              "[ModuleLoader loadModule for $uri] Error processing import directive for '$importedUriString' from ${uri.toString()}: $e\nStackTrace: $s");
          rethrow;
        }
      }
    }
    Logger.debug(
        "[ModuleLoader loadModule for $uri] Finished processing import directives.");

    DeclarationVisitor declarationVisitor =
        DeclarationVisitor(moduleEnvironment);
    // Only declarations are visited to populate the local environment
    for (var declaration in ast.declarations) {
      declaration.accept(declarationVisitor);
    }

    // Interpretation of top-level initializers
    // Create an InterpreterVisitor for this specific module.
    // It will use moduleEnvironment to resolve types and execute initializers.
    // The moduleLoader is passed for potentially resolved imports by initializers (less common).
    InterpreterVisitor moduleInterpreter = InterpreterVisitor(
        globalEnvironment:
            moduleEnvironment, // Important: use the module's local environment as base
        moduleLoader: this, // Pass the current loader
        initiallibrary: uri // The URI of the module being interpreted
        );

    Logger.debug(
        "[ModuleLoader loadModule for $uri] Executing InterpreterVisitor pass for initializers...");

    // First, process enum declarations to populate enum values
    // This must happen before top-level variable declarations in case
    // const variables reference enum values
    for (final declaration in ast.declarations) {
      if (declaration is EnumDeclaration) {
        declaration.accept(moduleInterpreter);
      }
    }

    // Process class and mixin declarations to populate their members (methods, constructors, etc.)
    // The DeclarationVisitor only creates placeholders with empty constructor maps.
    // Bug-59: Without this, imported classes have no constructors available!
    //
    // Bug-43 / forward-class-reference FIX (mirrors d4rt_base.dart and
    // tom_d4rt_ast/ast_module_loader.dart): defer every class's
    // static-field initializer block until ALL class/mixin members have
    // been registered, so a `static const` in class A can reference
    // class B even when B is declared later in source.
    moduleInterpreter.deferStaticFieldInits = true;
    try {
      for (final declaration in ast.declarations) {
        if (declaration is ClassDeclaration ||
            declaration is MixinDeclaration) {
          declaration.accept(moduleInterpreter);
        }
      }
    } finally {
      moduleInterpreter.deferStaticFieldInits = false;
    }
    moduleInterpreter.runDeferredStaticInitializers();

    // Process function declarations to populate interpreted functions properly
    for (final declaration in ast.declarations) {
      if (declaration is FunctionDeclaration) {
        declaration.accept(moduleInterpreter);
      }
    }

    // Bug-91: Process extension declarations to populate extension methods
    // Extensions need to be processed by the interpreter to be available for imported modules
    for (final declaration in ast.declarations) {
      if (declaration is ExtensionDeclaration) {
        declaration.accept(moduleInterpreter);
      }
    }

    // Cluster EXTTYPE: Process extension type declarations (Dart 3.3+) so
    // the wrapper class is registered for imported modules — otherwise
    // consumers see "Undefined variable" when invoking the constructor.
    for (final declaration in ast.declarations) {
      if (declaration is ExtensionTypeDeclaration) {
        declaration.accept(moduleInterpreter);
      }
    }

    // Then process top-level variable declarations
    for (final declaration in ast.declarations) {
      // We only care about the evaluation of TopLevelVariableDeclaration for their initializers.
      if (declaration is TopLevelVariableDeclaration) {
        declaration.accept(moduleInterpreter);
      }
    }
    Logger.debug(
        "[ModuleLoader loadModule for $uri] Finished InterpreterVisitor pass for initializers.");

    // PREPARATION OF THE EXPORTED ENVIRONMENT
    Environment exportedEnvironment = Environment(
        enclosing: globalEnvironment); // Must also enclose globalEnvironment
    // Now, moduleEnvironment should contain the variables with their initialized values.
    exportedEnvironment.importEnvironment(moduleEnvironment);
    Logger.debug(
        "[ModuleLoader loadModule for $uri] Initialized exportedEnvironment with local declarations (post-initialization).");

    // Process the export directives of this module to populate its exportedEnvironment
    // Must be done before caching to avoid recursion problems if A exports B and B exports A.
    // The cache is checked at the beginning of the function.
    Logger.debug(
        "[ModuleLoader loadModule for $uri] Processing export directives for ${uri.toString()}...");
    for (final directive in ast.directives) {
      if (directive is ExportDirective) {
        final exportedUriString = directive.uri.stringValue;
        if (exportedUriString == null) {
          Logger.warn(
              "[ModuleLoader loadModule for $uri] Export directive with null URI string in ${uri.toString()}");
          continue;
        }
        try {
          Uri resolvedExportUri = uri.resolve(
              exportedUriString); // Resolve relative to the current module's URI
          Logger.debug(
              "[ModuleLoader loadModule for $uri]   Exporting from ${uri.toString()}: URI '$exportedUriString', resolved to '${resolvedExportUri.toString()}'");
          LoadedModule subModule =
              loadModule(resolvedExportUri); // Recursive call

          // Get the show/hide combinators
          Set<String>? showNames;
          Set<String>? hideNames;

          for (final combinator in directive.combinators) {
            if (combinator is ShowCombinator) {
              showNames ??= {}; // Initialize if it's the first show combinator
              showNames.addAll(
                  combinator.shownNames.map((id) => id.name)); // Use id.name
              Logger.debug(
                  "[ModuleLoader loadModule for $uri]   Export combinator: show ${combinator.shownNames.map((id) => id.name).join(', ')}");
            } else if (combinator is HideCombinator) {
              hideNames ??= {}; // Initialize if it's the first hide combinator
              hideNames.addAll(
                  combinator.hiddenNames.map((id) => id.name)); // Use id.name
              Logger.debug(
                  "[ModuleLoader loadModule for $uri]   Export combinator: hide ${combinator.hiddenNames.map((id) => id.name).join(', ')}");
            }
          }

          // Import the environment of the sub-module by applying the show/hide filters.
          // Cluster EXPORT (I-MISC-40/41): pass errorOnConflict: true so that a
          // library that re-publishes two different definitions of the same
          // name (local vs re-export, or two re-exports) raises immediately
          // instead of silently overwriting.
          exportedEnvironment.importEnvironment(
            subModule.exportedEnvironment,
            show: showNames,
            hide: hideNames,
            errorOnConflict: true,
          );
          Logger.debug(
              "[ModuleLoader loadModule for $uri]   Successfully merged exported environment from ${resolvedExportUri.toString()} into ${uri.toString()} (show: ${showNames?.join(", ")}, hide: ${hideNames?.join(", ")}).");
        } catch (e, s) {
          Logger.error(
              "[ModuleLoader loadModule for $uri] Error processing export directive for '$exportedUriString' from ${uri.toString()}: $e\nStackTrace: $s");
          rethrow;
        }
      }
      // Note: ImportDirective is now processed earlier, before declarations
    }
    Logger.debug(
        "[ModuleLoader loadModule for $uri] Finished processing export directives for ${uri.toString()}.");

    try {
      final testGetSymbol = moduleEnvironment.get('getMessage');
      Logger.debug(
          "[ModuleLoader loadModule for $uri] Test get 'getMessage' from module env for $uri: SUCCESS, value: ${testGetSymbol?.runtimeType}");
    } catch (e) {
      // Silently ignore if not found
    }

    final loadedModule =
        LoadedModule(uri, ast, moduleEnvironment, exportedEnvironment);
    _moduleCache[uri] = loadedModule;
    Logger.debug(
        "[ModuleLoader loadModule for $uri] Module '${uri.toString()}' chargé et mis en cache.");

    // Restore the source URI before returning
    currentlibrary = previouslibraryForRecursiveLoad;
    Logger.debug(
        "[ModuleLoader loadModule for $uri] Restored currentlibrary to: $currentlibrary");
    return loadedModule;
  }

  /// Helper to check if a name should be registered based on show/hide filters.
  bool _shouldRegisterName(String name,
      {Set<String>? showNames, Set<String>? hideNames}) {
    // If hideNames is specified and contains this name, skip it
    if (hideNames != null && hideNames.contains(name)) {
      return false;
    }
    // If showNames is specified, only include if the name is in the list
    if (showNames != null && !showNames.contains(name)) {
      return false;
    }
    return true;
  }

  String _fetchModuleSource(Uri uri,
      {Set<String>? showNames,
      Set<String>? hideNames,
      Set<String>? reExportVisited}) {
    final uriString = uri.toString();
    Logger.debug(
        "[ModuleLoader] Récupération de la source pour: $uriString depuis sources. (show: $showNames, hide: $hideNames)");

    // First check if the exact URI is in the preloaded sources
    if (sources.containsKey(uriString)) {
      Logger.debug("[ModuleLoader] Source found for $uriString in sources.");
      return sources[uriString]!;
    }

    // Then handle the known Dart libraries provided by Stdlib
    if (uri.scheme == 'dart') {
      final knownStdlibDartLibs = [
        'core',
        'math',
        'async',
        'convert',
        'io',
        'collection',
        'typed_data',
        'isolate'
      ];
      if (knownStdlibDartLibs.contains(uri.path)) {
        if (uri.path == 'convert') {
          ConvertStdlib.register(globalEnvironment);
          return '';
        }
        if (uri.path == 'math') {
          MathStdlib.register(globalEnvironment);
          return '';
        }
        if (uri.path == 'io') {
          StdlibIo.register(globalEnvironment);
          return '';
        }
        if (uri.path == 'collection') {
          CollectionStdlib.register(globalEnvironment);
          return '';
        }
        if (uri.path == 'typed_data') {
          TypedDataStdlib.register(globalEnvironment);
          return '';
        }
        if (uri.path == 'isolate') {
          IsolateStdlib.register(globalEnvironment);
          return '';
        }
        Logger.info(
            "[ModuleLoader] The Dart library '${uri.toString()}' is provided natively by Stdlib. Returning an empty module.");
        return ""; // Empty source to allow the import to succeed
      } else {
        // Not a known stdlib - check if there are bridges for this dart: URI
        if (_hasBridgedContentForUri(uriString)) {
          Logger.info(
              "[ModuleLoader] Dart library '${uri.toString()}' has bridged content, falling through to bridge registration.");
          // Fall through to bridged content handling below
        } else {
          Logger.error(
              "[ModuleLoader] Dart library '${uri.toString()}' not supported or recognized by Stdlib.");
          throw SourceCodeD4rtException(
              "Dart library '${uri.toString()}' not supported.");
        }
      }
    }
    // Check if this URI has any bridged types or library-scoped globals registered
    final hasBridgedContent = bridgedClases.isNotEmpty ||
        bridgedEnumDefinitions.isNotEmpty ||
        libraryFunctions.isNotEmpty ||
        libraryVariables.isNotEmpty ||
        libraryGetters.isNotEmpty ||
        librarySetters.isNotEmpty ||
        bridgedExtensions.isNotEmpty;

    if (hasBridgedContent) {
      // Track if this specific URI has any content registered
      bool hasContentForUri = false;
      final registrationErrors = <String>[];

      for (final libEnum in bridgedEnumDefinitions[uriString]?.values ??
          const <LibraryEnum>[]) {
        hasContentForUri = true;
        final definition = libEnum.enumDefinition;
        final enumName = definition.name;

        // Check show/hide filters
        if (!_shouldRegisterName(enumName,
            showNames: showNames, hideNames: hideNames)) {
          Logger.debugLazy(() =>
              " [execute] Skipping enum '$enumName' due to show/hide filter");
          continue;
        }

        // Use sourceUri for deduplication if available, otherwise fall back to import URI
        final sourceUri = libEnum.sourceUri ?? uriString;

        if (_registeredEnums.containsKey(enumName)) {
          final existingSourceUri = _registeredEnums[enumName]!;
          if (existingSourceUri == sourceUri) {
            // Same enum from same canonical source - silently skip (re-export case)
            Logger.debugLazy(() =>
                " [execute] Skipping duplicate enum '$enumName' from same source: $sourceUri");
            continue;
          } else {
            // Different source - this is an actual duplicate, error
            registrationErrors.add(
                "Duplicate enum '$enumName' exists from source '$existingSourceUri' and source '$sourceUri'. "
                "These are different enums with the same name.");
            continue;
          }
        }

        _registeredEnums[enumName] = sourceUri;

        try {
          final bridgedEnum = definition.buildBridgedEnum();
          globalEnvironment.defineBridgedEnum(bridgedEnum);
          Logger.debugLazy(() =>
              " [execute] Registered bridged enum: $enumName from $sourceUri");
        } catch (e) {
          Logger.error("registering bridged enum '$enumName': $e");
          registrationErrors
              .add("Failed to register bridged enum '$enumName': $e");
        }
      }

      for (final libClass
          in bridgedClases[uriString]?.values ?? const <LibraryClass>[]) {
        hasContentForUri = true;
        final className = libClass.name;

        // Check show/hide filters
        if (!_shouldRegisterName(className,
            showNames: showNames, hideNames: hideNames)) {
          Logger.debugLazy(() =>
              " [execute] Skipping class '$className' due to show/hide filter");
          continue;
        }

        // Use sourceUri for deduplication if available, otherwise fall back to import URI
        final sourceUri = libClass.sourceUri ?? uriString;

        if (_registeredClasses.containsKey(className)) {
          final existingSourceUri = _registeredClasses[className]!;
          if (existingSourceUri == sourceUri) {
            // Same class from same canonical source - silently skip (re-export case)
            Logger.debugLazy(() =>
                " [execute] Skipping duplicate class '$className' from same source: $sourceUri");
            continue;
          }
          // B2 MarkdownParser clash: two different libraries declare a
          // same-name bridge. Do NOT error — register this one too. The
          // import wins as the primary; defineBridge records the displaced
          // sibling as a shadow so static/constructor lookups can fall back
          // to whichever bridge actually declares the requested member.
          // Matches the tolerant per-module behaviour of the GEN-100 path.
          Logger.debugLazy(() =>
              " [execute] Same-name class '$className' from a different "
              "source ($existingSourceUri vs $sourceUri); registering both "
              "with shadow fallback.");
        }

        _registeredClasses[className] = sourceUri;

        try {
          // Step #17 — transfer the deferred thunk (build on first resolve).
          globalEnvironment.defineBridgeLazy(
              libClass.name, libClass.nativeType, libClass.thunk);
          Logger.debugLazy(() =>
              " [execute] Registered bridged class: $className from $sourceUri");
        } catch (e) {
          Logger.error("registering bridged class '$className': $e");
          registrationErrors
              .add("Failed to register bridged class '$className': $e");
        }
      }

      // Register library-scoped functions for this import
      for (final libFunc
          in libraryFunctions[uriString]?.values ?? const <LibraryFunction>[]) {
        hasContentForUri = true;
        final nativeFunc = libFunc.function;
        final funcName = nativeFunc.name;

        // Check show/hide filters first
        if (!_shouldRegisterName(funcName,
            showNames: showNames, hideNames: hideNames)) {
          Logger.debugLazy(() =>
              " [execute] Skipping function '$funcName' due to show/hide filter");
          continue;
        }

        // Use sourceUri for deduplication if available, otherwise fall back to import URI
        final sourceUri = libFunc.sourceUri ?? uriString;

        // Check for duplicate registration
        if (_registeredFunctions.containsKey(funcName)) {
          final existingSourceUri = _registeredFunctions[funcName]!;
          if (existingSourceUri == sourceUri) {
            // Same function from same canonical source - silently skip (re-export case)
            Logger.debugLazy(() =>
                " [execute] Skipping duplicate function '$funcName' from same source: $sourceUri");
            continue;
          } else {
            // Different source - this is an actual duplicate, error
            registrationErrors.add(
                "Duplicate function '$funcName' exists from source '$existingSourceUri' and source '$sourceUri'. "
                "Use import show/hide clauses to resolve the conflict.");
            continue;
          }
        }

        try {
          globalEnvironment.define(funcName, nativeFunc);
          _registeredFunctions[funcName] = sourceUri;
          Logger.debugLazy(() =>
              " [execute] Registered library function: $funcName from $sourceUri");
        } catch (e) {
          Logger.error("registering library function '$funcName': $e");
          registrationErrors.add("Failed to register function '$funcName': $e");
        }
      }

      // Register library-scoped variables for this import
      for (final libVar
          in libraryVariables[uriString]?.values ?? const <LibraryVariable>[]) {
        hasContentForUri = true;
        final varName = libVar.name;

        // Check show/hide filters first
        if (!_shouldRegisterName(varName,
            showNames: showNames, hideNames: hideNames)) {
          Logger.debugLazy(() =>
              " [execute] Skipping variable '$varName' due to show/hide filter");
          continue;
        }

        // Use sourceUri for deduplication if available, otherwise fall back to import URI
        final sourceUri = libVar.sourceUri ?? uriString;

        // Check for duplicate registration
        if (_registeredVariables.containsKey(varName)) {
          final existingSourceUri = _registeredVariables[varName]!;
          if (existingSourceUri == sourceUri) {
            // Same variable from same canonical source - silently skip (re-export case)
            Logger.debugLazy(() =>
                " [execute] Skipping duplicate variable '$varName' from same source: $sourceUri");
            continue;
          } else {
            // Different source - this is an actual duplicate, error
            registrationErrors.add(
                "Duplicate variable '$varName' exists from source '$existingSourceUri' and source '$sourceUri'. "
                "Use import show/hide clauses to resolve the conflict.");
            continue;
          }
        }

        try {
          globalEnvironment.define(varName, libVar.value);
          _registeredVariables[varName] = sourceUri;
          Logger.debugLazy(() =>
              " [execute] Registered library variable: $varName from $sourceUri");
        } catch (e) {
          Logger.error("registering library variable '$varName': $e");
          registrationErrors.add("Failed to register variable '$varName': $e");
        }
      }

      // Register library-scoped getters for this import
      for (final libGetter
          in libraryGetters[uriString]?.values ?? const <LibraryGetter>[]) {
        hasContentForUri = true;
        final getterName = libGetter.name;

        // Check show/hide filters first
        if (!_shouldRegisterName(getterName,
            showNames: showNames, hideNames: hideNames)) {
          Logger.debugLazy(() =>
              " [execute] Skipping getter '$getterName' due to show/hide filter");
          continue;
        }

        // Use sourceUri for deduplication if available, otherwise fall back to import URI
        final sourceUri = libGetter.sourceUri ?? uriString;

        // Check for duplicate registration
        if (_registeredGetters.containsKey(getterName)) {
          final existingSourceUri = _registeredGetters[getterName]!;
          if (existingSourceUri == sourceUri) {
            // Same getter from same canonical source - silently skip (re-export case)
            Logger.debugLazy(() =>
                " [execute] Skipping duplicate getter '$getterName' from same source: $sourceUri");
            continue;
          } else {
            // Different source - this is an actual duplicate, error
            registrationErrors.add(
                "Duplicate getter '$getterName' exists from source '$existingSourceUri' and source '$sourceUri'. "
                "Use import show/hide clauses to resolve the conflict.");
            continue;
          }
        }

        try {
          globalEnvironment.define(getterName, GlobalGetter(libGetter.getter));
          _registeredGetters[getterName] = sourceUri;
          Logger.debugLazy(() =>
              " [execute] Registered library getter: $getterName from $sourceUri");
        } catch (e) {
          Logger.error("registering library getter '$getterName': $e");
          registrationErrors.add("Failed to register getter '$getterName': $e");
        }
      }

      // Register library-scoped setters for this import
      // Setters update existing GlobalGetters to include setter support
      for (final libSetter
          in librarySetters[uriString]?.values ?? const <LibrarySetter>[]) {
        hasContentForUri = true;
        final setterName = libSetter.name;

        // Check show/hide filters first
        if (!_shouldRegisterName(setterName,
            showNames: showNames, hideNames: hideNames)) {
          Logger.debugLazy(() =>
              " [execute] Skipping setter '$setterName' due to show/hide filter");
          continue;
        }

        // Use sourceUri for deduplication if available, otherwise fall back to import URI
        final sourceUri = libSetter.sourceUri ?? uriString;

        // Check for duplicate registration
        if (_registeredSetters.containsKey(setterName)) {
          final existingSourceUri = _registeredSetters[setterName]!;
          if (existingSourceUri == sourceUri) {
            // Same setter from same canonical source - silently skip (re-export case)
            Logger.debugLazy(() =>
                " [execute] Skipping duplicate setter '$setterName' from same source: $sourceUri");
            continue;
          } else {
            // Different source - this is an actual duplicate, error
            registrationErrors.add(
                "Duplicate setter '$setterName' exists from source '$existingSourceUri' and source '$sourceUri'. "
                "Use import show/hide clauses to resolve the conflict.");
            continue;
          }
        }

        try {
          // Find the corresponding getter and update it to include the setter
          final existingValue =
              globalEnvironment.getRawValueIfDefined(setterName);
          if (existingValue is GlobalGetter) {
            // Replace GlobalGetter with one that includes the setter
            globalEnvironment.define(
                setterName,
                GlobalGetter(
                  existingValue.getter,
                  setter: libSetter.setter,
                ));
            Logger.debugLazy(() =>
                " [execute] Added setter to existing getter: $setterName from $sourceUri");
          } else {
            // No getter yet - create a GlobalGetter that only has a setter
            // This allows assignment to work, but reading will return null
            Logger.warn(
                " [execute] Setter '$setterName' registered without corresponding getter");
            globalEnvironment.define(
                setterName,
                GlobalGetter(
                  () => null, // No getter - reading returns null
                  setter: libSetter.setter,
                ));
          }
          _registeredSetters[setterName] = sourceUri;
          Logger.debugLazy(() =>
              " [execute] Registered library setter: $setterName from $sourceUri");
        } catch (e) {
          Logger.error("registering library setter '$setterName': $e");
          registrationErrors.add("Failed to register setter '$setterName': $e");
        }
      }

      // Register bridged extensions for this import
      for (final libExt
          in bridgedExtensions[uriString] ?? const <LibraryExtension>[]) {
        hasContentForUri = true;
        final definition = libExt.extensionDefinition;
        final extName = definition.name ?? '<unnamed>';

        // Named extensions are subject to show/hide filters;
        // unnamed extensions are always registered since they cannot be hidden by name.
        if (definition.name != null &&
            !_shouldRegisterName(definition.name!,
                showNames: showNames, hideNames: hideNames)) {
          Logger.debugLazy(() =>
              " [execute] Skipping extension '$extName' due to show/hide filter");
          continue;
        }

        // Use sourceUri for deduplication if available, otherwise fall back to import URI
        final sourceUri = libExt.sourceUri ?? uriString;

        // Use a deduplication key that combines name + onType to allow
        // extensions with different target types but same name.
        final deduplicationKey = '$extName@${definition.onTypeName}';

        if (_registeredExtensions.containsKey(deduplicationKey)) {
          final existingSourceUri = _registeredExtensions[deduplicationKey]!;
          if (existingSourceUri == sourceUri) {
            Logger.debugLazy(() =>
                " [execute] Skipping duplicate extension '$extName on ${definition.onTypeName}' from same source: $sourceUri");
            continue;
          } else {
            registrationErrors.add(
                "Duplicate extension '$extName on ${definition.onTypeName}' exists from source '$existingSourceUri' and source '$sourceUri'.");
            continue;
          }
        }

        _registeredExtensions[deduplicationKey] = sourceUri;

        try {
          // Resolve the onType from the environment
          RuntimeType? onType;
          try {
            final typeObj = globalEnvironment.get(definition.onTypeName);
            if (typeObj is RuntimeType) {
              onType = typeObj;
            }
          } on RuntimeD4rtException {
            // Type not found yet — try fallbacks
          }

          // GEN-056 FIX: If the type isn't found in the environment, try
          // resolving it from registered bridge classes and stdlib modules.
          // This handles cases where a bridge extension targets a type from
          // a different package or stdlib (e.g., PlatformEx on Platform from
          // dart:io) that hasn't been explicitly imported by the script.
          onType ??= _resolveTypeForExtension(definition.onTypeName);

          if (onType == null) {
            Logger.warn(
                " [execute] Could not resolve type '${definition.onTypeName}' for extension '$extName'. "
                "Extension will not be registered.");
            registrationErrors.add(
                "Could not resolve type '${definition.onTypeName}' for extension '$extName'.");
            continue;
          }

          final interpretedExt = definition.buildInterpretedExtension(onType);

          // Named extensions are defined by name; unnamed are added as unnamed extensions
          if (definition.name != null) {
            globalEnvironment.define(definition.name!, interpretedExt);
            Logger.debugLazy(() =>
                " [execute] Registered named bridged extension: ${definition.name} on ${definition.onTypeName} from $sourceUri");
          } else {
            globalEnvironment.addUnnamedExtension(interpretedExt);
            Logger.debugLazy(() =>
                " [execute] Registered unnamed bridged extension on ${definition.onTypeName} from $sourceUri");
          }
        } catch (e) {
          Logger.error("registering bridged extension '$extName': $e");
          registrationErrors.add("Failed to register extension '$extName': $e");
        }
      }

      if (registrationErrors.isNotEmpty) {
        if (collectRegistrationErrors) {
          // Accumulate errors instead of throwing — allows collecting all errors
          accumulatedRegistrationErrors.addAll(registrationErrors);
        } else {
          final errorList = registrationErrors.map((e) => '- $e').join('\n');
          throw RuntimeD4rtException(
              'Errors during bridge registration:\n$errorList');
        }
      }

      // If this URI had bridged content, return empty source
      if (hasContentForUri) {
        // GEN-107: Also load any libraries that this URI re-exports.
        // This mirrors what ast_module_loader._mergeReExports does for the
        // AST-based pipeline: walks d4rt.libraryReExports[uriString] and
        // recursively calls _fetchModuleSource for every re-exported target
        // that has bridged content, so that a script which only imports
        // 'package:flutter/material.dart' still gets Widget (from
        // 'package:flutter/widgets.dart') in its globalEnvironment.
        // Thread reExportVisited so the caller's traversal cycle-set is shared,
        // preventing exponential re-traversal when _fetchModuleSource is called
        // from inside _mergeReExportsGlobal (which would otherwise start a fresh
        // empty-set traversal for every bridge URI it encounters).
        _mergeReExportsGlobal(uriString, reExportVisited ?? <String>{});
        return '';
      }
    }

    // If it's neither explicitly preloaded nor a known Dart library, it's an error.
    Logger.error(
        "[ModuleLoader] Source not preloaded and not a recognized Dart standard library for URI: $uriString");
    throw SourceCodeD4rtException(
        "Module source not preloaded for URI: $uriString, and not a recognized Dart standard library.",
        uriString);
  }

  /// GEN-056 FIX: Resolve a RuntimeType for an extension's on-type by
  /// searching registered bridge classes and auto-loading stdlib modules.
  ///
  /// This handles cases where:
  /// 1. An extension targets a type from another bridge package that may
  ///    already be registered (e.g., MyClassExt on MyClass from pkg_a)
  /// 2. An extension targets a stdlib type (e.g., PlatformEx on Platform
  ///    from dart:io) that hasn't been explicitly imported by the script
  ///
  /// Returns the RuntimeType if found, or null if the type cannot be resolved.
  RuntimeType? _resolveTypeForExtension(String typeName) {
    // Fallback 1: Search all registered BridgedClass definitions.
    // These are bridge classes registered with the interpreter (via
    // registerBridgedClass) that may not yet be loaded into the environment.
    for (final classMap in bridgedClases.values) {
      for (final libClass in classMap.values) {
        // Step #17 — compare by name without forcing a build; only the matched
        // class is materialized (it is genuinely being resolved here).
        if (libClass.name == typeName) {
          // Register the class in globalEnvironment so it's available
          // for extension type matching
          globalEnvironment.defineBridgeLazy(
              libClass.name, libClass.nativeType, libClass.thunk);
          Logger.debug(
              "[ModuleLoader] Resolved extension on-type '$typeName' from registered bridge class");
          return libClass.bridgedClass;
        }
      }
    }

    // Fallback 2: Try auto-loading known stdlib modules.
    // Bridge packages may depend on stdlib types (e.g., DCli uses Platform
    // from dart:io). In real Dart, these would be transitively available.
    // We auto-load stdlib modules to find the type.
    final stdlibRegistrars = <String, void Function()>{
      'io': () => StdlibIo.register(globalEnvironment),
      'math': () => MathStdlib.register(globalEnvironment),
      'convert': () => ConvertStdlib.register(globalEnvironment),
      'collection': () => CollectionStdlib.register(globalEnvironment),
      'typed_data': () => TypedDataStdlib.register(globalEnvironment),
    };

    for (final entry in stdlibRegistrars.entries) {
      if (_autoLoadedStdlibs.contains(entry.key)) continue;

      // Load the stdlib module
      entry.value();
      _autoLoadedStdlibs.add(entry.key);

      // Check if the type is now available
      try {
        final typeObj = globalEnvironment.get(typeName);
        if (typeObj is RuntimeType) {
          Logger.debug(
              "[ModuleLoader] Auto-loaded stdlib '${entry.key}' to resolve extension on-type '$typeName'");
          return typeObj;
        }
      } on RuntimeD4rtException {
        // Not in this module, try next
      }
    }

    return null; // Type not found anywhere
  }

  CompilationUnit _parseSource(Uri uri, String sourceCode) {
    Logger.debug("[ModuleLoader] Parsing source for module: ${uri.toString()}");
    // Ensure the path passed to parseString is meaningful for errors.
    // If the URI is opaque (ex: custom scheme), toFilePath may fail.
    // Use uri.path or uri.toString() as a fallback.
    String pathToReport =
        uri.isScheme('file') ? uri.toFilePath() : uri.toString();

    final result = parseString(
      content: sourceCode,
      throwIfDiagnostics: false,
      path: pathToReport,
      featureSet: FeatureSet.fromEnableFlags2(
        sdkLanguageVersion: Version(
            3, 10, 0), // Dart 3.6 for digit-separators and null-aware-elements
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
      final errorMessages = errors.map((e) {
        final location = result.lineInfo.getLocation(e.offset);
        return "- ${e.message} (ligne ${location.lineNumber}, colonne ${location.columnNumber})";
      }).join("\\n");
      Logger.error(
          "[ModuleLoader] Parsing errors for $pathToReport:\n$errorMessages");
      throw SourceCodeD4rtException(
          "Parsing errors in module $pathToReport:\n$errorMessages",
          sourceCode);
    }
    Logger.debug(
        "[ModuleLoader] Module ${uri.toString()} parsed successfully.");
    return result.unit;
  }

  // ---------------------------------------------------------------------------
  // GEN-107: Re-export merging for the source-based interpreter.
  //
  // When a bridged module is loaded, Dart's `export` semantics mean that
  // symbols visible through re-exported libraries must also be available to
  // scripts that import the re-exporting barrel. For example, a script that
  // writes `import 'package:flutter/material.dart'` expects `Widget` to be
  // in scope even though `Widget`'s bridge is registered under
  // `package:flutter/widgets.dart`.
  //
  // The generator (GEN-107 Phase 2) already records re-export edges in
  // `D4rt.libraryReExports` via `registerBridges → registerLibraryReExport`.
  // _mergeReExportsGlobal walks that map and loads bridges for every
  // transitively re-exported URI into `globalEnvironment`, mirroring what
  // `AstModuleLoader._mergeReExports` does for the AST-based pipeline.
  // ---------------------------------------------------------------------------

  /// GEN-107: Load bridges for all libraries re-exported by [sourceUri] into
  /// [globalEnvironment], respecting per-edge show/hide filters.
  ///
  /// The cycle guard is placed on [sourceUri] at the top of the method so
  /// that the same *source* file is never processed twice, but the same
  /// *target* URI can still be reached via multiple re-export paths, each
  /// with its own show/hide clause.  This is required because a single
  /// target (e.g. `dart:ui`) is commonly re-exported by several source
  /// files with disjoint name sets:
  ///
  ///   painting.dart → dart:ui  show:{PlaceholderAlignment,...}
  ///   src/painting/basic_types.dart → dart:ui  show:{Offset,Color,...}
  ///
  /// Both paths must be followed; the per-edge show/hide filters ensure only
  /// the names each source actually exposes are registered, preventing
  /// duplicate-sourceUri conflicts in [_fetchModuleSource]'s dedup maps.
  ///
  /// The recursive call to [_mergeReExportsGlobal] is made unconditionally for
  /// every re-export edge so that transitive re-exports are followed even when
  /// a URI has no direct bridge content of its own.
  ///
  /// [visited] prevents infinite recursion on cyclic re-export graphs.
  /// Callers should pass an empty set; this method adds [sourceUri] itself.
  void _mergeReExportsGlobal(String sourceUri, Set<String> visited) {
    if (d4rt == null) return;
    // Cycle guard on SOURCE URI — prevents reprocessing the same source file.
    // Do NOT guard on the target (re.uri): different sources pointing to the
    // same target with different show/hide sets must each be processed.
    if (!visited.add(sourceUri)) return;

    final reExports = d4rt!.libraryReExports[sourceUri];
    if (reExports == null || reExports.isEmpty) return;

    for (final re in reExports) {
      final targetUri = Uri.parse(re.uri);

      if (targetUri.scheme == 'dart') {
        // dart: re-exports — delegate to _fetchModuleSource which handles
        // stdlib and bridged dart: URIs. Ignore unknown dart: libraries.
        try {
          _fetchModuleSource(targetUri,
              showNames: re.show, hideNames: re.hide, reExportVisited: visited);
        } on SourceCodeD4rtException {
          // Unknown dart: library in a re-export — not a user error, skip.
        }
      } else if (_hasBridgedContentForUri(re.uri)) {
        // package: URI with registered bridges — load with show/hide applied.
        // _fetchModuleSource dedup maps prevent double-registration of names
        // from the same canonical sourceUri.  Pass visited so the shared
        // traversal set prevents exponential re-traversal of the same nodes.
        try {
          _fetchModuleSource(targetUri,
              showNames: re.show, hideNames: re.hide, reExportVisited: visited);
        } on SourceCodeD4rtException {
          Logger.debug(
            '[ModuleLoader] GEN-107: unexpected error loading re-exported '
            'bridge for ${re.uri} (re-exported from $sourceUri)',
          );
        }
      }

      // Always recurse — the target URI may itself re-export other URIs even
      // if it has no direct bridge content (e.g. pure-barrel source files).
      _mergeReExportsGlobal(re.uri, visited);
    }
  }
}
