import 'dart:async';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';
// The stdlib registrars are deliberately not re-exported from `runtime.dart`;
// `dart:async` is registered lazily by `ast_module_loader.dart` when a script
// imports it. Driving that path from a unit test would mean building a parsed
// AST module, so we reach for the same-package registrars directly rather than
// widening the published API.
import 'package:tom_d4rt_ast/src/runtime/stdlib/async/async_error.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/async/stream.dart';

/// SC6 mirror coverage for `tom_d4rt_ast` — `StreamView`, `AsyncError` and
/// `StreamTransformerBase`.
///
/// Registration-level rather than script-level, for the same reason as the SC4
/// mirror: the script-level equivalents live in
/// `tom_d4rt/test/stdlib/async/stream_view_async_error_test.dart`, and
/// `tom_d4rt_exec` — the only runner that could execute a script against *this*
/// tree — resolves `tom_d4rt_ast` from pub.dev rather than by path, so it cannot
/// see unpublished local edits.
///
/// What is observable without an interpreter is exactly the set of decisions
/// SC6 made: which bridges exist, which of them declare an `isAssignable` (and
/// therefore contest dispatch in `Environment.toBridgedInstance`), which native
/// names route where, and which supertype edges were registered.
///
/// Tear-down note: a single-subscription controller that was never listened to
/// returns a `close()` future that never completes, so `addTearDown(c.close)`
/// hangs the harness. Use [_disposer], which starts the close without waiting.
Future<void> Function() _disposer(StreamController<Object?> controller) =>
    () async => unawaited(controller.close());

