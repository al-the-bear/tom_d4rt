// SCD66 — the interpreter resolution strategy, and the two ways it can rot.
//
// THE DECISION, so it is readable where it is enforced: the Flutter twins and
// `tom_d4rt_exec` resolve their interpreter FROM PUB.DEV by default, because
// what they exist to measure is what a consumer of the published package gets
// (DGUC6). That default is the only configuration whose results may be
// recorded under `## Verification runs` in `doc/interpreter_issues.md`.
//
// Beside it there is an opt-in PRE-PUBLISH pass —
// `tool/prepublish_overrides.dart --set` — which path-resolves the interpreter
// so the corpus and the exec suite can be run against the working tree before
// the publish that makes it permanent. It exists because a publish cannot be
// undone and the quest's own protocol otherwise finds a corpus regression only
// AFTER the release: tcca19 is the precedent, a registry change that broke 17
// base-corpus scripts with every unit test green.
//
// THE OPT-IN PASS IS NOT A ROUTE AROUND THE WORKSPACE RULE against path
// overrides. That rule is about making a package WORK against an unpublished
// API and then shipping it; this is a measurement that is thrown away. The
// difference is enforced rather than asserted:
//
//   * the override files are gitignored, so the state cannot be committed
//     (SCD66-2), and
//   * a `dependency_overrides:` block in a tracked `pubspec.yaml` — the form
//     that IS committed and would silently redirect everyone — fails
//     (SCD66-1).
//
// EACH ROW OBSERVED, by breaking the thing named:
//
//   | Injected fault                                      | Fires |
//   | --------------------------------------------------- | ----- |
//   | `dependency_overrides:` added to a target pubspec    | 1     |
//   | the gitignore entry removed                          | 2     |
//   | a target dir renamed, or an override package no      |       |
//   |   longer resolved there                              | 3 and 4 |
//
// SCD66-3 is the one worth explaining. The pass is a list of directories and
// package names; if a package moves or stops pulling in the interpreter, the
// pass keeps "succeeding" while quietly covering one target fewer, and the
// corpus goes back to measuring the published interpreter with nobody told.
// The test imports the tool's own `targets` table rather than restating it, so
// the list it checks cannot drift from the list the tool uses.
//
// The rename row fires 4 as well as 3, which was not the prediction: SCD66-4
// checks membership of the very list SCD66-3 walks, so a renamed directory
// fails both. Read 3 — it names the directory; 4 only says the set changed.
//
// It asks whether each target RESOLVES the package, not whether it DECLARES
// it, and the first draft got that wrong — which is the fact worth keeping.
// Neither companion app depends on the interpreter directly: each depends on
// its twin by path and reaches the interpreter transitively. That is precisely
// why the apps need their own override entry. A `dependency_overrides:` block
// applies to the whole resolution, direct or not, so overriding there works;
// a check written against the dependency list declared two of the five targets
// broken while the pass was in fact covering them correctly.
//
// Pure file I/O — no companion app, no port — so this file is safe to run at
// any time and is NOT part of the serial corpus.
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import '../tool/prepublish_overrides.dart';

/// The `.gitignore` at the repository root, two levels up from this package.
final repoGitignore = File('../.gitignore');

