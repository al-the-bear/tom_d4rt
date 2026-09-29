// SCF29: four await-resumption routes that double-evaluated or dropped an
// await, and the neighbours that shared their cause.
//
// SCE139 stopped `_determineNextNodeAfterAwait` re-evaluating a node locally
// when its statement can be re-run instead: a declaration, an expression
// statement, a return. Four shapes were still wrong, measured with a `next()`
// that counts its calls, so a wrong VALUE and a wrong CALL COUNT are
// separable:
//
//   Q  `=> add(await next(), await next())`      4|calls=3  (want 3|calls=2)
//   R  `if (add(await next(), await next()) == 3)` false|calls=3 (want true|2)
//   S  `while (add(await next(), 0) < 2)`        n=0|calls=1 — loop never ran
//   T  `s = (await next()) + (await next());`    1|calls=1 — second await
//                                                 never evaluated at all
//
// Q, R and S were one cause: the invocation route re-evaluated locally
// whenever the enclosing unit was not a statement it knew it could re-run —
// an `=>` body, an `if` or loop condition. T was SCD121's defect on the
// assignment route: the resolved value of ONE await was assigned as the whole
// right-hand side. The same reading of `lastAwaitResult` as the whole
// condition broke `if` / `while` / `do` conditions holding awaits with no
// invocation — `(await a) + (await b) == 3`, `!await f()`.
//
// Every route now hands the unit back to the state machine and lets the
// resolved await sites replay. The loop cases run SEVERAL iterations on
// purpose: the per-site replay cache must end with each evaluation of the
// condition, or the next iteration replays the previous one's values.

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

const _pre = '''
var calls = 0;
Future<int> next() async { calls = calls + 1; return calls; }
Future<bool> below(int n) async { calls = calls + 1; return calls < n; }
int add(int a, int b) => a + b;
''';

Future<Object?> _run(String body) =>
    D4rt().execute(source: _pre + body) as Future<Object?>;

void main() {
  group('SCF29: the four routes the todo measured', () {
    test('F-SCF29-1 (Q): an `=>` body whose invocation holds two awaits '
        '[2026-09-29] (PASS)', () async {
      expect(
        await _run(
          'Future<int> f() async => add(await next(), await next()); '
          r'main() async { final r = await f(); return "$r|$calls"; }',
        ),
        '3|2',
      );
    });

    test('F-SCF29-2 (R): an `if` condition whose invocation holds two '
        'awaits [2026-09-29] (PASS)', () async {
      expect(
        await _run(
          'main() async { if (add(await next(), await next()) == 3) '
          r'{ return "true|$calls"; } return "false|$calls"; }',
        ),
        'true|2',
      );
    });

    test('F-SCF29-3 (S): a `while` condition whose invocation holds an '
        'await [2026-09-29] (PASS)', () async {
      expect(
        await _run(
          'main() async { var n = 0; while (add(await next(), 0) < 2) '
          r'{ n = n + 1; } return "n=$n|$calls"; }',
        ),
        'n=1|2',
      );
    });

    test('F-SCF29-4 (T): an assignment whose RHS holds two awaits '
        '[2026-09-29] (PASS)', () async {
      expect(
        await _run(
          'main() async { var s = 0; s = (await next()) + (await next()); '
          r'return "$s|$calls"; }',
        ),
        '3|2',
      );
    });
  });

  group('SCF29: neighbours of the same cause', () {
    test('F-SCF29-5: a loop condition with two awaits over several '
        'iterations — the replay cache ends with each evaluation '
        '[2026-09-29] (PASS)', () async {
      // Pairs (1,2)=3, (3,4)=7, (5,6)=11, (7,8)=15.
      expect(
        await _run(
          'main() async { var n = 0; '
          'while (add(await next(), await next()) < 12) { n = n + 1; } '
          r'return "n=$n|$calls"; }',
        ),
        'n=3|8',
      );
      expect(
        await _run(
          'main() async { var n = 0; do { n = n + 1; } '
          'while (add(await next(), await next()) < 8); '
          r'return "n=$n|$calls"; }',
        ),
        'n=3|6',
      );
    });

    test('F-SCF29-6: conditions holding awaits with no invocation, and a '
        'negated await [2026-09-29] (PASS)', () async {
      expect(
        await _run(
          'main() async { if ((await next()) + (await next()) == 3) '
          r'{ return "true|$calls"; } return "false|$calls"; }',
        ),
        'true|2',
      );
      expect(
        await _run(
          'main() async { var n = 0; while ((await next()) + 0 < 3) '
          r'{ n = n + 1; } return "n=$n|$calls"; }',
        ),
        'n=2|3',
      );
      expect(
        await _run(
          r'main() async { if (!await below(0)) { return "negated|$calls"; } '
          r'return "wrong|$calls"; }',
        ),
        'negated|1',
      );
    });

    test('F-SCF29-7: a compound assignment and an assignment inside a loop '
        '[2026-09-29] (PASS)', () async {
      expect(
        await _run(
          'main() async { var s = 10; s += (await next()) + (await next()); '
          r'return "$s|$calls"; }',
        ),
        '13|2',
      );
      expect(
        await _run(
          'main() async { var s = 0; for (var i = 0; i < 2; i++) '
          r'{ s = (await next()) + (await next()); } return "$s|$calls"; }',
        ),
        '7|4',
      );
    });
  });

  group('SCF29: controls on the routes that were already right', () {
    test('F-SCF29-8: declaration, return, plain `=>`, expression statement, '
        'direct-await conditions and `x = await f()` [2026-09-29] (PASS)', () async {
      final cases = <String, String>{
        r'main() async { var s = add(await next(), await next()); return "$s|$calls"; }':
            '3|2',
        r'Future<int> f() async { return add(await next(), await next()); } main() async { final r = await f(); return "$r|$calls"; }':
            '3|2',
        r'Future<int> f() async => (await next()) + (await next()); main() async { final r = await f(); return "$r|$calls"; }':
            '3|2',
        r'var log = []; main() async { log.add(add(await next(), await next())); return "${log[0]}|$calls"; }':
            '3|2',
        r'main() async { if (await below(3)) { return "t|$calls"; } return "f|$calls"; }':
            't|1',
        r'main() async { var n = 0; while (await below(3)) { n = n + 1; } return "n=$n|$calls"; }':
            'n=2|3',
        r'main() async { var s = 0; s = await next(); return "$s|$calls"; }':
            '1|1',
      };
      for (final entry in cases.entries) {
        expect(await _run(entry.key), entry.value, reason: entry.key);
      }
    });
  });
}
