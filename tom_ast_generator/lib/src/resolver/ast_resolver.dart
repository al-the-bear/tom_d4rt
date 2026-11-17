/// The resolving check of a bundle (ghissues68, GitHub #18 option 3 / B2).
///
/// [AstResolver] resolves the modules of a bundle with the analyzer and
/// reports the errors Dart would report - a name the script never imported,
/// a type mismatch, a missing member - which the parse-only bundler cannot
/// see. It is opt-in ([AstBundlerConfig.resolve], `astgen --resolve`); plain
/// bundling never runs it.
///
/// Two ways in:
///
/// * [checkModules] - the modules a bundle carries, as source text keyed by
///   their URI (what [AstBundler] collected, including its `explicitSources`),
///   optionally inside a project whose `.dart_tool/package_config.json`
///   supplies the packages they import. Nothing is written to disk: the
///   sources, the declaration stubs and the package configuration they need
///   are analyzer overlays.
/// * [checkFiles] - files on disk inside one project, sharing one analysis
///   context across calls, for checking many scripts (the twins' corpus).
///
/// Declaration stubs are Dart declarations for libraries that exist only at
/// run time (a host function registered with `registerTopLevelFunction`, a
/// bridged library whose source is not at hand). The resolver sees them; the
/// bundle never carries them.
library;

import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/diagnostic/diagnostic.dart';
import 'package:analyzer/error/error.dart' show DiagnosticSeverity;
import 'package:analyzer/file_system/overlay_file_system.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

import 'dart_sdk_locator.dart';

/// One analyzer error of a checked module.
class ResolveDiagnostic {
  /// The module's URI as the bundle names it (or the file path, for
  /// [AstResolver.checkFiles]).
  final String uri;

  /// 1-based line and column.
  final int line;
  final int column;

  /// The analyzer's diagnostic code, e.g. `undefined_identifier`.
  final String code;

  /// The analyzer's message.
  final String message;

  const ResolveDiagnostic({
    required this.uri,
    required this.line,
    required this.column,
    required this.code,
    required this.message,
  });

  @override
  String toString() => '$uri:$line:$column: error: $message ($code)';
}

/// The outcome of a resolving check.
class ResolveReport {
  /// How many modules (or files) were resolved.
  final int modulesChecked;

  /// The errors that fail the check.
  final List<ResolveDiagnostic> errors;

  /// The errors left out because they come only from a library that exists
  /// at run time alone (bridged or registered) and has neither source nor
  /// stub: its import, and the names a module importing it cannot resolve.
  final List<ResolveDiagnostic> filtered;

  const ResolveReport({
    required this.modulesChecked,
    required this.errors,
    required this.filtered,
  });

  /// Whether the check passed: no error is left.
  bool get passed => errors.isEmpty;

  /// How many errors were left out (see [filtered]).
  int get filteredCount => filtered.length;

  /// One line for a log: the verdict and the counts.
  String get summary =>
      '${passed ? 'passed' : 'FAILED'}: $modulesChecked module(s), '
      '${errors.length} error(s), $filteredCount filtered '
      '(runtime-only libraries without source or stub)';
}

/// The resolving check failed: [report] holds the errors. [AstBundler]
/// throws it and writes no bundle.
class AstResolveException implements Exception {
  final ResolveReport report;

  AstResolveException(this.report);

  @override
  String toString() =>
      'AstResolveException: the resolving check found '
      '${report.errors.length} error(s):\n'
      '${report.errors.map((e) => '  $e').join('\n')}'
      '${report.filteredCount > 0 ? '\n  (${report.filteredCount} more filtered: runtime-only libraries without source or stub)' : ''}';
}

/// Diagnostic codes of an unresolved import.
const _missingLibraryCodes = {
  'uri_does_not_exist',
  'uri_has_not_been_generated',
};

/// Diagnostic codes, besides every `undefined_*` one, of a name or type that
/// does not resolve. In a module that imports a runtime-only library without
/// source or stub, these are the errors that library's absence causes, and
/// they are left out.
const _unresolvedNameCodes = {
  'new_with_undefined_constructor',
  'new_with_undefined_constructor_default',
  'creation_with_non_type',
  'not_a_type',
  'non_type_as_type_argument',
  'non_type_in_catch_clause',
  'const_with_non_type',
  'extends_non_class',
  'implements_non_class',
  'mixin_of_non_class',
  'with_non_class',
};

/// Resolves bundle modules or project files with the analyzer and reports
/// their errors. See the library comment.
class AstResolver {
  /// The Dart SDK to analyze against; found with [findDartSdk] when null.
  final String? sdkPath;

