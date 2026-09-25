// RUNNER BUCKET: guard — run_guard_tests.sh
// REPO-WIDE GUARD (tom_d4rt_flutter_ast) — every test file in BOTH twins is reachable from some runner.
//
// Its subject reaches OUTSIDE this package (the sibling twin's test/ and its
// runners), so it runs only when tom_d4rt_flutter_ast's suite runs. SCD129 made
// that arrangement visible rather than incidental: `grep -rn 'REPO-WIDE GUARD'
// */test` lists every one, and
// `tom_d4rt/test/scd129_repo_wide_guard_index_test.dart` fails if a new one
// arrives without this banner.
//
// SCD142 — a test nobody runs is a comment, and this repo keeps writing them.
//
// The runners glob prefixes: `run_base_tests.sh` takes
// `test/flutter_base_*_test.dart`, `run_issue_analysis_tests.sh` adds
// `test/flutter_extended_*_test.dart`. Anything named outside both is invoked
// only by a human who already knows it exists. That has bitten three times:
//
//   * `sync_shared_user_bridges_test.dart` — the only check on the twins'
//     user-bridge de-dup — was unreachable for as long as it existed (SCD108).
//   * SCC48 deliberately named `framework_error_isolation_test.dart` outside the
//     globs, so that adding it could not shift the metrics tables. Correct for
//     the baselines; it was then executed by nothing (SCD142, this file).
//   * SCD133 found three more in the sibling twin at once, which is what made
//     the pattern visible rather than anecdotal.
//
// So the fix is not another runner — it is this: every `*_test.dart` must be
// reachable from a runner, or carry a recorded reason why not.
//
// HOW REACHABILITY IS DECIDED. A file is reachable when a corpus glob matches
// its name, or when some `run_*.sh` in the same twin names it, or when it
// matches the harness runner's `*_isolation_test.dart` convention. Read from the
// scripts rather than restated here: a guard that keeps its own copy of the
// runner's file list passes when the two disagree, which is the failure it
// exists to prevent.
//
// THE EXEMPTIONS ARE PINNED INDIVIDUALLY and F-SCD142-3 fails when one stops
// being needed, so a file that later gains a runner cannot leave a permanent
// permission behind (the scd49 / F-SCD134-3 lesson).
//
// EACH TEST HERE HAS BEEN SEEN TO FAIL:
//
//   | Injected fault                                              | Fires |
//   | ----------------------------------------------------------- | ----- |
//   | a new unreferenced `zz_orphan_test.dart` created             | 2     |
//   | an exemption added for a file that IS reachable              | 3     |
//   | the twin roots pointed at a directory with no test files      | 1 + 3 |
//
// The last row fires twice, and the reason is worth knowing before reading a
// double-red as two problems: with no twin found, the exempt files are present
// in no twin either, so F-SCD142-3's "no twin has it any more" branch fires for
// the same single cause. F-SCD142-1 is the one to believe, and it is ordered
// first for exactly that reason.
@TestOn('vm')
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Both twins, relative to this package root.
const _twins = <String>['.', '../tom_d4rt_flutter'];

/// The corpus runners' globs, as prefixes.
final RegExp _corpusName = RegExp(r'^flutter_(base|extended)_\d+_test\.dart$');

/// The harness runner's convention.
final RegExp _harnessName = RegExp(r'_isolation_test\.dart$');

/// Files deliberately reachable from nothing, and why.
///
/// Keyed by bare filename because both twins carry the same two.
const _exempt = <String, String>{
  'interpreter_generator_open_issues_test.dart':
      'EXPECTED TO FAIL. It drives a reproduction script per open A.x/B.x/C.x '
      'entry in doc/interpreter_generator_open_issues.md, so red is its correct '
      'output and a runner that included it would always report failure. It is '
      'read by a human comparing its results against that document; sce159 owns '
      'making that comparison a check.',
  'suspicious_rewrite_test.dart':
      'A CORPUS AUDIT, not a test of behaviour: it re-runs the 116 scripts '
      'flagged in doc/suspicious_tests.md to ask whether each still fails to '
      'exercise the class its filename advertises. It needs the companion app '
      'and takes ~16 minutes, so it belongs beside the corpus sweep rather than '
      'in any of the three runners; it is invoked directly, as the quest '
      'overview records.',
};

