/// Script execution utilities for D4rt.
///
/// Provides file-based script execution with automatic import resolution.
/// This enables executing Dart scripts from files with support for relative imports.
library;

import 'dart:io';

import 'package:tom_d4rt_exec/d4rt.dart';

/// Regular expression to match import statements.
/// Matches: import 'path'; or import "path";
final _importRegex = RegExp(r'''import\s+['"]([^'"]+)['"]''');

/// Result of a script execution.
class ScriptExecutionResult {
  /// Whether the execution was successful.
  final bool success;

  /// The result value from execution (if any).
  final Object? result;

  /// Error message if execution failed.
  final String? error;

  /// Stack trace if execution failed.
  final StackTrace? stackTrace;

  /// Number of source files loaded (main script + imports).
  final int sourcesLoaded;

  ScriptExecutionResult._({
    required this.success,
    this.result,
    this.error,
    this.stackTrace,
    required this.sourcesLoaded,
  });

  /// Create a successful result.
  factory ScriptExecutionResult.success(Object? result, int sourcesLoaded) {
    return ScriptExecutionResult._(
      success: true,
      result: result,
      sourcesLoaded: sourcesLoaded,
    );
  }

  /// Create a failed result.
  factory ScriptExecutionResult.failure(
    String error, {
    StackTrace? stackTrace,
    int sourcesLoaded = 0,
  }) {
    return ScriptExecutionResult._(
      success: false,
      error: error,
      stackTrace: stackTrace,
      sourcesLoaded: sourcesLoaded,
    );
  }
}

/// Execute a Dart script file with fresh interpreter state.
///
/// This method:
/// 1. Reads the script from the file
/// 2. Recursively resolves all relative imports
/// 3. Executes using [D4rt.execute] (replaces initialization)
///
/// [d4rt] The D4rt interpreter instance.
/// [filePath] Path to the Dart script file.
/// [log] Optional logging function for debugging import resolution.
///
/// Returns a [ScriptExecutionResult] with the execution outcome.
ScriptExecutionResult executeFile(
  D4rt d4rt,
  String filePath, {
  void Function(String)? log,
}) {
  final file = File(filePath);
  
  if (!file.existsSync()) {
    return ScriptExecutionResult.failure('File not found: $filePath');
  }
  
  // Use resolveSymbolicLinksSync to normalize path (removes ./ and ..)
  final fullPath = file.resolveSymbolicLinksSync();

  try {
    final source = file.readAsStringSync();
    final basePath = file.parent.path;
    final libraryUri = 'file://$fullPath';

    // Pre-resolve all imports into sources map
    final sources = <String, String>{};
    resolveImportsRecursively(source, libraryUri, sources, log);

    // Execute with sources
    final result = d4rt.execute(
      library: libraryUri,
      sources: sources,
      basePath: basePath,
      allowFileSystemImports: true,
    );

    return ScriptExecutionResult.success(result, sources.length);
  } catch (e, stackTrace) {
    return ScriptExecutionResult.failure(
      e.toString(),
      stackTrace: stackTrace,
    );
  }
}

/// Execute a Dart script file in the current interpreter environment.
///
/// This method:
/// 1. Reads the script from the file
/// 2. Recursively resolves all relative imports
/// 3. Evaluates each imported file using [D4rt.eval]
/// 4. Evaluates the main script using [D4rt.eval]
///
/// Note: Unlike [executeFile], this uses eval() for each file, which means
/// each file's declarations are added to the global environment. The imports
/// are processed in dependency order (deepest first).
///
/// [d4rt] The D4rt interpreter instance.
/// [filePath] Path to the Dart script file.
/// [log] Optional logging function for debugging import resolution.
///
/// Returns a [ScriptExecutionResult] with the execution outcome.
ScriptExecutionResult executeFileContinued(
  D4rt d4rt,
  String filePath, {
  void Function(String)? log,
}) {
  final file = File(filePath);
  
  if (!file.existsSync()) {
    return ScriptExecutionResult.failure('File not found: $filePath');
  }
  
  // Use resolveSymbolicLinksSync to normalize path (removes ./ and ..)
  final fullPath = file.resolveSymbolicLinksSync();

  try {
    final source = file.readAsStringSync();
    final libraryUri = 'file://$fullPath';

    // Pre-resolve all imports into sources map
    final sources = <String, String>{};
    resolveImportsRecursively(source, libraryUri, sources, log);

    // Eval each imported file in reverse order (dependencies first, main last)
    // Skip the main file itself - we'll eval it at the end
    final orderedUris = sources.keys.toList();
    
    for (final uri in orderedUris) {
      if (uri == libraryUri) continue; // Skip main file
      
      final importSource = sources[uri]!;
      log?.call('Evaluating import: $uri');
      
      // Wrap in a try-catch to get better error messages
      try {
        d4rt.eval(importSource);
      } catch (e) {
        log?.call('Error evaluating $uri: $e');
        rethrow;
      }
    }
    
    // Finally eval the main file
    log?.call('Evaluating main: $libraryUri');
    final result = d4rt.eval(source);

    return ScriptExecutionResult.success(result, sources.length);
  } catch (e, stackTrace) {
    return ScriptExecutionResult.failure(
      e.toString(),
      stackTrace: stackTrace,
    );
  }
}

