// RUNNER BUCKET: guard — run_guard_tests.sh
// REPO-WIDE GUARD (tom_d4rt_flutter_ast) — the cluster log's header table matches its sections, both twins' test/README.md agree on what the corpus certifies, and all four copies of the pass/skip/fail reading rule — including the quest overview, across the _ai mount — still state it.
//
// Its subject reaches OUTSIDE this package, so it runs only when tom_d4rt_flutter_ast's suite
// runs and a session working elsewhere in the repo reaches none of it. SCD129
// made that arrangement visible rather than incidental: `grep -rn 'REPO-WIDE
// GUARD' */test` lists every one, and
// `tom_d4rt/test/scd129_repo_wide_guard_index_test.dart` fails if a new one
// arrives without this banner.
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

import 'companion_app_resolution.dart';
import 'sibling_trees.dart';

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

/// One open cluster with the lines of its body — everything from its heading
/// up to the next `###` or `##`.
typedef ClusterBody = ({String heading, List<String> body});

/// Every open cluster under `## Active clusters`, with its body.
///
/// Same scoping as [parseOpenClustersFromSections] and for the same reason:
/// `## Verification runs` uses `###` for dated entries, and
/// `## Writing a cluster entry` (the template) uses `###` for its own
/// subsections. Only the cluster list is a status register.
List<ClusterBody> parseOpenClusterBodies(List<String> lines) {
  final result = <ClusterBody>[];
  var inActiveClusters = false;
  String? heading;
  var body = <String>[];

  void flush() {
    if (heading != null) result.add((heading: heading!, body: body));
    heading = null;
    body = <String>[];
  }

  for (final line in lines) {
    if (line.startsWith('## ')) {
      flush();
      inActiveClusters = line.trim() == '## Active clusters';
      continue;
    }
    if (!inActiveClusters) continue;
    if (line.startsWith('### ')) {
      flush();
      final parsed = _parseHeading(line);
      if (parsed != null && !_isClosed(parsed.marker)) {
        heading = '${parsed.marker} ${parsed.section}';
      }
      continue;
    }
    if (heading != null) body.add(line);
  }
  flush();
  return result;
}

