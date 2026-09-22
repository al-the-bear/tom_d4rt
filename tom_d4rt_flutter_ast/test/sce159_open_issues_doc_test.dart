// RUNNER BUCKET: guard — run_guard_tests.sh
//
/// SCE159 — `doc/interpreter_generator_open_issues.md` rates its open entries
/// and derives its header from them.
///
/// ## Why it was unguarded, and why that is not the same as safe
///
/// SCD135 made `interpreter_issues.md` state a blast radius for every open
/// cluster and enforced it. Its sibling here was held to none of it: 13 open
/// entries with no severity, no reach, and no structural check of any kind.
///
/// It LOOKS guarded, which is the interesting part.
/// `interpreter_generator_open_issues_test.dart` drives a reproduction script
/// per entry — but that suite is EXPECTED TO FAIL, red being its correct
/// output while an issue is open, so it says nothing whatever about the
/// document. Nothing checked that the ✅ markers agreed with it, that a
/// resolved entry had left the open set, or that an open entry was rated by
/// anything at all.
///
/// ## The entry→test mapping is mechanical, so the cross-check is real
///
/// That was measured before this guard was written, because the work that
/// asked for it said to stop at rating if it was not. Every test in the
/// reproduction suite is named `'<id> — …'` with the entry id first, and every
/// reproduction script is `open_issues/<id lowercased, dot dropped>_*.dart`.
/// So the doc, the suite and the corpus can be joined on the id without
/// inventing anything.
///
/// ## What is asserted
///
/// F-SCE159-1 — every OPEN entry carries a `**Blast radius:**` statement.
/// F-SCE159-2 — that statement is prose about reach, not a count. Same rule as
///   ISSUES-5 next door, and the same failure it guards:
///   `**Blast radius:** 8 framework errors` satisfies -1 while reintroducing
///   exactly the mistake the convention exists to prevent.
/// F-SCE159-3 — every entry, open or resolved, carries a `**Repro:**` line
///   declaring one of four states, and every script it names exists on disk.
///   `none` and `skipped` are first-class answers: several entries genuinely
///   cannot be reproduced as a single deterministic build, and saying so is
///   what stops the next reader looking for the missing test.
/// F-SCE159-4 — the header register is recomputed from the entries: the
///   counts, the red set, and the open-but-green set. The last of those is the
///   one `interpreter_issues.md` has no equivalent of, because its clusters
///   have no per-entry test — and it is the drift most likely to be misread,
///   since a green test under an open entry looks like a stale document.
/// F-SCE159-5 — every entry whose `**Repro:**` names a script has a test in the
///   reproduction suite naming its id, and every id the suite names exists in
///   the document (open in §2–4, or retired into §1).
/// F-SCE159-6 (control) — the parse found the sections, the section scoping
///   works, and the rules of -2 and -3 can actually fail.
///
/// This reads files in its own package and needs no transport, so it belongs in
/// `run_guard_tests.sh` rather than in either corpus runner. It deliberately
/// does NOT run the reproduction suite: that costs a companion app and its red
/// is correct by design, so the result recorded in the register is a dated
/// measurement rather than something to recompute on every guard run.
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'interpreter_issues_doc_test.dart' show fieldStatement;

const _doc = 'doc/interpreter_generator_open_issues.md';
const _suite = 'test/interpreter_generator_open_issues_test.dart';
const _scripts = 'test/tom_d4rt_flutter_ast_app/test/send_ast_via_http_scripts';

/// Sections that hold entries. §1 is the excluded table and §5 is housekeeping;
/// neither carries `###` entries, but scoping by heading rather than by
/// "every `###` in the file" is what keeps this honest if either grows one.
const _entrySections = <String>{
  '## 2. A — Genuinely unfixable limitations (→ limits doc)',
  '## 3. B — Interpreter-fixable issues',
  '## 4. C — Generator-fixable issues',
};

/// The four states a `**Repro:**` line may declare.
const _reproStates = <String>{'red', 'green', 'skipped', 'none'};

typedef _Entry = ({
  String id,
  String heading,
  bool resolved,
  List<String> body,
});

List<_Entry> _parseEntries(List<String> lines) {
  final entries = <_Entry>[];
  var inEntrySection = false;
  String? heading;
  var body = <String>[];

  void flush() {
    final current = heading;
    if (current != null) {
      entries.add((
        id: current.substring(4).split(' ').first.trim(),
        heading: current,
        resolved: current.contains('✅'),
        body: List.of(body),
      ));
    }
    heading = null;
    body = <String>[];
  }

  for (final line in lines) {
    if (line.startsWith('## ')) {
      flush();
      inEntrySection = _entrySections.contains(line.trim());
      continue;
    }
    if (!inEntrySection) continue;
    if (line.startsWith('### ')) {
      flush();
      heading = line;
      continue;
    }
    if (heading != null) body.add(line);
  }
  flush();
  return entries;
}