  /// The environment [findDartSdk] reads (`DART_SDK`, `PATH`); the process's
  /// when null.
  final Map<String, String>? environment;

  AstResolver({this.sdkPath, this.environment});

  String? _sdk;

  /// The SDK in use, found on first use.
  String get dartSdk =>
      _sdk ??= findDartSdk(explicitPath: sdkPath, environment: environment);

  /// Resolves [modules] (module URI -> source) and returns the report.
  ///
  /// A `package:` URI is placed where [projectRoot]'s package configuration
  /// puts its package, or, for a package it does not know (or without a
  /// project), in a virtual package of its own; a URI without a scheme is
  /// relative to [projectRoot] (or the virtual root). [stubs] (URI -> source)
  /// are placed the same way and are resolved against, never reported on.
  /// [runtimeOnlyLibraries] are the URIs that exist at run time alone (the
  /// bundler's `bridgedLibraries`): a module importing one that has neither
  /// source nor stub has the errors that causes filtered out
  /// ([ResolveReport.filtered]).
  Future<ResolveReport> checkModules({
    required Map<String, String> modules,
    Map<String, String> stubs = const {},
    Set<String> runtimeOnlyLibraries = const {},
    String? projectRoot,
  }) async {
    final workspace = _Workspace(
      projectRoot != null
          ? p.normalize(p.absolute(projectRoot))
          : p.join(
              Directory.systemTemp.path,
              'd4rt_astgen_resolve_${pid}_${_virtualRoots++}',
            ),
      isProject: projectRoot != null,
      languageVersion: _sdkLanguageVersion(),
    );
    final modulePaths = <String, String>{
      for (final MapEntry(key: uri, value: source) in modules.entries)
        uri: workspace.place(uri, source),
    };
    for (final MapEntry(key: uri, value: source) in stubs.entries) {
      if (!modules.containsKey(uri)) workspace.place(uri, source);
    }
    workspace.finish();

    final collection = AnalysisContextCollection(
      includedPaths: [workspace.root],
      resourceProvider: workspace.provider,
      sdkPath: dartSdk,
    );
    try {
      return await _resolveAll(collection, modulePaths, runtimeOnlyLibraries);
    } finally {
      await collection.dispose();
    }
  }

  /// Resolves each module of [paths] (URI -> path) in [collection].
  Future<ResolveReport> _resolveAll(
    AnalysisContextCollection collection,
    Map<String, String> paths,
    Set<String> runtimeOnlyLibraries,
  ) async {
    final errors = <ResolveDiagnostic>[];
    final filtered = <ResolveDiagnostic>[];
    for (final MapEntry(key: uri, value: path) in paths.entries) {
      final result = await collection
          .contextFor(path)
          .currentSession
          .getResolvedUnit(path);
      if (result is! ResolvedUnitResult) {
        errors.add(
          ResolveDiagnostic(
            uri: uri,
            line: 1,
            column: 1,
            code: 'not_resolved',
            message: 'the analyzer could not resolve the module ($result)',
          ),
        );
        continue;
      }
      final moduleUri = Uri.parse(uri);
      _collect(
        result,
        uri,
        moduleUri.hasScheme ? moduleUri : Uri.file(path),
        runtimeOnlyLibraries,
        errors,
        filtered,
      );
    }
    return ResolveReport(
      modulesChecked: paths.length,
      errors: errors,
      filtered: filtered,
    );
  }

  static int _virtualRoots = 0;

  final Map<String, AnalysisContextCollection> _projectCollections = {};

  /// Resolves the files [paths] (on disk) of the project at [projectRoot]
  /// and returns one report over all of them, with [stubs] (URI -> source)
  /// placed as in [checkModules]. The project's analysis context is created
  /// once and kept for later calls with the same root, so checking many files
  /// costs the analyzer's start once; the stubs of the first call are the
  /// ones that context sees. Call [dispose] when done.
  Future<ResolveReport> checkFiles(
    List<String> paths, {
    required String projectRoot,
    Map<String, String> stubs = const {},
    Set<String> runtimeOnlyLibraries = const {},
  }) async {
    final root = p.normalize(p.absolute(projectRoot));
    final collection = _projectCollections[root] ??= () {
      final workspace = _Workspace(
        root,
        isProject: true,
        languageVersion: _sdkLanguageVersion(),
      );
      for (final MapEntry(key: uri, value: source) in stubs.entries) {
        workspace.place(uri, source);
      }
      workspace.finish();
      return AnalysisContextCollection(
        includedPaths: [root],
        resourceProvider: workspace.provider,
        sdkPath: dartSdk,
      );
    }();
    return _resolveAll(collection, {
      for (final file in paths)
        p.normalize(p.absolute(file)): p.normalize(p.absolute(file)),
    }, runtimeOnlyLibraries);
  }

