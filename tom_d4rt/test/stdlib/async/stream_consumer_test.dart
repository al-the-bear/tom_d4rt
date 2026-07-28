import 'package:test/test.dart';
import '../../interpreter_test.dart' show executeAsync;

/// SC4 — `dart:async` `StreamConsumer`.
///
/// The audit filed this as a one-line gap ("register the abstract interface"),
/// but probing the interpreter showed the interface was only half the problem.
/// `StreamController.sink` — the one `StreamConsumer` a pure `dart:async`
/// script can actually get hold of — resolved to no bridge at all: *every*
/// member (`add`, `addError`, `close`, `done`, `addStream`) failed with
/// "Undefined property or method ... on `_StreamSinkWrapper<dynamic>`". So
/// registering `StreamConsumer` alone would have made the type nameable while
/// leaving every value of that type inert.
///
/// SC4 therefore does three things, and the tests below are grouped to match:
///   1. registers `StreamConsumer` so the name resolves,
///   2. routes `_StreamSinkWrapper` to the existing `StreamSink` bridge and
///      gives that bridge the `addStream` it inherits from `StreamConsumer`
///      in the SDK, so sink values are usable,
///   3. registers the supertype edges (`StreamController`/`StreamSink` ->
///      `StreamConsumer`) so `is StreamConsumer` answers truthfully.
///
/// Step 3 uses the supertype registry rather than an `isAssignable` closure on
/// the new bridge *deliberately*: `isAssignable` is consulted by
/// `Environment.toBridgedInstance` when choosing which bridge owns a native
/// object, and `StreamConsumer` is a supertype of both `StreamController` and
/// `StreamSink`. A `StreamConsumer` bridge that claimed assignability would
/// have entered that contest as an equally-ranked match — both bridges carry
/// `hierarchyDepth == 0`, so the tie breaks on registration order — and could
/// have silently stolen dispatch from the two concrete bridges. The registry
/// feeds `isSubtypeOf` only, so `is` learns the hierarchy while dispatch is
/// untouched.
void main() {
  group('SC4: StreamConsumer bridge', () {
    test('F-SC4-1: the StreamConsumer name resolves [2026-07-27]', () async {
      // Before SC4 this threw `Undefined variable: StreamConsumer`, which is
      // what made annotations and `is` checks unusable.
      final result = await executeAsync('''
        import 'dart:async';
        main() {
          return StreamConsumer.toString();
        }
      ''');
      expect(result, 'StreamConsumer');
    });

    test('F-SC4-2: a StreamController is a StreamConsumer [2026-07-27]',
        () async {
      final result = await executeAsync('''
        import 'dart:async';
        main() {
          final c = StreamController();
          return c is StreamConsumer;
        }
      ''');
      expect(result, isTrue);
    });

    test('F-SC4-3: a controller sink is a StreamConsumer [2026-07-27]',
        () async {
      final result = await executeAsync('''
        import 'dart:async';
        main() {
          final c = StreamController();
          return c.sink is StreamConsumer;
        }
      ''');
      expect(result, isTrue);
    });

    test('F-SC4-4: a Stream is not a StreamConsumer [2026-07-27]', () async {
      // Guards the registry edges from being over-broad: `is StreamConsumer`
      // must still discriminate, or F-SC4-2/3 would pass vacuously.
      final result = await executeAsync('''
        import 'dart:async';
        main() {
          final c = StreamController();
          return [c.stream is StreamConsumer, 'x' is StreamConsumer];
        }
      ''') as List;
      expect(result, orderedEquals([false, false]));
    });

    test('F-SC4-5: a value typed as StreamConsumer accepts addStream then close [2026-07-27]',
        () async {
      // The test the todo asks for: a parameter *annotated* StreamConsumer,
      // exercising both members the interface declares.
      final result = await executeAsync('''
        import 'dart:async';

        Future<void> feed(StreamConsumer sink, Stream source) async {
          await sink.addStream(source);
          await sink.close();
        }

        main() async {
          final c = StreamController();
          final collected = c.stream.toList();
          await feed(c.sink, Stream.fromIterable([1, 2, 3]));
          return await collected;
        }
      ''');
      expect(result, orderedEquals([1, 2, 3]));
    });

    test('F-SC4-6: addStream returns an awaitable that completes after the source drains [2026-07-27]',
        () async {
      // Pins the *ordering* contract, not just the final contents: if
      // addStream returned a non-Future (or a Future completing eagerly) the
      // marker would land before the piped events rather than after them.
      final result = await executeAsync('''
        import 'dart:async';
        main() async {
          final c = StreamController();
          final collected = c.stream.toList();
          await c.sink.addStream(Stream.fromIterable([1, 2]));
          c.sink.add(99);
          await c.sink.close();
          return await collected;
        }
      ''');
      expect(result, orderedEquals([1, 2, 99]));
    });
  });

  group('SC4: StreamSink routing for controller sinks', () {
    test('F-SC4-7: a controller sink resolves to the StreamSink bridge [2026-07-27]',
        () async {
      // `_StreamSinkWrapper` had no route to any bridge before SC4.
      final result = await executeAsync('''
        import 'dart:async';
        main() {
          final c = StreamController();
          return c.sink is StreamSink;
        }
      ''');
      expect(result, isTrue);
    });

    test('F-SC4-8: add and addError forward to the stream [2026-07-27]',
        () async {
      final result = await executeAsync('''
        import 'dart:async';
        main() async {
          final c = StreamController();
          final seen = [];
          // The unary `onError` deliberately: when SC4 was written this had to
          // be binary, because d4rt's `Stream.listen` bridge hardcoded the
          // two-argument call and the unary form the SDK also accepts threw
          // "Too many positional arguments". SCB9 fixed that, so this now
          // doubles as a second guard on the arity handling from a test that
          // is not about arity at all.
          c.stream.listen(
            (v) => seen.add('data:\$v'),
            onError: (e) => seen.add('error:\$e'),
          );
          c.sink.add(1);
          c.sink.addError(StateError('boom'));
          c.sink.add(2);
          await c.sink.close();
          await Future.delayed(Duration(milliseconds: 10));
          return seen;
        }
      ''') as List;
      expect(result.length, 3);
      expect(result[0], 'data:1');
      expect(result[1], contains('boom'));
      expect(result[2], 'data:2');
    });

    test('F-SC4-9: done completes when the sink is closed [2026-07-27]',
        () async {
      final result = await executeAsync('''
        import 'dart:async';
        main() async {
          final c = StreamController();
          c.stream.listen((_) {});
          final done = c.sink.done;
          await c.sink.close();
          await done;
          return 'done-completed';
        }
      ''');
      expect(result, 'done-completed');
    });

    test('F-SC4-10: Stream.pipe into a controller sink still works [2026-07-27]',
        () async {
      // Regression guard. `pipe` unwraps to the native object and never went
      // through the sink bridge, so it worked before SC4 — it must keep
      // working now that `_StreamSinkWrapper` resolves to StreamSink.
      final result = await executeAsync('''
        import 'dart:async';
        main() async {
          final c = StreamController();
          final collected = c.stream.toList();
          await Stream.fromIterable([1, 2]).pipe(c.sink);
          return await collected;
        }
      ''');
      expect(result, orderedEquals([1, 2]));
    });

    test('F-SC4-11: a broadcast controller sink resolves the same way [2026-07-27]',
        () async {
      // Both controller flavours hand out `_StreamSinkWrapper`, so one
      // nativeNames entry covers both — assert it rather than assume it.
      final result = await executeAsync('''
        import 'dart:async';
        main() async {
          final c = StreamController.broadcast();
          final seen = [];
          c.stream.listen((v) => seen.add(v));
          c.sink.add(1);
          await c.sink.close();
          await Future.delayed(Duration(milliseconds: 10));
          return [c.sink is StreamConsumer, seen];
        }
      ''') as List;
      expect(result[0], isTrue);
      expect(result[1], orderedEquals([1]));
    });
  });
}
