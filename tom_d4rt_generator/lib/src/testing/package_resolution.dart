/// Whether a Dart project still resolves, asked of pub rather than inferred.
///
/// WHY THIS EXISTS. Example projects sit behind `buildkit_skip.yaml`, so no
/// workspace scan resolves them, and a project that stops resolving keeps its
/// last `.dart_tool/package_config.json`. Everything that reads that config
/// then fails on its first downstream symptom. In the case that prompted this,
/// an example's config still named analyzer 8.4.1, long gone from the pub
/// cache, and the reported error was `DiagnosticSeverity is not defined` — an
/// apparent analyzer API break that sent the investigation the wrong way.
///
/// WHY NOT A TIMESTAMP CHECK. "`pubspec.yaml` is newer than the package
/// config" looks like the obvious staleness test and is wrong: measured,
/// `dart pub get` rewrites neither `package_config.json` nor `pubspec.lock`
/// when the resolution is unchanged, so after any edit that does not change
/// the resolution the comparison reports "stale" forever. The only reliable
/// question is to resolve. `dart pub get --offline` answers it in about a
/// second, needs no network, and writes nothing when the resolution is current.
///
/// WHAT PUB CANNOT SEE. A cached package directory that exists but lost its
/// `pubspec.yaml` (shape B in `_copilot_guidelines/dart/pub_cache_troubleshooting.md`)
/// passes a resolve — pub treats the directory's existence as "installed". So
/// after resolving, [resolutionProblems] reads the config once more.
library;

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

import 'project_discovery.dart';

/// Directories under [root] that contain a `pubspec.yaml`, relative to [root]
/// and sorted. `.dart_tool` and `build` trees are skipped.
List<String> findDartProjects(String root) =>
    projectDirectoriesUnder(root, 'pubspec.yaml');

/// What is wrong with [projectPath]'s `.dart_tool/package_config.json`, as
/// read from disk — without running pub. Empty means every package the config
/// names is present.
///
/// It reports a missing or unreadable config, a package directory that no
/// longer exists (the cache lost it, or a path dependency moved), and a
/// directory that exists without a `pubspec.yaml` — the one damage `dart pub
/// get` does not repair.
List<String> resolutionProblems(String projectPath) {
  final configFile = File(
    p.join(projectPath, '.dart_tool', 'package_config.json'),
  );
  if (!configFile.existsSync()) {
    return ['no .dart_tool/package_config.json — never resolved here'];
  }
  final Object? decoded;
  try {
    decoded = jsonDecode(configFile.readAsStringSync());
  } on FormatException catch (e) {
    return ['.dart_tool/package_config.json is not valid JSON: ${e.message}'];
  }
  final packages = decoded is Map ? decoded['packages'] : null;
  if (packages is! List) {
    return ['.dart_tool/package_config.json has no "packages" list'];
  }

  final configDir = configFile.parent.uri;
  final problems = <String>[];
  for (final entry in packages) {
    if (entry is! Map) continue;
    final name = entry['name'];
    final rootUri = entry['rootUri'];
    if (name is! String || rootUri is! String) continue;
    // Relative rootUris resolve against the config file's own directory, per
    // the package_config specification; absolute ones are `file:` URIs.
    final root = p.fromUri(configDir.resolve(rootUri));
    if (!Directory(root).existsSync()) {
      problems.add('$name: $root no longer exists');
    } else if (!File(p.join(root, 'pubspec.yaml')).existsSync()) {
      problems.add(
        '$name: $root has no pubspec.yaml — delete that directory, then '
        '`dart pub get` (pub treats its existence as installed)',
      );
    }
  }
  return problems;
}

/// Makes sure [projectPath] resolves, and returns what is wrong, or null.
///
/// Runs `dart pub get --offline` — about a second, no network, no writes when
/// the resolution is current — and, only if that fails, `dart pub get`, which
/// may download what the cache lost. A failure returns pub's own message,
/// which names the real cause (`version solving failed`, a missing path
/// dependency) instead of a downstream symptom. After a successful resolve,
/// [resolutionProblems] must come back empty.
///
/// `checkBridgeFreshness` refuses an unresolved package, because resolving
/// writes to it. A test of its own examples may resolve them as a setup step,
/// as `D4rtTester.prepareBridges` does: what `pub get` writes — `.dart_tool/`
/// and `pubspec.lock` — is gitignored in this workspace.
Future<String?> resolveIfUnresolved(String projectPath) async {
  final before = resolutionProblems(projectPath);

  var result = await _pubGet(projectPath, offline: true);
  if (result.exitCode != 0) {
    result = await _pubGet(projectPath, offline: false);
  }
  if (result.exitCode != 0) {
    return [
      '`dart pub get` failed in $projectPath:',
      '${result.stderr}'.trim(),
      if (before.isNotEmpty) ...[
        'Its package config was already broken:',
        ...before.map((problem) => '  $problem'),
      ],
    ].join('\n');
  }

  final after = resolutionProblems(projectPath);
  if (after.isEmpty) return null;
  return [
    '$projectPath resolved, but its package config is still broken:',
    ...after.map((problem) => '  $problem'),
  ].join('\n');
}

Future<ProcessResult> _pubGet(String projectPath, {required bool offline}) =>
    Process.run('dart', [
      'pub',
      'get',
      if (offline) '--offline',
    ], workingDirectory: projectPath);
