@Timeout(Duration(minutes: 5))
library;

import 'dart:io';

import 'package:test/test.dart';

import '../../tool/stdlib_member_diff.dart';

/// SCC89 — the gap audit's printed figures match a live run.
///
/// WHAT GOES WRONG WITHOUT THIS. Every headline number in
/// `doc/stdlib_sdk_gap_audit.md` is an output of `tool/stdlib_member_diff.dart`
/// transcribed by hand. The tool is mechanical and repeatable, which is the
/// document's stated virtue; the transcription is neither. A bridging change
/// invalidates some figure, and the person making that change has no reason to
/// know which — so the doc keeps reporting gaps that were closed, and closures
/// that were never measured.
///
/// That is not hypothetical. SCC57 measured the hierarchy audit at zero
/// candidates and wrote it down; SCC63 then bridged the `dart:io` WebSocket
/// surface without declaring `WebSocketTransformer -> StreamTransformer`, and
/// nothing re-ran `--hierarchy`. The doc said "zero candidates, zero confirmed,
/// across 183 classes" while a fresh run said one confirmed missing edge across
/// 205. It had been wrong for every commit in between.
///
/// WHY THE FIGURES ARE PARSED RATHER THAN GENERATED. Generating them would make
/// the doc a build artifact, and this one is mostly prose that explains what the
/// numbers mean — the movement table, the note on why a rising confirmed count
/// is good news. A generator would either rewrite that prose or be confined to
/// the tables, and the second is what this file is, without the generator.
///
/// The member and hierarchy audits are the tool's own `collectMemberDiffs` /
/// `verifyAll` / `auditHierarchy` / `applyDeclinedEdges`, not a
/// reimplementation, for the same reason `member_coverage_baseline_test.dart`
/// uses them: a checker that measures differently from the thing it checks
/// tests its own copy.
void main() {
  final doc = File('doc/stdlib_sdk_gap_audit.md');

  /// The `| Label | N |` rows of the one measured-state table in [section].
  ///
  /// Scoped to a section because both tables carry a "Bridged classes examined"
  /// row, and a whole-file search would silently compare the wrong one.
  Map<String, String> figuresIn(String section) {
    final text = doc.readAsStringSync();
    final start = text.indexOf(section);
    expect(
      start,
      isNot(-1),
      reason:
          'The heading "$section" is gone from the audit doc, so this guard is '
          'reading nothing. Point it at the new heading rather than deleting '
          'the case.',
    );
    final tableStart = text.indexOf('| Metric | Count |', start);
    expect(tableStart, isNot(-1), reason: 'No metric table under "$section".');
    final out = <String, String>{};
    for (final line in text.substring(tableStart).split('\n').skip(2)) {
      if (!line.startsWith('|')) break;
      final cells = line.split('|').map((c) => c.trim()).toList();
      if (cells.length < 4) continue;
      final label = cells[1].replaceAll('…', '').replaceAll('*', '').trim();
      final value = cells[2].replaceAll('*', '').trim();
      out[label] = value;
    }
    return out;
  }

  /// `'5'` and `'5 in 2 classes'` both yield 5 — the doc states some figures
  /// with their class count inline, and the leading number is the metric.
  int leadingInt(String cell) =>
      int.parse(RegExp(r'-?\d+').firstMatch(cell)!.group(0)!);

  group('SCC89: the audit doc reports what a fresh run measures', () {
    test('F-SCC89-1: the guard found both tables and they are populated '
        '[2026-09-07]', () {
      // Anti-vacuity. Every comparison below is a lookup by label, so a
      // renamed heading or a reformatted table would make them all pass by
      // finding nothing to compare.
      final member = figuresIn('### Current measured state');
      final hierarchy = figuresIn('## Hierarchy gaps');
      expect(member.length, greaterThan(5));
      expect(hierarchy.length, greaterThan(5));
      expect(member.keys, contains('Bridged classes examined'));
      expect(hierarchy.keys, contains('CONFIRMED missing edges'));
    });

    test(
      'F-SCC89-2: the member figures match a live audit [2026-09-07]',
      () async {
        final diffs = collectMemberDiffs(buildFullyRegisteredEnvironment());
        await verifyAll(diffs);
        final printed = figuresIn('### Current measured state');

        int sum(int Function(ClassDiff) f) => diffs.fold(0, (s, d) => s + f(d));
        final measured = <String, int>{
          'Bridged classes examined': diffs.length,
          'unverified - cannot be measured, reason stated': sum(
            (d) => d.notAuditableReason != null ? d.unverifiedCount : 0,
          ),
          'unverified - no recipe yet': sum(
            (d) => d.notAuditableReason == null ? d.unverifiedCount : 0,
          ),
        };

        final mismatches = <String>[];
        measured.forEach((label, value) {
          final key = printed.keys.firstWhere(
            (k) => k.replaceAll('—', '-') == label,
            orElse: () => '',
          );
          if (key.isEmpty) {
            mismatches.add('"$label" has no row in the doc');
            return;
          }
          final stated = leadingInt(printed[key]!);
          if (stated != value) {
            mismatches.add('$label: doc says $stated, a live run says $value');
          }
        });
        expect(
          mismatches,
          isEmpty,
          reason:
              'The doc\'s member figures no longer describe a fresh run. Re-run '
              '`dart run tool/stdlib_member_diff.dart` and correct the "Current '
              'measured state" table — and read the movement notes around it, '
              'because a RISING confirmed count is usually the audit seeing '
              'further rather than a regression.\n${mismatches.join('\n')}',
        );
      },
    );

    test(
      'F-SCC89-3: the hierarchy figures match a live audit [2026-09-07]',
      () async {
        final env = buildFullyRegisteredEnvironment();
        final gaps = auditHierarchy(env);
        for (final gap in gaps) {
          await verifyHierarchy(gap, env);
        }
        final declined = applyDeclinedEdges(gaps);
        final printed = figuresIn('## Hierarchy gaps');

        final measured = <String, int>{
          'Bridged classes examined': gaps.length,
          'declaring `isAssignable`': gaps
              .where((g) => g.hasIsAssignable)
              .length,
          'with >= 1 registered edge': gaps
              .where((g) => g.registeredEdges.isNotEmpty)
              .length,
          'satisfied anyway via `isAssignable`': gaps.fold(
            0,
            (s, g) => s + g.satisfiedAnyway.length,
          ),
          'unverified (no instance recipe)': gaps.fold(
            0,
            (s, g) => s + g.unverifiedEdges.length,
          ),
          'missing by decision': declined,
          'CONFIRMED missing edges': gaps.fold(
            0,
            (s, g) => s + g.missingEdges.length,
          ),
          'Classes with >= 1 confirmed gap': gaps
              .where((g) => g.missingEdges.isNotEmpty)
              .length,
        };

        String norm(String s) =>
            s.replaceAll('≥', '>=').replaceAll('—', '-').trim();
        final mismatches = <String>[];
        measured.forEach((label, value) {
          final key = printed.keys.firstWhere(
            (k) => norm(k) == label,
            orElse: () => '',
          );
          if (key.isEmpty) {
            mismatches.add('"$label" has no row in the doc');
            return;
          }
          final stated = leadingInt(printed[key]!);
          if (stated != value) {
            mismatches.add('$label: doc says $stated, a live run says $value');
          }
        });
        expect(
          mismatches,
          isEmpty,
          reason:
              'The doc\'s hierarchy figures no longer describe a fresh run. This '
              'is the failure SCC89 was filed for: SCC57 wrote "zero candidates" '
              'and SCC63 then bridged a class without declaring its edge, and the '
              'doc stayed wrong until somebody happened to re-run the tool. '
              'Re-run `dart run tool/stdlib_member_diff.dart --hierarchy`, fix '
              'the edge if it is a real gap, and correct the table.\n'
              '${mismatches.join('\n')}',
        );
      },
    );
  });
}
