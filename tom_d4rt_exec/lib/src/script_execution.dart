/// Script execution utilities for D4rt.
///
/// Provides file-based script execution with import resolution.
///
/// THE SANDBOX BOUNDARY (DFIN2). [executeFile] and [executeSource] hand the
/// interpreter only the entry source; every import is read by the module
/// loader, which checks [FilesystemPermission] on the file's real path, so a
/// symlink cannot carry a read outside the grant. For the duration of the run
/// they add one implicit grant: READ on the entry script's directory tree.
/// Imports beside or below the script work without a grant, as they always
/// did, and an import outside that tree needs the host's own permission.
/// [executeFileContinued] cannot use the loader (it evaluates each file into a
/// shared environment), so it reads imports itself, but through the same
/// permission check and under the same implicit grant.
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

/// Runs [body] with READ granted on [directory]'s tree, then removes exactly
/// that grant. A permission the host granted itself is left alone: grants are
/// held by identity, so revoking this instance cannot remove the host's.
T _withScriptDirectoryGrant<T>(D4rt d4rt, String directory, T Function() body) {
  final grant = FilesystemPermission.readPath(directory);
  d4rt.grant(grant);
  try {
    return body();
  } finally {
    d4rt.revoke(grant);
  }
}

/// Execute a Dart script file with fresh interpreter state.
///
/// The module loader resolves every import from disk under
/// [FilesystemPermission] (see the library comment): READ on the script's own
/// directory tree is granted for the run, and anything outside it needs a
/// grant the host made.
///
/// [d4rt] The D4rt interpreter instance.
/// [filePath] Path to the Dart script file.
/// [log] Optional logging function.
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

  // The real path: the implicit grant is anchored where the script actually
  // lives, so a symlinked entry point cannot widen it.
  final fullPath = file.resolveSymbolicLinksSync();
  final scriptDirectory = File(fullPath).parent.path;
  final libraryUri = Uri.file(fullPath).toString();

  try {
    final source = File(fullPath).readAsStringSync();
    log?.call('Executing $libraryUri');
    final result = _withScriptDirectoryGrant(
      d4rt,
      scriptDirectory,
      () => d4rt.execute(
        library: libraryUri,
        sources: {libraryUri: source},
        basePath: scriptDirectory,
        allowFileSystemImports: true,
      ),
    );
    return ScriptExecutionResult.success(result, d4rt.loadedSourceModuleCount);
  } catch (e, stackTrace) {
    return ScriptExecutionResult.failure(e.toString(), stackTrace: stackTrace);
  }
}

/// Execute a Dart script file in the current interpreter environment.
///
/// Evaluates each imported file with [D4rt.eval], dependencies first, then the
/// main script, so every file's declarations land in the global environment.
/// Imports are read through [FilesystemPermission] on their real paths, with
/// READ on the script's directory tree granted for the run.
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

  final fullPath = file.resolveSymbolicLinksSync();
  final scriptDirectory = File(fullPath).parent.path;

  try {
    final source = File(fullPath).readAsStringSync();
    final libraryUri = Uri.file(fullPath).toString();

    return _withScriptDirectoryGrant(d4rt, scriptDirectory, () {
      final sources = <String, String>{};
      resolveImportsRecursively(
        source,
        libraryUri,
        sources,
        log,
        readFile: (path) => _readPermitted(d4rt, path),
      );

      for (final uri in sources.keys) {
        if (uri == libraryUri) continue; // The main file runs last.
        log?.call('Evaluating import: $uri');
        try {
          d4rt.eval(sources[uri]!);
        } catch (e) {
          log?.call('Error evaluating $uri: $e');
          rethrow;
        }
      }

      log?.call('Evaluating main: $libraryUri');
      final result = d4rt.eval(source);
      return ScriptExecutionResult.success(result, sources.length);
    });
  } catch (e, stackTrace) {
    return ScriptExecutionResult.failure(e.toString(), stackTrace: stackTrace);
  }
}

/// Reads [path] only if the interpreter may read its REAL path.
String _readPermitted(D4rt d4rt, String path) {
  final realPath = File(path).resolveSymbolicLinksSync();
  if (!d4rt.checkPermission({
    'type': 'filesystem',
    'path': realPath,
    'read': true,
  })) {
    throw RuntimeD4rtException(
      'Reading module source from "$realPath" requires FilesystemPermission.',
    );
  }
  return File(realPath).readAsStringSync();
}

/// Execute a Dart script from source code with a basePath for import resolution.
///
/// The module loader resolves imports from disk under [FilesystemPermission],
/// with READ on [basePath]'s tree granted for the run (see the library
/// comment).
///
/// [d4rt] The D4rt interpreter instance.
/// [source] The Dart source code to execute.
/// [basePath] Base directory path for resolving relative imports.
/// [scriptName] Optional name for the script (defaults to '__script__.dart').
/// [log] Optional logging function.
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
    final directory = Directory(basePath).absolute.path;
    final libraryUri = Uri.file('$directory/$scriptName').toString();
    log?.call('Executing $libraryUri');
    final result = _withScriptDirectoryGrant(
      d4rt,
      directory,
      () => d4rt.execute(
        library: libraryUri,
        sources: {libraryUri: source},
        basePath: directory,
        allowFileSystemImports: true,
      ),
    );
    return ScriptExecutionResult.success(result, d4rt.loadedSourceModuleCount);
  } catch (e, stackTrace) {
    return ScriptExecutionResult.failure(e.toString(), stackTrace: stackTrace);
  }
}

/// Recursively collects a Dart source file and its relative imports.
///
/// A HOST-SIDE utility, not a sandbox boundary: by default it reads whatever
/// the host process can read. The script runners above route their reads
/// through the interpreter's permissions instead; [readFile] is how
/// [executeFileContinued] does that. Hosts use it to bundle trusted sources
/// (tom_d4rt_flutter's sample loader).
///
/// [source] The Dart source code to analyze.
/// [sourceUri] The URI of the source file (used as key in sources map and for
/// resolving relative imports).
/// [sources] The map to populate with URI -> source code pairs.
/// [log] Optional logging function for debugging.
/// [readFile] Reads one imported file by path; defaults to a plain read.
void resolveImportsRecursively(
  String source,
  String sourceUri,
  Map<String, String> sources,
  void Function(String)? log, {
  String Function(String path)? readFile,
}) {
  if (sources.containsKey(sourceUri)) return;

  sources[sourceUri] = source;
  log?.call('Added to sources: $sourceUri');

  final base = Uri.parse(sourceUri);
  if (base.scheme != 'file') return;

  for (final match in _importRegex.allMatches(source)) {
    final importPath = match.group(1)!;

    // package: and dart: imports are handled by D4rt's bridge system.
    if (importPath.startsWith('package:') || importPath.startsWith('dart:')) {
      continue;
    }

    // `Uri.resolve` handles `.`, `..` and absolute paths per RFC 3986.
    final resolved = base.resolve(importPath);
    if (resolved.scheme != 'file') continue;
    final resolvedUri = resolved.toString();
    if (sources.containsKey(resolvedUri)) continue;

    final filePath = resolved.toFilePath();
    if (!File(filePath).existsSync()) {
      log?.call('Warning: Imported file not found: $filePath');
      continue;
    }
    final importedSource = (readFile ?? _readPlain)(filePath);
    log?.call('Loading imported file: $filePath');
    resolveImportsRecursively(
      importedSource,
      resolvedUri,
      sources,
      log,
      readFile: readFile,
    );
  }
}

String _readPlain(String path) => File(path).readAsStringSync();
