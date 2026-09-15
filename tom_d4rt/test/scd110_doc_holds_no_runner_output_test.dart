// REPO-WIDE GUARD (tom_d4rt) — no package's doc/ holds runner output, and no runner script writes there.
//
// Its subject reaches OUTSIDE this package, so it runs only when tom_d4rt's suite
// runs and a session working elsewhere in the repo reaches none of it. SCD129
// made that arrangement visible rather than incidental: `grep -rn 'REPO-WIDE
// GUARD' */test` lists every one, and
// `tom_d4rt/test/scd129_repo_wide_guard_index_test.dart` fails if a new one
// arrives without this banner.
// SCD110: `doc/` is hand-authored. Runner output goes in `testlog/`. That rule
// has been stated in CLAUDE.md, in both Flutter twins' `test/README.md`, and in
// a comment at the top of `.gitignore` — and was broken, undetected, four
// separate times.
//
// THE HISTORY IS THE ARGUMENT FOR CHECKING THE SHAPE RATHER THAN THE NAME. Each
// breach was "fixed" by adding an ignore stanza for the folder name that had
// just been found:
//
//   2026-06-24  `1a4250154` moves the two `.sh` sweep runners to `testlog/` —
//               and misses the two `.ps1` twins and both `run_base_tests`
//               scripts, so the same command wrote a gitignored folder on
//               macOS/Linux and a TRACKED one on Windows.
//   2026-09-05  `**/doc/basetestlog_*/` added, because the base runner had been
//               writing there since 2026-06-05.
//   2026-09-14  `**/doc/testlog_*/` and `**/doc/extlog_*/` added, after 104
//               machine files across four folders were found already committed.
//
// Three stanzas, each added only after the next unforeseen folder name had
// already shipped. A rule that must be told each name in advance cannot catch
// the first occurrence of anything, which is the only occurrence that matters.
// All three are gone; this file replaces them.
//
// SO THE DETECTOR MATCHES SHAPE. [_runnerOutputReason] looks at what a path IS
// — a `*log_*` run folder, a `--file-reporter` JSON, a captured stdout log, a
// testkit baseline — not at a folder name someone remembered to enumerate. A
// fourth name is caught on its first appearance.
//
// F-SCD110-3 IS THE NEGATIVE CONTROL AND IS NOT OPTIONAL. A detector of this
// shape is trivially defanged — one over-eager exclusion and it passes forever
// while measuring nothing. It is therefore run against the commit immediately
// before the cleanup, where the answer is known to be exactly 104 files, and
// required to reproduce that. Break the detector and that case goes red even
// though the tree is clean. (Same reasoning as F-SCC17-4 in
// `release_hygiene_test.dart`, which this file is modelled on.)
//
// F-SCD110-4 CHECKS THE DISK, NOT THE INDEX, AND THAT IS DELIBERATE. The other
// cases are about what is committed; this one is about what this machine has
// lying around. It is the case that will be red on a fleet host that has not
// been swept yet — and that is the point. The old stanzas kept exactly that
// state quiet on four machines for three months. A red test with the move
// command in its message is how a host finds out it is the one still holding
// the residue.

import 'dart:io';

import 'package:test/test.dart';

import 'sibling_trees.dart';

/// Paths whose SHAPE says "a program wrote this", relative to the repo root.
///
/// Returns null when [path] is fine, or a one-line reason when it is runner
/// output sitting in a documentation folder.
///
/// Only `<package>/doc/...` counts. `tom_d4rt/test/doc/` is a test directory
/// that happens to be called `doc` and is not a documentation folder, so the
/// segment index is part of the rule rather than a substring match.
String? _runnerOutputReason(String path) {
  final parts = path.split('/');
  if (parts.length < 3 || parts[1] != 'doc') return null;

  // A whole run folder: `basetestlog_<ID>/`, `testlog_<ID>/`, `extlog_<ID>/`,
  // and whatever the next one gets called.
  for (final segment in parts.sublist(2, parts.length - 1)) {
    if (RegExp(r'^[a-z]*log_').hasMatch(segment)) {
      return 'inside run folder `$segment/`';
    }
  }

  final name = parts.last;
  // The four artefact shapes this repo's runners and testkit actually produce.
  if (name == 'metrics.txt') return 'runner summary (`metrics.txt`)';
  if (name.endsWith('.result.json')) return '`--file-reporter json` output';
  if (name.endsWith('.log.txt')) return 'captured stdout';
  if (name.endsWith('.console.log')) return 'captured console output';
  if (name == 'last_testrun.json') return 'testkit raw run';
  if (RegExp(r'^baseline_\d{4}_\d{4}\.csv$').hasMatch(name)) {
    return 'testkit baseline';
  }
  return null;
}