/// The statement following a `**Field:**` marker, joined until the blank line
/// that ends its paragraph. Null when the field is absent.
String? fieldStatement(List<String> body, String field) {
  final marker = '**$field:**';
  final start = body.indexWhere((l) => l.trimLeft().startsWith(marker));
  if (start < 0) return null;
  final collected = <String>[body[start].trimLeft().substring(marker.length)];
  for (var i = start + 1; i < body.length; i++) {
    if (body[i].trim().isEmpty) break;
    collected.add(body[i]);
  }
  return collected.join(' ').replaceAll(RegExp(r'\s+'), ' ').trim();
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
///
/// SCD179: this used to carry its own twelve-line lockfile parser. It now
/// defers to `readLockedPackages` in `companion_app_resolution.dart` — the
/// same directory, already parsing exactly this, already used by
/// `run_attribution.dart`, and already held byte-identical across both twins
/// by `CAR-07`. Two parsers beside each other is one more than the number of
/// places this decision should live.
///
/// NOT `hosted_drift.dart`, which is what SCD179 proposed and which cannot
/// answer this question: its `worktreePackages` is a non-recursive
/// `listSync()` over the repo root — "every package DIRECTLY under repoRoot" —
/// and the companion apps live two levels down, under a twin's `test/`. That
/// is deliberate rather than an oversight: recursing would pull every example
/// and fixture package in the repo into the drift report and change what
/// `--check` means. The tool measures the repo's published surface; this guard
/// measures the app the corpus actually runs in, and they are different
/// questions.
String? resolvedVersion(String lockPath, String package) {
  // `readLockedPackages` takes the package DIRECTORY; the tables above record
  // the lockfile path because that is what a reader checks by hand.
  const suffix = '/pubspec.lock';
  final dir = lockPath.endsWith(suffix)
      ? lockPath.substring(0, lockPath.length - suffix.length)
      : lockPath;
  return readLockedPackages(dir)[package]?.version;
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

/// One `## Verification runs` entry: its `###` heading and its body lines.
class VerificationRun {
  VerificationRun(this.heading, this.body);
  final String heading;
  final List<String> body;
}

/// Every entry under `## Verification runs`, newest first.
///
/// [newestVerificationRun] answers the same question for one entry; SCE168
/// needs all of them, because the rule it enforces is retrospective — the
/// case that produced the rule is six weeks old.
List<VerificationRun> verificationRuns(List<String> lines) {
  final result = <VerificationRun>[];
  final start = lines.indexWhere((l) => l.trim() == '## Verification runs');
  if (start < 0) return result;
  String? heading;
  var body = <String>[];
  for (var i = start + 1; i < lines.length; i++) {
    final line = lines[i];
    if (line.startsWith('## ')) break;
    if (line.startsWith('### ')) {
      if (heading != null) result.add(VerificationRun(heading, body));
      heading = line.trim();
      body = <String>[];
      continue;
    }
    if (heading != null) body.add(line);
  }
  if (heading != null) result.add(VerificationRun(heading, body));
  return result;
}

/// A pass / skip / fail triple read out of one table cell.
class RunTriple {
  const RunTriple(this.pass, this.skip, this.fail);
  final int pass;
  final int skip;
  final int fail;

  @override
  String toString() => '+$pass ~$skip -$fail';
}

final _runnerSummary = RegExp(r'\+(\d+)(?:\s*~(\d+))?(?:\s*-(\d+))?');
final _proseSummary = RegExp(
  r'(\d+)\s*pass\s*/\s*(\d+)\s*skip\s*/\s*(\d+)\s*fail',
);
final _bareTriple = RegExp(r'(\d+)\s*/\s*(\d+)\s*/\s*(\d+)');

/// The triple in [cell], or null when the cell carries none — or carries more
/// than one.
///
/// More than one is rejected rather than guessed at: the 2026-07-28 entry has
/// a row whose cell reads `` `+47`, `+60 ~1`, `+54`, `+61`, `+47` `` for five
/// files at once, and no single before/after comparison describes it.
/// [aggregate] admits the bare `**927 / 1 / 0**` form used by the suite-total
/// rows, which is too loose to apply to a cell that might hold a date.
RunTriple? parseRunTriple(String cell, {bool aggregate = false}) {
  final prose = _proseSummary.allMatches(cell).toList();
  if (prose.length > 1) return null;
  if (prose.length == 1) {
    final m = prose.single;
    return RunTriple(
      int.parse(m.group(1)!),
      int.parse(m.group(2)!),
      int.parse(m.group(3)!),
    );
  }
  final runner = _runnerSummary.allMatches(cell).toList();
  if (runner.length > 1) return null;
  if (runner.length == 1) {
    final m = runner.single;
    return RunTriple(
      int.parse(m.group(1)!),
      int.parse(m.group(2) ?? '0'),
      int.parse(m.group(3) ?? '0'),
    );
  }
  if (!aggregate) return null;
  final bare = _bareTriple.allMatches(cell).toList();
  if (bare.length != 1) return null;
  final m = bare.single;
  return RunTriple(
    int.parse(m.group(1)!),
    int.parse(m.group(2)!),
    int.parse(m.group(3)!),
  );
}

/// The canonical corpus file a row label names, or null when the label covers
/// more than one file (a range, a list, the suite total).
///
/// Two label shapes are in use and both are historical record, so both are
/// read rather than one being rewritten: `` `flutter_extended_23` `` in the
/// dated per-file tables, and `ext 23` in the 2026-07-28 entry.
String? canonicalCorpusFile(String label) {
  final bare = label.replaceAll(RegExp(r'[`*]'), '').trim();
  final full = RegExp(
    r'^(flutter_(?:base|extended)_\d+)(?:_test)?(?:\.dart)?$',
  ).firstMatch(bare);
  if (full != null) return full.group(1);
  final short = RegExp(r'^(base|ext)\s+(\d+)$').firstMatch(bare);
  if (short == null) return null;
  final family = short.group(1) == 'ext' ? 'extended' : 'base';
  return 'flutter_${family}_${short.group(2)}';
}

/// One before/after pair read out of a verification-run table.
class RunComparison {
  RunComparison(this.label, this.file, this.before, this.after);

  /// The row label, verbatim.
  final String label;

  /// The corpus file [label] names, when it names exactly one.
  final String? file;
  final RunTriple before;
  final RunTriple after;

  /// The rule from "Compare all three numbers" (SCD140): a skip that rises
  /// without the pass count rising by at least as much means a test stopped
  /// being measured.
  bool get skipRose =>
      after.skip > before.skip &&
      (after.pass - before.pass) < (after.skip - before.skip);
}

/// Every before/after pair in [body].
///
/// A row qualifies when it has at least three cells and both the second and
/// third parse as a triple. A third cell reading `identical` — the
/// 2026-07-28 shorthand — means the run reproduced the baseline.
List<RunComparison> runComparisons(List<String> body) {
  final result = <RunComparison>[];
  for (final line in body) {
    if (!line.trimLeft().startsWith('|')) continue;
    final cells = line.split('|').map((c) => c.trim()).toList();
    if (cells.length < 4) continue;
    final label = cells[1];
    if (label.isEmpty || label.startsWith('---')) continue;
    final aggregate = label
        .replaceAll(RegExp(r'[`*]'), '')
        .trim()
        .startsWith('pass / skip / fail');
    final before = parseRunTriple(cells[2], aggregate: aggregate);
    if (before == null) continue;
    final after = cells[3].toLowerCase().contains('identical')
        ? before
        : parseRunTriple(cells[3], aggregate: aggregate);
    if (after == null) continue;
    result.add(RunComparison(label, canonicalCorpusFile(label), before, after));
  }
  return result;
}

/// One of the four documents that state the pass / skip / fail reading rule.
///
/// They are written for different readers and must NOT be byte-identical —
/// `mirror_maintenance.md` records why a deliberately duplicated file is noise
/// in every future diff. What must not diverge is whether the rule is stated
/// at all.
class RuleCopy {
  const RuleCopy(this.path, this.audience);

  /// Relative to the `tom_d4rt_flutter_ast` package root.
  final String path;

  /// Who meets the rule here — named in the failure so the fix is obvious.
  final String audience;
}

const ruleCopies = <RuleCopy>[
  RuleCopy(
    'doc/interpreter_issues.md',
    'somebody comparing a run against its baseline',
  ),
  RuleCopy('test/README.md', 'somebody about to run the AST twin\'s corpus'),
  RuleCopy(
    '../tom_d4rt_flutter/test/README.md',
    'somebody about to run the source twin\'s corpus',
  ),
  RuleCopy(
    '../../../_ai/quests/d4rt/overview.d4rt.md',
    'somebody planning a cluster fix, in the verification protocol',
  ),
];

/// One thing every copy of the rule must say, however it words it.
class RuleElement {
  const RuleElement(this.name, this.pattern, this.whatItIs);
  final String name;
  final String pattern;

  /// Why dropping it drops the rule — quoted in the failure.
  final String whatItIs;

  bool presentIn(String normalised) =>
      RegExp(pattern, caseSensitive: false).hasMatch(normalised);
}

/// The rule, decomposed into what it ASSERTS rather than how it is worded.
///
/// Each element survives a copy being rewritten for its own audience and none
/// survives the rule being dropped, which is the distinction the guard exists
/// to make. The four copies differ legitimately — three carry the reading
/// table, the overview carries a protocol paragraph — so the table itself is
/// deliberately NOT an element.
const ruleElements = <RuleElement>[
  RuleElement(
    'the three numbers are named together',
    r'pass\s*[/,]\s*skip\s*[/,]\s*fail',
    'a runner prints three numbers and only `-N` is habitually read as bad; '
        'naming all three is the whole point',
  ),
  RuleElement(
    'the verdict',
    r'rising skip count.{0,80}?is a regression',
    'without it the document describes the numbers without saying what they '
        'mean, which is the state that let a fail→skip sit unexamined for six '
        'weeks',
  ),
  RuleElement(
    'the worked comparison',
    r'\+44 ~1 -1.{0,40}?\+44 ~2|\+44 ~2.{0,40}?\+44 ~1 -1',
    'the evidence the rule rests on — two triples describing the same amount '
        'of working software, only one of which says so',
  ),
  RuleElement(
    'how to record a rise',
    r'\*\*Rising skip:\*\*',
    'the actionable half: a reader who accepts the rule still has to know '
        'what to write, and SCE168 fails a recorded run that omits the field',
  ),
];

/// [text] with every run of whitespace collapsed, so a rule split across a
/// line break reads the same as one on a single line.
String normaliseProse(String text) => text.replaceAll(RegExp(r'\s+'), ' ');

/// The shared-cause detector, verbatim from the sweep command in
/// `## Writing a cluster entry`. SCE174-4 fails if the two copies part.
///
/// Deliberately generous: a false positive costs one line of evidence, a
/// false negative cost five weeks (SCC48).
const String sharedCauseDetector =
    r'share[sd]? one|one cause|attributable|all [0-9]+ |cascade|propagat|leak';

/// Entries dated on or after this must record their shared-cause evidence.
///
/// Why a cutoff here, when SCE168 refused one for the rising-skip rule: that
/// rule's evidence was IN the document (the table rows), so the history could
/// be annotated truthfully. This rule's evidence was not — every earlier
/// entry's per-script counts lived in a gitignored `testlog/` folder that is
/// gone, so a counts line written for one now would be invented rather than
/// measured, which is worse than the gap. The two historical claims SCD143
/// found under-evidenced are annotated in place instead. The date is the day
/// the rule came into force; no entry existed on it.
final DateTime sharedCauseCountsRequiredFrom = DateTime(2026, 9, 25);

/// The date an entry's `### YYYY-MM-DD — ...` heading opens with, or null.
DateTime? entryDate(String heading) {
  final m = RegExp(r'^### (\d{4})-(\d{2})-(\d{2})\b').firstMatch(heading);
  if (m == null) return null;
  return DateTime(
    int.parse(m.group(1)!),
    int.parse(m.group(2)!),
    int.parse(m.group(3)!),
  );
}

/// Whether [statement] — the body of a `**Shared-cause counts:**` field —
/// answers the rule: at least two counts, or an explicit statement that the
/// detector's match is not a shared-cause claim.
///
/// Dates and version numbers are removed before counting, so a field reading
/// "see the 2026-09-25 run at 1.80.0" does not pass as evidence.
bool answersSharedCause(String statement) {
  if (RegExp(
    r'not a shared-cause claim',
    caseSensitive: false,
  ).hasMatch(statement)) {
    return true;
  }
  final stripped = statement
      .replaceAll(RegExp(r'\d{4}-\d{2}-\d{2}'), ' ')
      .replaceAll(RegExp(r'\d+(?:\.\d+)+'), ' ');
  return RegExp(r'\b\d+\b').allMatches(stripped).length >= 2;
}

/// The headings of [runs] dated on or after [from] whose text matches the
/// detector and that do not answer it with a `**Shared-cause counts:**`
/// field.
List<String> sharedCauseViolations(
  List<VerificationRun> runs, {
  required DateTime from,
}) {
  final detector = RegExp(sharedCauseDetector, caseSensitive: false);
  return [
    for (final run in runs)
      if (!(entryDate(run.heading)?.isBefore(from) ?? false) &&
          [run.heading, ...run.body].any(detector.hasMatch))
        if (fieldStatement(run.body, 'Shared-cause counts') case final s
            when s == null || !answersSharedCause(s))
          run.heading,
  ];
}

void main() {
  // SCE191: this guard resolves its subject relative to the package it
  // runs in, so a copy anywhere else measures a different tree in silence.
  requirePackage(
    'tom_d4rt_flutter_ast',
    subject:
        "the cluster log's header table matches its sections, both twins' test/README.md agree on what the corpus certifies, and all four copies of the pass/skip/fail reading rule — including the quest overview, across the _ai mount — still state it",
  );

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

  // ───────────────────────────────────────────────────────────────────────────
  // SCD135 — a cluster is rated by what the defect can REACH, not by how many
  // consumers currently trip over it.
  //
  // GEN-124 sat open for 25 days rated "8 framework errors in one script, that
  // script still passing" while its own blast-radius sentence said, correctly
  // and on day one, that any bridged enum whose name starts with a >=3-char
  // registered bridge name is mistyped wherever `getRuntimeType` is consulted.
  // Nothing about the defect then changed — `_checkArgumentType` simply began
  // consulting `getRuntimeType`, a second reader of an already-wrong value —
  // and the corpus went from all-green to 131 failures across all 41 files.
  //
  // So the count is not the rating. These pin the two fields apart: the rating
  // is prose about reach, the count lives under its own marker, and a cluster
  // whose fix is already written names the todo that owes it. The template they
  // enforce is `## Writing a cluster entry` in the document itself.
  group('SCD135: open clusters are rated by blast radius', () {
    test('ISSUES-4: every open cluster carries a **Blast radius:** statement. '
        '[2026-09-15 00:00] (PASS)', () {
      final clusters = parseOpenClusterBodies(lines);

      // Anti-vacuity first, exactly as ISSUES-1 does for the table: a
      // splitter that returned nothing, or bodies that were empty, would
      // make every assertion in this group pass while reading nothing.
      expect(
        clusters.length,
        greaterThanOrEqualTo(2),
        reason:
            'Fewer than two open clusters parsed out of "## Active '
            'clusters". If the campaign really has closed down to one, say '
            'so deliberately — until then this is a broken splitter, and '
            'ISSUES-5/6 below are reading nothing.',
      );
      final thin = <String>[
        for (final cluster in clusters)
          if (cluster.body.length < 10)
            '${cluster.heading} (${cluster.body.length} lines)',
      ];
      expect(
        thin,
        isEmpty,
        reason:
            'These cluster bodies came back too short to contain an entry, '
            'so the splitter is cutting them off:\n${thin.join('\n')}',
      );

      final missing = <String>[
        for (final cluster in clusters)
          if (fieldStatement(cluster.body, 'Blast radius') == null)
            cluster.heading,
      ];
      expect(
        missing,
        isEmpty,
        reason:
            'These open clusters have no `**Blast radius:**` line. Write '
            'the sentence you would write if the corpus were entirely green '
            '— what the defect can REACH, independent of what currently '
            'trips over it. A failure count measures how many consumers '
            'happen to read a wrong value today; GEN-124 is what happens '
            'when that is mistaken for a severity. See "## Writing a '
            'cluster entry".\n  ${missing.join('\n  ')}',
      );
    });

    test('ISSUES-5: the blast-radius statement is prose, not a count. '
        '[2026-09-15 00:00] (PASS)', () {
      // The failure this guards is `**Blast radius:** 8 framework errors`,
      // which satisfies ISSUES-4 while reintroducing the exact mistake.
      final offenders = <String>[];
      for (final cluster in parseOpenClusterBodies(lines)) {
        final statement = fieldStatement(cluster.body, 'Blast radius');
        if (statement == null) continue; // ISSUES-4 owns that.
        if (RegExp(r'^[^A-Za-z]*\d').hasMatch(statement)) {
          offenders.add(
            '${cluster.heading}\n    opens with a number: '
            '"${statement.substring(0, statement.length.clamp(0, 70))}…"',
          );
        } else if (statement.length < 80) {
          offenders.add(
            '${cluster.heading}\n    too short to be a '
            'statement of reach (${statement.length} chars): '
            '"$statement"',
          );
        }
      }
      expect(
        offenders,
        isEmpty,
        reason:
            'A blast radius is what the defect can reach, in prose. Counts '
            'go under `**Measured:**`, with the run that produced '
            'them:\n  ${offenders.join('\n  ')}',
      );
    });

    test('ISSUES-6: a cluster whose fix is already written names the todo that '
        'owes it. [2026-09-15 00:00] (PASS)', () {
      // The other half of GEN-124's post-mortem: a written-out fix should be
      // applied, because the analysis is the expensive part and it is
      // already paid for. Deferring is sometimes unavoidable — DGUC6 means
      // an interpreter change cannot be certified by the corpus until it is
      // published — but it must never mean forgotten.
      final todoRef = RegExp(r'\b(scd|sce)\d+\b', caseSensitive: false);
      final unowned = <String>[];
      var withFix = 0;
      for (final cluster in parseOpenClusterBodies(lines)) {
        final hasFix = cluster.body.any(
          (l) => l.trimLeft().startsWith('**Fix**'),
        );
        if (!hasFix) continue;
        withFix++;
        if (!cluster.body.any(todoRef.hasMatch)) unowned.add(cluster.heading);
      }

      expect(
        unowned,
        isEmpty,
        reason:
            'These clusters write out a fix and name no todo to apply it. '
            'Add the `scd…` / `sce…` that owns it — a fix nobody is '
            'assigned is the state GEN-124 spent 25 days '
            'in:\n  ${unowned.join('\n  ')}',
      );
      // Coverage: without this the test passes just as happily on a document
      // where no cluster writes out a fix at all, which is a different
      // (worse) situation than every one of them being owned.
      expect(
        withFix,
        greaterThanOrEqualTo(1),
        reason:
            'No open cluster carries a `**Fix**` section, so this test '
            'asserted nothing. That may be legitimate — a cluster still '
            'under investigation has no fix to write down — but say so '
            'here rather than leaving a guard that cannot fail.',
      );
    });
  });

  group('SCE168: a recorded run obeys the rising-skip rule', () {
    // SCD140 wrote "a rising skip count is a regression" into four places and
    // guarded the SHAPE of a skip's justification in the drivers. Nothing
    // checked the rule itself — that a run RECORDED in this document obeys it.
    // The case the rule was written from is in this very section and was
    // tabulated beside genuine recoveries under a heading reading "no
    // regressions in either twin"; it took six weeks and SCC47 to notice.
    //
    // The check is deliberately retrospective. It reads every entry, not the
    // newest, because the failure it catches is a claim that ages into the
    // record — and a dated cutoff would make that history permanently exempt.
    // The repo has learned twice (scd49, F-SCD134-3) that an allow-list entry
    // outliving its cause silently un-guards what it names.

    /// A run whose skip rose must be explained in its OWN entry, under a
    /// field a reader and this test can both find.
    const field = '**Rising skip:**';

    test(
      'SCE168-1: both recorded table shapes parse, including the row the rule '
      'was written from. [2026-09-25 00:00] (PASS)',
      () {
        // Anti-vacuity, and load-bearing rather than ceremonial: SCE168-2
        // reports violations, so a parser that found no rows at all would
        // make it pass while checking nothing. The two shapes are checked
        // separately because they were added years apart and only one of
        // them carries the violation.
        final all = [
          for (final run in verificationRuns(lines))
            ...runComparisons(run.body),
        ];
        expect(
          all.length,
          greaterThanOrEqualTo(8),
          reason:
              'Fewer before/after rows parsed out of "## Verification runs" '
              'than the document is known to carry. Either the tables changed '
              'shape — in which case teach `runComparisons` the new one — or '
              'the parser broke.',
        );

        // Shape A: the dated per-file tables, `| `flutter_extended_02` |
        // `exit=0 +60 ~1` | `exit=0 +61` |`.
        expect(
          all.where((c) => c.file != null && c.label.contains('`')),
          isNotEmpty,
          reason: 'No backticked per-file rows parsed.',
        );

        // Shape B: the 2026-07-28 entry, `| ext 23 | `+44 ~1 -1` |
        // **`+44 ~2`** (fail → skip) |`. This row IS the rule's origin, so
        // it is pinned by value: if it ever stops parsing, the guard has
        // stopped seeing the only violation the document contains and
        // SCE168-2 would go quietly green.
        final origin = all.firstWhere(
          (c) => c.file == 'flutter_extended_23' && c.before.fail == 1,
          orElse: () => throw StateError(
            'The 2026-07-28 `ext 23` row no longer parses. It is the case '
            'SCD140 was written from and the only violation in the document; '
            'without it SCE168-2 asserts nothing.',
          ),
        );
        expect(origin.before.toString(), '+44 ~1 -1');
        expect(origin.after.toString(), '+44 ~2 -0');
        expect(origin.skipRose, isTrue);
      },
    );

    test(
      'SCE168-2: every recorded run whose skip rose says so in its own entry. '
      '[2026-09-25 00:00] (PASS)',
      () {
        final unexplained = <String>[];
        var rising = 0;
        for (final run in verificationRuns(lines)) {
          final statement = fieldStatement(run.body, 'Rising skip');
          for (final row in runComparisons(run.body)) {
            if (!row.skipRose) continue;
            rising++;
            // What counts as an explanation: the entry carries the field, and
            // — when the row names one file — the field names that file. A
            // file listed in a scope sentence is not an explanation of its
            // own skip rise, which is why the mention has to be inside the
            // field rather than anywhere in the entry.
            final named =
                statement != null &&
                (row.file == null ||
                    statement.contains(row.file!) ||
                    statement.contains(
                      row.label.replaceAll(RegExp(r'[`*]'), '').trim(),
                    ));
            if (named) continue;
            unexplained.add(
              '${run.heading}\n      row `${row.label}`: '
              '${row.before} -> ${row.after}',
            );
          }
        }

        expect(
          unexplained,
          isEmpty,
          reason:
              'These recorded runs have a skip count that rose without the '
              'pass count rising by at least as much — a test stopped being '
              'measured. Add a `$field` paragraph to the entry naming the '
              'file and saying what became unmeasured and why. See "Compare '
              'all three numbers" in this document:\n  '
              '${unexplained.join('\n  ')}',
        );
        // Coverage: the document is expected to contain exactly the one
        // historical case. Zero would mean the parser stopped finding it.
        expect(
          rising,
          greaterThanOrEqualTo(1),
          reason:
              'No rising-skip row found anywhere in "## Verification runs". '
              'That is not the state of this document — the 2026-07-28 entry '
              'carries one — so the parser has stopped reading the tables.',
        );
      },
    );
  });

  group('SCE169: all four copies of the reading rule still state it', () {
    // The pass / skip / fail reading rule lives in four hand-maintained
    // copies, and until now nothing checked that they agree. That is the
    // duplication this repo keeps being bitten by — but consolidating to one
    // statement plus three pointers is the wrong fix here, and deliberately
    // not what this does. Each copy is where a DIFFERENT reader meets the
    // rule: one planning a cluster fix, two about to run a corpus, one
    // comparing a run against its baseline. A runner README that says "see
    // the quest overview" is a README somebody stops reading.
    //
    // So: keep the four, guard the four. SCD65-3 one group up is the
    // precedent — it asserts both twins' READMEs carry the DGUC6 rule by
    // checking for a heading — and this is the same mechanism over four files
    // and four assertions instead of one file-pair and one.
    //
    // NOT a byte-identity check, and the distinction is load-bearing.
    // `mirror_maintenance.md` records why a deliberately duplicated file is
    // noise in every future diff, and the copies legitimately differ: three
    // carry the reading table, the overview carries a protocol paragraph.
    // What is checked is what the rule ASSERTS, decomposed into four elements
    // that each survive a rewrite and none survive a deletion.

    test('SCE169-1: all four copies were found and read. [2026-09-25 00:00] '
        '(PASS)', () {
      // Anti-vacuity. SCE169-2 asks whether patterns are PRESENT, so a
      // missing file fails loudly there too — but it fails naming the rule
      // rather than the mount, and the overview lives across the `_ai`
      // symlink where "absent" means a broken checkout rather than a
      // missing rule. Separating them makes the failure say which.
      for (final copy in ruleCopies) {
        final file = File(copy.path);
        expect(
          file.existsSync(),
          isTrue,
          reason:
              '${copy.path} not found. Run this from the '
              'tom_d4rt_flutter_ast package root. The `_ai` layer is '
              'symlinked into every workspace on every fleet machine, so '
              'its absence is a broken checkout rather than a supported '
              'configuration — fix the mount rather than dropping the '
              'copy from this list.',
        );
        expect(
          file.readAsLinesSync().length,
          greaterThan(50),
          reason: '${copy.path} is too short to be the document intended.',
        );
      }
    });

    test('SCE169-2: every copy states every element of the rule. '
        '[2026-09-25 00:00] (PASS)', () {
      final missing = <String>[];
      for (final copy in ruleCopies) {
        final text = normaliseProse(File(copy.path).readAsStringSync());
        for (final element in ruleElements) {
          if (element.presentIn(text)) continue;
          missing.add(
            '${copy.path}\n      missing: ${element.name}\n'
            '      which is: ${element.whatItIs}\n'
            '      read by:  ${copy.audience}',
          );
        }
      }
      expect(
        missing,
        isEmpty,
        reason:
            'A copy of the pass / skip / fail reading rule has stopped '
            'stating part of it. Reword freely — these four are written '
            'for different readers and must not be forced identical — but '
            'each has to keep saying what the rule asserts:\n  '
            '${missing.join('\n  ')}',
      );
    });
  });

  group('SCE174: a shared-cause claim records its counts in the entry', () {
    // An entry claiming that failures share a cause used to cite a run folder
    // under `testlog/` — gitignored, per-machine, and gone. The document
    // asserted "an inventory showed all 131 shared one signature" on exactly
    // that basis. The claim happened to be true; nobody could have known it
    // from the citation. SCD65 solved the same shape for interpreter pairs by
    // making the entry the durable record, and this is that rule for the
    // accumulation discriminator's input: the per-script counts.

    test('SCE174-1: every entry heading carries a parseable date, so none can '
        'fall outside the cutoff by accident. [2026-09-25 00:00] (PASS)', () {
      final runs = verificationRuns(lines);
      expect(runs.length, greaterThanOrEqualTo(8));
      final undated = [
        for (final run in runs)
          if (entryDate(run.heading) == null) run.heading,
      ];
      expect(
        undated,
        isEmpty,
        reason:
            'These entries do not open with `### YYYY-MM-DD`. An entry '
            'without a date is exempt from nothing: SCE174-2 treats it as '
            'current. Give it its date:\n  ${undated.join('\n  ')}',
      );
    });

    test(
      'SCE174-2: every current entry that makes a shared-cause claim records '
      'the counts. [2026-09-25 00:00] (PASS)',
      () {
        final missing = sharedCauseViolations(
          verificationRuns(lines),
          from: sharedCauseCountsRequiredFrom,
        );
        expect(
          missing,
          isEmpty,
          reason:
              'These entries match the shared-cause detector but carry no '
              '`**Shared-cause counts:**` paragraph with the per-script '
              'numbers. `testlog/` is gitignored, so the entry is the only '
              'place the evidence survives. Take the counts with\n'
              '  dart run tool/framework_error_inventory.dart testlog/<run> '
              '--order run\n'
              'and write them in run order. If the match is not a claim, say '
              '"not a shared-cause claim" and why:\n  ${missing.join('\n  ')}',
        );
      },
    );

    test('SCE174-3: the rule catches a claim, and accepts both honest answers. '
        '[2026-09-25 00:00] (PASS)', () {
      // Anti-vacuity. When this landed no entry was dated on or after the
      // cutoff, so SCE174-2 checked nothing on real entries; these fixtures
      // are what prove it can fail.
      VerificationRun entry(String date, List<String> body) =>
          VerificationRun('### $date — fixture', body);
      final from = sharedCauseCountsRequiredFrom;
      final claim = 'All 12 failures share one cause: a leaked error.';

      expect(
        sharedCauseViolations([
          entry('2026-09-30', [claim]),
        ], from: from),
        hasLength(1),
        reason: 'a claim with no counts must fail',
      );
      expect(
        sharedCauseViolations([
          entry('2026-09-30', [
            claim,
            '',
            '**Shared-cause counts:** 11, 78, 23, 8 — non-monotonic.',
          ]),
        ], from: from),
        isEmpty,
        reason: 'the counts answer it',
      );
      expect(
        sharedCauseViolations([
          entry('2026-09-30', [
            'All 17 files ran.',
            '',
            '**Shared-cause counts:** not a shared-cause claim — a scope '
                'statement.',
          ]),
        ], from: from),
        isEmpty,
        reason: 'an explicit not-a-claim answers it',
      );
      expect(
        sharedCauseViolations([
          entry('2026-09-30', [
            claim,
            '',
            '**Shared-cause counts:** see the 2026-09-30 run at 1.80.0.',
          ]),
        ], from: from),
        hasLength(1),
        reason: 'a date and a version are not counts',
      );
      expect(
        sharedCauseViolations([
          entry('2026-09-18', [claim]),
        ], from: from),
        isEmpty,
        reason: 'entries before the cutoff are exempt',
      );

      // And the detector does see the real history: the SCC48 entry and
      // the 131-failure entry are exactly what it exists to catch.
      final detector = RegExp(sharedCauseDetector, caseSensitive: false);
      final flagged = [
        for (final run in verificationRuns(lines))
          if (run.body.any(detector.hasMatch)) entryDate(run.heading),
      ];
      expect(flagged, contains(DateTime(2026, 7, 28)));
      expect(flagged, contains(DateTime(2026, 9, 6)));
    });

    test('SCE174-4: the guard\'s detector is the sweep the template tells a '
        'writer to run. [2026-09-25 00:00] (PASS)', () {
      final sweep = lines.firstWhere(
        (l) => l.contains('grep -inE'),
        orElse: () => '',
      );
      expect(
        sweep,
        contains("'$sharedCauseDetector'"),
        reason:
            'The shared-cause sweep in "## Writing a cluster entry" and '
            '`sharedCauseDetector` in this file have parted. A writer runs '
            'one and the guard enforces the other; change both together.',
      );
    });
  });
}
