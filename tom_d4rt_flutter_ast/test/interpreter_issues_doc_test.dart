/// Guard for the "What is still open" table in `doc/interpreter_issues.md`.
///
/// That header table is a SUMMARY of the per-cluster sections below it, and a
/// summary maintained by hand beside the thing it summarises is a summary that
/// goes stale. This one already did, twice: it spent three months claiming
/// "clusters 8-12 remaining" after the campaign had closed through 11, and
/// then claimed "every earlier cluster is closed" while three sections were
/// still marked `[~]` / `[REVERTED]` (SCC39).
///
/// So the table is not maintained — it is DERIVED, and these tests pin the
/// derivation. Within `## Active clusters`, a `###` section whose title opens
/// with a bracket is a cluster and that bracket is its state; anything that is
/// not `[X]` / `[RESOLVED...]` is open and must appear in the table, verbatim.
///
/// Deliberately NOT a count assertion. The sibling guard
/// `sync_shared_user_bridges_test.dart` carries the same lesson in its header
/// (SCC37): a count passes just as happily with the wrong item in the set, so
/// these compare the SETS and report the symmetric difference.
///
/// SCD65 added a second, unrelated guard to the same file: the
/// `## Verification runs` entries record which interpreter pair a corpus run
/// measured, and that record is the ONLY durable one — `pubspec.lock` is
/// gitignored in both twins and in both companion apps, so the resolved
/// version is machine-local and invisible in any diff or review. Two fleet
/// hosts can run the same corpus against different interpreters with nothing
/// in the repository saying which. See `### SCD65` below.
///
/// Pure file I/O (no HTTP companion app), so this file is safe to run on its
/// own and is NOT part of the serial corpus.
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// One open cluster: its state marker and the heading text that follows it.
typedef OpenCluster = ({String marker, String section});

/// Splits `### [MARKER] rest-of-heading` into its two parts.
///
/// Returns null when the heading does not open with a bracket — those are the
/// dated notes (`### Section Q triage closure (2026-04-26)`), not clusters.
OpenCluster? _parseHeading(String line) {
  final match = RegExp(r'^###\s+(\[[^\]]*\])\s*(.*)$').firstMatch(line);
  if (match == null) return null;
  return (marker: match.group(1)!, section: match.group(2)!.trim());
}

/// True for the markers that mean "closed": `[X]` and `[RESOLVED ...]`.
bool _isClosed(String marker) =>
    marker == '[X]' || marker.startsWith('[RESOLVED');

/// Every non-closed cluster heading inside `## Active clusters`.
///
/// Scoped to that section on purpose: `## Verification runs` further down uses
/// `###` for dated run entries, and the "How clusters were derived" / "History"
/// sections are prose. Only the cluster list is a status register.
List<OpenCluster> parseOpenClustersFromSections(List<String> lines) {
  final result = <OpenCluster>[];
  var inActiveClusters = false;
  for (final line in lines) {
    if (line.startsWith('## ')) {
      inActiveClusters = line.trim() == '## Active clusters';
      continue;
    }
    if (!inActiveClusters || !line.startsWith('### ')) continue;
    final parsed = _parseHeading(line);
    if (parsed != null && !_isClosed(parsed.marker)) result.add(parsed);
  }
  return result;
}

/// The rows of the `## What is still open` table, as (marker, section) pairs.
///
/// Row shape: `| \`[MARKER]\` | section text | explanation |`. The marker is
/// read out of its backticks so the table stays readable as markdown while
/// still being machine-checkable.
List<OpenCluster> parseOpenClustersFromTable(List<String> lines) {
  final result = <OpenCluster>[];
  var inTable = false;
  for (final line in lines) {
    if (line.startsWith('## ')) {
      inTable = line.trim() == '## What is still open';
      continue;
    }
    if (!inTable || !line.startsWith('|')) continue;

    final cells = line.split('|').map((c) => c.trim()).toList();
    // Leading and trailing empties from the outer pipes: expect 5 parts for a
    // 3-column row.
    if (cells.length != 5) continue;
    final marker = cells[1].replaceAll('`', '').trim();
    if (!marker.startsWith('[')) continue; // header row / separator row
    result.add((marker: marker, section: cells[2].trim()));
  }
  return result;
}