/// The commit immediately before the cleanup, i.e. the last tree in which the
/// defect is known to have existed. Pinned by hash on purpose: a relative ref
/// (`HEAD~n`, `<fix>^`) silently re-points as history grows, and a negative
/// control that quietly starts measuring a different tree is worse than none.
const String _preCleanupCommit = 'd54c2e03aef14822b8dd22994d88b1b9bffeacb9';

/// What [_preCleanupCommit] is known to contain. Measured, not estimated.
const int _preCleanupOffenderCount = 104;

String? _repoRoot;

bool _gitAvailable() {
  try {
    final result = Process.runSync('git', ['rev-parse', '--show-toplevel']);
    if (result.exitCode != 0) return false;
    _repoRoot = (result.stdout as String).trim();
    return true;
  } catch (_) {
    return false;
  }
}

List<String> _gitLines(List<String> args) {
  final result = Process.runSync('git', args, workingDirectory: _repoRoot);
  if (result.exitCode != 0) {
    throw StateError('git ${args.join(' ')} failed: ${result.stderr}');
  }
  return (result.stdout as String)
      .split('\n')
      .map((l) => l.trim())
      .where((l) => l.isNotEmpty)
      .toList();
}

/// Every offender in a list of repo-relative paths, as `path — reason`.
List<String> _offenders(Iterable<String> paths) {
  final found = <String>[];
  for (final path in paths) {
    final reason = _runnerOutputReason(path);
    if (reason != null) found.add('$path — $reason');
  }
  found.sort();
  return found;
}

/// The move that repairs a finding, quoted in every failure message so the fix
/// never has to be reconstructed from the rule.
const String _repairCommand = '''
    for d in */doc/*log_*/; do
      d=\${d%/}; pkg=\${d%%/doc/*}
      mkdir -p "\$pkg/testlog" && mv "\$d" "\$pkg/testlog/\$(basename "\$d")"
    done

MOVE it, do not delete it — the results are still valid locally, and
`testlog/` is exactly where a run would write them today.''';

