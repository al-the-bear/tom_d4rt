// SCE102 — an empty loop body inside `async` returns control to the loop.
//
// The async state machine dispatches into a loop body by taking the body's
// FIRST STATEMENT:
//
//     currentNode = (node.body as Block).statements.firstOrNull;
//     currentState.nextStateIdentifier = currentNode;
//     continue;
//
// For `{}` that is null, and the machine's own loop is `while (currentNode !=
// null)`, so the function ENDS THERE. Not the loop — the function. Everything
// after it is skipped and the declared return value never happens.
//
// THE RETURN VALUE IS THE SERIOUS PART. A loop that does nothing, doing
// nothing, is invisible. A function that silently returns the wrong thing is
// not: the caller gets it, and the failure surfaces wherever that value is
// finally used, with nothing pointing back at the empty body that caused it.
// Measured before the fix, in an `async` function:
//
//     | loop                                   | returned | expected |
//     | -------------------------------------- | -------- | -------- |
//     | `for (final x in [1, 2]) {}`           | null     | 'ran'    |
//     | `for (var i = 0; i < 2; i++) {}`       | TRUE     | 'ran'    |
//     | `await for (final x in aStream) {}`    | TRUE     | 'ran'    |
//     | `while (i++ < 1) {}`                   | null     | 'ran'    |
//     | `do {} while (false);`                 | 'ran'    | 'ran'    |
//
// The returned value is whatever `lastResult` happened to hold — null for the
// for-in forms, the CONDITION for the two that had just evaluated one. Three
// different wrong answers from one cause, which is why the table is pinned
// rather than a single case: a reader who met only the `true` would look for a
// condition bug.
//
// THE DO-WHILE ROW IS WHY THE FIX LOOKS THE WAY IT DOES. SCE19 met this at the
// do-while entry and solved it there — `currentNode ??= doNode`, fall back to
// the loop itself and let the condition decide. That is the pattern, and it was
// already in the file; the remaining five sites did not have it. The C-style
// `for` is the instructive one: it had the intent (`nextStateIdentifier =
// forNode` under a comment explaining the empty-body case) but never assigned
// `currentNode`, so the machine's own `while` still saw null and exited. Half a
// fix reads exactly like a whole one at the call site.
//
// ABLATED, by deleting the five `currentNode ??= <loopNode>` fallbacks and the
// C-style assignment: `+4 -7` here and `+1 -3` in the ast mirror. The four that
// survive are the controls — do-while, non-empty bodies, the sync path, and the
// loops whose body never runs — and they are the reason this is a fix rather
// than "make empty loops disappear", which would satisfy every other case.
//
// THE SYNC PATH WAS NEVER AFFECTED — it does not use the state machine at all —
// which is what makes the async/sync pair below a discriminator rather than
// decoration.

import 'dart:async';

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// Runs [source] and returns its value, resolving the future an `async` `main`
/// produces and catching the asynchronous errors a state-machine defect throws
/// outside the call stack.
Future<Object?> run(String source) {
  final done = Completer<Object?>();
  runZonedGuarded(
    () async {
      var value = D4rt().execute(source: source);
      if (value is Future) value = await value;
      if (!done.isCompleted) done.complete(value);
    },
    (error, _) {
      if (!done.isCompleted) done.complete('THREW: $error');
    },
  );
  return done.future.timeout(
    const Duration(seconds: 10),
    onTimeout: () => 'TIMEOUT',
  );
}

