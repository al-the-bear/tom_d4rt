/// AstBundler — Create [AstBundle]s from source code with import resolution.
///
/// This library requires the Dart analyzer to parse source code.
/// It produces bundles consumable by [D4rtRunner] which needs no analyzer.
library;

import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:path/path.dart' as p;
import 'package:tom_d4rt_ast/ast.dart';
import 'package:tom_d4rt_ast/runtime.dart' show AstBundle;

import 'package:tom_d4rt_astgen/src/converter/ast_converter.dart';

// =============================================================================
// Configuration
// =============================================================================

/// Configuration for [AstBundler] import resolution behavior.
///
/// Controls which import schemes are auto-resolved, which are skipped,
/// and what constitutes an error.
class AstBundlerConfig {
  /// URI schemes that are always skipped (stdlib, always available at runtime).
  ///
  /// Default: `{'dart'}`.
  final Set<String> stdlibSchemes;

  /// Maximum recursion depth for following imports.
  ///
  /// Prevents infinite loops in circular import chains.
  /// Default: `64`.
  final int maxImportDepth;

  /// Whether to include part directives when scanning for imports.
  ///
  /// Default: `true`.
  final bool followPartDirectives;

  /// Default configuration.
  const AstBundlerConfig({
    this.stdlibSchemes = const {'dart'},
    this.maxImportDepth = 64,
    this.followPartDirectives = true,
  });
}

// =============================================================================
// Import Resolution Result
// =============================================================================

/// Outcome of resolving a single import URI.
enum ImportAction {
  /// Include — parse the source and add to bundle.
  include,

  /// Skip — this URI is handled at runtime (stdlib, bridged library).
  skip,

  /// Error — cannot resolve this import.
  error,
}

/// Result of resolving a single import URI.
class ImportResolution {
  /// What to do with this import.
  final ImportAction action;

  /// For [ImportAction.include]: the source code to parse.
  /// For [ImportAction.error]: the error message.
  final String? value;

  /// The canonical URI string to use as the bundle key.
  final String canonicalUri;

  const ImportResolution._({
    required this.action,
    required this.canonicalUri,
    this.value,
  });

  /// Create an include resolution with source code.
  const ImportResolution.include(String source, {required String canonicalUri})
      : this._(
          action: ImportAction.include,
          canonicalUri: canonicalUri,
          value: source,
        );

  /// Create a skip resolution.
  const ImportResolution.skip({required String canonicalUri})
      : this._(action: ImportAction.skip, canonicalUri: canonicalUri);

  /// Create an error resolution.
  const ImportResolution.error(String message, {required String canonicalUri})
      : this._(
          action: ImportAction.error,
          canonicalUri: canonicalUri,
          value: message,
        );
}

// =============================================================================
// AstBundler
// =============================================================================

/// Creates [AstBundle]s from Dart source code by parsing the entry point
/// and recursively resolving all imports.
///
/// ## Import Resolution Rules
///
/// | Import Type | Resolution |
/// |-------------|------------|
/// | `dart:*` | Skip (stdlib, always available) |
/// | Match in [bridgedLibraries] | Skip (native bridge handles it) |
/// | `package:same_package/*` | Auto-include (parse from disk) |
/// | Relative import within package | Auto-include (parse from disk) |
/// | Match in [explicitSources] | Include provided source |
/// | Other `package:*` | **Error** — not bridged |
/// | Unresolvable relative import | **Error** |
///
/// ## Example
///
/// ```dart
/// final bundler = AstBundler(
///   bridgedLibraries: {'package:my_lib/my_lib.dart'},
/// );
///
/// // From a source string
/// final bundle = await bundler.createFromSource(
///   'void main() => print("hello");',
///   sourcePath: 'bin/main.dart',
/// );
///
/// // From a file
/// final bundle = await bundler.createFromFile('bin/main.dart');
/// ```
class AstBundler {
  /// Library URIs handled by native bridges at runtime (skipped during bundling).
  final Set<String> bridgedLibraries;

  /// Additional source code keyed by URI string, for imports that cannot
  /// be resolved from disk.
  final Map<String, String> explicitSources;

  /// The package name of the entry point project.
  /// Used to determine which `package:*` imports are "same-package"
  /// and should be auto-included.
  final String? packageName;

  /// The project root directory for resolving file paths.
  /// This is the directory containing `pubspec.yaml`.
  final String? projectRoot;

  /// Configuration for import resolution behavior.
  final AstBundlerConfig config;

  /// The [AstConverter] used for parsing. Injected for testability.
  final AstConverter _converter;

