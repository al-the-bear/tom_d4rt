/// Summary-bundle filtering for bridge generation.
///
/// Bridge generation needs full AST (default-parameter expressions,
/// annotation arguments, doc comments, token positions). `.sum` bundles
/// only carry the element model. Whenever the analyzer resolves a file
/// that also happens to be present in a loaded summary bundle, it
/// serves the element model from the bundle and the AST comes back
/// without type resolution — resulting in `dynamic` everywhere and
/// missing top-level functions / enum values in the generated bridges.
///
/// To keep summaries useful, we filter them: any package whose sources
/// the generator will actually visit (directly, or via `export`
/// directives followed through the barrels) is excluded; every other
/// dependency stays in the `.sum` cache.
library;

import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart' show ExportDirective;
import 'package:path/path.dart' as p;

import 'bridge_config.dart';

/// Collects the set of package names whose Dart libraries appear as a
/// module's `barrelImport` or `barrelFiles` entry. `dart:ui` bridging
/// maps to `sky_engine`.
Set<String> _collectDirectlyBridgedPackages(BridgeConfig bridgeConfig) {
  final names = <String>{};
  for (final module in bridgeConfig.modules) {
    final candidates = <String>[
      if (module.barrelImport != null) module.barrelImport!,
      ...module.barrelFiles,
    ];
    for (final uri in candidates) {
      if (uri.startsWith('package:')) {
        final rest = uri.substring('package:'.length);
        final slash = rest.indexOf('/');
        final pkg = slash < 0 ? rest : rest.substring(0, slash);
        if (pkg.isNotEmpty) names.add(pkg);
      } else if (uri.startsWith('dart:ui')) {
        names.add('sky_engine');
      }
    }
  }
  return names;
}

/// Reads `<projectDir>/.dart_tool/package_config.json` and returns a
/// mapping from package name to its `lib/` directory. Returns an empty
/// map if the file is missing or malformed.
Map<String, String> _readPackageLibRoots(String projectDir) {
  final file = File(p.join(projectDir, '.dart_tool', 'package_config.json'));
  if (!file.existsSync()) return const {};
  try {
    final doc = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
    final packages = doc['packages'] as List<dynamic>? ?? const [];
    final result = <String, String>{};
    for (final entry in packages) {
      final map = entry as Map<String, dynamic>;
      final name = map['name'] as String?;
      final rootUri = map['rootUri'] as String?;
      final packageUri = (map['packageUri'] as String?) ?? 'lib/';
      if (name == null || rootUri == null) continue;
      String rootPath;
      if (rootUri.startsWith('file://')) {
        rootPath = Uri.parse(rootUri).toFilePath();
      } else {
        rootPath = p.normalize(p.join(projectDir, '.dart_tool', rootUri));
      }
      result[name] = p.normalize(p.join(rootPath, packageUri));
    }
    return result;
  } catch (_) {
    return const {};
  }
}

String? _resolvePackageUri(String uri, Map<String, String> libRoots) {
  if (!uri.startsWith('package:')) return null;
  final rest = uri.substring('package:'.length);
  final slash = rest.indexOf('/');
  if (slash < 0) return null;
  final pkg = rest.substring(0, slash);
  final subPath = rest.substring(slash + 1);
  final lib = libRoots[pkg];
  if (lib == null) return null;
  return p.normalize(p.join(lib, subPath));
}

