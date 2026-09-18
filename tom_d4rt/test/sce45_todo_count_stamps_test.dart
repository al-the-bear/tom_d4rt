// REPO-WIDE GUARD (tom_d4rt) — no open quest todo cites a suite count without the date it was measured.
//
// Its subject reaches OUTSIDE this package — it reads
// `_ai/quests/d4rt/todos.d4rt.todo.yaml` — so it runs only when tom_d4rt's
// suite runs and a session working elsewhere in the repo reaches none of it.
// SCD129 made that arrangement visible rather than incidental: `grep -rn
// 'REPO-WIDE GUARD' */test` lists every one, and
// `tom_d4rt/test/scd129_repo_wide_guard_index_test.dart` fails if a new one
// arrives without this banner.
//
// WHAT WENT WRONG. `dguc11_agñb` carried "911 passed / 0 failed against
// tom_d4rt 1.22.0" as a reference figure. The real number was 936/3, then
// 939/0 after a floor change, and 1037/0 a fortnight later. Its own
// description says why that matters: a stale reference number in an open todo
// is worse than none, because the next reader diffs against it and sees a
// discrepancy that has no cause. SCD11 removed that one by hand; SCE45 found
// the same shape in eight more, and by the time SCE45 ran those eight had been
// archived and SIX DIFFERENT open todos had grown it. That is the reason this
// is a guard and not a second sweep — the shape comes back faster than anyone
// sweeps it.
//
// WHY A DATE IS THE BAR AND NOT A VERSION. SCE45 measured 23 todos citing a
// count and judged the fifteen date-stamped ones "fine as evidence": a count
// moves for reasons unrelated to the todo — a floor raise, a publish, tests
// another piece of work added — and a date is what lets a reader decide
// whether the figure still describes anything. Demanding a version as well
// would fire on almost every entry and be muted within a week.
//
// DELETING THE NUMBER IS NOT THE FIX, and this guard must never be satisfied
// that way: the count is the evidence the todo exists for. Stamp it.
//
// WHAT IS DELIBERATELY NOT MATCHED. `sce50/54/56` (todo ids), `120 / 450`
// (version floors), `lib/src/x.dart` (paths) and `1.20.0` (versions) all have
// the shape of a ratio and none of them is a suite count. Each cost a false
// positive while this guard was being written, and F-SCE45-4 pins that they
// stay out — a rule this noisy is one that gets muted.

import 'dart:io';

import 'package:test/test.dart';

import 'sibling_trees.dart';

/// The quest todo file this guard reads.
File _todos() => File('../../../_ai/quests/d4rt/todos.d4rt.todo.yaml');

/// Statuses that mean the todo is still to be acted on.
///
/// A completed or cancelled todo is a record of what happened, and its figures
/// are history rather than a reference someone is about to diff against.
const _openStatuses = {
  'not-started',
  'in-progress',
  'blocked',
  'decision-needed',
};

/// A count labelled as a test outcome: `1081 passing`, `3 failed`.
final RegExp _labelledCount = RegExp(
  r'\b\d{1,5}\s*(?:passed|passing|failed|failing)\b',
  caseSensitive: false,
);

/// `package:test`'s compact counter: `+3809 ~1 -4`.
final RegExp _compactCounter = RegExp(r'\+\d{1,5}\s*(?:~\d+\s*)?-\d+');

/// A bare ratio — `3467/0`, `108/0/0`, `924/1/3`.
///
/// Two and three parts both occur: the flutter runners report
/// pass/skip/fail. The lookarounds keep ids (`sce50/54`), paths
/// (`lib/src/x`) and versions (`1.20.0`) out; a trailing `.` is allowed
/// because these end sentences.
final RegExp _ratio = RegExp(
  r'(?<![\w/.])\d{1,5}(?:\s*/\s*\d{1,5}){1,2}(?![\d/])',
);

/// Words that make a nearby ratio a SUITE count rather than a coincidence.
final RegExp _suiteWord = RegExp(
  r'\b(suite|tests?|green|red|corpus|corpora|pass\w*|fail\w*|run|runner|'
  r'baseline|scripts?)\b',
  caseSensitive: false,
);

final RegExp _isoDate = RegExp(r'\b20\d\d-\d\d-\d\d\b');

/// Entry metadata whose dates say when the todo was WRITTEN, not when any
/// figure inside it was measured.
final RegExp _metadataLine = RegExp(
  r'^\s{4}(created|updated|completed_date|archived|deleted):',
);

/// True when [text] cites a figure a reader would diff against.
bool citesSuiteCount(String text) {
  if (_labelledCount.hasMatch(text) || _compactCounter.hasMatch(text)) {
    return true;
  }
  for (final m in _ratio.allMatches(text)) {
    final from = m.start - 65 < 0 ? 0 : m.start - 65;
    final to = m.end + 65 > text.length ? text.length : m.end + 65;
    if (_suiteWord.hasMatch(text.substring(from, to))) return true;
  }
  return false;
}

/// One todo entry: its id, its status, and its whole text.
typedef TodoEntry = ({String id, String status, String text});

