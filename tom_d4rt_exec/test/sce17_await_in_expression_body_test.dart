// SCE17 — an `await` inside an expression-bodied async function.
//
// `Future<int> a() async => 2; main() async => "x${await a()}y";` returned `2`.
// Not a crash: a silent wrong answer, in one of the commonest shapes of async
// Dart, where the whole expression collapsed to the value that was awaited.
//
// WHAT IT ACTUALLY WAS. The todo that opened this called it a string-
// interpolation bug, because that is the shape it was found in. It is not:
// measured here, `=> (await a()) + 10` returned 2 rather than 12 and
// `=> "x" + (await a()).toString()` returned 2 rather than "x2". Interpolation
// was one instance of "any composite expression".
//
// And the discriminator is the BODY, not the expression. A block body never had
// it — `return "x${await a()}y";` is a ReturnStatement, and SCC40 already
// re-runs a suspended statement with per-site replay from
// `resolvedAwaitResults`. An expression body has no statement, so nothing
// re-ran: `_determineNextNodeAfterAwait` recognised no case, returned null, the
// machine stopped, and the function completed with `lastAwaitResult`.
//
// The fix re-uses SCC40 rather than adding a case per expression kind: an
// expression body is the only other unit the machine executes, so it is handed
// back and evaluated again — resolved sites replay, the first unresolved one
// suspends, and the pass where nothing suspends yields the value.
//
// The block-body cases are here deliberately even though they passed before.
// They are what makes the diagnosis above falsifiable: if a later change breaks
// the two routes together, these say the cause is shared, and if it breaks only
// one, they say which.

import 'package:test/test.dart';

import 'interpreter_test.dart';

void main() {
  const futures = 'Future<int> a() async => 2; Future<int> b() async => 3;';

  group('SCE17: await inside an expression-bodied async function', () {
    test('F-SCE17-1: interpolation keeps the surrounding string '
        '[2026-09-18] (PASS)', () async {
      expect(
        await executeAsync('$futures main() async => "x\${await a()}y";'),
        equals('x2y'),
      );
    });

    test('F-SCE17-2: two awaits in one interpolation each keep their place '
        '[2026-09-18] (PASS)', () async {
      // The multi-site case. A single `lastAwaitResult` slot cannot express
      // this — it is what SCC40's per-site map exists for — so this fails
      // differently from F-SCE17-1 if the replay regresses to one value.
      expect(
        await executeAsync(
          '$futures main() async => "\${await a()}|\${await b()}";',
        ),
        equals('2|3'),
      );
    });

    test(
      'F-SCE17-3: an await in an arithmetic expression [2026-09-18] (PASS)',
      () async {
        // Not a string in sight: the defect was never about interpolation.
        expect(
          await executeAsync('$futures main() async => (await a()) + 10;'),
          equals(12),
        );
      },
    );

    test(
      'F-SCE17-4: an await in a concatenation [2026-09-18] (PASS)',
      () async {
        expect(
          await executeAsync(
            '$futures main() async => "x" + (await a()).toString();',
          ),
          equals('x2'),
        );
      },
    );

    test('F-SCE17-5: the body IS the await — still the whole expression '
        '[2026-09-18] (PASS)', () async {
      // This answered correctly before the fix, by accident: the machine
      // stopped and the awaited value happened to be the entire expression. It
      // now takes the same route as every other shape, so it is worth pinning
      // that the route did not break the easy case.
      expect(
        await executeAsync('$futures main() async => await a();'),
        equals(2),
      );
    });

    test('F-SCE17-6: an expression-bodied async function called from a block '
        '[2026-09-18] (PASS)', () async {
      // The defect is in the callee, not in `main`. Reaching it through an
      // await in a block body proves the repair travels with the function
      // rather than with the top-level frame.
      expect(
        await executeAsync(
          '$futures Future<String> f() async => "x\${await a()}y";'
          ' main() async { return await f(); }',
        ),
        equals('x2y'),
      );
    });

    test('F-SCE17-7: an expression body with no await is untouched '
        '[2026-09-18] (PASS)', () async {
      expect(
        await executeAsync('$futures main() async => "x\${1 + 1}y";'),
        equals('x2y'),
      );
    });
  });

  group('SCE17: the same shapes in a block body, which always worked', () {
    test('F-SCE17-8: return with interpolation [2026-09-18] (PASS)', () async {
      expect(
        await executeAsync(
          '$futures main() async { return "x\${await a()}y"; }',
        ),
        equals('x2y'),
      );
    });

    test(
      'F-SCE17-9: variable initialiser with two awaits [2026-09-18] (PASS)',
      () async {
        expect(
          await executeAsync(
            '$futures main() async { var s = "\${await a()}|\${await b()}";'
            ' return s; }',
          ),
          equals('2|3'),
        );
      },
    );

    test('F-SCE17-10: an await in an argument [2026-09-18] (PASS)', () async {
      expect(
        await executeAsync(
          '$futures String w(String s) => s + "!";'
          ' main() async { return w("x\${await a()}y"); }',
        ),
        equals('x2y!'),
      );
    });
  });
}
