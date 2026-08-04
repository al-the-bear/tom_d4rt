// ignore_for_file: implementation_imports

// DGUB3 — filesystem module sources. This loader is the CLI/server-side
// counterpart of tom_d4rt's ModuleLoader and, like it, may read a module's
// source off disk when `allowFileSystemImports` is enabled. It is deliberately
// NOT the zero-dependency `AstModuleLoader` in tom_d4rt_ast, which stays
// lookup-only so it remains usable where there is no filesystem. Note that
// `script_execution.dart` (exported from this package's barrel) already
// imports dart:io, so this adds no platform constraint the package did not
// already carry.
import 'dart:io';

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

/// DFUB10 — a module whose load is still in flight.
///
/// Registered before a module's import/export directives are walked, so that a
/// cyclic re-entry gets this partial entry back instead of recursing forever.
/// Circular imports and exports are legal Dart and must load, so we support the
/// cycle rather than rejecting it.
///
/// [deferredMerges] exists because [Environment.importEnvironment] copies
/// bindings at call time rather than aliasing the source environment. A module
/// that merges from an in-flight module therefore copies an incomplete — often
/// empty — set of exports. Each such merge is recorded here and replayed once
/// the in-flight module finishes, at which point its exports are complete. The
/// replay is idempotent: `importEnvironment` skips names already bound to the
/// identical value, so re-merging costs nothing and cannot raise a spurious
/// conflict.
class _InFlightModule {
  final LoadedModule partial;
  final List<void Function()> deferredMerges = [];

  _InFlightModule(this.partial);
}

class ModuleLoader implements context.ModuleContext {
  @override
  final Environment globalEnvironment;
  final Map<String, String> sources;
  final Map<Uri, LoadedModule> _moduleCache = {};

  /// DFUB10 — modules currently being loaded, keyed like [_moduleCache]. A URI
  /// is present here only between the start of its directive processing and its
  /// completion.
  final Map<Uri, _InFlightModule> _inFlightModules = {};
  final List<Map<String, LibraryEnum>> bridgedEnumDefinitions;
  final List<Map<String, LibraryClass>> bridgedClases;
  final D4rt? d4rt; // Reference to D4rt instance for permission checking

  /// DGUB3 (mirrors tom_d4rt DFUB1) — base directory for resolving relative
  /// filesystem imports.
  ///
  /// When [allowFileSystemImports] is enabled, a scheme-less relative import
  /// URI is resolved against `Directory(basePath).absolute.uri` before reading
  /// the module source off disk. `null` disables relative filesystem
  /// resolution (absolute `file:` URIs still resolve on their own).
  final String? basePath;