void main() {
  // SCD158: the walk starts at this package and climbs to the repo root, so a
  // copy in another package either finds nothing or re-asks the same question
  // of the same repository. SCD200 anchored it for the second reason — a
  // tom_d4rt_exec port passes, and passing twice about one repository is
  // duplication rather than coverage.
  requirePackage(
    'tom_d4rt',
    subject: "every package in this repository's doc/ and runner scripts",
  );

  if (!_gitAvailable()) {
    // Not a git checkout: skip rather than fail. The same posture as the other
    // history-reading suites in this package.
    test('SCD110: skipped — not a git repository', () {}, skip: true);
    return;
  }

  group('SCD110: `doc/` is hand-authored; runner output lives in `testlog/`', () {
    test('F-SCD110-1: no TRACKED file under any `<pkg>/doc/` is runner output '
        '[2026-09-14]', () {
      final offenders = _offenders(_gitLines(['ls-files']));
      expect(
        offenders,
        isEmpty,
        reason:
            'Machine-generated files are committed under a documentation '
            'folder. A committed run is a photograph of one machine\'s build '
            'that nothing updates, so a later reader cannot tell it from a '
            'current one.\n\n'
            '${offenders.join('\n')}\n\n'
            'Untrack them (`git rm -r --cached`, which keeps them on disk) '
            'and move them:\n$_repairCommand',
      );
    });

    test(
      'F-SCD110-2: no tracked runner script writes into `doc/` [2026-09-14]',
      () {
        // The scripts are the SOURCE of the defect F-SCD110-1 detects. Catching
        // the output without catching the writer means the folder comes back on
        // the next run.
        final scripts = _gitLines([
          'ls-files',
        ]).where((p) => p.endsWith('.sh') || p.endsWith('.ps1')).toList();
        expect(
          scripts,
          isNotEmpty,
          reason: 'no runner scripts found — the scan is measuring nothing',
        );

        final pattern = RegExp(r'doc/[A-Za-z0-9_${}]*log');
        final writers = <String>[];
        for (final script in scripts) {
          final file = File('$_repoRoot/$script');
          if (!file.existsSync()) continue;
          final lines = file.readAsLinesSync();
          for (var i = 0; i < lines.length; i++) {
            if (pattern.hasMatch(lines[i])) {
              writers.add('$script:${i + 1}: ${lines[i].trim()}');
            }
          }
        }
        expect(
          writers,
          isEmpty,
          reason:
              'A runner still targets `doc/`. Point it at `testlog/<name>_'
              '<ID>/` instead — that is where every other runner in this repo '
              'writes.\n\n${writers.join('\n')}',
        );
      },
    );

    test('F-SCD110-3: the detector still reports all 104 offenders in the '
        'pre-cleanup tree [2026-09-14]', () {
      final probe = Process.runSync('git', [
        'cat-file',
        '-e',
        '$_preCleanupCommit^{commit}',
      ], workingDirectory: _repoRoot);
      if (probe.exitCode != 0) {
        // A shallow clone genuinely cannot answer this. Say so instead of
        // passing, so "green" never means "did not look".
        fail(
          'the pinned control commit $_preCleanupCommit is not in this '
          'clone, so the detector is unverified here. Fetch full history '
          '(`git fetch --unshallow`) or update the pin.',
        );
      }

      final offenders = _offenders(
        _gitLines(['ls-tree', '-r', '--name-only', _preCleanupCommit]),
      );
      expect(
        offenders,
        hasLength(_preCleanupOffenderCount),
        reason:
            'The detector no longer reproduces the known answer for '
            '$_preCleanupCommit, so it can no longer be trusted on the '
            'current tree either. Found ${offenders.length}.',
      );
      // Shape, not just count: all four historical folders must be named.
      for (final folder in const [
        'tom_d4rt_flutter/doc/extlog_20260728-scb16',
        'tom_d4rt_flutter_ast/doc/extlog_20260728-scb16',
        'tom_d4rt_flutter_ast/doc/testlog_20260624-0713-issue-analysis',
        'tom_d4rt_flutter_test/doc/testlog_20260624-0713-issue-analysis',
      ]) {
        expect(
          offenders.any((o) => o.startsWith('$folder/')),
          isTrue,
          reason: 'the detector stopped recognising `$folder/`',
        );
      }
    });

    test('F-SCD110-4: nothing ON DISK under any `<pkg>/doc/` is runner output '
        '[2026-09-14]', () {
      final root = Directory(_repoRoot!);
      final onDisk = <String>[];
      for (final package in root.listSync().whereType<Directory>()) {
        final doc = Directory('${package.path}/doc');
        if (!doc.existsSync()) continue;
        final packageName = package.uri.pathSegments
            .where((s) => s.isNotEmpty)
            .last;
        for (final entity in doc.listSync(recursive: true)) {
          if (entity is! File) continue;
          final relative = entity.path.substring(_repoRoot!.length + 1);
          if (!relative.startsWith('$packageName/doc/')) continue;
          final reason = _runnerOutputReason(relative);
          if (reason != null) onDisk.add('$relative — $reason');
        }
      }
      onDisk.sort();
      expect(
        onDisk,
        isEmpty,
        reason:
            'THIS MACHINE still has run output in a documentation folder. It '
            'is not committed — which is exactly how it stayed invisible '
            'while three `.gitignore` stanzas kept it out of `git status` — '
            'but `doc/` is hand-authored and this is not.\n\n'
            '${onDisk.join('\n')}\n\n'
            'From the repo root:\n$_repairCommand',
      );
    });

    test(
      'F-SCD110-5: `.gitignore` has no `doc/`-shaped stanza [2026-09-14]',
      () {
        // The ratchet. Ignoring a run folder in place is the habit this file
        // exists to end: it silences the symptom, leaves the violation, and
        // falsifies the comment that says `doc/` carries no test artifacts.
        final lines = File('$_repoRoot/.gitignore').readAsLinesSync();
        final stanzas = <String>[];
        for (var i = 0; i < lines.length; i++) {
          final line = lines[i].trim();
          if (line.startsWith('#') || line.isEmpty) continue;
          if (RegExp(r'doc/[A-Za-z0-9_*]*log').hasMatch(line)) {
            stanzas.add('.gitignore:${i + 1}: $line');
          }
        }
        expect(
          stanzas,
          isEmpty,
          reason:
              'A `doc/`-shaped ignore rule is back. Three of these accumulated '
              'between 2026-09-05 and 2026-09-14, one per folder name somebody '
              'found already committed; none of them could catch the next name. '
              'Move the folder to `testlog/` instead — it is already ignored '
              'wholesale.\n\n${stanzas.join('\n')}',
        );
      },
    );
  });
}
