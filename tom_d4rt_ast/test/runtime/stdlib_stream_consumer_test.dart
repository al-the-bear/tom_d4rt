import 'dart:async';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';
// `AsyncStreamStdlib` — like every other stdlib registrar — is deliberately not
// re-exported from `runtime.dart`; `dart:async` is registered lazily by
// `ast_module_loader.dart` when a script imports it. Driving that path from a
// unit test would mean building a parsed AST module, so we reach for the
// same-package registrar directly instead of widening the published API.
import 'package:tom_d4rt_ast/src/runtime/stdlib/async/stream.dart';

/// SC4 mirror coverage for `tom_d4rt_ast`.
///
/// Registration-level rather than script-level: the script-level equivalents
/// live in `tom_d4rt/test/stdlib/async/stream_consumer_test.dart`, and
/// `tom_d4rt_exec` (the runner that could execute a script against *this* tree)
/// resolves `tom_d4rt_ast` from pub.dev rather than by path, so it cannot see
/// unpublished local edits.
///
/// What we can pin here is the three things SC4 changed, all of which are
/// observable without an interpreter: the new bridge exists with the interface
/// surface, the `StreamSink` bridge learned to claim `_StreamSinkWrapper` and
/// grew `addStream`, and the supertype edges that teach `isSubtypeOf` the sink
/// hierarchy are registered.
///
/// Tear-down note: several tests below need a `StreamController` only for the
/// objects it hands out (`.sink`, `.stream`) and never listen to it. For a
/// single-subscription controller that was never listened to, `close()` returns
/// a future that **never completes** — the SDK holds it open until the stream is
/// drained. `addTearDown(controller.close)` therefore hands the harness a
/// permanently-pending future and the test dies on the 30-second timeout rather
/// than on its assertions. Use [_disposer], which starts the close but does not
/// make the tear-down wait for it.
Future<void> Function() _disposer(StreamController<Object?> controller) =>
    () async => unawaited(controller.close());