  /// Creates an [AstBundler].
  ///
  /// - [bridgedLibraries] — URIs of libraries handled by native bridges
  /// - [explicitSources] — additional source code keyed by URI
  /// - [packageName] — the current package name (auto-detected from pubspec if null)
  /// - [projectRoot] — project root directory (auto-detected if null)
  /// - [config] — import resolution configuration
  /// - [converter] — custom [AstConverter] (defaults to a new instance)
  AstBundler({
    this.bridgedLibraries = const {},
    this.explicitSources = const {},
    this.packageName,
    this.projectRoot,
    this.config = const AstBundlerConfig(),
    AstConverter? converter,
  }) : _converter = converter ?? AstConverter();

  // ===========================================================================
  // Public API
  // ===========================================================================

  /// Creates an [AstBundle] from a source code string.
  ///
  /// [source] is parsed as a Dart compilation unit. All imports are
  /// recursively resolved according to the resolution rules.
  ///
  /// [sourcePath] is the logical path for the entry point (used as the
  /// bundle's entry point URI and for resolving relative imports).
  /// Defaults to `'main.dart'`.
  Future<AstBundle> createFromSource(
    String source, {
    String sourcePath = 'main.dart',
  }) async {
    final entryUri = sourcePath;
    final modules = <String, SCompilationUnit>{};

    // Parse and collect entry point
    final entryAst = _parseSourceCode(source, path: sourcePath);
    modules[entryUri] = entryAst;

    // Recursively resolve imports
    await _resolveImports(entryAst, Uri.parse(entryUri), modules, depth: 0);

    return AstBundle(entryPointUri: entryUri, modules: modules);
  }

  /// Creates an [AstBundle] from a file path.
  ///
  /// The file is read and parsed. The [entryPointPath] is used as the
  /// entry point URI. If [packageName] is set, relative paths are
  /// converted to `package:` URIs where appropriate.
  Future<AstBundle> createFromFile(String entryPointPath) async {
    final file = File(entryPointPath);
    if (!file.existsSync()) {
      throw ArgumentError('Entry point file not found: $entryPointPath');
    }

    final source = await file.readAsString();

    // Determine the entry point URI
    final root = projectRoot ?? _detectProjectRoot(entryPointPath);
    final entryUri = root != null
        ? p.relative(entryPointPath, from: root)
        : entryPointPath;

    final modules = <String, SCompilationUnit>{};

    // Parse entry point
    final entryAst = _parseSourceCode(source, path: entryPointPath);
    modules[entryUri] = entryAst;

    // Recursively resolve imports
    await _resolveImports(
      entryAst,
      Uri.parse(entryUri),
      modules,
      depth: 0,
      fileSystemRoot: root,
    );

    return AstBundle(entryPointUri: entryUri, modules: modules);
  }

  // ===========================================================================
  // Import Resolution
  // ===========================================================================

  /// Recursively resolves imports from an AST, adding discovered modules
  /// to [modules].
  Future<void> _resolveImports(
    SCompilationUnit ast,
    Uri moduleUri,
    Map<String, SCompilationUnit> modules, {
    required int depth,
    String? fileSystemRoot,
  }) async {
    if (depth >= config.maxImportDepth) {
      throw StateError(
        'Import depth exceeded ${config.maxImportDepth} '
        'while processing $moduleUri. Possible circular import chain.',
      );
    }

    for (final directive in ast.directives) {
      String? uriString;

      if (directive is SImportDirective) {
        uriString = _extractUriString(directive.uri);
      } else if (directive is SExportDirective) {
        uriString = _extractUriString(directive.uri);
      } else if (config.followPartDirectives && directive is SPartDirective) {
        uriString = _extractUriString(directive.uri);
      }

      if (uriString == null) continue;

      final importUri = Uri.parse(uriString);
      final resolvedUri = _resolveUri(importUri, moduleUri);
      final canonicalUri = resolvedUri.toString();

      // Skip if already processed
      if (modules.containsKey(canonicalUri)) continue;

      // Resolve the import
      final resolution = await _resolveImportUri(
        resolvedUri,
        moduleUri: moduleUri,
        fileSystemRoot: fileSystemRoot,
      );

      switch (resolution.action) {
        case ImportAction.skip:
          // dart:*, bridged — nothing to add
          break;

        case ImportAction.include:
          final importedAst = _parseSourceCode(
            resolution.value!,
            path: resolution.canonicalUri,
          );
          modules[resolution.canonicalUri] = importedAst;

          // Recurse into the imported module's imports
          await _resolveImports(
            importedAst,
            resolvedUri,
            modules,
            depth: depth + 1,
            fileSystemRoot: fileSystemRoot,
          );

        case ImportAction.error:
          throw StateError(
            'Cannot resolve import "$uriString" '
            'from $moduleUri: ${resolution.value}',
          );
      }
    }
  }

