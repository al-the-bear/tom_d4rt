// ignore_for_file: implementation_imports

import 'package:tom_d4rt_ast/runtime.dart';
import 'package:tom_d4rt_ast/src/runtime/module_context.dart' as context;
import 'package:tom_d4rt_ast/src/runtime/stdlib/convert.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/isolate.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/math.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/collection.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/typed_data.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/stdlib_io.dart'
    if (dart.library.html) 'package:tom_d4rt_ast/src/runtime/stdlib/stdlib_web.dart';

// Forward reference to D4rt - only used for permission checking
// ignore: always_use_package_imports
import 'd4rt_base.dart';

// Represent a module of source code loaded and parsed.
// This extends the basic LoadedModule with environment for internal caching.
class LoadedModule {
  final Uri uri; // The canonical URI of the module
  final SCompilationUnit ast; // The AST of the module
  final Environment environment; // The environment of this module
  final Environment
      exportedEnvironment; // The environment of the exported symbols

  LoadedModule(this.uri, this.ast, this.environment, this.exportedEnvironment);

  /// Convert to the interface-compatible LoadedModule from tom_d4rt_ast
  context.LoadedModule toContextLoadedModule() {
    return context.LoadedModule(
      ast: ast,
      exportedEnvironment: exportedEnvironment,
      uri: uri,
    );
  }
}

class ModuleLoader implements context.ModuleContext {
  @override
  final Environment globalEnvironment;
  final Map<String, String> sources;
  final Map<Uri, LoadedModule> _moduleCache = {};
  final List<Map<String, LibraryEnum>> bridgedEnumDefinitions;
  final List<Map<String, LibraryClass>> bridgedClases;
  final D4rt? d4rt; // Reference to D4rt instance for permission checking

  /// The current library URI for relative import resolution.
  Uri? _currentLibrary;

  @override
  Uri? get currentLibrary => _currentLibrary;

  @override
  set currentLibrary(Uri? uri) => _currentLibrary = uri;

  // Library-scoped globals (registered with library path) - added when import is processed
  // LibraryFunction wrapper includes sourceUri for deduplication across re-exports
  final List<Map<String, LibraryFunction>> libraryFunctions;
  final List<Map<String, LibraryVariable>> libraryVariables;
  final List<Map<String, LibraryGetter>> libraryGetters;
  final List<Map<String, LibrarySetter>> librarySetters;
  final List<Map<String, LibraryExtension>> bridgedExtensions;

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

  /// Callback for parsing source code into an SAstNode tree.
  /// When provided, this is used to convert raw source strings into
  /// [SCompilationUnit] nodes. When null, the module loader can only
  /// work with pre-parsed AST input.
  final SCompilationUnit Function(String sourceCode, Uri uri)?
      parseSourceCallback;

  ModuleLoader(this.globalEnvironment, this.sources,
      this.bridgedEnumDefinitions, this.bridgedClases,
      {this.d4rt,
      this.libraryFunctions = const [],
      this.libraryVariables = const [],
      this.libraryGetters = const [],
      this.librarySetters = const [],
      this.bridgedExtensions = const [],
      this.collectRegistrationErrors = false,
      this.parseSourceCallback}) {
    Logger.debug(
        "[ModuleLoader] Initialized with ${sources.length} preloaded sources.");
  }

  @override
  bool checkPermission(dynamic operation) {
    if (d4rt == null) return true; // Permissive when no D4rt instance
    return d4rt!.checkPermission(operation);
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
    for (final entry in bridgedEnumDefinitions) {
      if (entry.containsKey(uriString)) return true;
    }
    for (final entry in bridgedClases) {
      if (entry.containsKey(uriString)) return true;
    }
    for (final entry in libraryFunctions) {
      if (entry.containsKey(uriString)) return true;
    }
    for (final entry in libraryVariables) {
      if (entry.containsKey(uriString)) return true;
    }
    for (final entry in libraryGetters) {
      if (entry.containsKey(uriString)) return true;
    }
    for (final entry in librarySetters) {
      if (entry.containsKey(uriString)) return true;
    }
    for (final entry in bridgedExtensions) {
      if (entry.containsKey(uriString)) return true;
    }
    return false;
  }

  @override
  context.LoadedModule loadModule(Uri uri,
      {Set<String>? showNames, Set<String>? hideNames}) {
    return loadModuleInternal(uri, showNames: showNames, hideNames: hideNames)
        .toContextLoadedModule();
  }

