/// SCE223 — the interpreter no longer announces gaps that are not gaps.
///
/// Five sites claimed a feature was unsupported. Measured 2026-09-29:
///
///   * `'await' not yet supported within call arguments` (two sites) — gone
///     before this todo; nothing to do.
///   * "Resumption for simple assignment to complex LHS not implemented" — a
///     WARNING on the path that implements `o.x = await f()`: reached by all
///     three probes below, and correct. The message is now accurate.
///   * `BridgedInstance.set` — threw "not implemented" whatever the class
///     declared. It now assigns through the bridged setter, as `get` reads
///     through the getter, and a missing setter is an undefined member.
///   * `for (var i = await f(), j = 0; ...)` — GENUINELY unsupported. The throw
///     stays, stating exactly that shape and the workaround.
///
/// The probe found one more of the same kind: `await` on a non-Future
/// (`await 5`, `await null`) was refused as an error. Dart allows it and still
/// yields to the event loop; it now does both.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

import 'interpreter_test.dart';

class _Box {
  int v = 0;
}

void main() {
  group('SCE223: announced gaps', () {
    test(
      'F-SCE223-1: await into a field assigns once [2026-09-29] (PASS)',
      () async {
        expect(
          await executeAsync('''
          class O { int x = 0; }
          var calls = 0;
          Future<int> f() async { calls++; return 5; }
          Future<List> main() async { var o = O(); o.x = await f(); return [o.x, calls]; }
        '''),
          [5, 1],
        );
      },
    );

    test(
      'F-SCE223-2: await into an index assigns once [2026-09-29] (PASS)',
      () async {
        expect(
          await executeAsync('''
          var calls = 0;
          Future<int> f() async { calls++; return 5; }
          Future<List> main() async { var l = [0, 0]; l[1] = await f(); return [l, calls]; }
        '''),
          [
            [0, 5],
            1,
          ],
        );
      },
    );

    test('F-SCE223-3: the LHS index expression is evaluated once '
        '[2026-09-29] (PASS)', () async {
      // The branch re-visits the whole assignment on resumption, which is
      // what made it look risky. The awaited value is cached, so neither side
      // runs twice.
      expect(
        await executeAsync('''
          var calls = 0; var idx = 0;
          Future<int> f() async { calls++; return 5; }
          int i() { idx++; return 0; }
          Future<List> main() async { var l = [0, 0]; l[i()] = await f(); return [l, calls, idx]; }
        '''),
        [
          [5, 0],
          1,
          1,
        ],
      );
    });

    test(
      'F-SCE223-4: an awaited initializer in a multi-variable for loop is '
      'refused, and the message says exactly that [2026-09-29] (PASS)',
      () async {
        await expectLater(
          executeAsync('''
          Future<int> f() async => 3;
          Future<int> main() async { var s = 0; for (var i = await f(), j = 0; j < i; j++) { s += j; } return s; }
        '''),
          throwsA(
            isA<UnimplementedD4rtException>().having(
              (e) => e.message,
              'message',
              allOf(
                contains('more than one variable'),
                contains('Declare the awaited variable before the loop'),
              ),
            ),
          ),
        );
        // The control: the same loop with a synchronous multi-variable
        // initializer and an await in the body runs.
        expect(
          await executeAsync('''
          Future<int> main() async { var s = 0; for (var i = 3, j = 0; j < i; j++) { s += j; await Future.value(null); } return s; }
        '''),
          3,
        );
      },
    );

    test('F-SCE223-5: await accepts a non-Future, and still yields '
        '[2026-09-29] (PASS)', () async {
      expect(
        await executeAsync(
          'Future<List> main() async { return [await 5, await null]; }',
        ),
        [5, null],
      );
      // Real Dart: a microtask queued before `await 5` runs before the code
      // after it — the await suspends even though there is nothing to wait
      // for.
      expect(
        await executeAsync('''
          import 'dart:async';
          Future<List> main() async {
            var log = [];
            Future.microtask(() => log.add('microtask'));
            await 5;
            log.add('after await');
            return log;
          }
        '''),
        ['microtask', 'after await'],
      );
    });

    test('F-SCE223-6: BridgedInstance.set assigns through the setter, and a '
        'missing setter is an undefined member [2026-09-29] (PASS)', () {
      final boxClass = BridgedClass(
        nativeType: _Box,
        name: 'Box',
        setters: {
          'v': (visitor, target, value) => (target as _Box).v = value as int,
        },
      );
      final box = _Box();
      BridgedInstance(boxClass, box).set('v', 3);
      expect(box.v, 3);
      expect(
        () => BridgedInstance(boxClass, box).set('nope', 1),
        throwsA(isA<UndefinedMemberD4rtException>()),
      );
    });
  });
}
