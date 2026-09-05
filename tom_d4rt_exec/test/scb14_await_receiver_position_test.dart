import 'package:test/test.dart';

import 'interpreter_test.dart';

/// The multi-await tests below are FIXED in the working tree but cannot run
/// here yet: `tom_d4rt_exec` resolves `tom_d4rt_ast` **from pub.dev**, not by
/// path (DGUC6), so this suite certifies the *published* interpreter. The SCC40
/// fix landed after 0.40.0 and is verified green in the `tom_d4rt` suite and —
/// under a throwaway path override — in this suite too (3054/1/0). Un-skip when
/// `tom_d4rt_ast` publishes past 0.40.0.
const publishedAstGapSkip =
    'Fixed by SCC40 in the working tree; tom_d4rt_exec resolves tom_d4rt_ast '
    'from pub.dev (0.40.0), which predates the fix. Un-skip after publish.';

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
    // position"). They are kept here because they are the cheapest known
    // reproductions and they pin the exact boundary of what the receiver-slot
    // fix does and does not cover.
    //
    // Both are now FIXED by SCC40, which replaced the single per-frame
    // `lastAwaitResult` slot with a per-await-site map keyed by the
    // `AwaitExpression` node. Bug B fell out of the same change: once a
    // not-yet-reached await stopped short-circuiting to `lastAwaitResult` it
    // began reading its operand for real, which forced the resumption path to
    // restore the frame's environment — the very thing Bug B was about.
    //
    // They are nevertheless SKIPPED here, and only here: the `tom_d4rt` twin
    // runs them green. This package pins `tom_d4rt_ast` from pub.dev at 0.40.0,
    // which predates the fix — see [publishedAstGapSkip].
    // ---------------------------------------------------------------------

    // Bug A — there used to be one `lastAwaitResult` slot per async frame, and
    // every `visitAwaitExpression` read that same slot on resumption, so the
    // second and later awaits in a single statement all yielded the FIRST
    // future's value. Independent of receiver shape: F-SCB14-12 has no
    // receiver at all and still failed, on a code path the SCB14 fix never
    // touches. It was a silent wrong answer, not a crash, which is why the
    // suite stayed green around it.

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
      skip: publishedAstGapSkip,
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
      skip: publishedAstGapSkip,
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
    }, skip: publishedAstGapSkip);

    // The per-await-site map is scoped to ONE evaluation of the suspended
    // statement, and a loop body re-enters the *identical* AST node on every
    // iteration. If the map outlived the statement, iteration 2 would replay
    // iteration 1's value and the sum would be 2 instead of 3 — a silent wrong
    // answer of exactly the shape SCC40 removed. This pins the clearing.
    test('F-SCB14-13: the same await site in a loop body resolves afresh '
        'on every iteration', () async {
      final result = await executeAsync('''
        Future<int> run() async {
          var total = 0;
          for (var i = 1; i <= 2; i++) {
            total += await Future.value(i);
          }
          return total;
        }
        main() async => await run();
      ''');
      expect(result, equals(3));
    });

    // Bug B — resumption re-entered the statement in an environment that no
    // longer held the enclosing block's locals, so `out` was undefined on the
    // second pass. Tracked separately from Bug A (it is an await in ARGUMENT
    // position whose invocation target is a local) but closed by the same SCC40
    // change: restoring `visitor.environment` before re-evaluating is what the
    // per-site fix *forced*, because a not-yet-reached await now genuinely reads
    // its operand instead of short-circuiting to `lastAwaitResult`.
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
      skip: publishedAstGapSkip,
    );
  });
}