/// BFS-walks `export 'package:...'` directives from every module's
/// barrel files and collects each discovered package name. Seeds the
/// walk with directly-bridged packages so even packages whose barrel
/// is synthetic (e.g. `dart:ui` → `sky_engine`) make it into the set.
Future<Set<String>> collectBridgedAndReExportedPackages({
  required String projectDir,
  required BridgeConfig bridgeConfig,
}) async {
  final packages = _collectDirectlyBridgedPackages(bridgeConfig);
  final libRoots = _readPackageLibRoots(projectDir);
  if (libRoots.isEmpty) return packages;

  final visited = <String>{};
  final queue = <String>[];
  void enqueueUri(String uri, {String? baseFile}) {
    if (uri.startsWith('dart:')) return;
    String? path;
    if (uri.startsWith('package:')) {
      path = _resolvePackageUri(uri, libRoots);
    } else if (baseFile != null) {
      path = p.normalize(p.join(p.dirname(baseFile), uri));
    }
    if (path != null) queue.add(path);
  }

  for (final module in bridgeConfig.modules) {
    final uris = <String>[
      if (module.barrelImport != null) module.barrelImport!,
      ...module.barrelFiles,
    ];
    for (final uri in uris) {
      enqueueUri(uri);
    }
  }

  while (queue.isNotEmpty) {
    final current = queue.removeLast();
    if (!visited.add(current)) continue;
    final file = File(current);
    if (!file.existsSync()) continue;
    final String content;
    try {
      content = file.readAsStringSync();
    } catch (_) {
      continue;
    }
    try {
      final parsed = parseString(
        content: content,
        featureSet: FeatureSet.latestLanguageVersion(),
        throwIfDiagnostics: false,
      );
      for (final directive in parsed.unit.directives) {
        if (directive is! ExportDirective) continue;
        final uri = directive.uri.stringValue;
        if (uri == null) continue;
        if (uri.startsWith('package:')) {
          final rest = uri.substring('package:'.length);
          final slash = rest.indexOf('/');
          final pkg = slash < 0 ? rest : rest.substring(0, slash);
          if (pkg.isNotEmpty) packages.add(pkg);
        }
        enqueueUri(uri, baseFile: current);
      }
    } catch (_) {
      // Parse failures are non-fatal — this is only used to steer
      // summary filtering; the bridge generator has its own recovery
      // path.
    }
  }
  return packages;
}

/// Removes `.sum` entries whose package will be parsed from source.
/// Keeps the summaries for every other dependency.
///
/// When the bridged set includes `sky_engine` (i.e. `dart:ui` is being
/// bridged), the SDK summary is also dropped so the analyzer uses a
/// filesystem-backed SDK. That path runs the embedder-yaml locator,
/// which maps `{sky_engine}/lib/ui/*.dart` to the canonical `dart:ui`
/// URI — matching the element URIs the bridge generator used before
/// summaries were introduced. A `SummaryBasedDartSdk` has no file
/// mapping, so leaving the SDK summary in place re-routes `dart:ui`
/// types through `package:sky_engine/ui/ui.dart` and changes every
/// generated import in `dart_ui_bridges.b.dart`.
Future<({List<String>? summaryPaths, String? sdkSummaryPath})>
filterSummariesForBridgedPackages({
  required String projectDir,
  required List<String>? summaryPaths,
  required String? sdkSummaryPath,
  required BridgeConfig bridgeConfig,
}) async {
  if ((summaryPaths == null || summaryPaths.isEmpty) &&
      sdkSummaryPath == null) {
    return (summaryPaths: summaryPaths, sdkSummaryPath: sdkSummaryPath);
  }
  final exclusion = await collectBridgedAndReExportedPackages(
    projectDir: projectDir,
    bridgeConfig: bridgeConfig,
  );
  if (exclusion.isEmpty) {
    return (summaryPaths: summaryPaths, sdkSummaryPath: sdkSummaryPath);
  }
  final dropped = <String>[];
  final kept = <String>[];
  for (final path in summaryPaths ?? const <String>[]) {
    final base = p.basename(path);
    // Filenames look like `{name}@{version}.sum` — see
    // tom_analyzer_shared/SummaryCacheManager.
    final at = base.indexOf('@');
    final pkg = at > 0 ? base.substring(0, at) : base;
    if (exclusion.contains(pkg)) {
      dropped.add(base);
    } else {
      kept.add(path);
    }
  }
  final dropSdkSummary =
      sdkSummaryPath != null && exclusion.contains('sky_engine');
  if (dropSdkSummary) {
    dropped.add('<sdk summary>');
  }
  if (dropped.isNotEmpty) {
    print(
      '  SUMMARY-FILTER: skipping ${dropped.length} bundle(s) for bridged '
      'package(s) — source AST is required: ${dropped.join(', ')}',
    );
  }
  return (
    summaryPaths: kept,
    sdkSummaryPath: dropSdkSummary ? null : sdkSummaryPath,
  );
}
