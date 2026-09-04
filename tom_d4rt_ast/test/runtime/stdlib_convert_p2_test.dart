import 'dart:convert';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';
// The stdlib registrars are deliberately not re-exported from `runtime.dart`;
// `dart:convert` is registered lazily by `ast_module_loader.dart` when a script
// imports it. Driving that path from a unit test would mean building a parsed
// AST module, so we reach for the same-package registrar directly rather than
// widening the published API.
import 'package:tom_d4rt_ast/src/runtime/stdlib/convert.dart';

/// SC9 mirror coverage for `tom_d4rt_ast` — `JsonUtf8Encoder`,
/// `ClosableStringSink`, and the two chunked-sink bridges that had been
/// written and exported but never registered.
///
/// Registration-level rather than script-level, for the same reason as the SC5
/// through SC8 mirrors: the script-level equivalents live in
/// `tom_d4rt/test/stdlib/convert/`, and `tom_d4rt_exec` — the only runner that
/// could execute a script against *this* tree — resolves `tom_d4rt_ast` from
/// pub.dev rather than by path, so it cannot see unpublished local edits.
void main() {
  late Environment env;
  late InterpreterVisitor visitor;

  setUp(() {
    env = Environment();
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

  BridgedClass bridge(String name) => env.findBridgedClassByName(name)!;

  group('SC9: JsonUtf8Encoder convert bridge', () {
    test(
      'F-SC9-AST-1: is registered under the name JsonUtf8Encoder [2026-07-27]',
      () {
        final b = env.findBridgedClassByName('JsonUtf8Encoder');
        expect(b, isNotNull);
        expect(b!.nativeType, JsonUtf8Encoder);
        expect(b.constructors.keys, contains(''));
      },
    );

    test(
      'F-SC9-AST-2: needs no nativeNames — the class is concrete [2026-07-27]',
      () {
        // Unlike the SC5–SC8 bridges there is no private implementation to route:
        // `JsonUtf8Encoder` is public and concrete, so `runtimeType` is the class
        // itself and the direct-Type lookup resolves it.
        expect(JsonUtf8Encoder().runtimeType, JsonUtf8Encoder);
        expect(bridge('JsonUtf8Encoder').nativeNames, isNull);
      },
    );

    test(
      'F-SC9-AST-3: the constructor reads its three optionals by position [2026-07-27]',
      () {
        final ctor = bridge('JsonUtf8Encoder').constructors['']!;
        expect(ctor(visitor, [], {}), isA<JsonUtf8Encoder>());
        // A null indent is meaningful (it selects compact output), so presence
        // cannot stand in for the value.
        expect(ctor(visitor, [null], {}), isA<JsonUtf8Encoder>());
        expect(ctor(visitor, ['  '], {}), isA<JsonUtf8Encoder>());
        expect(ctor(visitor, [null, null, 64], {}), isA<JsonUtf8Encoder>());
      },
    );

    test(
      'F-SC9-AST-4: the constructor rejects mistyped arguments [2026-07-27]',
      () {
        final ctor = bridge('JsonUtf8Encoder').constructors['']!;
        expect(
          () => ctor(visitor, [42], {}),
          throwsA(isA<RuntimeD4rtException>()),
        );
        expect(
          () => ctor(visitor, [null, 'x'], {}),
          throwsA(isA<RuntimeD4rtException>()),
        );
        expect(
          () => ctor(visitor, [null, null, 'big'], {}),
          throwsA(isA<RuntimeD4rtException>()),
        );
      },
    );

    test('F-SC9-AST-5: convert produces UTF-8 JSON bytes [2026-07-27]', () {
      final result = bridge('JsonUtf8Encoder').methods['convert']!(
        visitor,
        JsonUtf8Encoder(),
        [
          {'a': 1},
        ],
        {},
        null,
      );
      expect(utf8.decode(result as List<int>), '{"a":1}');
    });

    // The reason the bridge exists: the SDK specialises `JsonEncoder.fuse`, so
    // the already-shipped `fuse` adapter has always been able to hand back a
    // `JsonUtf8Encoder` — previously an unregistered type, which made every
    // call on the result fail.
    test(
      'F-SC9-AST-6: JsonEncoder.fuse(Utf8Encoder()) lands on this bridge [2026-07-27]',
      () {
        final fused = const JsonEncoder().fuse(const Utf8Encoder());
        expect(fused, isA<JsonUtf8Encoder>());
        expect(bridge('JsonUtf8Encoder').isAssignable!(fused), isTrue);
      },
    );
  });

  group('SC9: ClosableStringSink convert bridge', () {
    test(
      'F-SC9-AST-7: is registered and routes its private impl [2026-07-27]',
      () {
        final b = env.findBridgedClassByName('ClosableStringSink');
        expect(b, isNotNull);
        // Abstract, so both routes to an instance return `_ClosableStringSink`.
        expect(b!.nativeNames, contains('_ClosableStringSink'));
        expect(
          ClosableStringSink.fromStringSink(
            StringBuffer(),
            () {},
          ).runtimeType.toString(),
          '_ClosableStringSink',
        );
      },
    );

    test(
      'F-SC9-AST-8: the write-through adapters reach the backing sink [2026-07-27]',
      () {
        // The sink is built natively rather than through the bridge constructor:
        // that constructor demands an `InterpretedFunction` for `onClose` (the
        // same contract every sibling sink bridge in this library uses for its
        // callback), and only a running script can supply one. The adapters
        // under test are independent of how the instance was made.
        final b = bridge('ClosableStringSink');
        final buffer = StringBuffer();
        var closed = false;
        final sink = ClosableStringSink.fromStringSink(
          buffer,
          () => closed = true,
        );
        b.methods['write']!(visitor, sink, ['hi'], {}, null);
        b.methods['writeCharCode']!(visitor, sink, [33], {}, null);
        b.methods['writeAll']!(
          visitor,
          sink,
          [
            ['a', 'b'],
            '-',
          ],
          {},
          null,
        );
        expect(buffer.toString(), 'hi!a-b');
        expect(closed, isFalse);
        b.methods['close']!(visitor, sink, [], {}, null);
        expect(closed, isTrue);
      },
    );

    test(
      'F-SC9-AST-15: fromStringSink validates both arguments [2026-07-27]',
      () {
        final ctor = bridge(
          'ClosableStringSink',
        ).constructors['fromStringSink']!;
        expect(
          () => ctor(visitor, [42, null], {}),
          throwsA(isA<RuntimeD4rtException>()),
        );
        // A native callback is rejected too: the contract is an interpreted
        // closure, matching the rest of the dart:convert sink bridges.
        expect(
          () => ctor(visitor, [StringBuffer(), 7], {}),
          throwsA(isA<RuntimeD4rtException>()),
        );
      },
    );

    test(
      'F-SC9-AST-9: the StringSink surface is declared, not inherited [2026-07-27]',
      () {
        // Bridge dispatch is per-bridge and the dart:convert hierarchy has no
        // supertype edges to `StringSink`, so a `_ClosableStringSink` would have
        // no route to those members unless this bridge declares them itself.
        expect(
          bridge('ClosableStringSink').methods.keys,
          containsAll(<String>[
            'write',
            'writeln',
            'writeCharCode',
            'writeAll',
          ]),
        );
      },
    );
  });

  group('SC9: chunked-conversion sinks, newly registered', () {
    test(
      'F-SC9-AST-10: both formerly-dead bridges are now reachable [2026-07-27]',
      () {
        // Fully written and exported, but never passed to `defineBridge` — so no
        // script could name either one, which left `startChunkedConversion`
        // uncallable (nothing could construct its argument).
        expect(env.findBridgedClassByName('StringConversionSink'), isNotNull);
        expect(env.findBridgedClassByName('ChunkedConversionSink'), isNotNull);
      },
    );

    test(
      'F-SC9-AST-11: asStringSink is the idiomatic ClosableStringSink route [2026-07-27]',
      () {
        final scs = StringConversionSink.withCallback((_) {});
        final css = bridge('StringConversionSink').methods['asStringSink']!(
          visitor,
          scs,
          [],
          {},
          null,
        );
        expect(css, isA<ClosableStringSink>());
        expect(bridge('ClosableStringSink').isAssignable!(css), isTrue);
      },
    );

    // Registering `ChunkedConversionSink` gave the root of the sink hierarchy
    // an `isAssignable` predicate, and it matches *every* sink in the library.
    // Without the supertype edges the root swallowed its own subtypes and the
    // specific surface vanished — "Bridged class 'ChunkedConversionSink' has no
    // instance method named 'asStringSink'".
    test(
      'F-SC9-AST-12: the root claims assignability over both subtypes [2026-07-27]',
      () {
        final root = bridge('ChunkedConversionSink').isAssignable!;
        expect(root(StringConversionSink.withCallback((_) {})), isTrue);
        expect(root(ByteConversionSink.withCallback((_) {})), isTrue);
      },
    );

    test(
      'F-SC9-AST-13: supertype edges let the resolver keep the subtype [2026-07-27]',
      () {
        // `Environment._filterToMostSpecific` drops any match whose name appears
        // in the union of the other matches' transitive supertypes. These edges
        // are what put `ChunkedConversionSink` into that union.
        expect(
          BridgedClass.transitiveSupertypeNames('StringConversionSink'),
          contains('ChunkedConversionSink'),
        );
        expect(
          BridgedClass.transitiveSupertypeNames('ByteConversionSink'),
          contains('ChunkedConversionSink'),
        );
        expect(
          BridgedClass.transitiveSupertypeNames('ClosableStringSink'),
          contains('StringSink'),
        );
      },
    );

    test(
      'F-SC9-AST-14: the byte sink carries its own predicate and names [2026-07-27]',
      () {
        // Needed once the root is assignable: without a predicate of its own the
        // byte sink never enters the isAssignable pass, so the filter has no
        // specific match to keep.
        final b = bridge('ByteConversionSink');
        expect(b.isAssignable, isNotNull);
        expect(
          b.isAssignable!(ByteConversionSink.withCallback((_) {})),
          isTrue,
        );
        expect(
          b.isAssignable!(StringConversionSink.withCallback((_) {})),
          isFalse,
        );
        expect(
          b.nativeNames,
          containsAll(<String>['_ByteCallbackSink', '_ByteAdapterSink']),
        );
      },
    );
  });
}