  /// Resolves a single import URI to an [ImportResolution].
  Future<ImportResolution> _resolveImportUri(
    Uri resolvedUri, {
    required Uri moduleUri,
    String? fileSystemRoot,
  }) async {
    final uriString = resolvedUri.toString();

    // 1. Stdlib schemes (dart:*)
    if (config.stdlibSchemes.contains(resolvedUri.scheme)) {
      return ImportResolution.skip(canonicalUri: uriString);
    }

    // 2. Bridged libraries
    if (bridgedLibraries.contains(uriString)) {
      return ImportResolution.skip(canonicalUri: uriString);
    }

    // 3. Explicit sources
    if (explicitSources.containsKey(uriString)) {
      return ImportResolution.include(
        explicitSources[uriString]!,
        canonicalUri: uriString,
      );
    }

    // 4. Same-package imports (package:packageName/*)
    if (resolvedUri.isScheme('package') && packageName != null) {
      final packagePath = resolvedUri.pathSegments.firstOrNull;
      if (packagePath == packageName) {
        return _resolveFromFileSystem(
          resolvedUri,
          fileSystemRoot: fileSystemRoot,
        );
      }
    }

    // 5. Relative imports (no scheme) — resolve from file system
    if (!resolvedUri.hasScheme || resolvedUri.scheme.isEmpty) {
      return _resolveFromFileSystem(
        resolvedUri,
        fileSystemRoot: fileSystemRoot,
      );
    }

    // 6. Unresolvable package: import — not bridged, not same package
    if (resolvedUri.isScheme('package')) {
      return ImportResolution.error(
        'Package import "$uriString" is not bridged and not in the same package. '
        'Either add it to bridgedLibraries or provide it via explicitSources.',
        canonicalUri: uriString,
      );
    }

    // 7. Unknown scheme
    return ImportResolution.error(
      'Unsupported import scheme "${resolvedUri.scheme}" in "$uriString".',
      canonicalUri: uriString,
    );
  }

  /// Resolves an import from the file system.
  Future<ImportResolution> _resolveFromFileSystem(
    Uri uri, {
    String? fileSystemRoot,
  }) async {
    final uriString = uri.toString();
    String? filePath;

    if (uri.isScheme('package') && packageName != null) {
      // package:packageName/path → projectRoot/lib/path
      final pathInPackage =
          uri.pathSegments.skip(1).join(Platform.pathSeparator);
      final root = fileSystemRoot ?? projectRoot;
      if (root != null) {
        filePath = p.join(root, 'lib', pathInPackage);
      }
    } else {
      // Relative or absolute file path
      filePath = uri.toFilePath();
      if (fileSystemRoot != null && !p.isAbsolute(filePath)) {
        filePath = p.join(fileSystemRoot, filePath);
      }
    }

    if (filePath == null) {
      return ImportResolution.error(
        'Cannot determine file path for "$uriString". '
        'Set projectRoot or provide the source via explicitSources.',
        canonicalUri: uriString,
      );
    }

    final file = File(filePath);
    if (!file.existsSync()) {
      return ImportResolution.error(
        'Source file not found: $filePath (for import "$uriString").',
        canonicalUri: uriString,
      );
    }

    final source = await file.readAsString();
    return ImportResolution.include(source, canonicalUri: uriString);
  }

  // ===========================================================================
  // Helpers
  // ===========================================================================

  /// Extracts the URI string from a directive's URI node.
  String? _extractUriString(SStringLiteral? uriNode) {
    if (uriNode is SSimpleStringLiteral) return uriNode.value;
    return null;
  }

  /// Resolves an import URI relative to the containing module.
  Uri _resolveUri(Uri importUri, Uri moduleUri) {
    if (importUri.isScheme('dart') || importUri.isScheme('package')) {
      return importUri;
    }
    return moduleUri.resolveUri(importUri);
  }

  /// Parses source code into an [SCompilationUnit] using the analyzer.
  SCompilationUnit _parseSourceCode(String source, {String? path}) {
    final parseResult = parseString(
      content: source,
      path: path,
      throwIfDiagnostics: false,
    );

    if (parseResult.errors.isNotEmpty) {
      final errors = parseResult.errors
          .map((e) => '  ${e.message} (offset ${e.offset})')
          .join('\n');
      throw FormatException(
        'Parse errors in ${path ?? "<source>"}:\n$errors',
      );
    }

    return _converter.convertCompilationUnit(parseResult.unit);
  }

  /// Detects the project root by searching upward for `pubspec.yaml`.
  String? _detectProjectRoot(String filePath) {
    var dir = Directory(p.dirname(p.absolute(filePath)));
    while (dir.path != dir.parent.path) {
      if (File(p.join(dir.path, 'pubspec.yaml')).existsSync()) {
        return dir.path;
      }
      dir = dir.parent;
    }
    return null;
  }
}
