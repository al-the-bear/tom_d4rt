/// SCC48: a script's verdict must depend only on the script itself.
///
/// WHY THIS EXISTS. On 2026-07-28, `flutter_extended_22` improved from
/// `+30 ~1 -12` to `+42 ~1`. The twelve recovered failures formed a contiguous
/// alphabetical block and shared one error text — a Flutter Material layout
/// advisory ("ListTile background color or ink splashes may be invisible")
/// that has nothing to do with image filters, indexed stacks or page storage.
/// The natural reading was a leak: one script raises a framework error, it
/// stays in a shared bucket, and every later script is failed on it until
/// something resets it. If that were true, every cluster count in
/// `interpreter_issues.md` would be an upper bound of unknown tightness.
///
/// It was not true. The twelve were twelve independent script-authoring
/// defects — each of those scripts wrapped its own ListTile in a coloured box
/// with no intervening Material, and each raised its own advisory during its
/// own build. Commit `0f93ea375` ("wrap ListTiles under colored boxes in
/// Material across corpus", 2026-06-24) fixed them by editing 40 corpus
/// scripts individually, and its message states the outcome the later run
/// measured: "flutter_extended_22 +30~1-12 -> +42~1". The contiguity was a
/// coincidence of alphabetical ordering over scripts written from a shared
/// template, and it was persuasive enough to nearly manufacture a harness bug
/// that did not exist.
///
/// WHAT THIS TEST DOES. Reading the harness source shows the bucket is reset
/// per `/build` and capture is bounded by the post-build pump, so leakage
/// should be impossible. That is an argument, not a measurement, and the
/// argument is exactly what the twelve-failure block appeared to contradict.
/// This test measures it, using two near-identical probe scripts under
/// `_harness/` that differ only by the `Material` that silences the advisory.
///
/// Measured 2026-09-06, all four green: the offender reports `frameworkErrors=1`
/// on every send (1, 1, 1 across three consecutive builds — flat, not growing),
/// and the victim reports 0 both alone and immediately after the offender. The
/// bucket is per-build. Leakage does not occur.
///
/// Not named `flutter_base_*` / `flutter_extended_*` on purpose: the corpus
/// runners glob those prefixes, and adding a file to them would shift the
/// metrics tables every verification run is compared against. Run it directly:
///
/// ```bash
/// flutter test test/framework_error_isolation_test.dart
/// ```
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

const String _kTestFileName = 'framework_error_isolation_test.dart';

/// Raises exactly one Flutter advisory per build.
const String _offender = '_harness/framework_error_offender_test.dart';

/// The same recipe with the advisory silenced the documented way.
const String _victim = '_harness/framework_error_victim_test.dart';

void main() {
  setUpAll(() async {
    await SendTestRunner.setUp(suite: _kTestFileName);
  });

  tearDownAll(() async {
    await SendTestRunner.tearDown();
  });

  group('SCC48: framework errors are attributed to the script that raised them',
      () {
    test(
      'F-SCC48-1: the offender probe raises a framework error, and it is a '
      'ListTile advisory',
      () async {
        final result = await SendTestRunner.send(_offender);

        expect(
          result.hasFrameworkErrors,
          isTrue,
          reason:
              'The offender probe exists to produce a framework error. If it '
              'stopped producing one, this whole test file is vacuous — the '
              'later assertions would pass no matter how the harness behaved. '
              'First suspect is the GUARD, not the check: the walk at '
              'list_tile.dart:1147 only runs when onTap/onLongPress is set or '
              'the tile has an opaque background (list_tile.dart:832). The '
              'probe opens that gate with an explicit tileColor; drop it and '
              'this assertion fails with frameworkErrors=0, which is exactly '
              'how the first draft failed on 2026-09-06. Only after ruling '
              'that out, check whether Flutter still ships '
              'ListTile._debugCheckBackgroundIsHidden at all.',
        );
        expect(
          result.frameworkErrors.every((e) => e.contains('ListTile')),
          isTrue,
          reason: 'Every captured error should be the advisory this probe '
              'raises, not something inherited: ${result.frameworkErrors}',
        );
      },
    );

    test(
      'F-SCC48-2: the victim probe is clean when run on its own',
      () async {
        final result = await SendTestRunner.send(_victim);

        expect(result.success, isTrue, reason: result.error);
        expect(
          result.hasFrameworkErrors,
          isFalse,
          reason: 'Baseline for F-SCC48-3. The victim differs from the '
              'offender only by a layout-neutral Material, so it must be '
              'clean in isolation: ${result.frameworkErrors}',
        );
      },
    );

    test(
      'F-SCC48-3: the victim is still clean immediately after the offender — '
      'a framework error does not survive into the next script',
      () async {
        final offending = await SendTestRunner.send(_offender);
        expect(
          offending.hasFrameworkErrors,
          isTrue,
          reason: 'Precondition: the offender must actually have raised.',
        );

        final result = await SendTestRunner.send(_victim);

        expect(
          result.hasFrameworkErrors,
          isFalse,
          reason:
              'THIS IS THE SCC48 ASSERTION. The immediately preceding script '
              'raised ${offending.frameworkErrors.length} framework error(s). '
              'If any of them are attributed to this script, a passing script '
              'can be failed by its predecessor and every cluster count in '
              'interpreter_issues.md is an upper bound. Leaked: '
              '${result.frameworkErrors}',
        );
        expect(result.success, isTrue, reason: result.error);
      },
    );

    test(
      'F-SCC48-4: repeated runs of the offender do not accumulate — the error '
      'bucket is reset per build, not per file',
      () async {
        final first = await SendTestRunner.send(_offender);
        final second = await SendTestRunner.send(_offender);
        final third = await SendTestRunner.send(_offender);

        final counts = [
          first.frameworkErrors.length,
          second.frameworkErrors.length,
          third.frameworkErrors.length,
        ];

        // Strict monotonic growth is the accumulation signature: run N would
        // carry every error runs 1..N-1 raised. Exact equality is deliberately
        // NOT asserted — the advisory fires once per ListTile build, and the
        // number of builds within the post-build pump window can legitimately
        // vary by a frame. Growth is the defect; jitter is not.
        expect(
          counts[0] < counts[1] && counts[1] < counts[2],
          isFalse,
          reason:
              'Framework errors accumulated across three identical builds '
              '($counts). That is the mechanism SCC48 hypothesised, and it '
              'would mean a script is scored on its predecessors errors.',
        );
      },
    );
  });
}