/// The bucket a file's own header declares, or null when it declares none.
///
/// SCE152. SCD142 below proves a file is REACHED by something; it does not
/// tell the reader OPENING that file what reaches it, and that is the half a
/// person actually needs. The classification used to live in a todo, which is
/// a snapshot — so it is a line in the file instead, and F-SCE152-1 holds the
/// line to what the runners actually say. A comment nothing checks is how the
/// last inventory decayed.
String? declaredBucket(String twin, String file) {
  final head = File(
    '$twin/test/$file',
  ).readAsLinesSync().take(_bucketWindow).join('\n');
  return RegExp(
    r'^// RUNNER BUCKET: (\S+)',
    multiLine: true,
  ).firstMatch(head)?.group(1);
}

/// How many lines of a file the bucket line must appear in.
///
/// Four rather than one: a file may open with a `REPO-WIDE GUARD` banner
/// (SCD129) or a shebang-ish first line, and requiring an exact position would
/// make two conventions fight over line 1.
const int _bucketWindow = 4;

/// What the runners say a file's bucket IS, as the header should spell it.
String measuredBucket(String twin, String file, Set<String> named) {
  if (_corpusName.hasMatch(file)) return 'corpus';
  if (named.contains(file)) return 'guard';
  if (_harnessName.hasMatch(file)) return 'harness';
  return 'exempt';
}

/// Every `*_test.dart` directly under a twin's `test/`.
List<String> testFilesIn(String twin) {
  final dir = Directory('$twin/test');
  if (!dir.existsSync()) return const [];
  return [
    for (final e in dir.listSync())
      if (e is File && e.path.endsWith('_test.dart')) e.uri.pathSegments.last,
  ]..sort();
}

/// Filenames named by any `run_*.sh` in a twin's `test/`.
Set<String> namedByRunners(String twin) {
  final dir = Directory('$twin/test');
  if (!dir.existsSync()) return const {};
  final named = <String>{};
  for (final e in dir.listSync()) {
    if (e is! File) continue;
    final name = e.uri.pathSegments.last;
    if (!name.startsWith('run_') || !name.endsWith('.sh')) continue;
    named.addAll(
      RegExp(
        r'test/([\w.]+_test\.dart)',
      ).allMatches(e.readAsStringSync()).map((m) => m.group(1)!),
    );
  }
  return named;
}

bool isReachable(String twin, String file, Set<String> named) =>
    _corpusName.hasMatch(file) ||
    _harnessName.hasMatch(file) ||
    named.contains(file);

/// One check in the AST twin's `run_guard_tests.sh`.
class GuardInvocation {
  GuardInvocation(this.kind, this.label, this.testFile);

  /// `run` (subject is this package) or `pair` (subject includes the source
  /// twin, so the source twin's runner reaches it through `--pair`).
  final String kind;
  final String label;

  /// The test file the check runs, relative to this package root, or null
  /// when the command runs no test file (the tool's `--check`).
  final String? testFile;
}

/// Every `run` / `pair` invocation in the AST twin's guard runner.
///
/// A `sh -c 'cd <dir> && ...'` command resolves its test file against `<dir>`,
/// which is how the runner reaches `tom_d4rt`'s SCD110.
List<GuardInvocation> guardInvocations() {
  final text = File('test/run_guard_tests.sh').readAsStringSync();
  final call = RegExp(r'^(run|pair) "([^"]*)" \\\n\s+(.*)$', multiLine: true);
  return [
    for (final m in call.allMatches(text))
      GuardInvocation(m.group(1)!, m.group(2)!, _testFileOf(m.group(3)!)),
  ];
}

String? _testFileOf(String command) {
  final test = RegExp(r'(test/[\w.]+_test\.dart)').firstMatch(command);
  if (test == null) return null;
  final cd = RegExp(r"cd (\S+) &&").firstMatch(command);
  return cd == null ? test.group(1) : '${cd.group(1)}/${test.group(1)}';
}