  /// Internal implementation that returns the full LoadedModule with environment.
  LoadedModule loadModuleInternal(Uri uri,
      {Set<String>? showNames, Set<String>? hideNames}) {
    // Check permissions for dangerous modules
    _checkModulePermissions(uri);

    // Save the current source URI for resolving relative exports of this module
    Uri? previousLibraryForRecursiveLoad = currentLibrary;
    currentLibrary = uri;
    Logger.debug(
        "[ModuleLoader loadModule for $uri] Setting currentLibrary to: $uri (show: $showNames, hide: $hideNames)");

    if (_moduleCache.containsKey(uri)) {
      Logger.debug(
          "[ModuleLoader loadModule for $uri] Module '${uri.toString()}' found in cache.");
      // Restore the source URI before returning for parent calls
      currentLibrary = previousLibraryForRecursiveLoad;
      return _moduleCache[uri]!;
    }
    Logger.debug(
        "[ModuleLoader loadModule for $uri] Loading module: ${uri.toString()}");
    String sourceCode = _fetchModuleSource(uri,
        showNames: showNames,
        hideNames: hideNames); // Pass show/hide to filter bridged registrations
    SCompilationUnit ast = _parseSource(uri, sourceCode);

    Environment moduleEnvironment = Environment(enclosing: globalEnvironment);

    // Bug-72 FIX: Process import directives BEFORE declarations
    // This ensures imported classes/mixins are available when class declarations are visited
    Logger.debug(
        "[ModuleLoader loadModule for $uri] Processing import directives first...");
    for (final directive in ast.directives) {
      if (directive is SImportDirective) {
        final importedUriString = (directive.uri is SSimpleStringLiteral)
            ? (directive.uri as SSimpleStringLiteral).value
            : null;
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
          LoadedModule importedModule = loadModuleInternal(
              resolvedImportUri); // Recursive call - this will check permissions

          // Get the show/hide combinators and prefix
          Set<String>? showNames;
          Set<String>? hideNames;
          String? prefix = directive.prefix?.name;

          for (final combinator in directive.combinators) {
            if (combinator is SShowCombinator) {
              showNames ??= {};
              showNames.addAll(combinator.shownNames.map((id) => id.name));
              Logger.debug(
                  "[ModuleLoader loadModule for $uri]   Import combinator: show ${combinator.shownNames.map((id) => id.name).join(', ')}");
            } else if (combinator is SHideCombinator) {
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
        moduleContext: this, // Pass the current loader as ModuleContext
        initialLibrary: uri // The URI of the module being interpreted
        );

    Logger.debug(
        "[ModuleLoader loadModule for $uri] Executing InterpreterVisitor pass for initializers...");

    // First, process enum declarations to populate enum values
    // This must happen before top-level variable declarations in case
    // const variables reference enum values
    for (final declaration in ast.declarations) {
      if (declaration is SEnumDeclaration) {
        declaration.accept(moduleInterpreter);
      }
    }

    // Process class and mixin declarations to populate their members (methods, constructors, etc.)
    // The DeclarationVisitor only creates placeholders with empty constructor maps.
    // Bug-59: Without this, imported classes have no constructors available!
    for (final declaration in ast.declarations) {
      if (declaration is SClassDeclaration ||
          declaration is SMixinDeclaration) {
        declaration.accept(moduleInterpreter);
      }
    }

    // Process function declarations to populate interpreted functions properly
    for (final declaration in ast.declarations) {
      if (declaration is SFunctionDeclaration) {
        declaration.accept(moduleInterpreter);
      }
    }

    // Bug-91: Process extension declarations to populate extension methods
    // Extensions need to be processed by the interpreter to be available for imported modules
    for (final declaration in ast.declarations) {
      if (declaration is SExtensionDeclaration) {
        declaration.accept(moduleInterpreter);
      }
    }

    // Then process top-level variable declarations
    for (final declaration in ast.declarations) {
      // We only care about the evaluation of STopLevelVariableDeclaration for their initializers.
      if (declaration is STopLevelVariableDeclaration) {
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
      if (directive is SExportDirective) {
        final exportedUriString = (directive.uri is SSimpleStringLiteral)
            ? (directive.uri as SSimpleStringLiteral).value
            : null;
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
              loadModuleInternal(resolvedExportUri); // Recursive call

          // Get the show/hide combinators
          Set<String>? showNames;
          Set<String>? hideNames;

          for (final combinator in directive.combinators) {
            if (combinator is SShowCombinator) {
              showNames ??= {}; // Initialize if it's the first show combinator
              showNames.addAll(
                  combinator.shownNames.map((id) => id.name)); // Use id.name
              Logger.debug(
                  "[ModuleLoader loadModule for $uri]   Export combinator: show ${combinator.shownNames.map((id) => id.name).join(', ')}");
            } else if (combinator is SHideCombinator) {
              hideNames ??= {}; // Initialize if it's the first hide combinator
              hideNames.addAll(
                  combinator.hiddenNames.map((id) => id.name)); // Use id.name
              Logger.debug(
                  "[ModuleLoader loadModule for $uri]   Export combinator: hide ${combinator.hiddenNames.map((id) => id.name).join(', ')}");
            }
          }

          // Import the environment of the sub-module by applying the show/hide filters
          exportedEnvironment.importEnvironment(
            subModule.exportedEnvironment,
            show: showNames,
            hide: hideNames,
          );
          Logger.debug(
              "[ModuleLoader loadModule for $uri]   Successfully merged exported environment from ${resolvedExportUri.toString()} into ${uri.toString()} (show: ${showNames?.join(", ")}, hide: ${hideNames?.join(", ")}).");
        } catch (e, s) {
          Logger.error(
              "[ModuleLoader loadModule for $uri] Error processing export directive for '$exportedUriString' from ${uri.toString()}: $e\nStackTrace: $s");
          rethrow;
        }
      }
      // Note: SImportDirective is now processed earlier, before declarations
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
    currentLibrary = previousLibraryForRecursiveLoad;
    Logger.debug(
        "[ModuleLoader loadModule for $uri] Restored currentLibrary to: $currentLibrary");
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
      {Set<String>? showNames, Set<String>? hideNames}) {
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

      for (var bridgedEnumDefinition in bridgedEnumDefinitions) {
        if (bridgedEnumDefinition.containsKey(uriString)) {
          hasContentForUri = true;
          final libEnum = bridgedEnumDefinition[uriString]!;
          final definition = libEnum.enumDefinition;
          final enumName = definition.name;

          // Check show/hide filters
          if (!_shouldRegisterName(enumName,
              showNames: showNames, hideNames: hideNames)) {
            Logger.debug(
                " [execute] Skipping enum '$enumName' due to show/hide filter");
            continue;
          }

          // Use sourceUri for deduplication if available, otherwise fall back to import URI
          final sourceUri = libEnum.sourceUri ?? uriString;

          if (_registeredEnums.containsKey(enumName)) {
            final existingSourceUri = _registeredEnums[enumName]!;
            if (existingSourceUri == sourceUri) {
              // Same enum from same canonical source - silently skip (re-export case)
              Logger.debug(
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
            Logger.debug(
                " [execute] Registered bridged enum: $enumName from $sourceUri");
          } catch (e) {
            Logger.error("registering bridged enum '$enumName': $e");
            registrationErrors
                .add("Failed to register bridged enum '$enumName': $e");
          }
        }
      }

      for (var bridgedClass in bridgedClases) {
        if (bridgedClass.containsKey(uriString)) {
          hasContentForUri = true;
          final libClass = bridgedClass[uriString]!;
          final definition = libClass.bridgedClass;
          final className = definition.name;

          // Check show/hide filters
          if (!_shouldRegisterName(className,
              showNames: showNames, hideNames: hideNames)) {
            Logger.debug(
                " [execute] Skipping class '$className' due to show/hide filter");
            continue;
          }

          // Use sourceUri for deduplication if available, otherwise fall back to import URI
          final sourceUri = libClass.sourceUri ?? uriString;

          if (_registeredClasses.containsKey(className)) {
            final existingSourceUri = _registeredClasses[className]!;
            if (existingSourceUri == sourceUri) {
              // Same class from same canonical source - silently skip (re-export case)
              Logger.debug(
                  " [execute] Skipping duplicate class '$className' from same source: $sourceUri");
              continue;
            } else {
              // Different source - this is an actual duplicate, error
              registrationErrors.add(
                  "Duplicate class '$className' exists from source '$existingSourceUri' and source '$sourceUri'. "
                  "These are different classes with the same name.");
              continue;
            }
          }

          _registeredClasses[className] = sourceUri;

          try {
            globalEnvironment.defineBridge(definition);
            Logger.debug(
                " [execute] Registered bridged class: $className from $sourceUri");
          } catch (e) {
            Logger.error("registering bridged class '$className': $e");
            registrationErrors
                .add("Failed to register bridged class '$className': $e");
          }
        }
      }

      // Register library-scoped functions for this import
      for (var entry in libraryFunctions) {
        if (entry.containsKey(uriString)) {
          hasContentForUri = true;
          final libFunc = entry[uriString]!;
          final nativeFunc = libFunc.function;
          final funcName = nativeFunc.name;

          // Check show/hide filters first
          if (!_shouldRegisterName(funcName,
              showNames: showNames, hideNames: hideNames)) {
            Logger.debug(
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
              Logger.debug(
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
            Logger.debug(
                " [execute] Registered library function: $funcName from $sourceUri");
          } catch (e) {
            Logger.error("registering library function '$funcName': $e");
            registrationErrors
                .add("Failed to register function '$funcName': $e");
          }
        }
      }

      // Register library-scoped variables for this import
      for (var entry in libraryVariables) {
        if (entry.containsKey(uriString)) {
          hasContentForUri = true;
          final libVar = entry[uriString]!;
          final varName = libVar.name;

          // Check show/hide filters first
          if (!_shouldRegisterName(varName,
              showNames: showNames, hideNames: hideNames)) {
            Logger.debug(
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
              Logger.debug(
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
            Logger.debug(
                " [execute] Registered library variable: $varName from $sourceUri");
          } catch (e) {
            Logger.error("registering library variable '$varName': $e");
            registrationErrors
                .add("Failed to register variable '$varName': $e");
          }
        }
      }

      // Register library-scoped getters for this import
      for (var entry in libraryGetters) {
        if (entry.containsKey(uriString)) {
          hasContentForUri = true;
          final libGetter = entry[uriString]!;
          final getterName = libGetter.name;

          // Check show/hide filters first
          if (!_shouldRegisterName(getterName,
              showNames: showNames, hideNames: hideNames)) {
            Logger.debug(
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
              Logger.debug(
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
            globalEnvironment.define(
                getterName, GlobalGetter(libGetter.getter));
            _registeredGetters[getterName] = sourceUri;
            Logger.debug(
                " [execute] Registered library getter: $getterName from $sourceUri");
          } catch (e) {
            Logger.error("registering library getter '$getterName': $e");
            registrationErrors
                .add("Failed to register getter '$getterName': $e");
          }
        }
      }

      // Register library-scoped setters for this import
      // Setters update existing GlobalGetters to include setter support
      for (var entry in librarySetters) {
        if (entry.containsKey(uriString)) {
          hasContentForUri = true;
          final libSetter = entry[uriString]!;
          final setterName = libSetter.name;

          // Check show/hide filters first
          if (!_shouldRegisterName(setterName,
              showNames: showNames, hideNames: hideNames)) {
            Logger.debug(
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
              Logger.debug(
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
              Logger.debug(
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
            Logger.debug(
                " [execute] Registered library setter: $setterName from $sourceUri");
          } catch (e) {
            Logger.error("registering library setter '$setterName': $e");
            registrationErrors
                .add("Failed to register setter '$setterName': $e");
          }
        }
      }

      // Register bridged extensions for this import
      for (var entry in bridgedExtensions) {
        if (entry.containsKey(uriString)) {
          hasContentForUri = true;
          final libExt = entry[uriString]!;
          final definition = libExt.extensionDefinition;
          final extName = definition.name ?? '<unnamed>';

          // Named extensions are subject to show/hide filters;
          // unnamed extensions are always registered since they cannot be hidden by name.
          if (definition.name != null &&
              !_shouldRegisterName(definition.name!,
                  showNames: showNames, hideNames: hideNames)) {
            Logger.debug(
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
              Logger.debug(
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
              Logger.debug(
                  " [execute] Registered named bridged extension: ${definition.name} on ${definition.onTypeName} from $sourceUri");
            } else {
              globalEnvironment.addUnnamedExtension(interpretedExt);
              Logger.debug(
                  " [execute] Registered unnamed bridged extension on ${definition.onTypeName} from $sourceUri");
            }
          } catch (e) {
            Logger.error("registering bridged extension '$extName': $e");
            registrationErrors
                .add("Failed to register extension '$extName': $e");
          }
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
    for (final classMap in bridgedClases) {
      for (final libClass in classMap.values) {
        if (libClass.bridgedClass.name == typeName) {
          // Register the class in globalEnvironment so it's available
          // for extension type matching
          globalEnvironment.defineBridge(libClass.bridgedClass);
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

  SCompilationUnit _parseSource(Uri uri, String sourceCode) {
    Logger.debug("[ModuleLoader] Parsing source for module: ${uri.toString()}");
    if (parseSourceCallback == null) {
      throw StateError('ModuleLoader: no parseSourceCallback provided. '
          'Cannot parse source code for module ${uri.toString()}. '
          'Provide a parseSourceCallback to the ModuleLoader constructor.');
    }
    final result = parseSourceCallback!(sourceCode, uri);
    Logger.debug(
        "[ModuleLoader] Module ${uri.toString()} parsed successfully.");
    return result;
  }
}