void main() {
  late Environment env;
  late InterpreterVisitor visitor;

  setUp(() {
    env = Environment();
    AsyncStreamStdlib.register(env);
    AsyncErrorStdlib.register(env);
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

  group('SC6: StreamView async bridge', () {
    test('F-SC6-AST-1: is registered under the name StreamView [2026-07-27]',
        () {
      final bridge = env.findBridgedClassByName('StreamView');
      expect(bridge, isNotNull);
      expect(bridge!.nativeType, StreamView);
      expect(bridge.typeParameterCount, 1);
    });

    test('F-SC6-AST-2: constructs a StreamView from a stream [2026-07-27]', () {
      final controller = StreamController<int>();
      addTearDown(_disposer(controller));
      final bridge = env.findBridgedClassByName('StreamView')!;
      final view = bridge.constructors['']!(visitor, [controller.stream], {});
      expect(view, isA<StreamView>());
    });

    test('F-SC6-AST-3: the constructor rejects a non-Stream argument [2026-07-27]',
        () {
      final bridge = env.findBridgedClassByName('StreamView')!;
      expect(
        () => bridge.constructors['']!(visitor, [42], {}),
        throwsA(isA<RuntimeD4rtException>()),
      );
    });

    test('F-SC6-AST-4: declares no isAssignable, so dispatch is untouched [2026-07-27]',
        () {
      // Load-bearing. `Environment.toBridgedInstance` picks a bridge by
      // iterating `isAssignable`, and every hand-written stdlib bridge carries
      // `hierarchyDepth == 0`, so ties break on registration order. A predicate
      // here would let `StreamView` contest `Stream`'s ownership of stream
      // objects. See F-SC6-AST-5 for how the surface is reached instead.
      expect(env.findBridgedClassByName('StreamView')!.isAssignable, isNull);
    });

    test('F-SC6-AST-5: StreamView instances route to the Stream bridge [2026-07-27]',
        () {
      // This is what gives a StreamView the ~60-member Stream surface it
      // inherits. Bridge dispatch is per-bridge rather than hierarchical, so
      // without this routing a StreamView would expose only its constructor.
      final controller = StreamController<int>();
      addTearDown(_disposer(controller));
      expect(
        env.findBridgedClassByName('Stream')!.nativeNames,
        contains('StreamView'),
      );
      final resolved = env.getRuntimeType(StreamView(controller.stream));
      expect(resolved, isA<BridgedClass>());
      expect((resolved as BridgedClass).name, 'Stream');
    });

    test('F-SC6-AST-6: the StreamView -> Stream edge is registered [2026-07-27]',
        () {
      expect(
        BridgedClass.transitiveSupertypeNames('StreamView'),
        contains('Stream'),
      );
    });
  });

  group('SC6: AsyncError async bridge', () {
    test('F-SC6-AST-7: is registered with error and stackTrace [2026-07-27]',
        () {
      final bridge = env.findBridgedClassByName('AsyncError');
      expect(bridge, isNotNull);
      expect(bridge!.nativeType, AsyncError);
      expect(bridge.getters.keys, containsAll(<String>['error', 'stackTrace']));
      expect(bridge.staticMethods.keys, contains('defaultStackTrace'));
    });

    test('F-SC6-AST-8: declares isAssignable, unlike the abstract bridges [2026-07-27]',
        () {
      // Safe here precisely because `AsyncError` is concrete: it cannot shadow
      // a more specific bridge the way an abstract supertype could. Pinned so
      // the asymmetry with F-SC6-AST-4 reads as a decision, not an oversight.
      final bridge = env.findBridgedClassByName('AsyncError')!;
      expect(bridge.isAssignable, isNotNull);
      expect(bridge.isAssignable!(AsyncError('boom', StackTrace.current)),
          isTrue);
      expect(bridge.isAssignable!('boom'), isFalse);
    });

    test('F-SC6-AST-9: the constructor accepts one or two arguments [2026-07-27]',
        () {
      // The SDK's second parameter is required-but-nullable and it supplies a
      // `defaultStackTrace` fallback, so `AsyncError(e)` is idiomatic.
      final bridge = env.findBridgedClassByName('AsyncError')!;
      expect((bridge.constructors['']!(visitor, ['boom'], {}) as AsyncError)
          .error, 'boom');
      final st = StackTrace.current;
      final two = bridge.constructors['']!(visitor, ['boom', st], {})
          as AsyncError;
      expect(two.stackTrace, st);
    });

    test('F-SC6-AST-10: the constructor rejects a null error [2026-07-27]', () {
      final bridge = env.findBridgedClassByName('AsyncError')!;
      expect(
        () => bridge.constructors['']!(visitor, [null], {}),
        throwsA(isA<RuntimeD4rtException>()),
      );
    });

    test('F-SC6-AST-11: the AsyncError -> Error edge is registered [2026-07-27]',
        () {
      // The only thing that can make `on Error catch (e)` see an AsyncError,
      // since bridges are registered flat.
      expect(
        BridgedClass.transitiveSupertypeNames('AsyncError'),
        contains('Error'),
      );
    });
  });

  group('SC6: StreamTransformerBase async bridge', () {
    test('F-SC6-AST-12: is registered under the name StreamTransformerBase [2026-07-27]',
        () {
      final bridge = env.findBridgedClassByName('StreamTransformerBase');
      expect(bridge, isNotNull);
      expect(bridge!.nativeType, StreamTransformerBase);
      expect(bridge.typeParameterCount, 2);
    });

    test('F-SC6-AST-13: exposes a default constructor so super() resolves [2026-07-27]',
        () {
      // The class exists to be extended. There is no native object to build —
      // the instance a script holds is the InterpretedInstance of its own
      // subclass — so the adapter returns null; it is present only so an
      // implicit or explicit `super()` in the subclass has something to call.
      final bridge = env.findBridgedClassByName('StreamTransformerBase')!;
      expect(bridge.constructors.keys, contains(''));
      expect(bridge.constructors['']!(visitor, [], {}), isNull);
    });

    test('F-SC6-AST-14: declares no isAssignable, so dispatch is untouched [2026-07-27]',
        () {
      // Abstract, and a supertype of everything `StreamTransformer` owns —
      // a predicate here would contest that bridge's dispatch.
      expect(env.findBridgedClassByName('StreamTransformerBase')!.isAssignable,
          isNull);
    });

    test('F-SC6-AST-15: the StreamTransformerBase -> StreamTransformer edge is registered [2026-07-27]',
        () {
      // What makes an interpreted `extends StreamTransformerBase` subclass
      // answer `true` to `is StreamTransformer`.
      expect(
        BridgedClass.transitiveSupertypeNames('StreamTransformerBase'),
        contains('StreamTransformer'),
      );
      expect(
        env
            .findBridgedClassByName('StreamTransformerBase')!
            .isSubtypeOf(env.findBridgedClassByName('StreamTransformer')!),
        isTrue,
      );
    });

    test('F-SC6-AST-16: Stream.transform accepts a native transformer [2026-07-27]',
        () async {
      // Regression guard for the broadened `transform` adapter: the shape it
      // already handled must keep working. The interpreted-transformer shape
      // needs a running interpreter and is covered script-level in tom_d4rt
      // (F-SC6-17/18).
      final bridge = env.findBridgedClassByName('Stream')!;
      final doubler =
          StreamTransformer<int, int>.fromBind((s) => s.map((e) => e * 2));
      final transformed = bridge.methods['transform']!(
          visitor, Stream.fromIterable([1, 2, 3]), [doubler], {}, []) as Stream;
      expect(await transformed.toList(), orderedEquals([2, 4, 6]));
    });

    test('F-SC6-AST-17: Stream.transform rejects a non-transformer [2026-07-27]',
        () {
      final bridge = env.findBridgedClassByName('Stream')!;
      expect(
        () => bridge.methods['transform']!(
            visitor, Stream.fromIterable([1]), [42], {}, []),
        throwsA(isA<RuntimeD4rtException>()),
      );
    });
  });
}
