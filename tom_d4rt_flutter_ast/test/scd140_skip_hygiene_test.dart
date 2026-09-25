// RUNNER BUCKET: guard — run_guard_tests.sh
// REPO-WIDE GUARD (tom_d4rt_flutter_ast) — every `skip:` in BOTH twins' corpus drivers states a mechanism and names its evidence.
//
// Its subject reaches OUTSIDE this package (the sibling twin's driver files), so
// it runs only when tom_d4rt_flutter_ast's suite runs. SCD129 made that
// arrangement visible rather than incidental: `grep -rn 'REPO-WIDE GUARD'
// */test` lists every one, and
// `tom_d4rt/test/scd129_repo_wide_guard_index_test.dart` fails if a new one
// arrives without this banner.
//
// SCD140 — a skip is a claim that the interpreter CANNOT be measured here, and
// twice that claim has been false.
//
// SCC47 found a skip asserting "the d4rt bridge wraps the native
// `UnsupportedError` in a way that the script's `catch (e)` does not reliably
// intercept" — a mechanism that does not exist, masking a plain script defect
// that compiled Flutter fails on identically. SCD139 found another claiming
// "the d4rt interpreter does not support real isolate execution" for a script
// containing no `Isolate.spawn` at all; the real cause was a permission gate,
// and granting it made the test measured and green on both lines.
//
// Both read plausibly. Neither named evidence. **That is the part a test can
// check**, and this is that test.
//
// WHAT IS REQUIRED, AND WHY EACH PART
//
//   * A JUSTIFICATION of some substance. A mechanism cannot be stated in a
//     clause: `'AndroidView only renders on Android'` was the entire defence of
//     two skips until SCD139 re-measured them. The floor is deliberately low —
//     it separates "somebody explained this" from "somebody named it".
//   * EVIDENCE: a commit hash, a source location, a reproduction, or a cluster /
//     todo id. Not because a reference proves a claim, but because it makes the
//     claim CHECKABLE by the next reader — which is exactly what SCC47 had to
//     do from scratch, six weeks late, for a skip that recorded nothing.
//
// WHAT IS DELIBERATELY NOT CHECKED. Whether the mechanism is TRUE. No test can
// do that; only a reproduction can, and the protocol in `test/README.md` is
// where that is asked for. This file guards the shape, which is the part that
// rots silently.
//
// EACH TEST HERE HAS BEEN SEEN TO FAIL:
//
//   | Injected fault                                          | Fires   |
//   | ------------------------------------------------------- | ------- |
//   | a skip's justification comment deleted                   | 2 AND 3 |
//   | every evidence reference stripped from one justification | 3       |
//   | the driver glob pointed at a directory with no drivers   | 1       |
//
// The first row fires twice because deleting the comment removes the substance
// AND the references inside it — the two are not independent, and F-SCD140-2 is
// the one to read. The second row is what separates them: it leaves a long
// justification standing and removes only what a reader could go and check,
// which is the exact shape of SCC47's bad skip.
@TestOn('vm')
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'sibling_trees.dart';

/// Both twins' driver directories, relative to this package root.
const _driverDirs = <String>['test', '../tom_d4rt_flutter/test'];

/// `flutter_base_NN_test.dart` and `flutter_extended_NN_test.dart`.
final RegExp _driverName = RegExp(r'^flutter_(base|extended)_\d+_test\.dart$');

/// Three skips survived SCD139's audit, in two files, in each twin — so six.
/// The floor is below that because its job is to separate "scanned the drivers"
/// from "scanned nothing": every assertion below is over a list of found skips,
/// and an empty list satisfies all of them.
const int _minSkips = 4;

/// Both twins held 41 driver files each on 2026-09-15.
const int _minDrivers = 60;

/// What counts as a checkable reference.
///
/// Deliberately generous: the point is that the next reader can GO somewhere,
/// not that the evidence takes one particular form. A commit hash, a Dart
/// source file, a test id, a cluster or todo id, or an SDK path all qualify.
final List<RegExp> _evidencePatterns = [
  RegExp(r'\b[0-9a-f]{7,40}\b'), // a commit
  RegExp(r'\b\w+\.dart\b'), // a source location
  RegExp(r'\bF-[A-Z]+\d+'), // a test id
  RegExp(r'\b(SCC|SCD|scc|scd|sce)\d+\b'), // a cluster / todo id
  RegExp(r'\bGEN-\d+\b'), // a generator issue
];

/// One `skip:` and the justification attached to it.
typedef SkipSite = ({String file, int line, String justification});

