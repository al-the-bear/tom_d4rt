import 'package:test/test.dart';
import '../../interpreter_test.dart' show execute, executeAsync;

/// SC6 — the three P2 `dart:async` gaps: `StreamView`, `AsyncError` and
/// `StreamTransformerBase`.
///
/// Each of the three needed a different registration shape, and two of them
/// turned out to be blocked by interpreter gaps rather than by the missing
/// bridge — which is why this file also carries tests for behaviour that is
/// not, on its face, about `dart:async` at all.
///
/// **`StreamView`** is `class StreamView<T> extends Stream<T>`: a thin wrapper
/// whose entire value is the ~60-member `Stream` surface it inherits. Bridge
/// dispatch is per-bridge, so a `StreamView` bridge that only declared the
/// constructor left every inherited member unreachable. Rather than duplicate
/// the `Stream` surface, `'StreamView'` is listed on `StreamAsync.nativeNames`
/// (so instances dispatch to the `Stream` bridge) and the `StreamView -> Stream`
/// edge is registered so `is Stream` answers truthfully. The `StreamView`
/// bridge deliberately declares **no** `isAssignable`: it would contest
/// `Stream`'s ownership of every stream-shaped native object in
/// `Environment.toBridgedInstance`, where all hand-written bridges tie at
/// `hierarchyDepth == 0` and the winner falls out of registration order. The
/// accepted cost is that `v is StreamView` is false — see F-SC6-5.
///
/// **`AsyncError`** is concrete and final in practice, so it *can* carry an
/// `isAssignable` without shadowing a more specific bridge. Its
/// `implements Error` edge goes in the registry, which is the only thing that
/// can make `on Error catch` see one.
///
/// **`StreamTransformerBase`** exists purely to be extended. Registering it
/// exposed two interpreter gaps that had nothing to do with `dart:async`:
///   * `visitIsExpression`'s `is BridgedX` branch short-circuited every
///     `InterpretedInstance` operand to `false`, so a script class extending
///     *any* bridged class failed its own `is` test (F-SC6-8/9/10);
///   * `InterpretedClass.isSubtypeOf` walked `bridgedSuperclass` and
///     `bridgedMixins` but not `bridgedInterfaces`, so `implements SomeBridge`
///     was not a subtype edge at all (F-SC6-11).
/// Both fixes are generic; the `dart:async` tests here are the cheapest way to
/// pin them.
void main() {
  group('SC6: StreamView bridge', () {
    test('F-SC6-1: StreamView constructs from a stream [2026-07-27]', () {
      final result = execute('''
        import 'dart:async';
        main() {
          final c = StreamController<int>();
          final v = StreamView<int>(c.stream);
          return v != null;
        }
      ''');
      expect(result, isTrue);
    });

    test('F-SC6-2: a StreamView is a Stream [2026-07-27]', () {
      final result = execute('''
        import 'dart:async';
        main() {
          final c = StreamController<int>();
          return StreamView<int>(c.stream) is Stream;
        }
      ''');
      expect(result, isTrue);
    });

    test(
      'F-SC6-3: inherited Stream methods dispatch on a StreamView [2026-07-27]',
      () async {
        // The point of the whole registration: before SC6 this failed with
        // "Bridged class 'StreamView' has no instance method named 'toList'".
        final result = await executeAsync('''
        import 'dart:async';
        main() async {
          final c = StreamController<int>();
          final v = StreamView<int>(c.stream);
          final f = v.map((e) => e * 10).where((e) => e > 10).toList();
          c.add(1); c.add(2); await c.close();
          final l = await f;
          return l.join(',');
        }
      ''');
        expect(result, '20');
      },
    );

    test(
      'F-SC6-4: inherited Stream getters and listen work on a StreamView [2026-07-27]',
      () async {
        final result = await executeAsync('''
        import 'dart:async';
        main() async {
          final c = StreamController<int>();
          final v = StreamView<int>(c.stream);
          final seen = <int>[];
          final sub = v.listen((e) => seen.add(e));
          c.add(1); c.add(2); c.add(3); await c.close();
          await sub.cancel();
          return seen.length;
        }
      ''');
        expect(result, 3);
      },
    );

    test(
      'F-SC6-5: is StreamView still discriminates despite Stream dispatch [2026-07-27]',
      () {
        // Routing StreamView instances to the `Stream` bridge for dispatch could
        // plausibly have cost `is StreamView` — the operand's bridge is `Stream`,
        // and `Stream` is not a subtype of `StreamView`. It does not, because
        // `visitIsExpression` falls back to resolving the *native* object's
        // runtime type (the SC4 fallback), which finds the `StreamView` bridge by
        // name. Pinned in both directions so a change to either the dispatch
        // routing or that fallback shows up here.
        final result =
            execute('''
        import 'dart:async';
        main() {
          final c = StreamController<int>();
          final v = StreamView<int>(c.stream);
          return [v is StreamView, c.stream is StreamView];
        }
      ''')
                as List;
        expect(result, orderedEquals([true, false]));
      },
    );

    test('F-SC6-6: StreamView rejects a non-stream argument [2026-07-27]', () {
      final result = execute('''
        import 'dart:async';
        main() {
          try { StreamView<int>(42); } catch (e) { return 'threw'; }
          return 'accepted';
        }
      ''');
      expect(result, 'threw');
    });
  });

  group('SC6: AsyncError bridge', () {
    test('F-SC6-7: AsyncError exposes error and stackTrace [2026-07-27]', () {
      final result =
          execute('''
        import 'dart:async';
        main() {
          final e = AsyncError('boom', StackTrace.current);
          return [e.error, e.stackTrace != null];
        }
      ''')
              as List;
      expect(result, orderedEquals(['boom', true]));
    });

    test('F-SC6-8: AsyncError accepts the one-argument form [2026-07-27]', () {
      // The SDK's second parameter is required-but-nullable and it supplies a
      // `defaultStackTrace` fallback, so `AsyncError(e)` is the idiomatic
      // spelling. Forcing an explicit null would be gratuitous.
      final result = execute('''
        import 'dart:async';
        main() => AsyncError('boom').error;
      ''');
      expect(result, 'boom');
    });

    test('F-SC6-9: AsyncError.defaultStackTrace is callable [2026-07-27]', () {
      final result = execute('''
        import 'dart:async';
        main() => AsyncError.defaultStackTrace('x') != null;
      ''');
      expect(result, isTrue);
    });

    test('F-SC6-10: an AsyncError is an Error [2026-07-27]', () {
      final result =
          execute('''
        import 'dart:async';
        main() {
          final e = AsyncError('boom', StackTrace.current);
          return [e is Error, e is String];
        }
      ''')
              as List;
      expect(result, orderedEquals([true, false]));
    });

    test(
      'F-SC6-11: a thrown AsyncError is caught by on AsyncError [2026-07-27]',
      () {
        final result = execute('''
        import 'dart:async';
        main() {
          try { throw AsyncError('boom', StackTrace.current); }
          on AsyncError catch (e) { return 'async:\${e.error}'; }
          catch (e) { return 'missed'; }
        }
      ''');
        expect(result, 'async:boom');
      },
    );

    test('F-SC6-12: a thrown AsyncError is caught by on Error [2026-07-27]', () {
      // Exercises the registry edge specifically: `on Error` only sees an
      // AsyncError because of `registerSupertypes({'AsyncError': ['Error']})`.
      final result = execute('''
        import 'dart:async';
        main() {
          try { throw AsyncError('boom', StackTrace.current); }
          on Error catch (e) { return 'error-branch'; }
          catch (e) { return 'missed'; }
        }
      ''');
      expect(result, 'error-branch');
    });
  });

  group('SC6: StreamTransformerBase bridge', () {
    const doubler = '''
      import 'dart:async';
      class Doubler extends StreamTransformerBase<int, int> {
        Stream<int> bind(Stream<int> s) => s.map((e) => e * 2);
      }
    ''';

    test(
      'F-SC6-13: a script class can extend StreamTransformerBase [2026-07-27]',
      () async {
        final result = await executeAsync('''$doubler
        main() async {
          final c = StreamController<int>();
          final f = Doubler().bind(c.stream).toList();
          c.add(1); c.add(2); await c.close();
          final l = await f;
          return l.join(',');
        }
      ''');
        expect(result, '2,4');
      },
    );

    test(
      'F-SC6-14: a StreamTransformerBase subclass is a StreamTransformerBase [2026-07-27]',
      () async {
        // Generic interpreter fix: `is BridgedX` used to be hard-false for every
        // interpreted operand, so a class failed the `is` test against its own
        // declared bridged superclass.
        final result = await executeAsync('''$doubler
        main() => Doubler() is StreamTransformerBase;
      ''');
        expect(result, isTrue);
      },
    );

    test(
      'F-SC6-15: a StreamTransformerBase subclass is a StreamTransformer [2026-07-27]',
      () async {
        // The transitive step, via `registerSupertypes`.
        final result = await executeAsync('''$doubler
        main() => Doubler() is StreamTransformer;
      ''');
        expect(result, isTrue);
      },
    );

    test(
      'F-SC6-16: an unrelated script class is not a StreamTransformer [2026-07-27]',
      () async {
        // Guards the two tests above from passing vacuously.
        final result =
            await executeAsync('''
        import 'dart:async';
        class Plain {}
        main() => [Plain() is StreamTransformer, Plain() is StreamTransformerBase];
      ''')
                as List;
        expect(result, orderedEquals([false, false]));
      },
    );

    test(
      'F-SC6-17: Stream.transform accepts a StreamTransformerBase subclass [2026-07-27]',
      () async {
        // An interpreted transformer has no native object at all, so the
        // `transform` adapter wraps its `bind` in `StreamTransformer.fromBind`.
        final result = await executeAsync('''$doubler
        main() async {
          final c = StreamController<int>();
          final f = c.stream.transform(Doubler()).toList();
          c.add(1); c.add(2); await c.close();
          final l = await f;
          return l.join(',');
        }
      ''');
        expect(result, '2,4');
      },
    );

    test(
      'F-SC6-18: Stream.transform accepts a class that implements StreamTransformer [2026-07-27]',
      () async {
        // `implements` reaches the same adapter, and additionally pins the
        // `bridgedInterfaces` subtype edge added in `InterpretedClass`.
        final result =
            await executeAsync('''
        import 'dart:async';
        class Plus100 implements StreamTransformer<int, int> {
          Stream<int> bind(Stream<int> s) => s.map((e) => e + 100);
        }
        main() async {
          final c = StreamController<int>();
          final f = c.stream.transform(Plus100()).toList();
          c.add(1); c.add(2); await c.close();
          final l = await f;
          return [l.join(','), Plus100() is StreamTransformer];
        }
      ''')
                as List;
        expect(result, orderedEquals(['101,102', true]));
      },
    );

    test(
      'F-SC6-19: Stream.transform still accepts a native transformer [2026-07-27]',
      () async {
        // Regression guard: broadening `transform` must not lose the shape it
        // already handled.
        final result = await executeAsync('''
        import 'dart:async';
        main() async {
          final c = StreamController<int>();
          final t = StreamTransformer<int, int>.fromBind((s) => s.map((e) => e * 3));
          final f = c.stream.transform(t).toList();
          c.add(1); c.add(2); await c.close();
          final l = await f;
          return l.join(',');
        }
      ''');
        expect(result, '3,6');
      },
    );

    test(
      'F-SC6-20: Stream.transform rejects a non-transformer [2026-07-27]',
      () async {
        final result = await executeAsync('''
        import 'dart:async';
        main() async {
          final c = StreamController<int>();
          try { c.stream.transform(42); } catch (e) { return 'threw'; }
          return 'accepted';
        }
      ''');
        expect(result, 'threw');
      },
    );
  });
}
