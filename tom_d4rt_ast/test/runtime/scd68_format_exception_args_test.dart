// SCD68/AST — `FormatException`'s three arguments are positional in the
// analyzer-free tree too.
//
// The mirror of `tom_d4rt/test/scd68_format_exception_args_test.dart`, and
// REGISTRATION-level rather than script-level, which is this tree's established
// shape for stdlib coverage (see `stdlib_core_errors_test.dart`'s header):
// executing a script against *this* tree needs `tom_d4rt_exec`, which resolves
// `tom_d4rt_ast` from pub.dev and so cannot see an unpublished local edit.
//
// That limitation is unusually harmless here, because the defect was entirely
// inside the constructor adapter: it read `source` and `offset` out of
// `namedArgs` while the SDK declares
// `FormatException([String message = "", this.source, this.offset])`. Calling
// the adapter directly with a positional argument list is exactly what the
// interpreter does, so this asks the same question the reference tree asks
// through a script — one layer closer in.
//
// The four arities, not the three-argument case alone: a fix that reads
// `positionalArgs[1]` and `[2]` unguarded turns the shorter forms — which are
// what nearly every real call uses — into a `RangeError`.
//
// CONTROL, measured by reverting the adapter: `+0 -4` — every case fails,
// in both trees. That is worth stating plainly because most guards in this
// quest record a split, and the rails there are the cases that keep passing.
// There is no such case here, and none is missing: the fix is four lines with
// no behaviour outside them, so everything this file asks about moves. The
// discrimination lives inside the cases instead —
//
//   * a fix that reads `positionalArgs[1]` and `[2]` UNGUARDED passes -1, -3
//     and -4 and fails -2 on `FormatException('bad')`;
//   * a fix that reads positional AND keeps honouring named passes -1, -2 and
//     -3 and fails -4.
//
// So the degenerate fixes are each caught by exactly one case, which is what a
// rail is for; they just do not survive the revert to advertise it.

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';
// `CoreStdlib` is deliberately not re-exported from `runtime.dart`; reach for
// the same-package registrar rather than widening the published API.
import 'package:tom_d4rt_ast/src/runtime/stdlib/core.dart';

void main() {
  late Environment env;
  late InterpreterVisitor visitor;

  setUp(() {
    env = Environment();
    CoreStdlib.register(env);
    visitor = InterpreterVisitor(
      globalEnvironment: env,
      moduleContext: AstModuleLoader(
        modules: const {},
        globalEnvironment: env,
        runner: D4rtRunner(),
      ),
    );
  });

  /// Builds a `FormatException` through the bridge, the way the interpreter
  /// does: positional arguments in a list, named in a map.
  FormatException build(
    List<Object?> positional, [
    Map<String, Object?> named = const {},
  ]) {
    final bridge = env.findBridgedClassByName('FormatException');
    expect(bridge, isNotNull, reason: 'FormatException should be registered');
    return bridge!.constructors['']!(visitor, positional, named)
        as FormatException;
  }

  group('SCD68/AST: FormatException takes its arguments positionally', () {
    test('F-SCD68-AST-1: all three positional arguments arrive '
        '[2026-09-12] (PASS)', () {
      final e = build(['bad', 'src', 2]);
      expect(e.message, 'bad');
      expect(e.source, 'src');
      expect(e.offset, 2);
      // `source` is `Object?` in the SDK, not `String?`.
      expect(
        build([
          'bad',
          [1, 2],
          0,
        ]).source,
        [1, 2],
      );
    });

    test(
      'F-SCD68-AST-2: the shorter arities still work [2026-09-12] (PASS)',
      () {
        // The rail: unguarded index reads would make all three of these throw,
        // and these are the forms real code uses.
        final one = build(['bad']);
        expect([one.message, one.source, one.offset], ['bad', null, null]);
        final none = build([]);
        expect([none.message, none.source, none.offset], ['', null, null]);
        final two = build(['bad', 'src']);
        expect([two.message, two.source, two.offset], ['bad', 'src', null]);
      },
    );

    test('F-SCD68-AST-3: toString() regains the position it is built from '
        '[2026-09-12] (PASS)', () {
      // Character 3, not offset 2 — the SDK reports a 1-based column, and the
      // caret line is part of what the arguments buy.
      expect(
        build(['bad', 'src', 2]).toString(),
        'FormatException: bad (at character 3)\nsrc\n  ^\n',
      );
      expect(build(['bad']).toString(), 'FormatException: bad');
      expect(build([]).toString(), 'FormatException');
    });

    test(
      'F-SCD68-AST-4: the named spelling sets nothing [2026-09-12] (PASS)',
      () {
        // Not legal Dart — the constructor declares no named parameters. The
        // adapter used to honour it, which is how the defect stayed invisible:
        // the only spelling that worked was one the analyzer rejects.
        final e = build(['bad'], {'source': 's', 'offset': 1});
        expect([e.message, e.source, e.offset], ['bad', null, null]);
      },
    );
  });
}
