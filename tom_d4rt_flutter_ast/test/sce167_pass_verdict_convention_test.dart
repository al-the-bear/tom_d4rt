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
/// ## Why the verdict has not changed yet, and what flips it
///
/// Gating is the right answer — a framework error is an interpreter runtime
/// error the script survived, and treating it as a pass is what let GEN-125
/// raise ~276 of them across 109 scripts while the corpus reported success.
/// `SendTestRunner.frameworkErrorsFailARun` is nonetheless still `false`, and
/// the reason is a measurement rather than caution. Base corpus, AST twin, all
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
/// costs nothing. So the flip belongs to the publish — and F-SCE167-3 makes
/// that a red test at the moment it becomes free, rather than a note somebody
/// has to remember while doing something else.
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';
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

/// The release measured at zero framework errors across the base corpus.
///
/// When the twins declare a floor at or past this, gating is free and
/// [SendTestRunner.frameworkErrorsFailARun] must be on.
const _clearedAt = (major: 0, minor: 164, patch: 0);

const _astPubspec = 'pubspec.yaml';

/// Every `flutter_*_test.dart` driver under [dir].
List<File> _drivers(String dir) {
  final d = Directory(dir);
  if (!d.existsSync()) return const [];
  return [
    for (final e in d.listSync())
      if (e is File &&
          e.path.split('/').last.startsWith('flutter_') &&
          e.path.endsWith('_test.dart'))
        e,
  ]..sort((a, b) => a.path.compareTo(b.path));
}

/// The `tom_d4rt_ast:` floor this twin declares, as (major, minor, patch).
({int major, int minor, int patch})? _declaredFloor() {
  for (final line in File(_astPubspec).readAsLinesSync()) {
    final m = RegExp(
      r'''^\s*tom_d4rt_ast:\s*["']?[\^>=]*\s*(\d+)\.(\d+)\.(\d+)''',
    ).firstMatch(line);
    if (m != null) {
      return (
        major: int.parse(m.group(1)!),
        minor: int.parse(m.group(2)!),
        patch: int.parse(m.group(3)!),
      );
    }
  }
  return null;
}

bool _atLeastCleared(({int major, int minor, int patch}) f) {
  if (f.major != _clearedAt.major) return f.major > _clearedAt.major;
  if (f.minor != _clearedAt.minor) return f.minor > _clearedAt.minor;
  return f.patch >= _clearedAt.patch;
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
              '${entry.key}/${driver.path.split('/').last} asserts the verdict '
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
            silent.add('${entry.key}/${driver.path.split('/').last}');
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

    test('F-SCE167-3: once the floor reaches the release measured at zero, '
        'gating is on', () {
      final floor = _declaredFloor();
      expect(
        floor,
        isNotNull,
        reason:
            'no parseable `tom_d4rt_ast:` floor in $_astPubspec, so this guard '
            'cannot decide anything and must be repaired rather than left '
            'green',
      );
      final text = '${floor!.major}.${floor.minor}.${floor.patch}';

      if (!_atLeastCleared(floor)) {
        expect(
          SendTestRunner.frameworkErrorsFailARun,
          isFalse,
          reason:
              'gating is on while this twin still declares $text. Against the '
              'interpreter it resolves, 47 base-corpus scripts raise 113 '
              'framework errors — turning them red is a measurement change '
              'indistinguishable from a regression. If this was deliberate, '
              'raise the floor first',
        );
        return;
      }

      expect(
        SendTestRunner.frameworkErrorsFailARun,
        isTrue,
        reason:
            'this twin now declares a floor of $text, at or past the 0.164.0 '
            'measured at ZERO framework errors across all 910 base-corpus '
            'scripts. Gating is free: set '
            '`SendTestRunner.frameworkErrorsFailARun` to true in BOTH twins, '
            'run both base corpora to confirm, and delete this case together '
            'with the constant it guards',
      );
    });

    test('F-SCE167-4 (control): the version comparison and the inline pattern '
        'both discriminate', () {
      expect(_atLeastCleared((major: 0, minor: 164, patch: 0)), isTrue);
      expect(_atLeastCleared((major: 0, minor: 163, patch: 99)), isFalse);
      expect(_atLeastCleared((major: 1, minor: 0, patch: 0)), isTrue);
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