void main() {
  late Environment env;
  late InterpreterVisitor visitor;

  setUp(() {
    env = Environment();
    AsyncStreamStdlib.register(env);
    // Method adapters take a non-nullable visitor (only getters accept `null`).
    // None of the members exercised here resolves a name or loads a module, so
    // an empty loader is enough.
    visitor = InterpreterVisitor(
      globalEnvironment: env,
      moduleContext: AstModuleLoader(
        modules: const {},
        globalEnvironment: env,
        runner: D4rtRunner(),
      ),
    );
  });

  group('SC4: StreamConsumer async bridge', () {
    test('F-SC4-AST-1: is registered under the name StreamConsumer [2026-07-27]',
        () {
      final bridge = env.findBridgedClassByName('StreamConsumer');
      expect(bridge, isNotNull);
      expect(bridge!.nativeType, StreamConsumer);
      expect(bridge.typeParameterCount, 1);
    });

    test('F-SC4-AST-2: exposes exactly the two interface members [2026-07-27]',
        () {
      final bridge = env.findBridgedClassByName('StreamConsumer')!;
      expect(bridge.methods.keys, containsAll(<String>['addStream', 'close']));
      // Abstract interface — scripts receive one, they never build one.
      expect(bridge.constructors, isEmpty);
    });

    test('F-SC4-AST-3: declares no isAssignable, so dispatch is untouched [2026-07-27]',
        () {
      // Load-bearing, not incidental. `Environment.toBridgedInstance` picks a
      // bridge by iterating `isAssignable`, and StreamConsumer is a supertype
      // of both StreamController and StreamSink — a predicate here would enter
      // this bridge into that contest as an equally-ranked match (every
      // hand-written stdlib bridge has `hierarchyDepth == 0`, so the tie breaks
      // on registration order) and could steal dispatch from the concrete
      // bridges. The hierarchy is expressed through the supertype registry
      // instead; see F-SC4-AST-6.
      expect(env.findBridgedClassByName('StreamConsumer')!.isAssignable, isNull);
    });

    test('F-SC4-AST-4: addStream forwards to the native consumer [2026-07-27]',
        () async {
      final bridge = env.findBridgedClassByName('StreamConsumer')!;
      final controller = StreamController<int>();
      final collected = controller.stream.toList();

      final added = bridge.methods['addStream']!(
          visitor, controller, [Stream.fromIterable([1, 2, 3])], {}, []);
      await (added as Future);
      await (bridge.methods['close']!(visitor, controller, [], {}, [])
          as Future);

      expect(await collected, orderedEquals([1, 2, 3]));
    });

    test('F-SC4-AST-5: addStream rejects a non-Stream argument [2026-07-27]',
        () {
      final bridge = env.findBridgedClassByName('StreamConsumer')!;
      final controller = StreamController<int>();
      addTearDown(_disposer(controller));
      expect(
        () => bridge.methods['addStream']!(visitor, controller, [42], {}, []),
        throwsA(isA<RuntimeD4rtException>()),
      );
    });
  });

  group('SC4: StreamSink routing and supertype edges', () {
    test('F-SC4-AST-6: the sink hierarchy is registered for isSubtypeOf [2026-07-27]',
        () {
      // These edges are what makes `x is StreamConsumer` answer truthfully.
      expect(
        BridgedClass.transitiveSupertypeNames('StreamSink'),
        containsAll(<String>['EventSink', 'StreamConsumer']),
      );
      expect(
        BridgedClass.transitiveSupertypeNames('StreamController'),
        containsAll(<String>['StreamSink', 'EventSink', 'StreamConsumer']),
      );
    });

    test('F-SC4-AST-7: StreamSink claims the controller sink wrapper [2026-07-27]',
        () {
      // `StreamController.sink` returns a `_StreamSinkWrapper`, which reached
      // no bridge at all before SC4 — every member, `close()` included, failed
      // as "undefined property or method".
      final bridge = env.findBridgedClassByName('StreamSink')!;
      expect(bridge.nativeNames, contains('_StreamSinkWrapper'));
    });

    test('F-SC4-AST-8: StreamSink exposes the inherited addStream [2026-07-27]',
        () {
      // Dispatch is per-bridge rather than hierarchical, so a member the SDK
      // inherits from StreamConsumer has to be repeated on the concrete bridge
      // or it is unreachable on the type scripts actually hold.
      final bridge = env.findBridgedClassByName('StreamSink')!;
      expect(
        bridge.methods.keys,
        containsAll(<String>['add', 'addError', 'close', 'addStream']),
      );
      expect(bridge.getters.keys, contains('done'));
    });

    test('F-SC4-AST-9: a sink resolves to StreamSink, and that bridge is a StreamConsumer [2026-07-27]',
        () {
      // The end-to-end shape of the `is` fix, minus the interpreter: the
      // wrapper resolves to StreamSink, and StreamSink reports itself a
      // subtype of StreamConsumer.
      final controller = StreamController<int>();
      addTearDown(_disposer(controller));
      final resolved = env.getRuntimeType(controller.sink);
      expect(resolved, isA<BridgedClass>());
      expect((resolved as BridgedClass).name, 'StreamSink');
      expect(
        resolved.isSubtypeOf(env.findBridgedClassByName('StreamConsumer')!),
        isTrue,
      );
    });

    test('F-SC4-AST-10: a Stream is not a StreamConsumer [2026-07-27]', () {
      // Guards the edges from being over-broad — otherwise F-SC4-AST-9 would
      // pass vacuously.
      final controller = StreamController<int>();
      addTearDown(_disposer(controller));
      final resolved = env.getRuntimeType(controller.stream) as BridgedClass;
      expect(
        resolved.isSubtypeOf(env.findBridgedClassByName('StreamConsumer')!),
        isFalse,
      );
    });
  });
}