  /// Releases the analysis contexts [checkFiles] keeps.
  Future<void> dispose() async {
    for (final collection in _projectCollections.values) {
      await collection.dispose();
    }
    _projectCollections.clear();
  }

  /// Sorts [result]'s errors into [errors] and [filtered].
  void _collect(
    ResolvedUnitResult result,
    String uri,
    Uri moduleUri,
    Set<String> runtimeOnlyLibraries,
    List<ResolveDiagnostic> errors,
    List<ResolveDiagnostic> filtered,
  ) {
    final diagnostics = result.diagnostics
        .where((d) => d.diagnosticCode.severity == DiagnosticSeverity.ERROR)
        .toList();

    // An import of a runtime-only library without source or stub is not an
    // error of the script; the names that library would have supplied do not
    // resolve, and those errors are its, too.
    final missingRuntimeOnly = <Diagnostic>{};
    for (final d in diagnostics) {
      if (!_missingLibraryCodes.contains(_code(d))) continue;
      final directiveUri = _directiveUriAt(result.unit, d.offset);
      if (directiveUri == null) continue;
      final canonical = _canonical(directiveUri, moduleUri);
      if (runtimeOnlyLibraries.contains(canonical) ||
          runtimeOnlyLibraries.contains(directiveUri)) {
        missingRuntimeOnly.add(d);
      }
    }

    for (final d in diagnostics) {
      final location = result.lineInfo.getLocation(d.offset);
      final entry = ResolveDiagnostic(
        uri: uri,
        line: location.lineNumber,
        column: location.columnNumber,
        code: _code(d),
        message: d.message,
      );
      final leaveOut =
          missingRuntimeOnly.contains(d) ||
          (missingRuntimeOnly.isNotEmpty &&
              (_code(d).startsWith('undefined_') ||
                  _unresolvedNameCodes.contains(_code(d))));
      (leaveOut ? filtered : errors).add(entry);
    }
  }

  static String _code(Diagnostic d) => d.diagnosticCode.lowerCaseName;

  /// The URI string of the directive of [unit] whose URI covers [offset].
  static String? _directiveUriAt(CompilationUnit unit, int offset) {
    for (final directive in unit.directives) {
      if (directive is UriBasedDirective) {
        final uri = directive.uri;
        if (offset >= uri.offset && offset <= uri.end) {
          return uri.stringValue;
        }
      }
    }
    return null;
  }

  static String _canonical(String uri, Uri moduleUri) {
    final parsed = Uri.parse(uri);
    if (parsed.hasScheme) return uri;
    return moduleUri.resolveUri(parsed).toString();
  }

  /// `<major>.<minor>` of the SDK in use, the language version a virtual
  /// package gets.
  String _sdkLanguageVersion() {
    final version = File(p.join(dartSdk, 'version')).readAsStringSync().trim();
    final parts = version.split('.');
    return parts.length >= 2 ? '${parts[0]}.${parts[1]}' : '3.0';
  }
}

/// The files the analyzer sees for one check: [root]'s own, plus overlays
/// for the sources and stubs [place] puts in, and the package configuration
/// they need ([finish]).
class _Workspace {
  /// The project root, or a virtual folder that exists only as overlays.
  final String root;

  /// Whether [root] is a project on disk (its package configuration is read
  /// and extended) or virtual.
  final bool isProject;

  /// The language version a virtual package gets.
  final String languageVersion;

  final OverlayResourceProvider provider = OverlayResourceProvider(
    PhysicalResourceProvider.INSTANCE,
  );

  late final Map<String, _Package> _packages = isProject
      ? _readPackageConfig(root)
      : {};
  bool _addedPackage = false;

  _Workspace(
    this.root, {
    required this.isProject,
    required this.languageVersion,
  });

  /// Puts [source] where [uri] lives and returns that path. A `package:` URI
  /// goes where the package configuration puts its package, or into a
  /// virtual package of its own under [root]; a URI without a scheme is
  /// relative to [root].
  String place(String uri, String source) {
    final path = _pathOf(uri);
    provider.setOverlay(path, content: source, modificationStamp: 0);
    return path;
  }

