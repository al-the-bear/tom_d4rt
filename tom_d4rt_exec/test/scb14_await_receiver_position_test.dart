import 'package:test/test.dart';

import 'interpreter_test.dart';

/// SCB14 — `await` used directly in RECEIVER position.
///
/// The suspension machinery re-enters the enclosing statement once the future
/// completes and substitutes the awaited value at the await site. These tests
/// pin that the receiver slot of a member access / index / property read is one
/// of the sites that gets rewritten — before the fix, the internal
/// `AsyncSuspensionRequest` sentinel leaked into normal evaluation and surfaced
/// as `Undefined property or method '<x>' on AsyncSuspensionRequest`.
///
/// Deliberately uses only plain `Stream` / `Future` so the repro carries no
/// bridge dependency: this is an interpreter bug, not a dart:async bridging one.
void main() {
  group('SCB14: await in receiver position', () {
    test(
      'F-SCB14-1: (await stream.toList()).join() — method call receiver',
      () async {
        final result = await executeAsync('''
        Future<String> run() async {
          final f = Stream.fromIterable([1, 2, 3]).toList();
          return (await f).join(',');
        }
        main() async => await run();
      ''');
        expect(result, equals('1,2,3'));
      },
    );

    test('F-SCB14-2: two-step spelling still works (control)', () async {
      final result = await executeAsync('''
        Future<String> run() async {
          final f = Stream.fromIterable([1, 2, 3]).toList();
          final l = await f;
          return l.join(',');
        }
        main() async => await run();
      ''');
      expect(result, equals('1,2,3'));
    });

    test('F-SCB14-3: (await f)[0] — index expression receiver', () async {
      final result = await executeAsync('''
        Future<int> run() async {
          final f = Stream.fromIterable([10, 20, 30]).toList();
          return (await f)[1];
        }
        main() async => await run();
      ''');
      expect(result, equals(20));
    });

    test('F-SCB14-4: (await f).length — property access receiver', () async {
      final result = await executeAsync('''
        Future<int> run() async {
          final f = Stream.fromIterable([1, 2, 3, 4]).toList();
          return (await f).length;
        }
        main() async => await run();
      ''');
      expect(result, equals(4));
    });

    test('F-SCB14-5: (await f).method() on an INTERPRETED class', () async {
      final result = await executeAsync('''
        class Box {
          final int v;
          Box(this.v);
          int doubled() => v * 2;
        }
        Future<int> run() async {
          final f = Future.value(Box(21));
          return (await f).doubled();
        }
        main() async => await run();
      ''');
      expect(result, equals(42));
    });

    test('F-SCB14-6: (await f).field on an INTERPRETED class', () async {
      final result = await executeAsync('''
        class Box {
          final int v;
          Box(this.v);
        }
        Future<int> run() async {
          final f = Future.value(Box(7));
          return (await f).v;
        }
        main() async => await run();
      ''');
      expect(result, equals(7));
    });

    test('F-SCB14-7: chained — (await f).map(..).toList().join()', () async {
      final result = await executeAsync('''
        Future<String> run() async {
          final f = Stream.fromIterable([1, 2, 3]).toList();
          return (await f).map((e) => e * 2).toList().join('-');
        }
        main() async => await run();
      ''');
      expect(result, equals('2-4-6'));
    });

    test('F-SCB14-8: await in receiver position inside an argument', () async {
      final result = await executeAsync('''
        Future<String> run() async {
          final f = Stream.fromIterable(['a', 'b']).toList();
          return 'x' + (await f).join('');
        }
        main() async => await run();
      ''');
      expect(result, equals('xab'));
    });

    // ---------------------------------------------------------------------
    // Below this line: two DISTINCT pre-existing bugs that this suite
    // uncovered but that are outside SCB14's scope ("await in receiver
    // position"). They are kept here — skipped — because they are the
    // cheapest known reproductions and they pin the exact boundary of what
    // the receiver-slot fix does and does not cover. Un-skip them in the
    // referenced todo, not here.
    // ---------------------------------------------------------------------

    // Bug A — one `lastAwaitResult` slot per async frame. Every
    // `visitAwaitExpression` reads the same slot on resumption, so the second
    // and later awaits in a single statement all yield the FIRST future's
    // value. Independent of receiver shape: F-SCB14-12 has no receiver at all
    // and still fails, on a code path the SCB14 fix never touches.
    // This is a silent wrong answer, not a crash — see the todo.
    const bugAskip =
        'scc40_agñg-multi-await-per-statement-single-slot: second await in a '
        'statement resolves to the first future value';

    test(
      'F-SCB14-9: two awaits in receiver position in one statement',
      () async {
        final result = await executeAsync('''
        Future<String> run() async {
          final a = Stream.fromIterable([1, 2]).toList();
          final b = Stream.fromIterable([3, 4]).toList();
          return (await a).join(',') + '|' + (await b).join(',');
        }
        main() async => await run();
      ''');
        expect(result, equals('1,2|3,4'));
      },
      skip: bugAskip,
    );

    test(
      'F-SCB14-11: two awaits via INDEX receivers in one statement',
      () async {
        final result = await executeAsync('''
        Future<String> run() async {
          final a = Stream.fromIterable([1, 2]).toList();
          final b = Stream.fromIterable([3, 4]).toList();
          return '\${(await a)[0]}|\${(await b)[0]}';
        }
        main() async => await run();
      ''');
        expect(result, equals('1|3'));
      },
      skip: bugAskip,
    );

    test('F-SCB14-12: two awaits with no receiver at all', () async {
      final result = await executeAsync('''
        Future<String> run() async {
          final a = Future.value('A');
          final b = Future.value('B');
          return (await a) + (await b);
        }
        main() async => await run();
      ''');
      expect(result, equals('AB'));
    }, skip: bugAskip);

    // Bug B — resumption re-enters the statement in an environment that no
    // longer holds the enclosing block's locals, so `out` is undefined on the
    // second pass. Distinct from Bug A: this is an await in ARGUMENT position
    // whose invocation target is a local. The error text is byte-identical
    // before and after the SCB14 fix, which is what proves it pre-existing.
    test(
      'F-SCB14-10: await in an argument whose target is a local',
      () async {
        final result = await executeAsync('''
        Future<int> run() async {
          final f = Stream.fromIterable([5, 6]).toList();
          final out = <int>[];
          out.addAll(await f);
          return (await f).length + out.length;
        }
        main() async => await run();
      ''');
        expect(result, equals(4));
      },
      skip:
          'scc41_agñg-await-in-argument-resumption-loses-local: '
          'resumption drops the enclosing block scope — "Undefined variable"',
    );
  });
}