  /// DGUB3 (mirrors tom_d4rt DFUB1) — when true, [_fetchModuleSource] may read
  /// a module's source from the filesystem (via [_resolveFileSystemUri]) if the
  /// URI is not already in [sources] and the resolved file exists. Defaults to
  /// `false` (sandboxed: only preloaded [sources] and bridged/stdlib modules
  /// are visible). Every such read is gated by
  /// [_checkFileSystemSourceReadPermission].
  final bool allowFileSystemImports;

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
      this.parseSourceCallback,
      this.basePath,
      this.allowFileSystemImports = false}) {
    Logger.debug(
        "[ModuleLoader] Initialized with ${sources.length} preloaded sources.");
  }

  /// DGUB3 (mirrors tom_d4rt DFUB1) — the URI the interpreter should treat as
  /// the initial library when the root source was supplied inline (no explicit
  /// `library:`) and filesystem imports are enabled.
  ///
  /// Relative imports in the root source are resolved against
  /// [currentLibrary], which is otherwise `null` for an inline source — so
  /// without this seed `import './utils.dart'` fails with "Base URI not defined
  /// in ModuleLoader" no matter what [basePath] says. Returns `null` when there
  /// is no filesystem base to seed from.
  Uri? get initialFileSystemLibraryUri =>
      (allowFileSystemImports && basePath != null)
          ? Directory(basePath!).absolute.uri
          : null;

  /// DGUB3 (mirrors tom_d4rt DFUB1) — maps a module [uri] to the `file:` URI it
  /// would be read from, or `null` when it is not a filesystem candidate.
  ///
  /// - `file:` URIs resolve to themselves (already absolute on disk).
  /// - Any other explicit scheme (`dart:`, `package:`, …) returns `null` — not
  ///   a filesystem import.
  /// - A scheme-less (relative) URI resolves against
  ///   `Directory(basePath).absolute.uri`; returns `null` when [basePath] is
  ///   unset (no base to resolve against).
  Uri? _resolveFileSystemUri(Uri uri) {
    if (uri.scheme == 'file') {
      return uri;
    }
    if (uri.scheme.isNotEmpty) {
      return null;
    }
    if (basePath == null) {
      return null;
    }
    return Directory(basePath!).absolute.uri.resolveUri(uri);
  }

  /// DGUB3 (mirrors tom_d4rt DFUB3) — canonicalizes a module [uri] to a single
  /// absolute spelling so the URI that flows through source reads, the
  /// read-permission gate and nested import resolution is always the same
  /// absolute `file:` form.
  ///
  /// This is load-bearing here, not cosmetic: a nested relative import is
  /// resolved by the interpreter against [currentLibrary], which this loader
  /// sets to the URI it is loading. Without canonicalization a module reached
  /// as `features/feature.dart` would resolve its own `messages/value.dart`
  /// against that *relative* spelling and miss the file.
  ///
  /// Deliberately does NOT resolve symlinks: the returned URI keeps the
  /// caller's directory spelling, so a [FilesystemPermission] granted on a
  /// (possibly symlinked) directory keeps matching the read. Symlink identity
  /// for cache deduplication is [_moduleIdentityUri]'s job.
  Uri _canonicalizeModuleUri(Uri uri) {
    final fileUri = _resolveFileSystemUri(uri);
    if (fileUri == null) {
      return uri;
    }
    return File.fromUri(fileUri).absolute.uri;
  }

  /// DGUB3 (mirrors tom_d4rt DFUB3) — computes the deduplication identity for a
  /// module [uri] used as the [_moduleCache] / [_inFlightModules] key, so
  /// different spellings of the same underlying file — including symlinked
  /// directories/files and `..`/`.` segments — collapse to a single cached
  /// module instance and load exactly once.
  ///
  /// For an existing filesystem file this is the real (symlink-resolved) path;
  /// when the file does not exist or the real-path call fails it falls back to
  /// the absolute spelling. Non-filesystem URIs (`dart:`, `package:`) are
  /// returned unchanged.
  Uri _moduleIdentityUri(Uri uri) {
    final fileUri = _resolveFileSystemUri(uri);
    if (fileUri == null) {
      return uri;
    }
    final file = File.fromUri(fileUri);
    if (file.existsSync()) {
      try {
        return File(file.resolveSymbolicLinksSync()).uri;
      } on FileSystemException {
        // Fall through to the absolute-spelling identity below.
      }
    }
    return file.absolute.uri;
  }

  /// DGUB3 (mirrors tom_d4rt DFUB2) — gates a filesystem module-source read
  /// behind a [FilesystemPermission] read check.
  ///
  /// The resolved [fileUri] is normalized to an absolute path and matched
  /// against the granted permissions via [D4rt.checkPermission]. An ungranted
  /// read throws a [RuntimeD4rtException] before any bytes are read. No-op when
  /// there is no owning [D4rt] instance (nothing to enforce against).
  void _checkFileSystemSourceReadPermission(Uri fileUri) {
    if (d4rt == null) return;

    final filePath = File.fromUri(fileUri).absolute.path;
    if (!d4rt!.checkPermission({
      'type': 'filesystem',
      'path': filePath,
      'read': true,
    })) {
      throw RuntimeD4rtException(
          'Reading module source from "$filePath" requires '
          'FilesystemPermission.');
    }
  }

  /// DGUB3 (mirrors tom_d4rt DFUB2/DFUB13) — builds the exception for a module
  /// whose source could not be obtained, choosing the message that names the
  /// actual reason:
  ///
  /// - a filesystem candidate with imports disabled → says so, rather than
  ///   blaming the stdlib;
  /// - a filesystem candidate that simply is not there → reports the resolved
  ///   path so the caller can see where the loader looked;
  /// - a `package:` URI → package-specific guidance (preload or bridge it);
  /// - anything else → the generic "not preloaded / not a stdlib" message.
  SourceCodeD4rtException _missingModuleSourceError(Uri uri) {
    final uriString = uri.toString();
    final fileUri = _resolveFileSystemUri(uri);

    if (fileUri != null) {
      if (!allowFileSystemImports) {
        return SourceCodeD4rtException(
            "Module source not preloaded for URI: $uriString. Filesystem "
            "imports are disabled; enable allowFileSystemImports or preload "
            "the module source.",
            uriString);
      }
      final resolvedPath = File.fromUri(fileUri).absolute.path;
      return SourceCodeD4rtException(
          "Module source not found on filesystem for URI: $uriString "
          "(resolved path: $resolvedPath).",
          uriString);
    }

    if (uri.scheme == 'package') {
      return SourceCodeD4rtException(
          "Package module source not preloaded for URI: $uriString. Provide "
          "it in sources or register a bridge for that package library.",
          uriString);
    }

    return SourceCodeD4rtException(
        "Module source not preloaded for URI: $uriString, and not a "
        "recognized Dart standard library.",
        uriString);
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
      // The import gate asks only "is ANY filesystem access granted?" — it has
      // no path to check, so it must not be measured against a scoped grant's
      // path. The per-operation checks in `stdlib/io/` enforce the scope.
      if (!d4rt!
          .checkPermission({'type': 'filesystem', 'pathAgnostic': true})) {
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
  ///
  /// DFUB10 — the real work lives in [_loadModuleInternal]; this wrapper only
  /// guarantees that a *failed* load drops its in-flight registration, so an
  /// abandoned partial is never handed out on a later execute.
  LoadedModule loadModuleInternal(Uri uri,
      {Set<String>? showNames, Set<String>? hideNames}) {
    try {
      return _loadModuleInternal(uri,
          showNames: showNames, hideNames: hideNames);
    } catch (_) {
      _inFlightModules.remove(_moduleIdentityUri(_canonicalizeModuleUri(uri)));
      rethrow;
    }
  }

  LoadedModule _loadModuleInternal(Uri uri,
      {Set<String>? showNames, Set<String>? hideNames}) {
    // DGUB3 — canonicalize filesystem module URIs to a single absolute spelling
    // so reads, the read-permission gate and nested import resolution all use
    // the same (grant-matching) form. No-op for non-filesystem URIs (`dart:`,
    // `package:`, unresolvable relative).
    uri = _canonicalizeModuleUri(uri);

    // DGUB3 — the cache is keyed by the symlink-resolved identity so different
    // spellings of the same underlying file dedupe to one cached module and
    // load exactly once. Reads still use `uri` (the caller's spelling).
    final identityUri = _moduleIdentityUri(uri);

    // Check permissions for dangerous modules
    _checkModulePermissions(uri);

    // Save the current source URI for resolving relative exports of this module
    Uri? previousLibraryForRecursiveLoad = currentLibrary;
    currentLibrary = uri;
    Logger.debug(
        "[ModuleLoader loadModule for $uri] Setting currentLibrary to: $uri (show: $showNames, hide: $hideNames)");

    if (_moduleCache.containsKey(identityUri)) {
      Logger.debug(
          "[ModuleLoader loadModule for $uri] Module '${uri.toString()}' found in cache.");
      // Restore the source URI before returning for parent calls
      currentLibrary = previousLibraryForRecursiveLoad;
      return _moduleCache[identityUri]!;
    }

    // DFUB10 — a cycle: this module is already being loaded further up the
    // stack. Hand back its partial entry instead of recursing forever. The
    // partial's environments are the very objects the in-progress frame will
    // finish populating, and any merge taken from an incomplete export set is
    // replayed when that frame completes (see [_mergeFromModule]).
    final inFlightEntry = _inFlightModules[identityUri];
    if (inFlightEntry != null) {
      Logger.debug(
          "[ModuleLoader loadModule for $uri] Module '${uri.toString()}' is already in flight (circular import/export); returning partial module.");
      currentLibrary = previousLibraryForRecursiveLoad;
      return inFlightEntry.partial;
    }
    Logger.debug(
        "[ModuleLoader loadModule for $uri] Loading module: ${uri.toString()}");
    String sourceCode = _fetchModuleSource(uri,
        showNames: showNames,
        hideNames: hideNames); // Pass show/hide to filter bridged registrations
    SCompilationUnit ast = _parseSource(uri, sourceCode);

    Environment moduleEnvironment = Environment(enclosing: globalEnvironment);
    // Must also enclose globalEnvironment. DFUB10 — created here rather than
    // just before the export directives so the partial module published below
    // carries the SAME Environment instance that later receives this module's
    // local declarations; a cyclic importer therefore holds a live reference.
    Environment exportedEnvironment =
        Environment(enclosing: globalEnvironment);

    // DFUB10 — publish the partial module BEFORE walking any directive, so a
    // cycle back to this URI terminates. Circular imports and exports are legal
    // Dart and must load; we support the cycle rather than rejecting it.
    final inFlight = _InFlightModule(
        LoadedModule(uri, ast, moduleEnvironment, exportedEnvironment));
    _inFlightModules[identityUri] = inFlight;

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
            // For prefixed imports, create a filtered environment and define it
            // with the prefix. `shallowCopyFiltered` snapshots, so a cyclic
            // import needs the same deferred replay as the plain case (DFUB10).
            _mergeFromModule(importedModule, () {
              Environment prefixedEnv =
                  importedModule.exportedEnvironment.shallowCopyFiltered(
                showNames: showNames,
                hideNames: hideNames,
              );
              moduleEnvironment.definePrefixedImport(prefix, prefixedEnv);
            });
            Logger.debug(
                "[ModuleLoader loadModule for $uri]   Successfully defined prefixed import '$prefix' from ${resolvedImportUri.toString()} into ${uri.toString()} (show: ${showNames?.join(", ")}, hide: ${hideNames?.join(", ")}).");
          } else {
            // For regular imports, import directly into the module environment
            _mergeFromModule(
              importedModule,
              () => moduleEnvironment.importEnvironment(
                importedModule.exportedEnvironment,
                show: showNames,
                hide: hideNames,
              ),
            );
            Logger.debug(
                "[ModuleLoader loadModule for $uri]   Successfully imported environment from ${resolvedImportUri.toString()} into ${uri.toString()} (show: ${showNames?.join(", ")}, hide: ${hideNames?.join(", ")}).");
          }
        } catch (e, s) {
          Logger.error(
              "[ModuleLoader loadModule for $uri] Error processing import directive for '$importedUriString' from ${uri.toString()}: $e\nStackTrace: $s");
          // DFUB13 — the log line above has the owner/target context; the
          // exception the caller actually sees did not. Attach it there too.
          if (e is D4rtException) {
            throw wrapDirectiveError(
                'import', uri, uri.resolve(importedUriString), e);
          }
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
    // `exportedEnvironment` was created up-front (DFUB10) so cyclic importers
    // hold a live reference; here it finally receives this module's own
    // declarations, now that moduleEnvironment holds their initialized values.
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

          // Import the environment of the sub-module by applying the show/hide filters.
          // Cluster EXPORT (I-MISC-40/41): pass errorOnConflict: true so that a
          // library that re-publishes two different definitions of the same
          // name (local vs re-export, or two re-exports) raises immediately
          // instead of silently overwriting.
          _mergeFromModule(
            subModule,
            () => exportedEnvironment.importEnvironment(
              subModule.exportedEnvironment,
              show: showNames,
              hide: hideNames,
              errorOnConflict: true,
            ),
          );
          Logger.debug(
              "[ModuleLoader loadModule for $uri]   Successfully merged exported environment from ${resolvedExportUri.toString()} into ${uri.toString()} (show: ${showNames?.join(", ")}, hide: ${hideNames?.join(", ")}).");
        } catch (e, s) {
          Logger.error(
              "[ModuleLoader loadModule for $uri] Error processing export directive for '$exportedUriString' from ${uri.toString()}: $e\nStackTrace: $s");
          // DFUB13 — see the import branch. Barrels are where this matters
          // most: the failing barrel is rarely the file the user was editing.
          if (e is D4rtException) {
            throw wrapDirectiveError(
                'export', uri, uri.resolve(exportedUriString), e);
          }
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

    // DFUB10 — reuse the very instance the cyclic importers were handed, so
    // every reference to this module (partial or final) is the same object.
    final loadedModule = inFlight.partial;
    _moduleCache[identityUri] = loadedModule;
    _inFlightModules.remove(identityUri);

    // DFUB10 — this module's exports are complete now, so replay every merge
    // that was taken from it while it was still incomplete. Replays are
    // idempotent: `importEnvironment` skips names already bound to the
    // identical value.
    for (final replay in inFlight.deferredMerges) {
      replay();
    }
    Logger.debug(
        "[ModuleLoader loadModule for $uri] Module '${uri.toString()}' chargé et mis en cache.");

    // Restore the source URI before returning
    currentLibrary = previousLibraryForRecursiveLoad;
    Logger.debug(
        "[ModuleLoader loadModule for $uri] Restored currentLibrary to: $currentLibrary");
    return loadedModule;
  }

  /// DFUB10 — the in-flight entry that owns [module], or null when the module
  /// is fully loaded.
  ///
  /// The scan is over the current import-nesting depth (one entry per module on
  /// the load stack), not over the module cache, so it stays tiny.
  _InFlightModule? _inFlightFor(LoadedModule module) {
    for (final entry in _inFlightModules.values) {
      if (identical(entry.partial, module)) return entry;
    }
    return null;
  }

  /// DFUB10 — runs [merge] now and schedules a replay when [source] is only
  /// partially loaded.
  ///
  /// `Environment.importEnvironment` copies bindings at call time; a merge that
  /// runs against a module still walking its own directives therefore captures
  /// an incomplete — often empty — export set and would never self-heal.
  /// Replaying once [source] finishes fills in the rest.
  void _mergeFromModule(LoadedModule source, void Function() merge) {
    merge();
    _inFlightFor(source)?.deferredMerges.add(merge);
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

    // DGUB3 (mirrors tom_d4rt DFUB1) — when filesystem imports are enabled, a
    // URI not in the preloaded sources may be read off disk. Relative URIs
    // resolve against basePath; `file:` URIs read directly.
    // DGUB3 (mirrors tom_d4rt DFUB2) — every on-disk read is gated by a
    // per-read FilesystemPermission check, which throws before any bytes are
    // read. This is checked ahead of the stdlib branch below so a filesystem
    // module never falls through to "not a recognized Dart standard library".
    if (allowFileSystemImports) {
      final fileUri = _resolveFileSystemUri(uri);
      if (fileUri != null) {
        final file = File.fromUri(fileUri);
        if (file.existsSync()) {
          _checkFileSystemSourceReadPermission(fileUri);
          Logger.debug(
              "[ModuleLoader] Source loaded from filesystem for $fileUri.");
          return file.readAsStringSync();
        }
        Logger.debug(
            "[ModuleLoader] Filesystem import enabled, but no file found at "
            "${file.absolute.path}.");
      }
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
          final className = libClass.name;

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
            }
            // B2 MarkdownParser clash: two different libraries declare a
            // same-name bridge. Do NOT error — register this one too. The
            // import wins as the primary; defineBridge records the displaced
            // sibling as a shadow so static/constructor lookups can fall back
            // to whichever bridge actually declares the requested member.
            // Matches the tolerant per-module behaviour of the tom_d4rt and
            // tom_d4rt_ast runtimes.
            Logger.debug(
                " [execute] Same-name class '$className' from a different "
                "source ($existingSourceUri vs $sourceUri); registering both "
                "with shadow fallback.");
          }

          _registeredClasses[className] = sourceUri;

          try {
            // Step #17 — transfer the deferred thunk (build on first resolve).
            globalEnvironment.defineBridgeLazy(
                libClass.name, libClass.nativeType, libClass.thunk);
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
            // Resolve the onType from the environment.
            //
            // `lookup`, not `get`: this probe misses by design whenever the
            // importing script does not also import the on-type's own library
            // (the `_resolveTypeForExtension` fallback below is what handles
            // that case). The throwing `get` turned every such routine miss
            // into a reported `Undefined variable` error that nothing ever
            // revoked, so a host collecting reported errors as its pass/fail
            // signal — the REPL in `-test` mode — failed runs in which nothing
            // went wrong.
            final typeObj = globalEnvironment.lookup(definition.onTypeName);
            var onType = typeObj is RuntimeType ? typeObj : null;

            // GEN-056 FIX: If the type isn't found in the environment, try
            // resolving it from registered bridge classes and stdlib modules.
            // This handles cases where a bridge extension targets a type from
            // a different package or stdlib (e.g., PlatformEx on Platform from
            // dart:io) that hasn't been explicitly imported by the script.
            onType ??= _resolveTypeForExtension(definition.onTypeName);

            if (onType == null) {
              // Cross-sync with tom_d4rt/lib/src/module_loader.dart:409-413:
              // in normal execute() mode an unresolved on-type is a
              // non-fatal skip — a bridge package may declare an extension
              // (e.g., DCli's DigestHelper on crypto.Digest) whose on-type
              // is never bridged because no consumer script uses it. The
              // analyzer-based runtime warns and continues; this path
              // matches that behaviour.
              //
              // In validate mode (collectRegistrationErrors == true) the
              // caller is `D4rt.validateRegistrations()` which is
              // expected to surface every unresolved registration —
              // including unresolved on-types — to the test/IDE. There
              // we still record the error so it ends up in the returned
              // list (and only the returned list — collectRegistrationErrors
              // also suppresses the throw below).
              Logger.warn(
                  " [execute] Could not resolve type '${definition.onTypeName}' for extension '$extName'. "
                  "Extension will not be registered.");
              if (collectRegistrationErrors) {
                registrationErrors.add(
                    "Could not resolve type '${definition.onTypeName}' for extension '$extName'.");
              }
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
    // DFUB13 / DGUB3 — the reason a module could not be loaded decides the
    // message: a filesystem candidate reports either the disabled flag or the
    // path the loader looked at, a `package:` URI gets package-specific
    // guidance, and only the genuine leftovers get the generic stdlib tail.
    throw _missingModuleSourceError(uri);
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
