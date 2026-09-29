// SCF20: exec's `functionTypedefs` carries the record the reference does.
//
// The reference `D4rt.functionTypedefs` and `D4rtRunner.functionTypedefs`
// return `({name, library, requiredPositional, maxPositional})` — the arity
// fields SCD137 added so a callable that provably cannot be invoked through a
// typedef is refused. Exec's forwarder returned a two-field projection, because
// while exec resolved a `tom_d4rt_ast` that still declared the two-field record,
// returning the runner's list verbatim compiled against only one of the two
// shapes. Exec's floor has since passed the release carrying the wide record,
// so the projection, and the narrower `registerFunctionTypedef` that could not
// pass arity at all, are gone.

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

void main() {
  group('SCF20: exec reports function typedefs as the reference does', () {
    test('F-SCF20-1: the arity a registration supplies is reported back '
        '[2026-09-29] (PASS)', () {
      final interpreter = D4rt()
        ..registerFunctionTypedef(
          'Pair',
          'package:p/p.dart',
          requiredPositional: 2,
          maxPositional: 3,
        );
      final typedef = interpreter.functionTypedefs.singleWhere(
        (t) => t.name == 'Pair',
      );
      expect(typedef.library, 'package:p/p.dart');
      expect(typedef.requiredPositional, 2);
      expect(typedef.maxPositional, 3);
    });

    test('F-SCF20-2: a registration without arity reports it absent, which '
        'the interpreter reads as arity-blind [2026-09-29] (PASS)', () {
      final interpreter = D4rt()
        ..registerFunctionTypedef('VoidCallback', 'package:p/p.dart');
      final typedef = interpreter.functionTypedefs.singleWhere(
        (t) => t.name == 'VoidCallback',
      );
      expect(typedef.requiredPositional, isNull);
      expect(typedef.maxPositional, isNull);
    });
  });
}
