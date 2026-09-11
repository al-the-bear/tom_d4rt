/// Whether the companion app resolves what this package resolves.
///
/// The corpus runs its scripts inside a companion app under `test/`, which is
/// a separate package with its own gitignored `pubspec.lock`. Nothing
/// re-resolves it when this package moves, so it can quietly keep an older
/// interpreter: the source twin's app was once locked to tom_d4rt 1.22.0 while
/// the package itself was on 1.30.x, and the corpus certified the old
/// interpreter for as long as nobody read the lock. When the gap is wide enough
/// to break the build, the app never answers `/health`, and the run used to
/// end — minutes later — in "test app failed to start" with nothing naming the
/// lock.
///
/// So the harness asks two questions before it launches the app, from files
/// already on disk:
///
///   * every hosted `tom_*` package the app resolves must be the version this
///     package resolves — otherwise the corpus measures a different
///     interpreter from the one the package is tested against;
///   * the app's lock must record this package at its current version — a
///     path dependency resolves the tree either way, but a stale entry means
///     nobody has resolved the app since this package was bumped.
///
/// This file is identical in both flutter twins
/// (`test/companion_app_resolution.dart`); the AST twin's
/// `test/companion_app_resolution_test.dart` fails when the copies differ.
library;

import 'dart:io';

/// One entry of a `pubspec.lock`.
class LockedPackage {
  const LockedPackage(this.name, this.version, this.source);

  final String name;
  final String version;

  /// `hosted`, `path`, `sdk` or `git`.
  final String source;
}

/// The packages recorded in [packageDir]'s `pubspec.lock`, by name; empty when
/// there is no lock.
///
/// Hand-parsed rather than read with `package:yaml`: the lock is machine
/// written with a fixed shape — package names at two spaces, their fields at
/// four — and this file must not depend on anything either twin might lack.
Map<String, LockedPackage> readLockedPackages(String packageDir) {
  final lock = File('$packageDir/pubspec.lock');
  if (!lock.existsSync()) return const {};
  final namePattern = RegExp(r'^  ([A-Za-z0-9_]+):\s*$');
  final fieldPattern = RegExp(r'^    (source|version):\s*"?([^"]*)"?\s*$');

  final packages = <String, LockedPackage>{};
  String? name;
  String? source;
  String? version;
  void flush() {
    if (name != null && source != null && version != null) {
      packages[name!] = LockedPackage(name!, version!, source!);
    }
    name = source = version = null;
  }

  for (final line in lock.readAsLinesSync()) {
    final nameMatch = namePattern.firstMatch(line);
    if (nameMatch != null) {
      flush();
      name = nameMatch.group(1);
      continue;
    }
    final field = fieldPattern.firstMatch(line);
    if (name == null || field == null) continue;
    if (field.group(1) == 'source') {
      source = field.group(2);
    } else {
      version = field.group(2);
    }
  }
  flush();
  return packages;
}

/// The `name:` and `version:` of [packageDir]'s `pubspec.yaml`.
({String? name, String? version}) readPubspecIdentity(String packageDir) {
  final pubspec = File('$packageDir/pubspec.yaml');
  if (!pubspec.existsSync()) return (name: null, version: null);
  final text = pubspec.readAsStringSync();
  String? field(String key) =>
      RegExp('^$key:\\s*(\\S+)', multiLine: true).firstMatch(text)?.group(1);
  return (name: field('name'), version: field('version'));
}

/// What stops [appDir] from certifying what [parentDir] resolves, one line per
/// problem; empty when the app is in step.
List<String> companionResolutionMismatches({
  required String parentDir,
  required String appDir,
}) {
  final app = readLockedPackages(appDir);
  if (app.isEmpty) {
    return ['the app has no pubspec.lock — it has never been resolved here'];
  }
  final parent = readLockedPackages(parentDir);
  final identity = readPubspecIdentity(parentDir);

  final problems = <String>[];
  for (final entry in app.values) {
    // This package first, whatever its name: the app's lock entry for it is
    // what says whether the app was resolved since the last bump.
    if (entry.name == identity.name) {
      if (entry.version != identity.version) {
        problems.add(
          '${entry.name}: the app\'s lock records ${entry.version}, but this '
          'package is ${identity.version} — the app has not been resolved '
          'since the bump',
        );
      }
      continue;
    }
    if (!entry.name.startsWith('tom_')) continue;
    final ours = parent[entry.name];
    if (ours == null || entry.source != 'hosted' || ours.source != 'hosted') {
      continue;
    }
    if (ours.version != entry.version) {
      problems.add(
        '${entry.name}: the app resolves ${entry.version}, this package '
        'resolves ${ours.version}',
      );
    }
  }
  return problems;
}

/// Every `tom_*` package the app resolves, beside what this package resolves —
/// for the failure message when the app does not come up.
String companionResolutionReport({
  required String parentDir,
  required String appDir,
}) {
  final app = readLockedPackages(appDir);
  final parent = readLockedPackages(parentDir);
  final identity = readPubspecIdentity(parentDir);
  final lines = <String>[
    'Companion app resolution ($appDir):',
    if (app.isEmpty) '  no pubspec.lock — the app has never been resolved',
  ];
  for (final entry in app.values.where(
    (e) => e.name == identity.name || e.name.startsWith('tom_'),
  )) {
    final ours = entry.name == identity.name
        ? 'this package is ${identity.version}'
        : parent[entry.name] == null
        ? 'not resolved by this package'
        : 'this package resolves ${parent[entry.name]!.version}';
    lines.add('  ${entry.name} ${entry.version} (${entry.source}) — $ours');
  }
  return lines.join('\n');
}

/// The message the harness fails with when the app is out of step, or null.
String? companionResolutionFailure({
  required String parentDir,
  required String appDir,
}) {
  final problems = companionResolutionMismatches(
    parentDir: parentDir,
    appDir: appDir,
  );
  if (problems.isEmpty) return null;
  return [
    'The companion app does not resolve what this package resolves, so the '
        'corpus would run a different interpreter from the one this package '
        'is tested against:',
    for (final problem in problems) '  $problem',
    '',
    'Run `flutter pub get` in $appDir (the corpus runner scripts do it before '
        'the first file). `pub get` keeps a lock it can keep, so if a version '
        'does not move, run `flutter pub upgrade <package>` there.',
  ].join('\n');
}
