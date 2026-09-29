// REPO-WIDE GUARD (tom_d4rt) — the four consumers' copies of the resolved-interpreter helper are identical.
//
// Its subject reaches OUTSIDE this package, so it runs only when tom_d4rt's suite
// runs and a session working elsewhere in the repo reaches none of it. SCD129
// made that arrangement visible rather than incidental: `grep -rn 'REPO-WIDE
// GUARD' */test` lists every one, and
// `tom_d4rt/test/scd129_repo_wide_guard_index_test.dart` fails if a new one
// arrives without this banner.
//
// SCE240. Four consumers of the interpreter (tom_ast_generator, tom_d4rt_dcli,
// tom_dcli_exec, tom_d4rt_generator) each print, in their own suite's log, the
// interpreter they resolved. Their locks are gitignored, and for a 1.x
// interpreter the caret names nothing: two of them declare `tom_d4rt: ^1.77.0`
// and resolved 1.192.0 (measured 2026-09-29).
//
// There is no package all four could import the helper from, so it is COPIED,
// which is the repo's established answer (`sibling_trees.dart`,
// `companion_app_resolution.dart`, `run_attribution.dart`). Copies drift, so
// this file holds them identical, as F-SCD164-5 does for `run_attribution.dart`.
//
// SEEN TO FAIL (2026-09-29):
//
//   | Injected fault                                   | Fires |
//   | ------------------------------------------------ | ----- |
//   | one copy's comment edited                        | 1     |
//   | one consumer's copy of the test file deleted     | 1     |

import 'dart:io';

import 'package:test/test.dart';

import 'sibling_trees.dart';

const _consumers = [
  'tom_ast_generator',
  'tom_d4rt_dcli',
  'tom_dcli_exec',
  'tom_d4rt_generator',
];

const _sharedFiles = [
  'test/resolved_interpreter.dart',
  'test/resolved_interpreter_test.dart',
];

void main() {
  requirePackage(
    'tom_d4rt',
    subject: 'the four consumers\' copies of the resolved-interpreter helper',
  );

  test('F-SCE240-C1: every consumer carries both shared files, byte-identical '
      '[2026-09-29] (PASS)', () {
    final problems = <String>[];
    for (final file in _sharedFiles) {
      String? canonical;
      String? canonicalOwner;
      for (final consumer in _consumers) {
        final f = File('../$consumer/$file');
        if (!f.existsSync()) {
          problems.add('$consumer is missing $file');
          continue;
        }
        final text = f.readAsStringSync();
        if (canonical == null) {
          canonical = text;
          canonicalOwner = consumer;
        } else if (text != canonical) {
          problems.add('$consumer/$file differs from $canonicalOwner\'s copy');
        }
      }
    }
    expect(
      problems,
      isEmpty,
      reason:
          '${problems.length} problem(s), all of them:\n${problems.join('\n')}\n'
          'The copies are one helper kept in four places. Copy the edited one '
          'to the other three in the same commit.',
    );
  });
}
