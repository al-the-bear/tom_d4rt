/// The attribution header the corpus runners write at the top of `metrics.txt`.
///
/// A `testlog/` folder used to be a pass/skip/fail triple with no provenance.
/// Two facts made that a reproducibility hole rather than an inconvenience:
/// both twins **gitignore `pubspec.lock`**, so the resolved interpreter is
/// machine-local and appears in no diff, no review and no commit; and the
/// runners recorded only per-file results. Two fleet hosts could therefore run
/// the same corpus against different published interpreters and produce two
/// incomparable result sets that look identical in shape, and a folder kept
/// across a `pub upgrade` silently changed meaning.
///
/// The quest's cluster-fix protocol ends in "run the corpus serially", so this
/// is the attribution step for its primary evidence artifact. The trace that
/// already existed — the resolved-version table in each `Verification runs`
/// entry of `doc/interpreter_issues.md` — is hand-written, and exactly as
/// reliable as whoever remembered to fill it in. With the header, that table
/// becomes a transcription of a measured value.
///
/// EVERY HOSTED `tom_` PACKAGE IS RECORDED, NOT A CHOSEN THREE. The obvious
/// design is to name `tom_d4rt`, `tom_d4rt_ast` and `tom_d4rt_generator`,
/// which is what the `Verification runs` table happens to carry today. A
/// hand-written list of the interesting names is the failure mode this
/// repository keeps re-finding: the next package that matters presents as one
/// the record quietly does not mention. Reading them all costs nothing and
/// cannot go stale, and it is the same set
/// `companionResolutionMismatches` already compares.
///
/// THE HEADER IS WRITTEN AFTER THE COMPANION APP IS RESOLVED, on purpose. The
/// app's lock is re-resolved by the runner at start-up; a header taken before
/// that would attribute the run to versions it did not use.
///
/// The Dart/Flutter SDK version is deliberately ABSENT. The header is written
/// by whichever `dart` is on PATH, which is not necessarily the SDK bundled
/// with the `flutter` that runs the tests — and a version field that is
/// sometimes about a different toolchain is worse than no field.
///
/// This file is identical in both flutter twins (`test/run_attribution.dart`);
/// `test/scd164_run_attribution_test.dart` fails when the copies differ.
library;

import 'dart:io';

import 'companion_app_resolution.dart';

/// The prefix every attribution line carries, so a parser can separate the
/// header from the per-file result lines that follow it without counting.
const String attributionPrefix = '# ';

/// One `<prefix>: <name> <version> (<source>)` line per package [packageDir]
/// resolves that is either `tom_`-named or [alsoInclude], sorted by name.
///
/// [alsoInclude] is the twin's own package name, and it is not decoration: the
/// companion app resolves its twin by PATH, and that entry is what says whether
/// the app is wired to this working tree or to a published copy — the same
/// question `companionResolutionMismatches` asks first, before it applies any
/// `tom_` filter. Selecting purely on the `tom_` prefix gets the right answer
/// here only because both twins happen to be `tom_`-named, which is a property
/// of today's names rather than of the thing being recorded.
///
/// Returns a single `NONE — <reason>` line when there is nothing to report, so
/// that "asked and found none" is distinguishable from "never asked" (which
/// shows as no line with this prefix at all). An empty diagnostic that cannot
/// tell those apart is the shape of diagnostic this corpus keeps being misled
/// by.
List<String> _resolvedLines(
  String prefix,
  String packageDir, {
  String? alsoInclude,
}) {
  final lock = File('$packageDir/pubspec.lock');
  if (!lock.existsSync()) {
    return [
      '$attributionPrefix$prefix: NONE — $packageDir has no pubspec.lock',
    ];
  }
  final recorded = [
    for (final entry in readLockedPackages(packageDir).values)
      if (entry.name.startsWith('tom_') || entry.name == alsoInclude) entry,
  ]..sort((a, b) => a.name.compareTo(b.name));
  if (recorded.isEmpty) {
    return [
      '$attributionPrefix$prefix: NONE — no tom_ package in '
          '$packageDir/pubspec.lock',
    ];
  }
  return [
    for (final entry in recorded)
      '$attributionPrefix$prefix: ${entry.name} ${entry.version} '
          '(${entry.source})',
  ];
}

/// The attribution header for one corpus run, one line per fact.
///
/// [parentDir] is the twin being run and [appDir] its companion app, both as
/// the runner sees them (the runner `cd`s to the package root first).
List<String> runAttributionLines({
  required String parentDir,
  required String appDir,
  required String runId,
  required DateTime startedAt,
}) {
  final identity = readPubspecIdentity(parentDir);
  return [
    '${attributionPrefix}run: $runId',
    // Seconds precision: a corpus run takes minutes, and the microseconds
    // `toIso8601String` emits only make two headers harder to compare by eye.
    '${attributionPrefix}started: '
        '${startedAt.toIso8601String().split('.').first}',
    '${attributionPrefix}package: ${identity.name ?? '<unnamed>'} '
        '${identity.version ?? '<unversioned>'}',
    '${attributionPrefix}app: $appDir',
    ..._resolvedLines('resolved', parentDir),
    ..._resolvedLines('app-resolved', appDir, alsoInclude: identity.name),
  ];
}

/// Prints the header for `<parentDir> <appDir> <runId>`.
///
/// Never exits non-zero and never throws: a run whose attribution failed is
/// still a run worth having, and the failure is recorded in the header itself
/// rather than aborting sixteen minutes of corpus.
void main(List<String> args) {
  try {
    if (args.length < 3) {
      stdout.writeln(
        '${attributionPrefix}attribution: FAILED — expected '
        '<parentDir> <appDir> <runId>, got ${args.length} argument(s)',
      );
      return;
    }
    stdout.writeAll(
      runAttributionLines(
        parentDir: args[0],
        appDir: args[1],
        runId: args[2],
        startedAt: DateTime.now(),
      ),
      '\n',
    );
    stdout.writeln();
  } catch (e) {
    stdout.writeln('${attributionPrefix}attribution: FAILED — $e');
  }
}