  String _pathOf(String uri) {
    final parsed = Uri.parse(uri);
    if (parsed.isScheme('package') && parsed.pathSegments.isNotEmpty) {
      final name = parsed.pathSegments.first;
      final rest = parsed.pathSegments.skip(1).join('/');
      final package = _packages[name] ??= () {
        _addedPackage = true;
        return _Package(
          name,
          p.join(root, '__d4rt_resolve__', name),
          'lib/',
          languageVersion,
        );
      }();
      return p.normalize(p.join(package.libPath, rest));
    }
    if (parsed.isScheme('file')) return parsed.toFilePath();
    return p.normalize(p.join(root, uri));
  }

  /// Writes the overlays the placed files need: the package configuration
  /// when a virtual package was added or [root] is virtual, a pubspec for a
  /// virtual [root], and, in a project, each `analysis_options.yaml` without
  /// its `analyzer: exclude` - a file the check is asked about is resolved
  /// even when the project keeps it out of `dart analyze` (the twins' corpus
  /// fixtures are excluded so). Nothing on disk changes.
  void finish() {
    if (isProject) _dropAnalysisExcludes();
    if (!isProject || _addedPackage) {
      provider.setOverlay(
        p.join(root, '.dart_tool', 'package_config.json'),
        content: _packageConfigJson(_packages.values),
        modificationStamp: 0,
      );
    }
    if (!isProject) {
      provider.setOverlay(
        p.join(root, 'pubspec.yaml'),
        content: 'name: d4rt_astgen_resolve\n',
        modificationStamp: 0,
      );
    }
  }

  /// Overlays every `analysis_options.yaml` under [root] that has an
  /// `analyzer: exclude` with the same options without it (as JSON, which is
  /// YAML). Hidden folders and `build/` are not searched.
  void _dropAnalysisExcludes() {
    final pending = [Directory(root)];
    while (pending.isNotEmpty) {
      final dir = pending.removeLast();
      final List<FileSystemEntity> entries;
      try {
        entries = dir.listSync(followLinks: false);
      } on FileSystemException {
        continue;
      }
      for (final entry in entries) {
        final name = p.basename(entry.path);
        if (entry is Directory) {
          if (!name.startsWith('.') && name != 'build') pending.add(entry);
        } else if (entry is File && name == 'analysis_options.yaml') {
          final text = entry.readAsStringSync();
          if (!text.contains('exclude')) continue;
          final options = _plain(loadYaml(text));
          if (options is! Map<String, Object?>) continue;
          final analyzer = options['analyzer'];
          if (analyzer is! Map<String, Object?> ||
              !analyzer.containsKey('exclude')) {
            continue;
          }
          analyzer.remove('exclude');
          provider.setOverlay(
            entry.path,
            content: jsonEncode(options),
            modificationStamp: 0,
          );
        }
      }
    }
  }

  /// [yaml] as plain maps and lists.
  static Object? _plain(Object? yaml) => switch (yaml) {
    YamlMap() => <String, Object?>{
      for (final e in yaml.entries) '${e.key}': _plain(e.value),
    },
    YamlList() => [for (final v in yaml) _plain(v)],
    _ => yaml,
  };

  /// The packages of [root]'s `.dart_tool/package_config.json`, by name.
  static Map<String, _Package> _readPackageConfig(String root) {
    final file = File(p.join(root, '.dart_tool', 'package_config.json'));
    final packages = <String, _Package>{};
    if (!file.existsSync()) return packages;
    final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
    final configDir = Uri.directory(p.join(root, '.dart_tool'));
    for (final entry
        in (json['packages'] as List).cast<Map<String, dynamic>>()) {
      final name = entry['name'] as String;
      var rootUri = entry['rootUri'] as String;
      if (!rootUri.endsWith('/')) rootUri = '$rootUri/';
      final packageRoot = configDir.resolve(rootUri).toFilePath();
      packages[name] = _Package(
        name,
        p.normalize(packageRoot),
        (entry['packageUri'] as String?) ?? 'lib/',
        entry['languageVersion'] as String?,
      );
    }
    return packages;
  }

  static String _packageConfigJson(Iterable<_Package> packages) =>
      const JsonEncoder.withIndent('  ').convert({
        'configVersion': 2,
        'packages': [
          for (final package in packages)
            {
              'name': package.name,
              'rootUri': Uri.directory(package.root).toString(),
              'packageUri': package.packageUri,
              'languageVersion': ?package.languageVersion,
            },
        ],
      });
}

class _Package {
  final String name;
  final String root;
  final String packageUri;
  final String? languageVersion;

  _Package(this.name, this.root, this.packageUri, this.languageVersion);

  String get libPath => p.join(root, packageUri);
}