/// Whether the check at [path] has a subject that includes the source twin.
///
/// Two signals, either sufficient:
///
/// - A PATH into the source twin, in code rather than a comment. A bare
///   mention of `tom_d4rt_flutter` is not enough: scd133 quotes the source
///   twin's measured counts in a comment while its subject is this package
///   alone, and would be forced to a `pair` tag it should not carry.
/// - The REPO-WIDE GUARD banner saying so: "both twins", "the two twins",
///   "sibling twin", "twins'". This catches a check that names the twins by
///   package rather than by path (sce14). Measured 2026-09-25: none of the
///   nine `run` checks' banners uses these phrases.
///
/// The user-bridge sync test builds its path at run time and has no banner,
/// so neither signal sees it; it is tagged `pair` by hand. Missing one is the
/// safe direction for a ratchet.
bool coversSourceTwin(String path) {
  final file = File(path);
  if (!file.existsSync()) return false;
  final lines = file.readAsLinesSync();
  final signal = RegExp(r'\.\./tom_d4rt_flutter(?![_a-z])');
  if (lines.where((l) => !l.trimLeft().startsWith('//')).any(signal.hasMatch)) {
    return true;
  }
  final start = lines.indexWhere((l) => l.contains('REPO-WIDE GUARD'));
  if (start < 0) return false;
  final banner = lines.skip(start).take(12).join(' ');
  return RegExp(
    r"\b([Bb]oth|[Tt]he two|BOTH) twins\b|sibling twin|twins' ",
  ).hasMatch(banner);
}

