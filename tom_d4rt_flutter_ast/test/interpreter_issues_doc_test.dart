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
    test(
      'ISSUES-1: the document actually parses into both a section set and a '
      'table set. [2026-09-05 00:00] (PASS)',
      () {
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
      },
    );

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

    test(
      'ISSUES-3: the header carries no corpus pass/fail numbers. '
      '[2026-09-05 00:00] (PASS)',
      () {
        // The header used to quote `927 / 1 / 0` and `2164 / 5 / 0`, each
        // measured against an interpreter pair the twins had long since moved
        // past. Corpus results belong in "## Verification runs" (which records
        // the pair it measured) and in the gitignored `testlog/`; a bare
        // triple in the header reads as current and cannot be dated.
        final headerEnd = lines.indexWhere((l) => l.trim() == '## Active clusters');
        expect(headerEnd, greaterThan(0), reason: 'No "## Active clusters" heading.');

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
      },
    );
  });
}
