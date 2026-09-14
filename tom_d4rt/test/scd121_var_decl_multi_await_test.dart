/// SCD121 — a variable declaration whose initializer holds more than one
/// `await` keeps all of them.
///
/// `var s = (await a) + (await b);` bound `s = 1`, not 3. The resumption branch
/// for a declaration bound `futureResult` — the value of ONE await — straight
/// to the variable and moved on, so everything else in the initializer was
/// discarded. `var s = '${await a},${await b}';` was the same defect wearing a
/// different symptom: `s` held the raw int, and the next line failed with a
/// type error about a value the script never wrote.
///
/// IT WAS NEVER A MISSING-EVALUATION BUG. The discarded operands were
/// evaluated — the call counts said so — which is why every case here counts
/// calls as well as checking the value. A repair that produced the right sum by
/// evaluating an operand twice would pass a value-only test and be wrong, and
/// the first attempt at this fix did exactly that: re-evaluating the
/// initializer inside the resumption branch gave 5 instead of 3, because that
/// evaluation's suspension cannot be registered with the state machine and the
/// statement is re-executed anyway.
///
/// THE SECOND DEFECT, found by those counts. `visitBinaryExpression` evaluated
/// BOTH operands before checking either for a suspension, so a suspending left
/// operand still cost a full evaluation of the right. Invisible while the
/// statement never re-ran; once it did, `(await next()) + (await next())` cost
/// three calls for two awaits and three awaits cost six. Dart evaluates `a + b`
/// left to right and never reaches `b` while `a` is outstanding.
///
/// F-SCD121-5 is the control for the cache this rests on. The per-await-site
/// map is scoped to ONE evaluation of ONE statement; a loop body re-enters the
/// identical AST node, so an entry that outlived its statement would replay the
/// previous iteration's value. That case is also what SCC40's F-SCB14-13 pins
/// for the return route — this is the declaration route's copy of it, and it
/// was the risk the fix's clearing step was written against.
library;

import 'package:test/test.dart';
import 'interpreter_test.dart';

/// A script preamble with a counter and an async `next()` that increments it,
/// so a discarded evaluation is visible as a call that should not have happened.
const String _preamble = '''
  int _n = 0;
  Future<int> next() async { _n = _n + 1; return _n; }
''';

Future<Object?> _run(String body) => executeAsync('$_preamble\n$body');

void main() {
  group('SCD121: a declaration keeps every await in its initializer', () {
    test(
      'F-SCD121-1: two awaits in one initializer both count [2026-09-14]',
      () async {
        // Pre-fix: '1|calls=2' — the second operand was evaluated and dropped.
        expect(
          await _run('''
            Future<String> main() async {
              var s = (await next()) + (await next());
              return '\$s|calls=\$_n';
            }
          '''),
          equals('3|calls=2'),
        );
      },
    );

    test(
      'F-SCD121-2: an interpolation with two awaits binds the STRING, not the '
      'last awaited value [2026-09-14]',
      () async {
        // Pre-fix this did not merely produce the wrong string: `s` was bound
        // to the raw int, so the function failed its own return type with
        // "A value of type 'int' can't be returned ... 'String'" — an error
        // about a value the script never wrote.
        expect(
          await _run('''
            Future<String> main() async {
              var s = '\${await next()},\${await next()}';
              return '\$s|calls=\$_n';
            }
          '''),
          equals('1,2|calls=2'),
        );
      },
    );

    test('F-SCD121-3: three awaits, three calls [2026-09-14]', () async {
      // The arity matters: the first repair attempt was right for two awaits
      // and wrong for three, because its extra evaluation compounded.
      expect(
        await _run('''
          Future<String> main() async {
            var s = (await next()) + (await next()) + (await next());
            return '\$s|calls=\$_n';
          }
        '''),
        equals('6|calls=3'),
      );
    });

    test('F-SCD121-4 (control): one await per declaration was always right and '
        'still is [2026-09-14]', () async {
      // The shape the branch was written for. It must keep taking the fast
      // path — a repair that routed it through the re-run would still give
      // the right answer, so this case earns its keep by the call count.
      expect(
        await _run('''
            Future<String> main() async {
              var a = await next();
              var b = await next();
              return '\${a + b}|calls=\$_n';
            }
          '''),
        equals('3|calls=2'),
      );
    });

    test('F-SCD121-5 (control): a loop body re-evaluates its awaits every '
        'iteration [2026-09-14]', () async {
      // The per-site cache must not outlive the statement. Three iterations
      // over the SAME two await nodes: (1+2) + (3+4) + (5+6) = 21. A stale
      // cache replays the first iteration's values and gives 9.
      expect(
        await _run('''
            Future<String> main() async {
              var total = 0;
              for (var i = 0; i < 3; i = i + 1) {
                var s = (await next()) + (await next());
                total = total + s;
              }
              return '\$total|calls=\$_n';
            }
          '''),
        equals('21|calls=6'),
      );
    });
  });
}
