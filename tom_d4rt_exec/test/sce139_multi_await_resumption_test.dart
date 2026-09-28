/// SCE139 — a `return` or an invocation holding more than one `await` is
/// evaluated once per pass, not twice.
///
/// The resumption branches for a return statement and for an invocation with
/// awaits in its arguments both re-evaluated the node *inside*
/// `_determineNextNodeAfterAwait`. That evaluation's suspension cannot be
/// registered with the state machine — the machine only ever attaches to a
/// suspension raised by executing a node — so it was discarded and the node was
/// executed again anyway. Every await site the machine had not yet resolved
/// therefore ran twice per pass.
///
/// IT WAS NEVER ONLY A CALL-COUNT BUG, which is why every case here checks the
/// value as well. The discarded pass CONSUMED the value its site should have
/// received: with `next()` incrementing a counter,
/// `return (await next()) + (await next())` answered 4 rather than 3, and three
/// awaits answered 9 rather than 6. A repair that fixed the sum by evaluating
/// something twice would pass a value-only test and still be wrong.
///
/// THE SECOND DEFECT, which the same repair closes. Completing the function
/// inside `_determineNextNodeAfterAwait` — set `lastAwaitResult`, return null —
/// bypasses the state machine's `ReturnException` handler, and with it the jump
/// into an enclosing `finally`. `try { return "${await f()}"; } finally { … }`
/// ran no finally at all. F-SCE139-7 and F-SCE139-8 pin that half; -8 needs only
/// ONE await, so it is red for the completion route alone and stays green under
/// any change to the call counts.
///
/// SCD121 fixed the declaration route the same way and is the control here:
/// F-SCE139-9 and F-SCE139-10 were already green before this change and must
/// stay green, because a repair that moved the defect from one route to the
/// other would otherwise look like a fix.
library;

import 'package:test/test.dart';
import 'interpreter_test.dart';

/// A counter and an async `next()` that increments it, so an evaluation that
/// should not have happened is visible as a call that should not have happened.
const String _preamble = '''
  int _n = 0;
  int _total = 0;
  Future<int> next() async { _n = _n + 1; return _n; }
  int add(int a, int b) => a + b;
  void acc(int a, int b) { _total = a + b; }
''';

Future<Object?> _run(String body) => executeAsync('$_preamble\n$body');