/// Splits the file into entries textually.
///
/// Textual rather than parsed: this package has no `yaml` dependency, and
/// adding one so a guard can read a document would be a heavier coupling than
/// the guard is worth. Entries start at column 2 with `- id:`, which is the
/// file's own shape.
List<TodoEntry> readTodos(String source) {
  final lines = source.split('\n');
  final starts = <int>[];
  for (var i = 0; i < lines.length; i++) {
    if (lines[i].startsWith('  - id: ')) starts.add(i);
  }
  final out = <TodoEntry>[];
  for (var n = 0; n < starts.length; n++) {
    final from = starts[n];
    final to = n + 1 < starts.length ? starts[n + 1] : lines.length;
    final body = lines.sublist(from, to);
    final statusLine = body.firstWhere(
      (l) => l.startsWith('    status:'),
      orElse: () => '    status: <none>',
    );
    // METADATA LINES ARE EXCLUDED, and this is load-bearing rather than
    // tidiness: every entry carries `created:` and most carry `updated:`,
    // both ISO dates. Including them made every todo look stamped, so the
    // rule below could never fail — caught by ablating a real entry and
    // watching the guard stay green.
    final prose = body.where((l) => !_metadataLine.hasMatch(l)).join(' ');
    out.add((
      id: lines[from].substring('  - id: '.length).trim(),
      status: statusLine.split(':').last.trim(),
      text: prose,
    ));
  }
  return out;
}

void main() {
  requirePackage('tom_d4rt', subject: 'the d4rt quest todo file');

  group('SCE45: an open todo dates the counts it cites', () {
    test('F-SCE45-1: the todo file was found and parsed [2026-09-18] (PASS)', () {
      // Anti-vacuity: F-SCE45-2 asks whether a set is empty, and an unreadable
      // file satisfies it while checking nothing.
      final file = _todos();
      expect(
        file.existsSync(),
        isTrue,
        reason:
            '${file.path} not found. The `_ai` layer is symlinked into every '
            'workspace on every fleet machine, so its absence is a broken '
            'checkout rather than a supported configuration.',
      );
      final todos = readTodos(file.readAsStringSync());
      expect(todos.length, greaterThan(100));
      expect(
        todos.where((t) => _openStatuses.contains(t.status)),
        isNotEmpty,
        reason: 'no OPEN todo was parsed, so the rule below applies to nothing',
      );
      expect(
        todos.where((t) => citesSuiteCount(t.text)),
        isNotEmpty,
        reason:
            'no todo anywhere cites a count, which means the patterns stopped '
            'recognising their subject rather than that the quest stopped '
            'measuring things',
      );
    });

    test('F-SCE45-2: no open todo cites a count without a date '
        '[2026-09-18] (PASS)', () {
      final offenders = readTodos(_todos().readAsStringSync())
          .where((t) => _openStatuses.contains(t.status))
          .where((t) => citesSuiteCount(t.text))
          .where((t) => !_isoDate.hasMatch(t.text))
          .map((t) => t.id)
          .toList();

      expect(
        offenders,
        isEmpty,
        reason:
            'These open todos cite a suite or corpus count with no date '
            'anywhere in the entry, so nothing tells the next reader what the '
            'number described — and a count moves for reasons unrelated to the '
            'todo holding it. Do NOT delete the figure; it is the evidence. '
            'Stamp it `(measured YYYY-MM-DD)`, or replace it with the command '
            'that reproduces it:\n  ${offenders.join('\n  ')}',
      );
    });

    test('F-SCE45-3 (control): the patterns match the shapes they were '
        'written against [2026-09-18] (PASS)', () {
      // Without this, a typo in any pattern turns F-SCE45-2 into a test that
      // passes because it can no longer recognise its own subject. Every
      // string here is the pre-stamp text of a real todo.
      const samples = [
        'scd34_aidc: full suite green (3467/0) before commit',
        'sound on real corpora: 2083/2085 flutter-cluster scripts',
        'one measured instance went from 108/0/0 to 40/2/66 when run',
        'the file passes 12/12. Nothing has pushed it to converge',
        'The FIRST reported `+3771 ~1 -3` while naming only the two',
        'restored afterwards): 924/1/3 against a 927/1/0 baseline',
        'Suite: 1076 passing, 0 failing.',
      ];
      for (final sample in samples) {
        expect(
          citesSuiteCount(sample),
          isTrue,
          reason: 'stopped recognising: $sample',
        );
      }
    });

    test('F-SCE45-4 (control): shapes that only LOOK like counts are not '
        'flagged [2026-09-18] (PASS)', () {
      // Each of these produced a false positive while the guard was written.
      // A rule that reports them is a rule that gets muted.
      const notCounts = [
        'the `_bin/` scopes of sce50/54/56 are fixed in the same commit',
        'the floors while there. They are set at 120 / 450 and should',
        'lib/src/stdlib/core.dart and lib/src/runtime/x.dart',
        'from `tom_d4rt_generator` 1.20.0 on every generated file',
        'GEN-045 / GEN-064 both apply here',
      ];
      for (final sample in notCounts) {
        expect(
          citesSuiteCount(sample),
          isFalse,
          reason: 'false positive on: $sample',
        );
      }
    });
  });
}