/// The state word a `**Repro:**` statement declares.
String reproState(String statement) {
  if (statement.contains('**red**')) return 'red';
  if (statement.contains('**green**')) return 'green';
  if (statement.trimLeft().startsWith('none')) return 'none';
  if (statement.contains('skipped')) return 'skipped';
  return 'unrecognised';
}

/// Scripts a `**Repro:**` statement names, as corpus-relative paths.
List<String> reproScripts(String statement) => RegExp(
  r'`(open_issues/[A-Za-z0-9_]+\.dart)`',
).allMatches(statement).map((m) => m.group(1)!).toList();

/// Reads a `| label | count |` row out of the header register.
int? _registerCount(List<String> lines, String label) {
  for (final line in lines) {
    if (!line.startsWith('| ')) continue;
    final cells = line.split('|').map((c) => c.trim()).toList();
    if (cells.length >= 4 && cells[1] == label) return int.tryParse(cells[2]);
  }
  return null;
}

/// The ids listed after [marker] in the header register, in order.
List<String> _registerIds(List<String> lines, String marker) {
  for (final line in lines) {
    final at = line.indexOf(marker);
    if (at < 0) continue;
    final tail = line.substring(at + marker.length);
    return RegExp(
      r'\b[A-C]\.\d+\b',
    ).allMatches(tail).map((m) => m.group(0)!).toList();
  }
  return const [];
}