// ===========================================================================
// SCD65 — the corpus certifies the PUBLISHED interpreter, and the record of
// WHICH one is a table in this document.
//
// DGUC6 is written down for `tom_d4rt_exec`; it is equally true of both
// Flutter twins and was written down nowhere. Both resolve their interpreter
// from pub.dev — deliberately, so the corpus measures what a consumer gets —
// so an interpreter change that is only in the working tree is not in the
// package the corpus loads. An hour of green results after such a change is
// evidence about the PREVIOUS release.
//
// The hazard is not the gap itself, which is the normal state between
// publishes. It is that the gap is INVISIBLE: `pubspec.lock` is gitignored in
// both twins and both companion apps, so nothing in the repository records
// which interpreter any given run used. The `## Verification runs` entries do
// record it, per run, in a table — which makes them the thing to guard.
//
// WHY NOT "fail when the tree is ahead of what we resolve". That is the
// literal shape of the hazard and it was the first design, but it would be RED
// AS THE NORMAL OPERATING STATE: the working tree runs ahead of pub.dev for as
// long as a change is unpublished, which is most of the time. A guard that is
// red by default is one people learn to ignore, and then it guards nothing.
//
// What this checks instead is COMPARABILITY: the newest recorded run names a
// pair, and this machine resolves a pair. When they differ, the newest entry
// does not describe a run made here, and comparing a fresh result against it
// is comparing two different interpreters. That fires exactly when someone
// publishes and upgrades — which is precisely when a new run is owed — and is
// green the rest of the time.
//
// EACH ROW OBSERVED, by breaking the thing named:
//
//   | Injected fault                                     | Fires |
//   | -------------------------------------------------- | ----- |
//   | `## Verification runs` renamed                      | 1     |
//   | the newest entry's recorded version edited          | 2     |
//   | the README section removed from EITHER twin         | 3     |
//   | an app lock edited to disagree with its twin's      | 2, 4  |
//
// The first row fires 1 ALONE, which is the design and not an accident: with
// nothing recorded, SCD65-2 has no pair to compare and stays silent rather
// than reporting a second, derived failure. Read SCD65-1 first.
//
// IT LIVES IN THE AST TWIN because that twin owns `doc/interpreter_issues.md`,
// and the record being guarded is a table in that document. It reaches across
// to the sibling package for the source twin's companion-app lockfile and
// README — as `scc26_format_alignment_test.dart` already does in the
// interpreter trees — rather than being duplicated, because one record cannot
// have two guards that could disagree about it.

/// The two companion apps, by the path each `## Verification runs` table uses
/// as its row label, and where that app's lockfile lives relative to THIS
/// package root.
///
/// The tables read the COMPANION APP lockfiles rather than the twins' own,
/// because the app is the package the corpus scripts actually execute in.
const companionApps =
    <String, ({String lockPath, String twinLockPath, String interpreter})>{
      'tom_d4rt_flutter/test/tom_d4rt_flutter_test_app': (
        lockPath:
            '../tom_d4rt_flutter/test/tom_d4rt_flutter_test_app/pubspec.lock',
        twinLockPath: '../tom_d4rt_flutter/pubspec.lock',
        interpreter: 'tom_d4rt',
      ),
      'tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app': (
        lockPath: 'test/tom_d4rt_flutter_ast_app/pubspec.lock',
        twinLockPath: 'pubspec.lock',
        interpreter: 'tom_d4rt_ast',
      ),
    };

/// The resolved version of [package] in the lockfile at [lockPath], or null
/// when the file or the entry is absent.
String? resolvedVersion(String lockPath, String package) {
  final file = File(lockPath);
  if (!file.existsSync()) return null;
  final lines = file.readAsLinesSync();
  for (var i = 0; i < lines.length; i++) {
    if (lines[i].trimRight() != '  $package:') continue;
    for (var j = i + 1; j < lines.length && lines[j].startsWith('    '); j++) {
      final match = RegExp(r'^\s+version: "([^"]+)"').firstMatch(lines[j]);
      if (match != null) return match.group(1);
    }
  }
  return null;
}

/// The lines of the NEWEST `## Verification runs` entry.
///
/// Entries are newest-first in this document, so the newest is the first
/// `###` heading after the `## Verification runs` heading, up to the next
/// `###` or `##`.
List<String> newestVerificationRun(List<String> lines) {
  var i = lines.indexWhere((l) => l.trim() == '## Verification runs');
  if (i < 0) return const [];
  i = lines.indexWhere((l) => l.startsWith('### '), i + 1);
  if (i < 0) return const [];
  final result = <String>[lines[i]];
  for (var j = i + 1; j < lines.length; j++) {
    if (lines[j].startsWith('### ') || lines[j].startsWith('## ')) break;
    result.add(lines[j]);
  }
  return result;
}

/// The interpreter version an entry's resolved-version table records for the
/// companion app labelled [appPath], or null when there is no such row.
///
/// Row shape, with the app path in backticks in the first cell, the version
/// bolded, and the other twin's column an em dash:
/// `| ...app path... | **1.77.0** | — |`
String? recordedVersion(List<String> entry, String appPath) {
  for (final line in entry) {
    if (!line.startsWith('|') || !line.contains(appPath)) continue;
    final cells = line.split('|').map((c) => c.trim()).toList();
    for (final cell in cells.skip(2)) {
      final match = RegExp(r'^\*\*(\d+\.\d+\.\d+[^*]*)\*\*$').firstMatch(cell);
      if (match != null) return match.group(1);
    }
  }
  return null;
}

