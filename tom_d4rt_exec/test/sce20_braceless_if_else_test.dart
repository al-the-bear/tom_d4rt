// SCE20 — a single-statement `then` branch with an `else`, in an async body.
//
//   var x = 0; var c = true;
//   if (c) x = 1; else x = 2;
//   return x + 10;            // answered 1, not 11
//
// `_findNextSequentialNode` returned null for the end of a braceless `then`
// whenever an `else` was present, reasoning that "there is no next sequential
// node after the then if there is an else". There is: the `else` is the branch
// NOT taken, and control resumes after the if — which is exactly what the
// neighbouring `else` case had always returned. Null stopped the state machine,
// so the function completed with the last value it happened to evaluate.
//
// WHY IT SURVIVED. Braced branches end at the block-end case instead, which
// never had this, and almost all Dart is braced. Only the braceless form with
// an else reached it.
//
// IN A LOOP IT WAS WORSE THAN A WRONG VALUE. The loop never advanced and the
// function answered null — F-SCE20-4.
//
// THE SYNCHRONOUS VISITOR IS THE ORACLE. Every case that can be written without
// `await` runs as both an async and a sync `main` and the two must agree. Two
// interpreters in one package disagreeing about `if` is the strongest available
// statement that one of them is wrong.

import 'package:test/test.dart';

import 'interpreter_test.dart';

void main() {
  /// Runs [body] as both an async and a synchronous `main`.
  Future<({Object? async, Object? sync})> both(String body) async => (
    async: await executeAsync('main() async { $body }'),
    sync: await executeAsync('main() { $body }'),
  );

  group('SCE20: a braceless then with an else continues after the if', () {
    test('F-SCE20-1: the then branch is taken [2026-09-18] (PASS)', () async {
      final r = await both(
        'var x = 0; var c = true; if (c) x = 1; else x = 2; return x + 10;',
      );
      expect(r.async, equals(11));
      expect(r.sync, equals(11), reason: 'the sync oracle');
    });

    test('F-SCE20-2: the else branch is taken [2026-09-18] (PASS)', () async {
      // Always worked — the else case returned the node after the if. It is
      // here because it is the half that was RIGHT, and the fix makes the two
      // halves identical; if a later change breaks them apart again, this says
      // which one moved.
      final r = await both(
        'var x = 0; var c = false; if (c) x = 1; else x = 2; return x + 10;',
      );
      expect(r.async, equals(12));
      expect(r.sync, equals(12), reason: 'the sync oracle');
    });

    test(
      'F-SCE20-3: braced branches are unaffected [2026-09-18] (PASS)',
      () async {
        // The shape that hid the defect: a braced then ends at the block-end
        // case, not at this one.
        final r = await both(
          'var x = 0; var c = true;'
          ' if (c) { x = 1; } else { x = 2; }'
          ' return x + 10;',
        );
        expect(r.async, equals(11));
        expect(r.sync, equals(11), reason: 'the sync oracle');
      },
    );

    test('F-SCE20-4: a braceless if/else in a loop body returns to the loop '
        '[2026-09-18] (PASS)', () async {
      // The DONE WHEN's second clause, and the case where a wrong value became
      // no value: the loop never advanced and the function answered null.
      final r = await both(
        'var log = [];'
        ' for (var i = 0; i < 3; i++) {'
        ' if (i == 1) log.add("a"); else log.add("b"); }'
        ' return log.join(",");',
      );
      expect(r.async, equals('b,a,b'));
      expect(r.sync, equals('b,a,b'), reason: 'the sync oracle');
    });

    test('F-SCE20-5: nested braceless if/else [2026-09-18] (PASS)', () async {
      // The inner `else` binds to the inner `if` (Dart's dangling-else rule),
      // so the outer else is not taken and `end` must still run.
      final r = await both(
        'var log = []; var c = true;'
        ' if (c) if (c) log.add("i"); else log.add("j"); else log.add("k");'
        ' log.add("end");'
        ' return log.join(",");',
      );
      expect(r.async, equals('i,end'));
      expect(r.sync, equals('i,end'), reason: 'the sync oracle');
    });

    test('F-SCE20-6: a braceless else-if chain [2026-09-18] (PASS)', () async {
      final r = await both(
        'var x = 0; var c = false;'
        ' if (c) x = 1; else if (!c) x = 2; else x = 3;'
        ' return x + 10;',
      );
      expect(r.async, equals(12));
      expect(r.sync, equals(12), reason: 'the sync oracle');
    });
  });

  group('SCE20: the same with awaits, which only the async body can have', () {
    test('F-SCE20-7: an await after the if [2026-09-18] (PASS)', () async {
      // The suspension resumes into the statement AFTER the if, which is the
      // node this case computes.
      final result = await executeAsync(
        'main() async { var x = 0; var c = true;'
        ' if (c) x = 1; else x = 2;'
        ' await Future.value(0);'
        ' return x + 10; }',
      );
      expect(result, equals(11));
    });

    test(
      'F-SCE20-8: the then branch IS the await [2026-09-18] (PASS)',
      () async {
        // The branch suspends, and its resumption has to find its way out of a
        // braceless then that has an else.
        final result = await executeAsync(
          'main() async { var x = 0; var c = true;'
          ' if (c) x = await Future.value(1); else x = 2;'
          ' return x + 10; }',
        );
        expect(result, equals(11));
      },
    );

    test('F-SCE20-9: an await in a braceless branch inside a loop '
        '[2026-09-18] (PASS)', () async {
      final result = await executeAsync(
        'main() async { var log = [];'
        ' for (var i = 0; i < 2; i++) {'
        ' if (i == 0) log.add(await Future.value("a")); else log.add("b"); }'
        ' return log.join(","); }',
      );
      expect(result, equals('a,b'));
    });
  });
}