void main() {
  late List<String> lines;
  late List<_Entry> entries;
  late String suiteSource;

  setUpAll(() {
    final doc = File(_doc);
    expect(
      doc.existsSync(),
      isTrue,
      reason:
          '$_doc is this guard\'s entire subject; if it moved, move the guard '
          'with it rather than leaving one that passes over nothing',
    );
    lines = doc.readAsLinesSync();
    entries = _parseEntries(lines);
    suiteSource = File(_suite).readAsStringSync();
  });

  group('SCE159: the open-issues doc is rated and its header is derived', () {
    test(
      'F-SCE159-1: every open entry carries a **Blast radius:** statement',
      () {
        final missing = <String>[
          for (final entry in entries)
            if (!entry.resolved &&
                fieldStatement(entry.body, 'Blast radius') == null)
              entry.heading,
        ];
        expect(
          missing,
          isEmpty,
          reason:
              'An open entry with no statement of what it can REACH cannot be '
              'prioritised against the others, which is how 13 entries sat here '
              'with no severity at all. Add a `**Blast radius:**` line; counts '
              'go under `**Measured:**`:\n  ${missing.join('\n  ')}',
        );
      },
    );

    test('F-SCE159-2: the blast-radius statement is prose, not a count', () {
      final offenders = <String>[];
      for (final entry in entries) {
        final statement = fieldStatement(entry.body, 'Blast radius');
        if (statement == null) continue; // F-SCE159-1 owns that.
        if (RegExp(r'^[^A-Za-z]*\d').hasMatch(statement)) {
          offenders.add('${entry.id} opens with a number');
        } else if (statement.length < 80) {
          offenders.add(
            '${entry.id} is too short to state a reach '
            '(${statement.length} chars)',
          );
        }
      }
      expect(
        offenders,
        isEmpty,
        reason:
            'A blast radius is what the defect can reach, in prose. '
            '`**Blast radius:** 8 framework errors` passes F-SCE159-1 while '
            'reintroducing the exact mistake the convention '
            'prevents:\n  ${offenders.join('\n  ')}',
      );
    });

    test('F-SCE159-3: every entry declares a repro state, and named scripts '
        'exist', () {
      final missing = <String>[];
      final unrecognised = <String>[];
      final absent = <String>[];
      for (final entry in entries) {
        final statement = fieldStatement(entry.body, 'Repro');
        if (statement == null) {
          missing.add(entry.id);
          continue;
        }
        final state = reproState(statement);
        if (!_reproStates.contains(state)) {
          unrecognised.add('${entry.id}: "$statement"');
          continue;
        }
        for (final script in reproScripts(statement)) {
          if (!File('$_scripts/$script').existsSync()) {
            absent.add('${entry.id} -> $script');
          }
        }
      }
      expect(
        missing,
        isEmpty,
        reason:
            'these entries say nothing about whether a reproduction exists, so '
            'the next reader has to grep for one: ${missing.join(', ')}',
      );
      expect(
        unrecognised,
        isEmpty,
        reason:
            'the states are ${_reproStates.join(' / ')}; `none` and `skipped` '
            'are first-class answers and are what stops somebody hunting for a '
            'test that deliberately does not exist:\n  '
            '${unrecognised.join('\n  ')}',
      );
      expect(
        absent,
        isEmpty,
        reason:
            'a `**Repro:**` line names a script that is not in the corpus. '
            'Either the script moved or the entry is describing one that was '
            'never written:\n  ${absent.join('\n  ')}',
      );
    });

    test('F-SCE159-4: the header register is derived from the entries', () {
      final open = entries.where((e) => !e.resolved).toList();
      final resolved = entries.where((e) => e.resolved).toList();

      expect(
        _registerCount(lines, 'entries (`### `)'),
        entries.length,
        reason: 'the register\'s entry count and the `###` headings disagree',
      );
      expect(
        _registerCount(lines, 'open'),
        open.length,
        reason: 'the register\'s open count and the unticked headings disagree',
      );
      expect(
        _registerCount(lines, 'marked resolved (✅)'),
        resolved.length,
        reason: 'the register\'s resolved count and the ✅ headings disagree',
      );

      String stateOf(_Entry e) {
        final statement = fieldStatement(e.body, 'Repro');
        return statement == null ? 'unrecognised' : reproState(statement);
      }

      final red = <String>{
        for (final e in entries)
          if (stateOf(e) == 'red') e.id,
      };
      final openGreen = <String>{
        for (final e in open)
          if (stateOf(e) == 'green') e.id,
      };

      expect(
        _registerIds(lines, 'Still reproducing (the red set):').toSet(),
        red,
        reason:
            'the register names a red set the `**Repro:**` lines do not '
            'support. Recompute it from the entries, never the other way round',
      );
      expect(
        _registerIds(
          lines,
          'Open entries whose reproduction is GREEN:',
        ).toSet(),
        openGreen,
        reason:
            'the open-but-green list is the drift most likely to be misread — '
            'a green test under an open entry looks like a stale document, and '
            'each of these has a reason on its own `**Repro:**` line. It has to '
            'be derived, or it becomes the stale thing it exists to explain',
      );
    });

    test('F-SCE159-5: the document and the reproduction suite name the same '
        'entries', () {
      final suiteIds = RegExp(
        r"test\(\s*\n?\s*'([A-C]\.\d+) —",
      ).allMatches(suiteSource).map((m) => m.group(1)!).toSet();
      expect(
        suiteIds,
        isNotEmpty,
        reason:
            'no test names were parsed out of $_suite, so both directions '
            'below would pass by comparing against an empty set',
      );

      final documented = {for (final e in entries) e.id};
      final retired = <String>{
        for (final line in lines)
          if (line.startsWith('| '))
            ...RegExp(
              r'\|\s*([A-C]\.\d+)\b',
            ).allMatches(line).map((m) => m.group(1)!),
      };

      final orphanTests = suiteIds.difference(documented).difference(retired);
      expect(
        orphanTests,
        isEmpty,
        reason:
            'the reproduction suite drives these ids and the document knows '
            'nothing about them — neither an open `###` entry nor a row in §1. '
            'An entry resolved and deleted while its test lingers is exactly '
            'this shape: ${orphanTests.join(', ')}',
      );

      final withScript = <String>{
        for (final e in entries)
          if (reproScripts(fieldStatement(e.body, 'Repro') ?? '').isNotEmpty)
            e.id,
      };
      final untested = withScript.difference(suiteIds);
      expect(
        untested,
        isEmpty,
        reason:
            'these entries name a reproduction script but no test in $_suite '
            'drives it, so nothing would notice the day it flips: '
            '${untested.join(', ')}',
      );
    });

    test('F-SCE159-6 (control): the parse is non-vacuous and the rules can '
        'fail', () {
      expect(
        entries.length,
        greaterThanOrEqualTo(10),
        reason:
            'only ${entries.length} entries parsed. Every assertion above '
            'iterates this list, so a broken section scope passes them all by '
            'iterating nothing',
      );
      expect(
        entries.where((e) => e.resolved).length,
        greaterThanOrEqualTo(1),
        reason:
            'no ✅ entry parsed, so the open/resolved split is untested and '
            'F-SCE159-1 is asserting over everything rather than over the '
            'open set',
      );
      expect(
        _parseEntries(['## 1. Excluded', '### A.9 — not an entry section']),
        isEmpty,
        reason:
            'a `###` outside the three entry sections must not be read as an '
            'entry — §1 is a table and §5 is housekeeping',
      );

      // The rules of -2 and -3, exercised so neither is a claim that happens
      // to hold only while the document is in its current shape.
      expect(RegExp(r'^[^A-Za-z]*\d').hasMatch('8 framework errors'), isTrue);
      expect(
        RegExp(r'^[^A-Za-z]*\d').hasMatch('Every script that crosses'),
        isFalse,
      );
      expect(reproState('`open_issues/x.dart` — **red**, correct'), 'red');
      expect(reproState('`open_issues/x.dart` — **green**, correct'), 'green');
      expect(reproState('none — the suite skips it'), 'none');
      expect(
        reproState('`open_issues/x.dart` — skipped (non-fatal)'),
        'skipped',
      );
      expect(reproState('probably fine'), 'unrecognised');
      expect(reproScripts('`open_issues/a.dart` and `open_issues/b.dart`'), [
        'open_issues/a.dart',
        'open_issues/b.dart',
      ]);
    });
  });
}
