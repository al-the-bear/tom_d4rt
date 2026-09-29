// SHARED FILE (SCE240) — one copy in each of tom_ast_generator,
// tom_d4rt_dcli, tom_dcli_exec and tom_d4rt_generator, kept byte-identical by
// `tom_d4rt/test/sce240_resolved_interpreter_copies_test.dart`.
//
// Prints, into this suite's own log, the interpreter it measured. See
// `resolved_interpreter.dart` for why.

import 'package:test/test.dart';

import 'resolved_interpreter.dart';

void main() {
  test('F-SCE240-1: this run names the interpreter it measured '
      '[2026-09-29] (PASS)', () {
    final lines = resolvedInterpreterLines();
    // The print IS the product: the line a reader of a red run looks for.
    // ignore: avoid_print
    print(
      '${packageName()} measured against:\n'
      '${lines.map((l) => '  $l').join('\n')}',
    );
    // Non-vacuity: every one of these packages depends on an interpreter, so a
    // run that names none has stopped reading its lock rather than found a
    // package with no interpreter.
    expect(
      lines.where((l) => !l.startsWith('NONE')),
      isNotEmpty,
      reason:
          'No interpreter package was found in pubspec.lock:\n'
          '${lines.join('\n')}',
    );
  });
}