/// Execute a Dart script from source code with a basePath for import resolution.
///
/// This method:
/// 1. Recursively resolves all relative imports from the source
/// 2. Executes using [D4rt.execute] (replaces initialization)
///
/// [d4rt] The D4rt interpreter instance.
/// [source] The Dart source code to execute.
/// [basePath] Base directory path for resolving relative imports.
/// [scriptName] Optional name for the script (defaults to '__script__.dart').
/// [log] Optional logging function for debugging import resolution.
///
/// Returns a [ScriptExecutionResult] with the execution outcome.
ScriptExecutionResult executeSource(
  D4rt d4rt,
  String source,
  String basePath, {
  String scriptName = '__script__.dart',
  void Function(String)? log,
}) {
  try {
    final libraryUri = 'file://$basePath/$scriptName';

    // Pre-resolve all imports into sources map
    final sources = <String, String>{};
    resolveImportsRecursively(source, libraryUri, sources, log);

    // Execute with sources
    final result = d4rt.execute(
      library: libraryUri,
      sources: sources,
      basePath: basePath,
      allowFileSystemImports: true,
    );

    return ScriptExecutionResult.success(result, sources.length);
  } catch (e, stackTrace) {
    return ScriptExecutionResult.failure(
      e.toString(),
      stackTrace: stackTrace,
    );
  }
}

/// Recursively resolves imports from a Dart source file.
///
/// This function:
/// 1. Adds the source to the sources map with its URI
/// 2. Extracts all import statements from the source
/// 3. For file: and relative imports, loads the file and recursively processes its imports
///
/// [source] The Dart source code to analyze.
/// [sourceUri] The URI of the source file (used as key in sources map and for resolving relative imports).
/// [sources] The map to populate with URI -> source code pairs.
/// [log] Optional logging function for debugging.
void resolveImportsRecursively(
  String source,
  String sourceUri,
  Map<String, String> sources,
  void Function(String)? log,
) {
  // Skip if already processed
  if (sources.containsKey(sourceUri)) {
    return;
  }

  // Add this source to the map
  sources[sourceUri] = source;
  log?.call('Added to sources: $sourceUri');

  // Parse the URI to get the base directory for resolving relative imports
  final uri = Uri.parse(sourceUri);
  final baseDir =
      uri.scheme == 'file' ? File(uri.toFilePath()).parent.path : null;

  // Extract all imports
  final matches = _importRegex.allMatches(source);

  for (final match in matches) {
    final importPath = match.group(1)!;

    // Skip package: and dart: imports - these are handled by D4rt's bridge system
    if (importPath.startsWith('package:') || importPath.startsWith('dart:')) {
      continue;
    }

    String? resolvedUri;
    String? filePath;

    if (importPath.startsWith('file://')) {
      // Absolute file URI
      resolvedUri = importPath;
      filePath = Uri.parse(importPath).toFilePath();
    } else if (importPath.startsWith('/')) {
      // Absolute path without scheme
      resolvedUri = 'file://$importPath';
      filePath = importPath;
    } else if (baseDir != null) {
      // Relative path - resolve against base directory
      final resolvedPath = _resolvePath(baseDir, importPath);
      resolvedUri = 'file://$resolvedPath';
      filePath = resolvedPath;
    }

    if (resolvedUri != null &&
        filePath != null &&
        !sources.containsKey(resolvedUri)) {
      final file = File(filePath);
      if (file.existsSync()) {
        try {
          final importedSource = file.readAsStringSync();
          log?.call('Loading imported file: $filePath');
          // Recursively process the imported file
          resolveImportsRecursively(importedSource, resolvedUri, sources, log);
        } catch (e) {
          log?.call('Warning: Failed to read import $filePath: $e');
        }
      } else {
        log?.call('Warning: Imported file not found: $filePath');
      }
    }
  }
}

/// Resolves a relative path against a base directory.
/// Handles '..' and '.' path segments.
String _resolvePath(String baseDir, String relativePath) {
  final baseParts = baseDir.split('/').where((p) => p.isNotEmpty).toList();
  final relativeParts =
      relativePath.split('/').where((p) => p.isNotEmpty).toList();

  final resultParts = List<String>.from(baseParts);

  for (final part in relativeParts) {
    if (part == '..') {
      if (resultParts.isNotEmpty) {
        resultParts.removeLast();
      }
    } else if (part != '.') {
      resultParts.add(part);
    }
  }

  return '/${resultParts.join('/')}';
}
