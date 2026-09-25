// RUNNER BUCKET: guard — run_guard_tests.sh
// REPO-WIDE GUARD (tom_d4rt_flutter_ast) — the two twins execute ONE script corpus, and it lives here.
//
// Its subject reaches OUTSIDE this package (the sibling twin's runner and
// companion app), so it runs only when tom_d4rt_flutter_ast's suite runs. SCD129
// made that arrangement visible rather than incidental: `grep -rn 'REPO-WIDE
// GUARD' */test` lists every one, and
// `tom_d4rt/test/scd129_repo_wide_guard_index_test.dart` fails if a new one
// arrives without this banner.
//
// SCD141 — `tom_d4rt_flutter` has no script corpus of its own. Its
// `send_test_runner.dart` points `scriptsPath` at this package's
// `send_ast_via_http_scripts/`, so both suites execute the same ~2 085 scripts
// and a script fix lands on both twins from one edit.
//
// WHY A TEST AND NOT ONLY THE DOCUMENTATION. Both twins' `test/README.md` and
// the quest overview now state it, which handles the reader who looks. The
// failure mode is the one who does not: SCC47 nearly hand-copied a script change
// into `tom_d4rt_flutter/test/tom_d4rt_flutter_test_app/test/send_via_http_scripts/`
// — a path that does not exist — and found out only because `git diff --no-index`
// happened to fail on it. Had the directory been created, the corpus would have
// FORKED silently: the source twin would still run the shared scripts, the new
// copy would be dead weight that looks authoritative, and nothing would say so.
//
// A missing path is already loud — `send_test_runner` fails at run time. A
// SECOND corpus is the silent case, and F-SCD141-2 is the one that matters.
//
// The path is READ from the sibling's source rather than hardcoded here. A guard
// that repeats the constant it is guarding passes when both copies are wrong
// together, which is the failure it exists to prevent.
//
// EACH TEST HERE HAS BEEN SEEN TO FAIL:
//
//   | Injected fault                                              | Fires |
//   | ----------------------------------------------------------- | ----- |
//   | `scriptsPath` repointed at a directory that does not exist    | 1     |
//   | a `…/test/send_via_http_scripts/` created in the source twin  | 2     |
//   | the script floor raised above the corpus size                 | 3     |
//
// The third row is the honest description of what was injected. Emptying the
// corpus would fire the same assertion, but 2 085 files is not a fault worth
// staging to prove a `>=` works.
@TestOn('vm')
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'sibling_trees.dart';

/// The sibling twin's runner, which declares where its scripts come from.
const _siblingRunner = '../tom_d4rt_flutter/test/send_test_runner.dart';

/// Where the sibling's companion app lives — the plausible home for a second,
/// forked corpus, and the path SCC47 nearly created.
const _siblingAppTestDir =
    '../tom_d4rt_flutter/test/tom_d4rt_flutter_test_app/test';

/// 2 085 scripts on 2026-09-15. The floor is far below that because its job is
/// to separate "found the corpus" from "found nothing" — F-SCD141-1 asserts a
/// directory exists, and an EMPTY directory satisfies that.
const int _minScripts = 1500;

/// The `scriptsPath` constant as the sibling twin declares it.
String? siblingScriptsPath() {
  final file = File(_siblingRunner);
  if (!file.existsSync()) return null;
  final match = RegExp(
    r"""static\s+const\s+String\s+scriptsPath\s*=\s*['"]([^'"]+)['"]""",
  ).firstMatch(file.readAsStringSync());
  return match?.group(1);
}

/// Directories under the sibling's companion app whose name suggests a corpus.
List<String> siblingCorpusLookalikes() {
  final dir = Directory(_siblingAppTestDir);
  if (!dir.existsSync()) return const [];
  return [
    for (final e in dir.listSync())
      if (e is Directory &&
          e.uri.pathSegments.any((s) => s.contains('scripts')))
        e.path,
  ];
}

void main() {
  // SCE191: this guard resolves its subject relative to the package it
  // runs in, so a copy anywhere else measures a different tree in silence.
  requirePackage(
    'tom_d4rt_flutter_ast',
    subject: 'the two twins execute ONE script corpus, and it lives here',
  );

  group('SCD141: one shared script corpus', () {
    test(
      'F-SCD141-1: the sibling twin points at a corpus that exists, and it is '
      'this package\'s [2026-09-15]',
      () {
        final declared = siblingScriptsPath();
        expect(
          declared,
          isNotNull,
          reason:
              'could not read `scriptsPath` from $_siblingRunner. Either the '
              'sibling checkout is absent (this guard needs it) or the constant '
              'was renamed — in which case update the pattern here rather than '
              'deleting the check.',
        );
        expect(
          declared,
          contains('tom_d4rt_flutter_ast'),
          reason:
              'the sibling twin no longer sources its scripts from this '
              'package. If that is deliberate the twins have stopped sharing a '
              'corpus, which is a change to the quest\'s non-obvious rules and '
              'to both READMEs — not to this expectation alone. Declared: '
              '$declared',
        );

        // Resolved from the sibling's own package root, which is what its
        // runner does.
        final resolved = Directory('../tom_d4rt_flutter/$declared');
        expect(
          resolved.existsSync(),
          isTrue,
          reason:
              'the declared corpus path does not resolve to a directory:\n'
              '  ${resolved.path}\n'
              'The sibling suite would fail at run time on every script.',
        );
      },
    );

    test('F-SCD141-2: the sibling twin has NOT grown a corpus of its own '
        '[2026-09-15]', () {
      // The silent failure. A second copy would not break a run — the runner
      // keeps reading the shared one — so nothing else would ever mention it,
      // while it sat in the tree looking authoritative and drifting.
      final lookalikes = siblingCorpusLookalikes();
      expect(
        lookalikes,
        isEmpty,
        reason:
            'A script directory has appeared under the sibling twin\'s '
            'companion app. The corpus is shared and lives in this package; a '
            'second copy is not read by anything and will drift from the one '
            'that is:\n  ${lookalikes.join('\n  ')}\n'
            'If the twins are genuinely forking their corpora, that is a '
            'deliberate change to the rule in both READMEs and the quest '
            'overview.',
      );
    });

    test(
      'F-SCD141-3: the shared corpus actually holds scripts [2026-09-15]',
      () {
        // Anti-vacuity for F-SCD141-1, which is satisfied by an empty directory.
        final root = Directory(
          'test/tom_d4rt_flutter_ast_app/test/send_ast_via_http_scripts',
        );
        expect(root.existsSync(), isTrue, reason: 'corpus root ${root.path}');
        final scripts = root
            .listSync(recursive: true)
            .whereType<File>()
            .where((f) => f.path.endsWith('.dart'))
            .length;
        expect(
          scripts,
          greaterThanOrEqualTo(_minScripts),
          reason:
              'only $scripts scripts under ${root.path}. 2 085 on 2026-09-15; '
              'finding almost none means the corpus moved and both twins are '
              'running nothing.',
        );
      },
    );
  });
}