void main() {
  final docFile = File('doc/interpreter_issues.md');
  late List<String> lines;

  setUpAll(() {
    expect(
      docFile.existsSync(),
      isTrue,
      reason:
          'doc/interpreter_issues.md not found — run this from the '
          'tom_d4rt_flutter_ast package root.',
    );
    lines = docFile.readAsLinesSync();
  });

  group('interpreter_issues.md "What is still open" table', () {
    test('ISSUES-1: the document actually parses into both a section set and a '
        'table set. [2026-09-05 00:00] (PASS)', () {
      // A parser that silently returns nothing would make ISSUES-2 pass
      // vacuously, which is the failure mode this whole file exists to
      // prevent. Pin that both sides found something first.
      expect(
        parseOpenClustersFromSections(lines),
        isNotEmpty,
        reason:
            'No open cluster headings found under "## Active clusters". If '
            'the campaign really has closed everything, delete this '
            'expectation together with the now-empty table — do not leave a '
            'guard that cannot fail.',
      );
      expect(
        parseOpenClustersFromTable(lines),
        isNotEmpty,
        reason: 'No rows parsed from the "## What is still open" table.',
      );
    });

    test(
      'ISSUES-2: every open cluster section has a table row and vice versa, '
      'matched on marker + verbatim heading text. [2026-09-05 00:00] (PASS)',
      () {
        final fromSections = parseOpenClustersFromSections(lines).toSet();
        final fromTable = parseOpenClustersFromTable(lines).toSet();

        final missingFromTable = fromSections.difference(fromTable);
        final missingFromSections = fromTable.difference(fromSections);

        expect(
          missingFromTable,
          isEmpty,
          reason:
              'These cluster sections are open but absent from the "What is '
              'still open" table — add a row reproducing the heading text '
              'verbatim:\n${missingFromTable.join('\n')}',
        );
        expect(
          missingFromSections,
          isEmpty,
          reason:
              'These table rows match no open cluster section — either the '
              'cluster was closed and the row should go, or the row\'s marker '
              '/ heading text drifted from the section:\n'
              '${missingFromSections.join('\n')}',
        );
      },
    );

    test('ISSUES-3: the header carries no corpus pass/fail numbers. '
        '[2026-09-05 00:00] (PASS)', () {
      // The header used to quote `927 / 1 / 0` and `2164 / 5 / 0`, each
      // measured against an interpreter pair the twins had long since moved
      // past. Corpus results belong in "## Verification runs" (which records
      // the pair it measured) and in the gitignored `testlog/`; a bare
      // triple in the header reads as current and cannot be dated.
      final headerEnd = lines.indexWhere(
        (l) => l.trim() == '## Active clusters',
      );
      expect(
        headerEnd,
        greaterThan(0),
        reason: 'No "## Active clusters" heading.',
      );

      final triple = RegExp(r'\b\d{2,5}\s*/\s*\d+\s*/\s*\d+\b');
      final offenders = <String>[
        for (final line in lines.take(headerEnd))
          if (triple.hasMatch(line)) line.trim(),
      ];
      expect(
        offenders,
        isEmpty,
        reason:
            'Corpus pass/skip/fail numbers found in the header. Put them in '
            '"## Verification runs" with the interpreter pair they '
            'measured:\n${offenders.join('\n')}',
      );
    });
  });

  group('SCD65: the recorded interpreter pair still describes this machine', () {
    test(
      'SCD65-1: the newest "## Verification runs" entry records a version for '
      'both companion apps. [2026-09-12 00:00] (PASS)',
      () {
        // Anti-vacuity, and not a formality: SCD65-2 compares a recorded value
        // against a resolved one, and BOTH sides are parsed out of files. A
        // parser that returns null on each side would make it pass while
        // checking nothing — which is the exact failure ISSUES-1 exists to
        // prevent one group up, arrived at the same way.
        final entry = newestVerificationRun(lines);
        expect(
          entry,
          isNotEmpty,
          reason:
              'No "### " entry found under "## Verification runs". Either the '
              'section was renamed or the entries stopped using "###" — this '
              'guard reads the first entry after that heading as the newest.',
        );

        for (final appPath in companionApps.keys) {
          expect(
            recordedVersion(entry, appPath),
            isNotNull,
            reason:
                'The newest verification run has no resolved-version row for '
                '`$appPath`. Every entry must record the pair it measured: '
                'the lockfiles are gitignored, so this table is the only '
                'durable record of which interpreter the run used.\n'
                'Entry: ${entry.first}',
          );
        }
      },
    );

    test(
      'SCD65-2: what the companion apps resolve here matches what the newest '
      'run recorded. [2026-09-12 00:00] (PASS)',
      () {
        final entry = newestVerificationRun(lines);
        final mismatches = <String>[];

        companionApps.forEach((appPath, app) {
          final recorded = recordedVersion(entry, appPath);
          final resolved = resolvedVersion(app.lockPath, app.interpreter);
          if (recorded == null) return; // SCD65-1 owns that failure.
          if (resolved == null) {
            // A missing lockfile is not a mismatch — it is an unresolved app,
            // which the runner scripts fix with `flutter pub get`. Say so
            // rather than reporting it as drift.
            mismatches.add(
              '$appPath: nothing resolved (${app.lockPath} is absent or has '
              'no ${app.interpreter} entry) — run `flutter pub get` in the '
              'app before reading this guard as a version difference.',
            );
            return;
          }
          if (recorded != resolved) {
            mismatches.add(
              '$appPath: the newest run recorded ${app.interpreter} '
              '$recorded, this machine resolves $resolved.',
            );
          }
        });

        expect(
          mismatches,
          isEmpty,
          reason:
              'The newest "## Verification runs" entry does not describe a run '
              'made on this machine, so its numbers are NOT comparable to a '
              'fresh corpus run here:\n${mismatches.join('\n')}\n\n'
              'This normally means an interpreter was published and upgraded '
              'since that entry was written — in which case a new run is owed '
              'and its own entry closes this. It can also mean the apps were '
              'upgraded without a run, which is the case worth catching: a '
              'corpus run made now would silently be compared against numbers '
              'from a different interpreter.\n\n'
              'Entry: ${entry.isEmpty ? '(none)' : entry.first}',
        );
      },
    );

    test(
      'SCD65-4: each twin and its companion app resolve the same interpreter. '
      '[2026-09-12 00:00] (PASS)',
      () {
        // The verification tables are read from the COMPANION APP lockfiles
        // and claim to equal "what each twin itself resolves". That claim can
        // come apart: `flutter pub upgrade` in the twin does not touch the
        // app's lock, and the 2026-09-06 entry records exactly that near-miss
        // — caught then by someone noticing, not by anything checking.
        //
        // The runner scripts and `test/companion_app_resolution.dart` do check
        // it, but only for the AST twin and only once a corpus run has already
        // started. This is the same question asked from a file, for both
        // twins, at any time — including before committing to an hour of runs.
        final divergences = <String>[];
        companionApps.forEach((appPath, app) {
          final inApp = resolvedVersion(app.lockPath, app.interpreter);
          final inTwin = resolvedVersion(app.twinLockPath, app.interpreter);
          if (inApp == null || inTwin == null) return; // unresolved: SCD65-2.
          if (inApp != inTwin) {
            divergences.add(
              '$appPath resolves ${app.interpreter} $inApp, but its twin '
              '(${app.twinLockPath}) resolves $inTwin.',
            );
          }
        });
        expect(
          divergences,
          isEmpty,
          reason:
              'A twin and its companion app resolve different interpreters, so '
              'the corpus would certify one while the package declares the '
              'other:\n${divergences.join('\n')}\n\n'
              'Run `flutter pub get` (or `upgrade`) in BOTH — upgrading the '
              'twin alone leaves the app behind, and the app is the package '
              'the corpus scripts actually execute in.',
        );
      },
    );

    test('SCD65-3: both twins\' test/README.md state that the corpus certifies '
        'the published interpreter. [2026-09-12 00:00] (PASS)', () {
      // The constraint is stated in the quest overview, inside the
      // cluster-fix protocol. That is where somebody planning the work meets
      // it; this is where somebody about to RUN the corpus meets it, which
      // is a different person on a different day. Both twins carry it
      // because the hazard is identical on both and neither reader has any
      // reason to open the other's docs.
      const heading =
          '## ⚠️ The corpus certifies the PUBLISHED interpreter, '
          'not the working tree';
      const readmes = <String>[
        'test/README.md',
        '../tom_d4rt_flutter/test/README.md',
      ];
      for (final path in readmes) {
        final file = File(path);
        expect(
          file.existsSync(),
          isTrue,
          reason: '$path not found — run this from the package root.',
        );
        expect(
          file.readAsStringSync(),
          contains(heading),
          reason:
              '$path no longer carries the section stating that a corpus run '
              'certifies the PUBLISHED interpreter. Without it the runner '
              'docs read as though a green corpus proves an interpreter '
              'change, which for an unpublished one it does not.',
        );
      }
    });
  });
}