void main() {
  group('SCE139: one evaluation per resumption pass', () {
    test('F-SCE139-1: a return with two awaits calls each site once '
        '[2026-09-22]', () async {
      // Pre-fix: '4|calls=3'.
      expect(
        await _run('''
          Future<int> f() async { return (await next()) + (await next()); }
          Future<String> main() async {
            final v = await f();
            return '\$v|calls=\$_n';
          }
        '''),
        equals('3|calls=2'),
      );
    });

    test('F-SCE139-2: a return with three awaits calls each site once '
        '[2026-09-22]', () async {
      // Pre-fix: '9|calls=5' — one call for the first site, two for each of
      // the rest. The cost is per not-yet-resolved site, so it grows with the
      // number of awaits rather than being a constant doubling.
      expect(
        await _run('''
          Future<int> f() async {
            return (await next()) + (await next()) + (await next());
          }
          Future<String> main() async {
            final v = await f();
            return '\$v|calls=\$_n';
          }
        '''),
        equals('6|calls=3'),
      );
    });

    test('F-SCE139-3: awaits in the arguments of a returned invocation are '
        'called once each [2026-09-22]', () async {
      // Pre-fix: '4|calls=3'. This is the invocation branch rather than the
      // return branch — the await context is lifted to the nearest enclosing
      // invocation before either branch is chosen.
      expect(
        await _run('''
          Future<int> f() async { return add(await next(), await next()); }
          Future<String> main() async {
            final v = await f();
            return '\$v|calls=\$_n';
          }
        '''),
        equals('3|calls=2'),
      );
    });

    test('F-SCE139-4: awaits in the arguments of an invocation that '
        'initializes a variable are called once each [2026-09-22]', () async {
      // Pre-fix: '4|calls=3'. The enclosing statement is a declaration, so the
      // machine binds the variable on the pass where nothing suspends — the
      // branch no longer hand-assigns it.
      expect(
        await _run('''
          Future<int> f() async {
            final x = add(await next(), await next());
            return x;
          }
          Future<String> main() async {
            final v = await f();
            return '\$v|calls=\$_n';
          }
        '''),
        equals('3|calls=2'),
      );
    });

    test('F-SCE139-5: awaits in the arguments of a standalone invocation are '
        'called once each [2026-09-22]', () async {
      // Pre-fix: '4|calls=3'. An expression statement keeps nothing, so only
      // the side effect says what the callee received.
      expect(
        await _run('''
          Future<int> f() async {
            acc(await next(), await next());
            return _total;
          }
          Future<String> main() async {
            final v = await f();
            return '\$v|calls=\$_n';
          }
        '''),
        equals('3|calls=2'),
      );
    });

    test('F-SCE139-6: a returned interpolation mixing an operand with two '
        'awaits keeps both values [2026-09-22]', () async {
      // Pre-fix: '2|3|calls=3' — the second interpolation read 3 because the
      // discarded pass had already consumed 2.
      expect(
        await _run('''
          Future<String> f() async {
            final one = 1;
            return '\${one + (await next())}|\${await next()}';
          }
          Future<String> main() async {
            final v = await f();
            return '\$v|calls=\$_n';
          }
        '''),
        equals('2|2|calls=2'),
      );
    });

    test('F-SCE139-7: a returned expression with two awaits still runs its '
        'enclosing finally [2026-09-22]', () async {
      // Pre-fix: '4|calls=3|0'. The zero is the finally that never ran.
      expect(
        await _run('''
          Future<int> f() async {
            try {
              return (await next()) + (await next());
            } finally {
              _total = 9;
            }
          }
          Future<String> main() async {
            final v = await f();
            return '\$v|calls=\$_n|\$_total';
          }
        '''),
        equals('3|calls=2|9'),
      );
    });

    test('F-SCE139-8: ONE await in a returned expression still runs its '
        'enclosing finally [2026-09-22]', () async {
      // Pre-fix: '1|calls=1|0'. With a single await site there is nothing to
      // double-count, so this case isolates the completion route: the return
      // has to reach the state machine's ReturnException handler, which is what
      // knows about the finally.
      expect(
        await _run('''
          Future<String> f() async {
            try {
              return '\${await next()}';
            } finally {
              _total = 9;
            }
          }
          Future<String> main() async {
            final v = await f();
            return '\$v|calls=\$_n|\$_total';
          }
        '''),
        equals('1|calls=1|9'),
      );
    });

    test('F-SCE139-9: CONTROL — the declaration route is unchanged '
        '[2026-09-22]', () async {
      // Green before this change (SCD121) and green after. A repair that moved
      // the double evaluation from the return route onto this one would look
      // like a fix without it.
      expect(
        await _run('''
          Future<int> f() async {
            final s = (await next()) + (await next()) + (await next());
            return s;
          }
          Future<String> main() async {
            final v = await f();
            return '\$v|calls=\$_n';
          }
        '''),
        equals('6|calls=3'),
      );
    });

    test('F-SCE139-10: CONTROL — a loop body re-entering the same await sites '
        'gets fresh values [2026-09-22]', () async {
      // The per-site cache is scoped to ONE evaluation of ONE statement; a loop
      // re-enters the identical AST nodes, so an entry that outlived its
      // statement would replay the previous iteration's values and answer
      // '3,3'. Green before this change, and the property the new clearing step
      // in the ReturnException handler was written against.
      expect(
        await _run('''
          Future<String> f() async {
            final out = <String>[];
            for (var i = 0; i < 2; i++) {
              final s = (await next()) + (await next());
              out.add(s.toString());
            }
            return out.join(',');
          }
          Future<String> main() async {
            final v = await f();
            return '\$v|calls=\$_n';
          }
        '''),
        equals('3,7|calls=4'),
      );
    });

    test('F-SCE139-11: a cascade with two awaits writes each section once '
        '[2026-09-22]', () async {
      // Pre-fix: '13|calls=3'. SCE81 lifts a cascade section to the whole
      // cascade and relies on its memoised target and completed-section record
      // to make re-execution safe; handing the enclosing statement back instead
      // has to keep that working.
      expect(
        await _run('''
          Future<String> f() async {
            final sb = StringBuffer();
            sb..write(await next())..write(await next());
            return sb.toString();
          }
          Future<String> main() async {
            final v = await f();
            return '\$v|calls=\$_n';
          }
        '''),
        equals('12|calls=2'),
      );
    });
  });
}
