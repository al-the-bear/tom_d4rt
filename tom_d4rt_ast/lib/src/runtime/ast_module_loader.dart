import 'package:tom_d4rt_ast/ast.dart';
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
      Logger.debug(
        '[AstModuleLoader] Cache hit for module: $uri',
      );
      return _moduleCache[uri]!;
    }

    Logger.debug(
      '[AstModuleLoader] Loading module: $uri '
      '(show: $showNames, hide: $hideNames)',
    );

    // 2. Handle dart:* stdlib modules
    if (uri.isScheme('dart')) {
      return _loadStdlibModule(uri);
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

  /// Loads a `dart:*` stdlib module by registering its definitions
  /// into the global environment.
  LoadedModule _loadStdlibModule(Uri uri) {
    final libName = uri.path;

    if (!_stdlibRegistrars.containsKey(libName)) {
      throw RuntimeD4rtException(
        "Dart library 'dart:$libName' is not supported.",
      );
    }

    // Register if not already done
    if (!_registeredStdlibs.contains(libName)) {
      final registrar = _stdlibRegistrars[libName];
      if (registrar != null) {
        registrar(globalEnvironment);
        Logger.debug(
          '[AstModuleLoader] Registered stdlib: dart:$libName',
        );
      }
      _registeredStdlibs.add(libName);
    }

    // Return an empty module — stdlib symbols are in globalEnvironment
    final emptyAst = SCompilationUnit(offset: 0, length: 0);
    final module = LoadedModule(
      ast: emptyAst,
      exportedEnvironment: globalEnvironment,
      uri: uri,
    );
    _moduleCache[uri] = module;
    return module;
  }

  // ===========================================================================
  // Bridged Library Loading
  // ===========================================================================

  /// Attempts to load a bridged library by registering its definitions.
  ///
  /// Returns `null` if the URI has no bridged content registered in the runner.
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

    // Only register bridges once per URI
    if (!_registeredBridgeUris.contains(uriString)) {
      _registerBridgesForUri(uriString, showNames, hideNames);
      _registeredBridgeUris.add(uriString);
    }

    // Return an empty module — bridge symbols are in globalEnvironment
    final emptyAst = SCompilationUnit(offset: 0, length: 0);
    final module = LoadedModule(
      ast: emptyAst,
      exportedEnvironment: globalEnvironment,
      uri: uri,
    );
    _moduleCache[uri] = module;
    return module;
  }

  /// Checks if the runner has any bridged content for the given URI.
  bool _hasBridgedContent(String uriString) {
    return _anyEntryMatches(runner.bridgedEnumDefinitions, uriString) ||
        _anyEntryMatches(runner.bridgedClasses, uriString) ||
        _anyEntryMatches(runner.bridgedExtensions, uriString) ||
        _anyEntryMatches(runner.libraryFunctions, uriString) ||
        _anyEntryMatches(runner.libraryVariables, uriString) ||
        _anyEntryMatches(runner.libraryGetters, uriString) ||
        _anyEntryMatches(runner.librarySetters, uriString);
  }

  /// Checks if any map entry in a list has the given key.
  bool _anyEntryMatches<T>(List<Map<String, T>> entries, String key) {
    return entries.any((m) => m.containsKey(key));
  }

  /// Registers all bridged definitions for a URI into the global environment.
  void _registerBridgesForUri(
    String uriString,
    Set<String>? showNames,
    Set<String>? hideNames,
  ) {
    // Register bridged enums
    for (final entry in runner.bridgedEnumDefinitions) {
      final libEnum = entry[uriString];
      if (libEnum == null) continue;
      final name = libEnum.enumDefinition.name;
      if (!_shouldInclude(name, showNames, hideNames)) continue;

      final bridgedEnum = libEnum.enumDefinition.buildBridgedEnum();
      globalEnvironment.defineBridgedEnum(bridgedEnum);
      Logger.debug(
        '[AstModuleLoader] Registered bridged enum: $name from $uriString',
      );
    }

    // Register bridged classes
    for (final entry in runner.bridgedClasses) {
      final libClass = entry[uriString];
      if (libClass == null) continue;
      final name = libClass.bridgedClass.name;
      if (!_shouldInclude(name, showNames, hideNames)) continue;

      globalEnvironment.defineBridge(libClass.bridgedClass);
      Logger.debug(
        '[AstModuleLoader] Registered bridged class: $name from $uriString',
      );
    }

    // Register bridged extensions
    for (final entry in runner.bridgedExtensions) {
      final libExt = entry[uriString];
      if (libExt == null) continue;
      final name = libExt.name;
      if (name != null && !_shouldInclude(name, showNames, hideNames)) continue;

      // Extensions register themselves into the environment via their methods
      Logger.debug(
        '[AstModuleLoader] Registered bridged extension: $name from $uriString',
      );
    }

    // Register library functions
    for (final entry in runner.libraryFunctions) {
      final libFunc = entry[uriString];
      if (libFunc == null) continue;
      final name = libFunc.function.name;
      if (name == '<native>') continue; // Skip unnamed functions
      if (!_shouldInclude(name, showNames, hideNames)) continue;

      globalEnvironment.define(name, libFunc.function);
      Logger.debug(
        '[AstModuleLoader] Registered library function: $name from $uriString',
      );
    }

    // Register library variables
    for (final entry in runner.libraryVariables) {
      final libVar = entry[uriString];
      if (libVar == null) continue;
      if (!_shouldInclude(libVar.name, showNames, hideNames)) continue;

      globalEnvironment.define(libVar.name, libVar.value);
      Logger.debug(
        '[AstModuleLoader] Registered library variable: '
        '${libVar.name} from $uriString',
      );
    }

    // Register library getters (paired with optional setters)
    final settersByName = <String, LibrarySetter>{};
    for (final entry in runner.librarySetters) {
      final libSetter = entry[uriString];
      if (libSetter != null) {
        settersByName[libSetter.name] = libSetter;
      }
    }

    for (final entry in runner.libraryGetters) {
      final libGetter = entry[uriString];
      if (libGetter == null) continue;
      if (!_shouldInclude(libGetter.name, showNames, hideNames)) continue;

      final setter = settersByName.remove(libGetter.name);
      globalEnvironment.define(
        libGetter.name,
        GlobalGetter(libGetter.getter, setter: setter?.setter),
      );
      Logger.debug(
        '[AstModuleLoader] Registered library getter: '
        '${libGetter.name} from $uriString',
      );
    }

    // Register any remaining standalone setters
    for (final entry in settersByName.entries) {
      if (!_shouldInclude(entry.key, showNames, hideNames)) continue;

      globalEnvironment.define(
        entry.key,
        GlobalGetter(
          () => throw RuntimeD4rtException(
            'Property ${entry.key} is write-only',
          ),
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

      Logger.debug(
        '[AstModuleLoader] Export: $exportUriString → $resolvedUri',
      );

      final loaded = loadModule(resolvedUri);
      exportedEnv.importEnvironment(
        loaded.exportedEnvironment,
        show: showNames,
        hide: hideNames,
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
    for (final decl in ast.declarations) {
      if (decl is SClassDeclaration || decl is SMixinDeclaration) {
        decl.accept<Object?>(interpreter);
      }
    }
    for (final decl in ast.declarations) {
      if (decl is SFunctionDeclaration) decl.accept<Object?>(interpreter);
    }
    for (final decl in ast.declarations) {
      if (decl is SExtensionDeclaration) decl.accept<Object?>(interpreter);
    }
    for (final decl in ast.declarations) {
      if (decl is STopLevelVariableDeclaration) {
        decl.accept<Object?>(interpreter);
      }
    }
  }
}
