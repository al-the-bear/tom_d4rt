// ghissues24 — a doc-comment reference never makes a script fail.
//
// Measured 2026-11-10 (tom_d4rt 1.247.0, tom_d4rt_exec 1.55.0):
//
//   /// Uses [NotDeclared].
//   main() => 1;           // Runtime Error: Undefined variable: NotDeclared
//
// The static name pass (`reportUnresolvedNames`, lib/src/static_name_report.dart)
// walked into `Comment` nodes, so each `[Name]` of a doc comment was reported
// as an unresolved read and evaluated before `main` (GEN-129; in the Flutter
// corpus `/// Visual deep demo for [BinaryMessenger] ...` refused
// `services/binary_messenger_test.dart` in the source twin). The pass now
// skips comments. tom_d4rt_ast is not affected: the mirror model carries no
// comments.
//
// tom_d4rt_exec runs its own copy of the pass over the analyzer AST at parse
// time and had the same descent; this file is in both suites.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

Object? _run(String source) => D4rt().execute(source: source);

void main() {
  group('ghissues24: a doc-comment reference never makes a script fail', () {
    test('GHI24-1: an undeclared name on main [2026-11-10]', () {
      expect(_run('/// Uses [NotDeclared].\nmain() => 1;\n'), 1);
    });

    test('GHI24-2: an undeclared, an imported, a prefixed and a member '
        'reference on a class, a member, a function and a top-level variable '
        '[2026-11-10]', () {
      expect(
        _run(
          "import 'dart:math' as p;\n"
          '/// A box; see [Missing], [Duration] and [p.Nothing].\n'
          'class Box {\n'
          '  /// The value, like [Missing.field] and [Box.v].\n'
          '  final int v;\n'
          '  Box(this.v);\n'
          '  /// Doubles, see [alsoMissing].\n'
          '  int twice() => v * 2;\n'
          '}\n'
          '/// The seed, see [NotHere.either].\n'
          'final seed = 3;\n'
          '/** Calls [Gone] and [p.max]. */\n'
          'int make() => Box(seed).twice();\n'
          'main() => [make(), p.max(1, 2)];\n',
        ),
        [6, 2],
      );
    });

    test('GHI24-3: a real undefined read is still refused [2026-11-10]', () {
      expect(
        () => _run('/// Reads [Fine].\nmain() => notDefinedAnywhere;\n'),
        throwsA(
          isA<RuntimeD4rtException>().having(
            (e) => e.message,
            'message',
            contains('notDefinedAnywhere'),
          ),
        ),
      );
    });
  });
}