/// Every `skip:` across [_driverDirs], with the comment block above it plus the
/// skip expression itself as its justification.
///
/// The comment is where a mechanism can actually be stated — the reason STRING
/// is what `dart test` prints and is necessarily short — so both are collected
/// and judged together.
List<SkipSite> collectSkips() {
  final found = <SkipSite>[];
  for (final dir in _driverDirs) {
    final directory = Directory(dir);
    if (!directory.existsSync()) continue;
    final files =
        directory
            .listSync()
            .whereType<File>()
            .where((f) => _driverName.hasMatch(f.uri.pathSegments.last))
            .toList()
          ..sort((a, b) => a.path.compareTo(b.path));
    for (final file in files) {
      final lines = file.readAsLinesSync();
      for (var i = 0; i < lines.length; i++) {
        // `skip:` as an argument, not the word inside a string or a comment.
        final trimmed = lines[i].trimLeft();
        if (!trimmed.startsWith('skip:')) continue;

        // Walk back over the contiguous comment block directly above.
        final buffer = <String>[];
        for (var j = i - 1; j >= 0; j--) {
          final above = lines[j].trimLeft();
          if (above.startsWith('//')) {
            buffer.insert(0, above);
          } else if (above.isEmpty && buffer.isNotEmpty) {
            break;
          } else {
            break;
          }
        }
        // …and forward over the skip expression, which may be a ternary across
        // several lines and may itself carry the comment (SCC47's does).
        for (var j = i; j < lines.length && j < i + 60; j++) {
          final line = lines[j].trimLeft();
          buffer.add(line);
          // A comment NEVER ends the expression. An earlier draft broke on
          // `contains('),')` and truncated SCC47's justification at
          // `(collateral damage), so a` — losing the commit hash further down,
          // which is precisely the evidence F-SCD140-3 looks for. The guard
          // reported its own best-documented skip as unevidenced.
          if (line.startsWith('//')) continue;
          if (j > i && line.endsWith(',')) break;
        }
        found.add((
          file: file.path,
          line: i + 1,
          justification: buffer.join('\n'),
        ));
      }
    }
  }
  return found;
}

int countDrivers() {
  var n = 0;
  for (final dir in _driverDirs) {
    final directory = Directory(dir);
    if (!directory.existsSync()) continue;
    n += directory
        .listSync()
        .whereType<File>()
        .where((f) => _driverName.hasMatch(f.uri.pathSegments.last))
        .length;
  }
  return n;
}

void main() {
  // SCE191: this guard resolves its subject relative to the package it
  // runs in, so a copy anywhere else measures a different tree in silence.
  requirePackage(
    'tom_d4rt_flutter_ast',
    subject:
        "every `skip:` in BOTH twins' corpus drivers states a mechanism and names its evidence",
  );

  group('SCD140: a skip states a mechanism and names its evidence', () {
    test('F-SCD140-1: the drivers were actually scanned [2026-09-15]', () {
      // Anti-vacuity, and the failure this file is most exposed to: F-SCD140-2
      // and -3 iterate a list of skips, so a walk that found none would
      // satisfy both while checking nothing. Pin the corpus first.
      expect(
        countDrivers(),
        greaterThanOrEqualTo(_minDrivers),
        reason:
            'only ${countDrivers()} driver files found across '
            '${_driverDirs.join(', ')}. Both twins carried 41 each on '
            '2026-09-15; finding almost none means the layout moved and this '
            'file is guarding nothing.',
      );
      expect(
        collectSkips().length,
        greaterThanOrEqualTo(_minSkips),
        reason:
            'only ${collectSkips().length} skips found. If the audit really '
            'has driven the corpus to almost no skips that is excellent — but '
            'lower this floor deliberately, rather than leaving a guard that '
            'cannot fail.',
      );
    });

    test('F-SCD140-2: every skip carries a justification with some substance '
        '[2026-09-15]', () {
      // A mechanism cannot be stated in a clause. Two skips were defended by
      // `'AndroidView only renders on Android'` — a symptom, and not even the
      // right one — until SCD139 measured that the real cause is an
      // uncatchable Objective-C exception that kills the companion app.
      const minChars = 200;
      final thin = <String>[];
      for (final skip in collectSkips()) {
        if (skip.justification.length < minChars) {
          thin.add(
            '${skip.file}:${skip.line} '
            '(${skip.justification.length} chars)',
          );
        }
      }
      expect(
        thin,
        isEmpty,
        reason:
            'These skips assert that the interpreter cannot be measured here '
            'without explaining why. State the MECHANISM that makes the '
            'condition unobservable — "platform-dependent API" is not one, '
            'because a script can guard a platform-dependent API and still be '
            'measured:\n  ${thin.join('\n  ')}',
      );
    });

    test('F-SCD140-3: every skip names evidence somebody else can check '
        '[2026-09-15]', () {
      // Not because a reference proves the claim — it does not — but because
      // it makes the claim checkable. SCC47 had to re-derive six-week-old
      // provenance from `git log -S` for a skip that recorded none, and what
      // it found overturned the skip.
      final unevidenced = <String>[];
      for (final skip in collectSkips()) {
        final hasEvidence = _evidencePatterns.any(
          (p) => p.hasMatch(skip.justification),
        );
        if (!hasEvidence) unevidenced.add('${skip.file}:${skip.line}');
      }
      expect(
        unevidenced,
        isEmpty,
        reason:
            'These skips name nothing a reader can go and check. Cite the '
            'commit that added it, the source location that makes the '
            'condition unobservable, a reproduction, or the cluster / todo '
            'that owns it:\n  ${unevidenced.join('\n  ')}',
      );
    });
  });
}