void main() {
  group('SCD66: hosted by default, path only as an opt-in pass', () {
    test('SCD66-1: no target commits a `dependency_overrides:` block. '
        '[2026-09-12 00:00] (PASS)', () {
      // The committed form is the dangerous one: it redirects the package
      // for every checkout and every machine, and unlike `pubspec_overrides`
      // it is not ignorable. A pre-publish pass that reached for this would
      // be indistinguishable, in the repository, from the workspace rule
      // being broken outright.
      final offenders = <String>[];
      for (final target in targets) {
        final pubspec = File('${target.dir}/pubspec.yaml');
        if (!pubspec.existsSync()) continue; // SCD66-3 owns that failure.
        final hasBlock = pubspec.readAsLinesSync().any(
          (l) => l.trimRight() == 'dependency_overrides:',
        );
        if (hasBlock) offenders.add('${target.dir}/pubspec.yaml');
      }
      expect(
        offenders,
        isEmpty,
        reason:
            'These pubspecs carry a committed `dependency_overrides:` '
            'block:\n${offenders.join('\n')}\n\n'
            'The pre-publish pass uses a gitignored `pubspec_overrides.yaml` '
            'precisely so the state cannot be committed. If an override is '
            'genuinely needed permanently, that is a publish, not an '
            'override — see the workspace dependency rule.',
      );
    });

    test('SCD66-2: `pubspec_overrides.yaml` is gitignored repo-wide. '
        '[2026-09-12 00:00] (PASS)', () {
      // Without this the pass is one `git add -A` away from committing the
      // very thing it is designed to keep local — and it would look like an
      // ordinary new file in the diff.
      expect(
        repoGitignore.existsSync(),
        isTrue,
        reason:
            '${repoGitignore.path} not found — run this from the '
            'tom_d4rt_flutter_ast package root.',
      );
      final entries = repoGitignore
          .readAsLinesSync()
          .map((l) => l.trim())
          .where((l) => l.isNotEmpty && !l.startsWith('#'));
      expect(
        entries,
        contains('pubspec_overrides.yaml'),
        reason:
            'The repository .gitignore no longer ignores '
            '`pubspec_overrides.yaml`, so a pre-publish pass left in place '
            'can be committed. Restore the entry rather than relying on '
            'whoever runs `--restore` remembering to.',
      );
    });

    test('SCD66-3: every target the pass covers still exists and still '
        'resolves what it overrides. [2026-09-12 00:00] (PASS)', () {
      final problems = <String>[];
      for (final target in targets) {
        final pubspec = File('${target.dir}/pubspec.yaml');
        if (!pubspec.existsSync()) {
          problems.add('${target.dir}: no pubspec.yaml — moved or renamed?');
          continue;
        }
        final lock = File('${target.dir}/pubspec.lock');
        if (!lock.existsSync()) {
          problems.add(
            '${target.dir}: no pubspec.lock — run `pub get` there before '
            'reading this as a coverage gap.',
          );
          continue;
        }
        final lines = lock.readAsLinesSync();
        for (final package in target.overrides.keys) {
          // Resolution, not declaration: both companion apps reach the
          // interpreter through their twin. The lockfile entry sits at pub's
          // own two-space indent, so this cannot be satisfied by a mention in
          // a comment — and these files do carry comments naming the
          // interpreter, because the policy is written in them.
          final resolved = lines.any((l) => l.trimRight() == '  $package:');
          if (!resolved) {
            problems.add(
              '${target.dir}: the pass overrides `$package`, but nothing '
              'there resolves that package any more.',
            );
          }
        }
      }
      expect(
        problems,
        isEmpty,
        reason:
            'The pre-publish pass would silently cover fewer targets than it '
            'claims:\n${problems.join('\n')}\n\n'
            'Fix `targets` in tool/prepublish_overrides.dart. A pass that '
            'misses a target does not fail — it just leaves that package '
            'resolving the PUBLISHED interpreter, which is the state the pass '
            'exists to leave.',
      );
    });

    test('SCD66-4: the targets cover both twins, both companion apps and exec. '
        '[2026-09-12 00:00] (PASS)', () {
      // Anti-vacuity for the three above: every one of them iterates
      // `targets`, so an empty or truncated table would make all three pass
      // while checking nothing. The companion apps are named explicitly
      // because they are the ones easiest to forget — they are separate
      // packages with their own lockfiles, and the corpus executes in them.
      final dirs = targets.map((t) => t.dir).toSet();
      expect(dirs, contains('.'));
      expect(dirs, contains('test/tom_d4rt_flutter_ast_app'));
      expect(dirs, contains('../tom_d4rt_flutter'));
      expect(
        dirs,
        contains('../tom_d4rt_flutter/test/tom_d4rt_flutter_test_app'),
      );
      expect(dirs, contains('../tom_d4rt_exec'));
    });
  });
}
