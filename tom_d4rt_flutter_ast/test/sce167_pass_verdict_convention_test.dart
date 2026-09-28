// RUNNER BUCKET: guard — run_guard_tests.sh
// REPO-WIDE GUARD (tom_d4rt_flutter_ast) — every corpus driver in BOTH twins
// uses one definition of a passing script.
//
// Its subject reaches OUTSIDE this package (the sibling twin's drivers and its
// runner), so it runs only when tom_d4rt_flutter_ast's suite runs. SCD129 made
// that arrangement visible rather than incidental: `grep -rn 'REPO-WIDE GUARD'
// */test` lists every one, and
// `tom_d4rt/test/scd129_repo_wide_guard_index_test.dart` fails if a new one
// arrives without this banner.
//
/// SCE167 — the drivers disagreed about what a pass is, so one script got two
/// verdicts from one run.
///
/// `widgets/android_view_test.dart` sits in both `flutter_base_15` and
/// `flutter_extended_22`. Measured on one hosted run: PASS in the first with
/// `frameworkErrors=2`, FAIL in the second on those same two errors. Both
/// readings are defensible in isolation; having both is not.
///
/// The split was not base-versus-extended, which is what it looked like.
/// Measured 2026-09-23: **3 of the 41 driver files** called
/// `SendTestRunner.expectSuccess` and **38 asserted inline** — 104 call sites
/// against 2 018, and 21 of the 24 `flutter_extended_*` files were on the
/// non-gating side too. The minority convention was the gating one.
///
/// All 41 now call the helper, in both twins. That is what this file holds.
///
/// ## Gating, and why it waited for a publish
///
/// Gating is the right answer — a framework error is an interpreter runtime
/// error the script survived, and treating it as a pass is what let GEN-125
/// raise ~276 of them across 109 scripts while the corpus reported success.
/// It stayed off until the publish, and the reason was a measurement rather
/// than caution. Base corpus, AST twin, all
/// 910 scripts:
///
/// | interpreter                    | scripts with errors | errors |
/// | ------------------------------ | ------------------: | -----: |
/// | hosted `tom_d4rt_ast` 0.65.0   |                  47 |    113 |
/// | working tree 0.164.0           |                   0 |      0 |
///
/// Switching it on today turns 47 scripts across 8 base files red against the
/// interpreter the twins actually resolve (DGUC6) and green only under the
/// pre-publish pass, which is the worst of both readings. Against the tree it
/// costs nothing. So the flip belonged to the publish, and a guard made it a
/// red test at the moment it became free. SCE212's publish (tom_d4rt_ast
/// 0.177.0) measured zero across both twins on 2026-09-28; the switch is gone
/// and F-SCE167-3 now holds that the helper gates.
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'sibling_trees.dart';

const _twins = <String, String>{
  'tom_d4rt_flutter_ast': 'test',
  'tom_d4rt_flutter': '../tom_d4rt_flutter/test',
};

/// The inline assertion the drivers used to make, and must not make again.
///
/// It is the exact string every one of the 2 018 sites used — there was only
/// ever one spelling — so matching it literally is precise rather than
/// approximate.
const _inlineVerdict = 'expect(result.success, isTrue';

/// Every `flutter_*_test.dart` driver under [dir].
List<File> _drivers(String dir) {
  final d = Directory(dir);
  if (!d.existsSync()) return const [];
  return [
    for (final e in d.listSync())
      if (e is File &&
          e.uri.pathSegments.last.startsWith('flutter_') &&
          e.path.endsWith('_test.dart'))
        e,
  ]..sort((a, b) => a.path.compareTo(b.path));
}

void main() {
  // SCE191: this guard resolves its subject relative to the package it
  // runs in, so a copy anywhere else measures a different tree in silence.
  requirePackage(
    'tom_d4rt_flutter_ast',
    subject: 'every corpus driver in BOTH twins',
  );

  group('SCE167: one definition of a passing corpus script', () {
    test('F-SCE167-1: every driver in both twins asks the shared helper', () {
      final offenders = <String>[];
      var scanned = 0;
      for (final entry in _twins.entries) {
        for (final driver in _drivers(entry.value)) {
          scanned++;
          final source = driver.readAsStringSync();
          if (source.contains(_inlineVerdict)) {
            offenders.add(
              '${entry.key}/${driver.uri.pathSegments.last} asserts the verdict '
              'inline',
            );
          }
        }
      }
      expect(
        scanned,
        greaterThanOrEqualTo(70),
        reason:
            'only $scanned drivers scanned across both twins; there are 41 '
            'each. A scan that finds nothing passes the check below by '
            'iterating nothing',
      );
      expect(
        offenders,
        isEmpty,
        reason:
            'A driver that decides for itself what a pass is can give a script '
            'a different verdict from the file next to it — which is exactly '
            'what happened to widgets/android_view_test.dart. Call '
            '`SendTestRunner.expectSuccess(result)`; the definition lives '
            'there, once:\n  ${offenders.join('\n  ')}',
      );
    });

    test('F-SCE167-2: every driver actually calls the helper', () {
      // The other way F-SCE167-1 passes over nothing: a driver that asserts
      // neither inline NOR through the helper has no verdict at all.
      final silent = <String>[];
      for (final entry in _twins.entries) {
        for (final driver in _drivers(entry.value)) {
          if (!driver.readAsStringSync().contains(
            'SendTestRunner.expectSuccess(',
          )) {
            silent.add('${entry.key}/${driver.uri.pathSegments.last}');
          }
        }
      }
      expect(
        silent,
        isEmpty,
        reason:
            'these drivers send scripts and never assert a verdict on the '
            'result:\n  ${silent.join('\n  ')}',
      );
    });

    test('F-SCE167-3: the shared helper gates on framework errors '
        '[2026-09-28]', () {
      // Gating was a switch until SCE212's publish made it free: the published
      // pair raises ZERO framework errors across all 910 base-corpus scripts
      // in both twins. The switch was deleted, so what is left to hold is that
      // the ONE definition of a pass still refuses a script that survived an
      // interpreter runtime error.
      for (final entry in _twins.entries) {
        final runner = File(
          '${entry.value}/send_test_runner.dart',
        ).readAsStringSync();
        expect(
          runner,
          contains('result.success && !result.hasFrameworkErrors'),
          reason:
              '${entry.key}: expectSuccess no longer gates on framework '
              'errors, so a script that survived an interpreter error passes',
        );
        expect(runner, isNot(contains('frameworkErrorsFailARun')));
      }
    });

    test('F-SCE167-4 (control): the inline pattern discriminates', () {
      // And the string F-SCE167-1 looks for is the one the drivers used, not
      // something that matches the helper call too.
      expect(
        'SendTestRunner.expectSuccess(result);'.contains(_inlineVerdict),
        isFalse,
        reason:
            'the inline pattern matches the helper call, so F-SCE167-1 would '
            'report every driver as an offender',
      );
      expect(
        'expect(result.success, isTrue, reason: result.error);'.contains(
          _inlineVerdict,
        ),
        isTrue,
      );
    });
  });
}