void main() {
  group('SCE102: an empty loop body does not end the function', () {
    test('F-SCE102-1: for-in with an empty body [2026-09-22] (PASS)', () async {
      expect(
        await run("main() async { for (final x in [1, 2]) {} return 'ran'; }"),
        'ran',
      );
      // The statements after the loop, not just the return: the defect skipped
      // those too, so a fix that only repaired the return value would pass the
      // case above and still lose the assignment.
      expect(
        await run(
          'main() async { var n = 0; for (final x in [1, 2]) {} '
          'n = 9; return n; }',
        ),
        9,
      );
    });

    test(
      'F-SCE102-2: C-style for with an empty body [2026-09-22] (PASS)',
      () async {
        expect(
          await run(
            "main() async { for (var i = 0; i < 2; i++) {} "
            "return 'ran'; }",
          ),
          'ran',
        );
      },
    );

    test(
      'F-SCE102-3: await-for with an empty body [2026-09-22] (PASS)',
      () async {
        expect(
          await run(
            'main() async { '
            'await for (final x in Stream.fromIterable([1, 2])) {} '
            "return 'ran'; }",
          ),
          'ran',
        );
      },
    );

    test('F-SCE102-4: while with an empty body [2026-09-22] (PASS)', () async {
      expect(
        await run(
          "main() async { var i = 0; while (i++ < 2) {} return 'ran'; }",
        ),
        'ran',
      );
    });

    test('F-SCE102-5 (control): do-while with an empty body [2026-09-22] '
        '(PASS)', () async {
      // Already correct before this change — SCE19 fixed the do-while entry.
      // It is the shape the other five are being made to match, so it is
      // pinned here to catch a fix that repairs them by breaking it.
      expect(
        await run("main() async { do {} while (false); return 'ran'; }"),
        'ran',
      );
    });

    // ---- the loop must ITERATE, not merely terminate -----------------------
    //
    // Every case above is satisfied by a fix that treats an empty body as
    // "skip the loop entirely". These say the iterations still happen.

    test(
      'F-SCE102-6: the loop still runs every iteration [2026-09-22] (PASS)',
      () async {
        // `map` is lazy, so the counter advances once per `moveNext` — which is
        // the only way to observe iteration from a body that does nothing.
        expect(
          await run(
            'main() async { var n = 0; '
            'for (final x in [1, 2, 3].map((e) { n++; return e; })) {} '
            'return n; }',
          ),
          3,
        );
        expect(
          await run(
            'main() async { var i = 0; for (i = 0; i < 3; i++) {} '
            'return i; }',
          ),
          3,
        );
        expect(
          await run(
            'main() async { var i = 0; while (i < 3) { i++; } '
            'return i; }',
          ),
          3,
        );
      },
    );

    test('F-SCE102-7: an empty await-for still drains the stream '
        '[2026-09-22] (PASS)', () async {
      expect(
        await run(
          'main() async { var n = 0; '
          'await for (final x in Stream.fromIterable([1, 2, 3])'
          '.map((e) { n++; return e; })) {} '
          'return n; }',
        ),
        3,
      );
    });

    // ---- the discriminators ------------------------------------------------

    test('F-SCE102-8 (control): a NON-empty body was always correct '
        '[2026-09-22] (PASS)', () async {
      // The whole defect is the empty-block dispatch, so these must keep
      // passing; a fix that reroutes every body through the loop node would
      // break them.
      expect(
        await run(
          "main() async { for (final x in [1, 2]) { 1; } "
          "return 'ran'; }",
        ),
        'ran',
      );
      expect(
        await run(
          "main() async { for (var i = 0; i < 2; i++) { 1; } "
          "return 'ran'; }",
        ),
        'ran',
      );
      expect(
        await run(
          'main() async { '
          'await for (final x in Stream.fromIterable([1])) { 1; } '
          "return 'ran'; }",
        ),
        'ran',
      );
    });

    test('F-SCE102-9 (control): the synchronous path is unaffected '
        '[2026-09-22] (PASS)', () async {
      // Not the state machine at all. If one of these ever fails, the fix has
      // reached code it has no business in.
      expect(
        await run("main() { for (final x in [1, 2]) {} return 'ran'; }"),
        'ran',
      );
      expect(
        await run("main() { for (var i = 0; i < 2; i++) {} return 'ran'; }"),
        'ran',
      );
      expect(
        await run("main() { var i = 0; while (i++ < 2) {} return 'ran'; }"),
        'ran',
      );
    });

    test('F-SCE102-10 (control): a loop whose body never runs [2026-09-22] '
        '(PASS)', () async {
      // These were already correct, because the body is never dispatched into.
      // They separate "the empty BODY is mishandled" from "the empty LOOP is",
      // which is the distinction that says where the fix belongs.
      expect(
        await run("main() async { for (final x in []) {} return 'ran'; }"),
        'ran',
      );
      expect(
        await run("main() async { while (false) {} return 'ran'; }"),
        'ran',
      );
    });

    test('F-SCE102-11: nested empty bodies [2026-09-22] (PASS)', () async {
      // The inner loop returns control to the OUTER body, not to the function.
      expect(
        await run(
          'main() async { for (final x in [1, 2]) '
          "{ for (final y in [3]) {} } return 'ran'; }",
        ),
        'ran',
      );
      expect(
        await run(
          "main() async { for (final x in [1]) {} "
          "await Future.value(1); return 'ran'; }",
        ),
        'ran',
      );
    });
  });
}
