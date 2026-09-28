// SCE19 — a `do` loop in an async body ran its condition before its body.
//
// `do { n++; } while (false);` answered 0. A `do` body always runs once, so
// Dart — and this interpreter's own synchronous visitor — answer 1.
//
// The state machine re-enters a `DoStatement` node for two different reasons:
// arriving at the loop from the statement before it, and coming back from the
// end of its body. It assumed the second every time. The comment that stood
// there said as much, and said what it would cost — "if we entered the loop in
// a non-standard way, this could fail". Arriving from the statement before the
// loop is the standard way.
//
// A loop whose condition is true on entry gave the right answer, which is why
// nothing caught it: `do { n++; } while (n < 3)` counts to 3 either way.
//
// THE SYNCHRONOUS VISITOR IS THE ORACLE. Every case is run as both an async and
// a sync `main` and the two are required to agree. Two interpreters in one
// package disagreeing about `do` is the strongest available statement that one
// of them is wrong, and it costs one extra expect per case.
//
// THE RE-ENTRY CASES ARE THE POINT of the bookkeeping. Membership of
// `doBodiesStarted` has to be forgotten when the loop is left, or a `do` nested
// in another loop would check its condition before its body on the outer loop's
// SECOND iteration — the same bug, one level in, and much harder to see.

import 'package:test/test.dart';

import 'interpreter_test.dart';

void main() {
  /// Runs [body] as both an async and a synchronous `main`.
  Future<({Object? async, Object? sync})> both(String body) async => (
    async: await executeAsync('main() async { $body }'),
    sync: await executeAsync('main() { $body }'),
  );

  group('SCE19: a do body runs before its condition', () {
    test('F-SCE19-1: a false condition still runs the body once '
        '[2026-09-18] (PASS)', () async {
      final r = await both('var n = 0; do { n++; } while (false); return n;');
      expect(r.async, equals(1));
      expect(r.sync, equals(1), reason: 'the sync oracle');
    });

    test(
      'F-SCE19-2: a true condition is unchanged [2026-09-18] (PASS)',
      () async {
        // The shape that always worked. It is here because it is the reason the
        // defect survived: if a fix broke this, the bug would simply move.
        final r = await both('var n = 0; do { n++; } while (n < 3); return n;');
        expect(r.async, equals(3));
        expect(r.sync, equals(3), reason: 'the sync oracle');
      },
    );

    test(
      'F-SCE19-3: a body that awaits still runs once [2026-09-18] (PASS)',
      () async {
        // The async-only shape: the frame suspends and resumes inside the body,
        // so the loop is re-entered through the suspension path as well.
        final result = await executeAsync(
          'main() async { var n = 0;'
          ' do { await Future.value(1); n++; } while (false);'
          ' return n; }',
        );
        expect(result, equals(1));
      },
    );

    test(
      'F-SCE19-4: nested do loops each run their body [2026-09-18] (PASS)',
      () async {
        final r = await both(
          'var log = [];'
          ' do { do { log.add("i"); } while (false); log.add("o"); }'
          ' while (false);'
          ' return log.join(",");',
        );
        expect(r.async, equals('i,o'));
        expect(r.sync, equals('i,o'), reason: 'the sync oracle');
      },
    );

    test('F-SCE19-5: an empty body leaves the condition to decide '
        '[2026-09-18] (PASS)', () async {
      // `do {} while (false)` has no first statement to jump to. Without the
      // fallback to the loop node this stops the machine and the function
      // never returns.
      final r = await both('var n = 0; do { } while (false); n++; return n;');
      expect(r.async, equals(1));
      expect(r.sync, equals(1), reason: 'the sync oracle');
    });
  });

  group('SCE19: a do loop entered more than once', () {
    test('F-SCE19-6: a do inside a for runs its body every iteration '
        '[2026-09-18] (PASS)', () async {
      // Without forgetting the started-mark on exit, iterations after the first
      // would find the loop already "started" and check the condition first —
      // giving d0 alone.
      final r = await both(
        'var log = [];'
        ' for (var i = 0; i < 3; i++) { do { log.add("d\$i"); } while (false); }'
        ' return log.join(",");',
      );
      expect(r.async, equals('d0,d1,d2'));
      expect(r.sync, equals('d0,d1,d2'), reason: 'the sync oracle');
    });

    test('F-SCE19-7: a do left by break can be entered again [2026-09-18] '
        '(PASS)', () async {
      // `break` leaves by a different route than a false condition, so it needs
      // its own cleanup — this is what fails if only the condition path forgets.
      final r = await both(
        'var log = [];'
        ' for (var i = 0; i < 2; i++) { do { log.add("d\$i"); break; }'
        ' while (true); }'
        ' return log.join(",");',
      );
      expect(r.async, equals('d0,d1'));
      expect(r.sync, equals('d0,d1'), reason: 'the sync oracle');
    });

    test(
      'F-SCE19-8: a labelled break out of a do [2026-09-18] (PASS)',
      () async {
        final r = await both(
          'var log = [];'
          ' outer: for (var i = 0; i < 3; i++) {'
          ' do { log.add("d\$i"); if (i == 1) break outer; } while (false); }'
          ' return log.join(",");',
        );
        expect(r.async, equals('d0,d1'));
        expect(r.sync, equals('d0,d1'), reason: 'the sync oracle');
      },
    );

    test('F-SCE19-9: continue in a do still evaluates the condition '
        '[2026-09-18] (PASS)', () async {
      // The case the started-mark must NOT clear. `continue` returns to the
      // loop from inside it, and Dart evaluates the condition for it; F-SCD4-13
      // pins the same rule from the jump side.
      final r = await both(
        'var n = 0; var g = 0;'
        ' do { n++; if (n == 1) continue; g++; } while (n < 2);'
        ' return "\$n:\$g";',
      );
      expect(r.async, equals('2:1'));
      expect(r.sync, equals('2:1'), reason: 'the sync oracle');
    });
  });
}
