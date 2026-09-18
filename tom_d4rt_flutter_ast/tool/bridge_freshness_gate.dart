// ignore_for_file: avoid_print
/// Decide by CONTENT whether this package's committed bridges still match what
/// the generator produces, and regenerate only when they do not.
///
/// WHY THIS EXISTS. `SendTestRunner.setUp` used to decide staleness from
/// MTIMES — buildkit.yaml, tool/regenerate_bridges.dart and the resolved
/// tom_d4rt_generator, against the oldest `*.b.dart`. A `flutter pub upgrade`
/// moves the generator to a different pub-cache directory with fresh mtimes,
/// so every lock change read as stale even when the generator's output was
/// byte-identical. Measured 2026-09-18 in this package: a full regeneration
/// took 116 s and rewrote all 18 bridges with ZERO differences beyond the
/// `// Generated:` line. That cost two things — 116 s of silence inside
/// `setUpAll`, long enough for the corpus runner's idle watchdog to kill
/// file 01 and report a wedged transport, and a dirty `lib/src/bridges` that
/// forced a cold rebuild of the companion app.
///
/// Mtimes cannot answer the question being asked. The question is whether the
/// committed bytes differ, and `checkBridgeFreshness` (tom_d4rt_generator
/// >= 1.18.0) answers exactly that: it runs the ordinary generation inside a
/// scratch overlay, compares each file ignoring the `// Generated:` line, and
/// never writes to the package.
///
/// WHY A SEPARATE PROCESS rather than an import in `send_test_runner.dart`.
/// `tom_d4rt_generator` pulls in the analyzer. Importing it from the runner
/// would put the analyzer into the compilation unit of all seventeen
/// `flutter_base_NN_test.dart` files, which every one of them would then pay
/// for at build time — to run a check that fires only after a lock change.
/// As a subprocess its output also streams, which is what keeps the idle
/// watchdog fed.
///
/// Exit codes, which the caller reads:
///   0  fresh — nothing was written to the package
///   20 regenerated — the bridges genuinely differed and have been rewritten
///   1  the check could not be made; the message says why
library;

import 'dart:async';
import 'dart:io';

import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

/// Exit code for "the committed bridges genuinely differed and were rewritten".
///
/// `SendTestRunner._bridgeRegeneratedExitCode` is a hand-kept copy of this. It
/// cannot import it: that would pull this package's analyzer dependency into
/// every corpus test file, which is the reason this gate is a subprocess in the
/// first place. Change one and you must change the other.
const int regeneratedExitCode = 20;

Future<void> main() async {
  final projectPath = Directory.current.path;

  // The generator prints as it works, but not on a guaranteed cadence: the
  // summary-caching phase is quiet for a long stretch. The corpus runner kills
  // a test file after IDLE_TIMEOUT seconds of NO output at all, so a backstop
  // tick costs nothing and removes the whole failure mode rather than making
  // it less likely.
  final started = DateTime.now();
  final heartbeat = Timer.periodic(const Duration(seconds: 10), (_) {
    final secs = DateTime.now().difference(started).inSeconds;
    print('  bridge-freshness: still working (${secs}s)');
  });

  try {
    print('Checking bridge freshness by content: $projectPath');
    final freshness = await checkBridgeFreshness(projectPath);

    if (freshness.errors.isNotEmpty) {
      print('Bridge freshness check FAILED — nothing was measured:');
      for (final e in freshness.errors) {
        print('  ERROR: $e');
      }
      exitCode = 1;
      return;
    }

    if (freshness.isFresh) {
      print(
        'Bridges are fresh: ${freshness.checked.length} generated file(s) '
        'match a fresh generation. Nothing written.',
      );
      return;
    }

    print('Bridges are stale — ${freshness.stale.length} file(s) differ:');
    for (final s in freshness.stale) {
      print('  - $s');
    }
    print('Regenerating in place...');

    // A second generation, and deliberately so. `checkBridgeFreshness` does
    // not hand back what it produced — it deletes its scratch tree, which is
    // what makes it safe to run against a package it must not modify. Paying
    // for a second pass here buys that safety in the common case (fresh, one
    // generation, no writes) at the cost of the rare one (genuinely stale,
    // which happens only when the generator's output actually changed).
    final result = await generateBridges(
      configPath: '$projectPath/buildkit.yaml',
      projectPath: projectPath,
    );

    if (!result.isSuccess) {
      print('Regeneration FAILED:');
      for (final e in result.errors) {
        print('  ERROR: $e');
      }
      exitCode = 1;
      return;
    }

    print('Regenerated ${result.outputFiles.length} file(s).');
    exitCode = regeneratedExitCode;
  } finally {
    heartbeat.cancel();
  }
}