void main() {
  group('SCD142: every test file is reachable from a runner', () {
    test('F-SCD142-1: both twins were scanned [2026-09-15]', () {
      // Anti-vacuity: F-SCD142-2 iterates the file list, so an empty list
      // satisfies it while checking nothing.
      for (final twin in _twins) {
        expect(
          testFilesIn(twin).length,
          greaterThanOrEqualTo(40),
          reason:
              'only ${testFilesIn(twin).length} test files found under '
              '$twin/test. Both twins carried 47+ on 2026-09-15 (41 corpus '
              'drivers plus the rest); finding almost none means the layout '
              'moved and this file is guarding nothing.',
        );
      }
    });

    test('F-SCD142-2: no test file is invoked by nothing [2026-09-15]', () {
      final orphans = <String>[];
      for (final twin in _twins) {
        final named = namedByRunners(twin);
        for (final file in testFilesIn(twin)) {
          if (_exempt.containsKey(file)) continue;
          if (!isReachable(twin, file, named)) orphans.add('$twin/test/$file');
        }
      }
      expect(
        orphans,
        isEmpty,
        reason:
            'These test files are executed by no runner, so nothing runs them '
            'unless somebody already knows they exist — which is how SCC48\'s '
            'isolation test sat idle for six weeks. Add each to the runner '
            'whose cost it matches (`run_guard_tests.sh` for a fast '
            'transport-free check, `run_harness_tests.sh` if it drives the '
            'companion app, a corpus runner if it is a corpus file), or record '
            'an exemption with its reason:\n  ${orphans.join('\n  ')}',
      );
    });

    test('F-SCE152-1: every non-corpus test declares the bucket that actually '
        'reaches it [2026-09-22]', () {
      // THE CLASSIFICATION, MOVED OUT OF A TODO AND INTO THE FILES. SCE152
      // audited both twins and found 26 non-corpus test files and ZERO
      // orphans — F-SCD142-2 above had already made bucket four impossible.
      // What was missing was that a reader opening one of them could not tell
      // which sweep runs it, which is the question the audit was actually
      // asked to answer.
      //
      // The line is checked against the runners rather than trusted, so it
      // cannot drift: move a file from `run_guard_tests.sh` to a corpus glob
      // and its header is wrong the same minute.
      //
      // `exempt` is what an unreached file declares; F-SCD142-3 above is what
      // stops that being a free pass, by failing when a runner starts reaching
      // it and the exemption stays.
      final wrong = <String>[];
      for (final twin in _twins) {
        final named = namedByRunners(twin);
        for (final file in testFilesIn(twin)) {
          if (_corpusName.hasMatch(file)) continue; // its name is the bucket
          final measured = measuredBucket(twin, file, named);
          final declared = declaredBucket(twin, file);
          if (declared == null) {
            wrong.add(
              '$twin/test/$file: no `// RUNNER BUCKET:` line in its first '
              '$_bucketWindow lines (it is `$measured`)',
            );
          } else if (declared != measured) {
            wrong.add(
              '$twin/test/$file: declares `$declared`, the runners say '
              '`$measured`',
            );
          }
        }
      }
      expect(
        wrong,
        isEmpty,
        reason:
            'A non-corpus test file says which sweep runs it, on one of its '
            'first $_bucketWindow lines:\n\n'
            '    // RUNNER BUCKET: guard — run_guard_tests.sh\n'
            '    // RUNNER BUCKET: harness — run_harness_tests.sh, by the '
            '*_isolation_test.dart glob\n'
            '    // RUNNER BUCKET: exempt — <why nothing runs it>\n\n'
            'A corpus driver needs none: `flutter_base_07_test.dart` says it '
            'in its name. Fix the line, or fix the runner — the mismatch says '
            'which:\n  ${wrong.join('\n  ')}',
      );
    });

    test('F-SCD142-3: no exemption outlives its reason [2026-09-15]', () {
      // An exemption left behind after the file gains a runner silently
      // un-guards it: F-SCD142-2 skips the entry, so a later rename or
      // removal from the runner would go unnoticed.
      final stale = <String>[];
      for (final file in _exempt.keys) {
        for (final twin in _twins) {
          if (!testFilesIn(twin).contains(file)) continue;
          if (isReachable(twin, file, namedByRunners(twin))) {
            stale.add('$twin/test/$file — exempt, but a runner now reaches it');
          }
        }
      }
      final absent = _exempt.keys
          .where((f) => !_twins.any((t) => testFilesIn(t).contains(f)))
          .map((f) => '$f — exempt, but no twin has it any more')
          .toList();
      expect(
        [...stale, ...absent],
        isEmpty,
        reason:
            'Delete these exemptions; each names a situation that no longer '
            'holds:\n  ${[...stale, ...absent].join('\n  ')}',
      );
    });
  });

  group('SCE171: the source twin\'s runner reaches the pair guards', () {
    test('F-SCE171-1: the AST runner\'s checks were parsed, both kinds '
        '[2026-09-25]', () {
      // Anti-vacuity: a parser that found nothing would pass F-SCE171-2
      // while checking nothing, and one that found only `run` would mean the
      // tagging had been lost.
      final all = guardInvocations();
      expect(
        all.where((g) => g.kind == 'pair').length,
        greaterThanOrEqualTo(12),
      );
      expect(all.where((g) => g.kind == 'run').length, greaterThanOrEqualTo(5));
    });

    test('F-SCE171-2: a check whose test file reaches the source twin is '
        'tagged `pair` [2026-09-25]', () {
      final hidden = [
        for (final g in guardInvocations())
          if (g.kind == 'run' &&
              g.testFile != null &&
              coversSourceTwin(g.testFile!))
            '"${g.label}" (${g.testFile})',
      ];
      expect(
        hidden,
        isEmpty,
        reason:
            'These checks cover the source twin (tom_d4rt_flutter) but are '
            'invoked with `run`, so its own guard runner never reaches them. '
            'Invoke them with `pair` in test/run_guard_tests.sh:\n  '
            '${hidden.join('\n  ')}',
      );
    });

    test('F-SCE171-3: the source twin\'s runner calls `--pair` and counts its '
        'result [2026-09-25]', () {
      final lines = File(
        '../tom_d4rt_flutter/test/run_guard_tests.sh',
      ).readAsLinesSync().where((l) => !l.trimLeft().startsWith('#'));
      final call = RegExp(
        r'^if ! \.\./tom_d4rt_flutter_ast/test/run_guard_tests\.sh --pair; then$',
      );
      expect(
        lines.map((l) => l.trim()).any(call.hasMatch),
        isTrue,
        reason:
            'tom_d4rt_flutter/test/run_guard_tests.sh no longer calls '
            '`../tom_d4rt_flutter_ast/test/run_guard_tests.sh --pair` inside an '
            '`if !` that sets its status. Without it, running the guards from '
            'the source twin covers only its four own checks, silently.',
      );
    });
  });
}
