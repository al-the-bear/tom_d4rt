import 'dart:convert';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';
// The stdlib registrars are deliberately not re-exported from `runtime.dart`
// — see the note in `stdlib_bytes_builder_test.dart`. Reaching for them by
// same-package path keeps the published API unchanged.
import 'package:tom_d4rt_ast/src/runtime/stdlib/convert.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/async.dart';

import '../bridge_reachability.dart';

/// SCD181 coverage for `tom_d4rt_ast` — sink arguments survive the
/// interpreter's type-argument erasure.
///
/// THE CONTRAVARIANT TWIN OF SCC68. That work fixed `Converter.bind`, where a
/// container-typed guard rejected the `Stream<Object?>` a script can actually
/// build. `startChunkedConversion` had the identical defect on the other side
/// of the arrow: `positionalArgs[0] is! Sink<String>` rejects the
/// `ChunkedConversionSink<Object?>` that `ChunkedConversionSink.withCallback`
/// evaluates to, because `Sink<Object?>` is not a `Sink<String>`.
///
/// The REMEDY differs from SCC68's, and the reason is the direction of flow. A
/// `Stream<T>` is a producer, so `D4.coerceStream` has elements in hand and can
/// map them. A `Sink<T>` is a consumer — nothing exists yet, only a method that
/// will later be handed a `T` — so the only thing that can be returned is a
/// forwarding wrapper. `D4.adaptSink` is that wrapper.
///
/// The level is registration-level for the DGUC6 reason: `tom_d4rt_exec` is the
/// only runner that could execute a script against *this* tree, and it resolves
/// `tom_d4rt_ast` from pub.dev rather than by path, so it cannot see unpublished
/// local edits. The script-level twin lives in
/// `tom_d4rt/test/stdlib/convert/chunked_sink_arg_adaptation_test.dart`.
void main() {
  late Environment env;
  late InterpreterVisitor visitor;

  setUp(() {
    env = Environment();
    // dart:async first: the convert bridges lean on its stream types.
    AsyncStdlib.register(env);
    ConvertStdlib.register(env);
    visitor = InterpreterVisitor(
      globalEnvironment: env,
      moduleContext: AstModuleLoader(
        modules: const {},
        globalEnvironment: env,
        runner: D4rtRunner(),
      ),
    );
  });

  /// A native instance for every bridge that exposes `startChunkedConversion`.
  ///
  /// Held as a map rather than a list of calls so the census below can assert
  /// that it is COMPLETE — a new chunked converter added to the stdlib fails
  /// F-SCD181-AST-1 until it is listed here, rather than silently going
  /// untested.
  final targets = <String, Object>{
    'AsciiEncoder': const AsciiEncoder(),
    'AsciiDecoder': const AsciiDecoder(),
    'Base64Encoder': const Base64Encoder(),
    'Base64Decoder': const Base64Decoder(),
    'JsonEncoder': const JsonEncoder(),
    'JsonDecoder': const JsonDecoder(),
    'HtmlEscape': const HtmlEscape(),
    'LineSplitter': const LineSplitter(),
    'Utf8Encoder': const Utf8Encoder(),
    'Utf8Decoder': const Utf8Decoder(),
    'Latin1Encoder': const Latin1Encoder(),
    'Latin1Decoder': const Latin1Decoder(),
  };

  /// What a script's `ChunkedConversionSink.withCallback(...)` evaluates to:
  /// the element type is erased to the top type, which is exactly the shape
  /// the old guards rejected.
  ChunkedConversionSink<Object?> erasedSink(List<Object?> collected) =>
      ChunkedConversionSink<Object?>.withCallback(collected.add);

  /// Every bridge in the environment from which `startChunkedConversion` is
  /// REACHABLE — resolved through the supertype chain rather than read out of
  /// one bridge's own member map, per SCD151. Several of these converters
  /// inherit the method from `Converter`, and asking which bridge declares it
  /// would fail the moment a member correctly moved upward.
  Map<String, BridgedMethodAdapter> chunkedAdapters() {
    final found = <String, BridgedMethodAdapter>{};
    for (final name in targets.keys) {
      final m = findReachableMethod(env, name, 'startChunkedConversion');
      if (m != null) found[name] = m;
    }
    return found;
  }

  group('SCD181: startChunkedConversion accepts an erased sink', () {
    test('F-SCD181-AST-1: every listed bridge really registers the method '
        '[2026-09-15] (PASS)', () {
      // Anti-vacuity, and the reason the targets are a map: if a name is
      // misspelled or a bridge stops registering the method, the per-bridge
      // tests below would pass by never running. This asserts coverage before
      // anything asserts behaviour.
      expect(chunkedAdapters().keys, unorderedEquals(targets.keys));
      expect(targets, hasLength(greaterThanOrEqualTo(12)));
    });

    for (final name in targets.keys) {
      test('F-SCD181-AST-2-$name: the adapter takes a '
          'ChunkedConversionSink<Object?> [2026-09-15] (PASS)', () {
        final collected = <Object?>[];
        final adapter = chunkedAdapters()[name]!;
        expect(
          () =>
              adapter(visitor, targets[name]!, [erasedSink(collected)], {}, []),
          returnsNormally,
        );
      });
    }

    test('F-SCD181-AST-3: the adapted sink forwards add and close '
        '[2026-09-15] (PASS)', () {
      // A wrapper that swallowed `close` would still pass the tests above:
      // nothing throws, the final chunk is simply never emitted. This is the
      // case that distinguishes "accepted" from "works".
      final collected = <Object?>[];
      final inner =
          chunkedAdapters()['Utf8Decoder']!(
                visitor,
                const Utf8Decoder(),
                [erasedSink(collected)],
                {},
                [],
              )
              as ByteConversionSink;
      inner.add([104, 105]);
      expect(collected, isEmpty, reason: 'nothing is emitted before close');
      inner.close();
      // `withCallback` accumulates and fires ONCE at close with the whole
      // list, so the nesting here is the callback's shape, not the wrapper's.
      expect(
        collected,
        equals([
          ['hi'],
        ]),
      );
    });

    test('F-SCD181-AST-4: ByteConversionSink.from takes an erased sink '
        '[2026-09-15] (PASS)', () {
      // The one guarded site that is a static rather than an instance adapter.
      final b = env.findBridgedClassByName('ByteConversionSink');
      expect(b, isNotNull);
      expect(
        () => b!.staticMethods['from']!(visitor, [erasedSink([])], {}, []),
        returnsNormally,
      );
    });
  });

  group('SCD181: the D4 sink adaptation helper', () {
    test('F-SCD181-AST-5: adaptSink forwards add and close to the erased sink '
        '[2026-09-15] (PASS)', () {
      final collected = <Object?>[];
      var closed = false;
      final under = _ProbeSink(collected.add, () => closed = true);
      final adapted = D4.adaptSink<String>(under, 'test');
      adapted.add('a');
      expect(closed, isFalse, reason: 'add must not close');
      adapted.close();
      expect(collected, equals(['a']));
      expect(closed, isTrue);
    });

    test('F-SCD181-AST-6: adaptSink passes an already-typed sink through '
        'untouched [2026-09-15] (PASS)', () {
      // The rule F-SCC68-AST-16 set for `coerceStream`, applied here: when the
      // argument already has the demanded type there is nothing to adapt, and
      // wrapping it anyway would hide the concrete subtype a receiver may
      // legitimately test for (`is StringConversionSink`, say).
      final typed = _ProbeSink<String>((_) {}, () {});
      expect(identical(D4.adaptSink<String>(typed, 'test'), typed), isTrue);
    });

    test('F-SCD181-AST-7: adaptSink rejects a non-Sink with '
        'ArgumentD4rtException [2026-09-15] (PASS)', () {
      expect(
        () => D4.adaptSink<String>('nope', 'test'),
        throwsA(isA<ArgumentD4rtException>()),
      );
    });

    test('F-SCD181-AST-8: the stdlib guard still throws its OWN exception '
        'class [2026-09-15] (PASS)', () {
      // F-SCB23-12's concern, and why the guards were NARROWED to `is! Sink`
      // rather than deleted in favour of the helper. `ArgumentD4rtException`
      // and `RuntimeD4rtException` are SIBLINGS under `D4rtException`, not
      // parent and child, so routing the whole check through `D4.adaptSink`
      // would silently change what a script's `catch` dispatches on.
      expect(
        () => chunkedAdapters()['Utf8Decoder']!(
          visitor,
          const Utf8Decoder(),
          [42],
          {},
          [],
        ),
        throwsA(isA<RuntimeD4rtException>()),
      );
    });
  });
}

/// A sink that records what reached it, used to prove forwarding rather than
/// mere acceptance.
class _ProbeSink<T> implements Sink<T> {
  _ProbeSink(this._onAdd, this._onClose);

  final void Function(T) _onAdd;
  final void Function() _onClose;

  @override
  void add(T data) => _onAdd(data);

  @override
  void close() => _onClose();
}
