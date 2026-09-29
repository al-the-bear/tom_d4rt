// SHARED FILE (SCE240) — one copy in each of tom_ast_generator,
// tom_d4rt_dcli, tom_dcli_exec and tom_d4rt_generator, kept byte-identical by
// `tom_d4rt/test/sce240_resolved_interpreter_copies_test.dart`. Edit one, copy
// it to the other three in the same commit.
//
// A consumer's suite names, in its own log, the interpreter it measured.
//
// `pubspec.lock` is gitignored, so which interpreter a run exercised is
// per-machine and appears in no diff. For a 1.x interpreter the caret does not
// narrow it either: `tom_d4rt: ^1.77.0` admits every 1.x release, and on
// 2026-09-29 two consumers declaring exactly that resolved 1.192.0. So a red
// in one of these suites could not be matched to an interpreter from anything
// the repository holds. Printing the resolution in the run is the narrowest
// record that can.
//
// Parsed with regular expressions rather than `package:yaml`, because not every
// consumer depends on it, and a test helper that adds a dependency is a worse
// trade than a few patterns over two files whose shape pub fixes.

import 'dart:io';

/// The packages whose version decides what a consumer's suite measured.
const interpreterPackages = <String>[
  'tom_d4rt',
  'tom_d4rt_ast',
  'tom_d4rt_exec',
  'tom_ast_model',
  'tom_ast_generator',
];

/// This package's name, read from its `pubspec.yaml`.
String packageName({String pubspecPath = 'pubspec.yaml'}) =>
    RegExp(
      r'^name:\s*(\S+)',
      multiLine: true,
    ).firstMatch(File(pubspecPath).readAsStringSync())?.group(1) ??
    '<unnamed>';

/// One line per interpreter package this package resolves:
/// `tom_d4rt 1.192.0 (hosted; pubspec ^1.77.0)`.
///
/// The constraint is shown beside the resolution because their distance is
/// the thing a reader needs to see. Packages absent from the lock are left out.
/// An absent or unreadable lock yields a single line saying so, because "asked
/// and found nothing" must not look like "never asked".
List<String> resolvedInterpreterLines({
  String lockPath = 'pubspec.lock',
  String pubspecPath = 'pubspec.yaml',
}) {
  final lock = File(lockPath);
  if (!lock.existsSync()) {
    return ['NONE: no $lockPath; run `dart pub get`'];
  }
  final lockText = lock.readAsStringSync();
  final pubspecText = File(pubspecPath).readAsStringSync();
  final lines = <String>[];
  for (final name in interpreterPackages) {
    final entry = RegExp(
      '^  $name:\\n((?:    .*\\n)+)',
      multiLine: true,
    ).firstMatch(lockText);
    if (entry == null) continue;
    final body = entry.group(1)!;
    final version =
        RegExp(
          r'^    version: "?([^"\n]+)"?',
          multiLine: true,
        ).firstMatch(body)?.group(1) ??
        '?';
    final source =
        RegExp(
          r'^    source: (\S+)',
          multiLine: true,
        ).firstMatch(body)?.group(1) ??
        '?';
    final declared =
        RegExp('^\\s+$name:\\s*(\\S.*)\$', multiLine: true)
            .firstMatch(pubspecText)
            ?.group(1)
            ?.trim()
            .replaceAll(RegExp('[\'"]'), '') ??
        'transitive';
    lines.add('$name $version ($source; pubspec $declared)');
  }
  return lines;
}
