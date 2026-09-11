/// Whether a fixture project resolves its host's dependencies the way the
/// host does.
///
/// WHY THIS EXISTS. An example project reaches the package it exercises by
/// `path: ../..`. A path dependency supplies the SOURCE but not the
/// RESOLUTION: the fixture compiles the host's worktree `lib/` against the
/// FIXTURE's lock. A stale fixture lock therefore type-checks current
/// first-party source against an old third-party dependency, and what the
/// reader is shown is a compile error inside `../../lib/` — a directory the
/// fixture does not own and whose contents are correct.
///
/// The measured instance: every `tom_d4rt_exec/example/*/pubspec.lock` pinned
/// `tom_d4rt_ast` 0.19.0 while exec's own lib needed 0.20.x. It surfaced as
/// `The getter 'Logger' isn't defined for the type 'ModuleLoader'` followed by
/// `Bad state: Generating AOT kernel dill failed!`, and cost a full triage
/// cycle to rule out as a real defect (scd9_aicx). Lock files are gitignored,
/// so the drift never shows in `git status` and accumulates silently until an
/// interpreter change happens to touch a member the old version lacks.
///
/// This is the DGUC10 lock-vs-constraint pattern in its most confusing shape:
/// the file named in the error is not the file that is wrong, and the pubspec
/// that is wrong names no version at all.
library;

import 'dart:io';

import 'package:path/path.dart' as p;

/// One package a fixture resolves differently from its host.
class ResolutionMismatch {
  ResolutionMismatch({
    required this.fixturePath,
    required this.package,
    required this.hostVersion,
    required this.fixtureVersion,
  });

  /// The fixture project that resolved [package] at [fixtureVersion].
  final String fixturePath;

  /// Package name as both locks spell it.
  final String package;

  /// What the host resolves — the version its `lib/` is written against.
  final String hostVersion;

  /// What the fixture resolves, and therefore compiles the host's lib against.
  final String fixtureVersion;

  @override
  String toString() => '${p.basename(fixturePath)}: $package '
      '$fixtureVersion, host has $hostVersion';
}

/// Packages [fixtureProjectPath] resolves differently from
/// [hostProjectPath], in lock order.
///
/// Only the host's RUNTIME dependencies are compared — the ones whose API its
/// `lib/` is compiled against, which the lock labels `direct main` or
/// `transitive`. A `direct dev` package cannot produce this failure, and
/// comparing everything reports benign differences instead: measured across
/// the three d4rt packages with examples, every such difference was `lints`.
///
/// Returns empty when either side has no lock file: a project that has never
/// resolved is a different problem, with its own check.
List<ResolutionMismatch> compareFixtureResolution({
  required String hostProjectPath,
  required String fixtureProjectPath,
}) {
  final host = _hostedVersions(hostProjectPath, runtimeOnly: true);
  if (host.isEmpty) return const [];
  final fixture = _hostedVersions(fixtureProjectPath, runtimeOnly: false);
  if (fixture.isEmpty) return const [];

  final mismatches = <ResolutionMismatch>[];
  for (final entry in host.entries) {
    final fixtureVersion = fixture[entry.key];
    // A fixture need not use everything the host does.
    if (fixtureVersion == null || fixtureVersion == entry.value) continue;
    mismatches.add(ResolutionMismatch(
      fixturePath: fixtureProjectPath,
      package: entry.key,
      hostVersion: entry.value,
      fixtureVersion: fixtureVersion,
    ));
  }
  return mismatches;
}

/// A report naming each drifted package, why the fixture's lock governs, and
/// the repair.
String describeMismatches(List<ResolutionMismatch> mismatches) {
  if (mismatches.isEmpty) return '';
  final buffer = StringBuffer()
    ..writeln('${mismatches.length} package(s) resolve differently in the '
        'fixture than in the package it exercises.')
    ..writeln('The fixture reaches that package by `path:`, which supplies its '
        'SOURCE but not its RESOLUTION — so the fixture compiles the '
        "host's current lib/ against these older versions, and the error "
        'surfaces inside a directory the fixture does not own.');
  for (final mismatch in mismatches) {
    buffer.writeln('  - $mismatch');
  }
  buffer.write('Repair: `dart pub get` in the fixture(s) named above.');
  return buffer.toString();
}

/// `name -> version` for hosted packages in a project's lock.
///
/// [runtimeOnly] keeps `direct main` and `transitive` entries, which are what
/// a library is compiled against.
Map<String, String> _hostedVersions(
  String projectPath, {
  required bool runtimeOnly,
}) {
  final lock = File(p.join(projectPath, 'pubspec.lock'));
  if (!lock.existsSync()) return const {};

  final versions = <String, String>{};
  String? name;
  String? dependency;
  String? source;
  String? version;

  void flush() {
    final packageName = name;
    final packageVersion = version;
    if (packageName == null || source != 'hosted' || packageVersion == null) {
      return;
    }
    if (runtimeOnly && dependency == 'direct dev') return;
    versions[packageName] = packageVersion;
  }

  // Parsed line-wise rather than with a YAML dependency: this runs in test
  // setup of packages that do not otherwise need one.
  for (final line in lock.readAsLinesSync()) {
    final packageStart = RegExp(r'^  ([A-Za-z0-9_]+):\s*$').firstMatch(line);
    if (packageStart != null) {
      flush();
      name = packageStart.group(1);
      dependency = source = version = null;
      continue;
    }
    if (name == null) continue;
    if (line.startsWith('  ') && !line.startsWith('    ')) {
      // A top-level key such as `sdks:` ends the package list.
      flush();
      name = null;
      continue;
    }
    dependency = _value(line, 'dependency') ?? dependency;
    source = _value(line, 'source') ?? source;
    version = _value(line, 'version') ?? version;
  }
  flush();
  return versions;
}

String? _value(String line, String key) {
  // The value may be quoted AND contain a space (`dependency: "direct main"`),
  // so it cannot be matched as a run of non-space characters.
  final match = RegExp('^\\s+$key:\\s*"?([^"]+?)"?\\s*\$').firstMatch(line);
  return match?.group(1);
}
