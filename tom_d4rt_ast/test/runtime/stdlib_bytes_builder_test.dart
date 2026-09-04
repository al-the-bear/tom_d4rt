import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';
// `TypedDataStdlib` — like every other stdlib registrar — is deliberately not
// re-exported from `runtime.dart`; `dart:typed_data` is registered lazily by
// `ast_module_loader.dart` when a script imports it. Driving that path from a
// unit test would mean building a parsed AST module, so we reach for the
// same-package registrar directly rather than widening the published API.
import 'package:tom_d4rt_ast/src/runtime/stdlib/typed_data.dart';

/// SC8 mirror coverage for `tom_d4rt_ast` — the `BytesBuilder` bridge.
///
/// Registration-level rather than script-level, for the same reason as the SC5
/// through SC7 mirrors: the script-level equivalents live in
/// `tom_d4rt/test/stdlib/typed_data/bytes_builder_test.dart`, and
/// `tom_d4rt_exec` — the only runner that could execute a script against *this*
/// tree — resolves `tom_d4rt_ast` from pub.dev rather than by path, so it cannot
/// see unpublished local edits.
///
/// What is observable without an interpreter is exactly the set of decisions
/// SC8 made: that the bridge exists, that both private implementations are on
/// `nativeNames`, and — because the adapters read straight through to the
/// native builder — that the accumulation surface actually works.
void main() {
  late Environment env;
  late InterpreterVisitor visitor;

  setUp(() {
    env = Environment();
    TypedDataStdlib.register(env);
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

  BridgedClass builderBridge() => env.findBridgedClassByName('BytesBuilder')!;

  group('SC8: BytesBuilder typed_data bridge', () {
    test(
      'F-SC8-AST-1: is registered under the name BytesBuilder [2026-07-27]',
      () {
        final bridge = env.findBridgedClassByName('BytesBuilder');
        expect(bridge, isNotNull);
        expect(bridge!.nativeType, BytesBuilder);
        expect(bridge.constructors.keys, contains(''));
      },
    );

    test('F-SC8-AST-2: routes both private implementations [2026-07-27]', () {
      // `BytesBuilder` is abstract; the factory returns `_CopyingBytesBuilder`
      // for the default and `_BytesBuilder` for `copy: false`. Both names must
      // be present or one of the two flavours constructs and then reaches no
      // bridge on its first member call.
      expect(
        builderBridge().nativeNames,
        containsAll(<String>['_CopyingBytesBuilder', '_BytesBuilder']),
      );
      expect(BytesBuilder().runtimeType.toString(), '_CopyingBytesBuilder');
      expect(BytesBuilder(copy: false).runtimeType.toString(), '_BytesBuilder');
    });

    test(
      'F-SC8-AST-3: declares isAssignable over both flavours [2026-07-27]',
      () {
        // Safe because the two implementations are private, so there is no more
        // specific bridge whose dispatch this predicate could steal.
        final bridge = builderBridge();
        expect(bridge.isAssignable, isNotNull);
        expect(bridge.isAssignable!(BytesBuilder()), isTrue);
        expect(bridge.isAssignable!(BytesBuilder(copy: false)), isTrue);
        expect(bridge.isAssignable!(Uint8List(1)), isFalse);
      },
    );

    test(
      'F-SC8-AST-4: the constructor honours the copy: flag [2026-07-27]',
      () {
        final bridge = builderBridge();
        expect(bridge.constructors['']!(visitor, [], {}), isA<BytesBuilder>());
        expect(
          bridge.constructors['']!(visitor, [], {'copy': false}).runtimeType
              .toString(),
          '_BytesBuilder',
        );
        expect(
          bridge.constructors['']!(visitor, [], {'copy': true}).runtimeType
              .toString(),
          '_CopyingBytesBuilder',
        );
      },
    );

    test('F-SC8-AST-5: the constructor rejects bad arguments [2026-07-27]', () {
      final bridge = builderBridge();
      // A positional argument is the natural mistake, since the SDK signature
      // reads like a plain bool parameter.
      expect(
        () => bridge.constructors['']!(visitor, [true], {}),
        throwsA(isA<RuntimeD4rtException>()),
      );
      expect(
        () => bridge.constructors['']!(visitor, [], {'copy': 1}),
        throwsA(isA<RuntimeD4rtException>()),
      );
    });

    test('F-SC8-AST-6: addByte and add accumulate in order [2026-07-27]', () {
      final bridge = builderBridge();
      final builder = BytesBuilder();
      bridge.methods['addByte']!(visitor, builder, [1], {}, []);
      bridge.methods['add']!(
        visitor,
        builder,
        [
          [2, 3],
        ],
        {},
        [],
      );
      expect(bridge.getters['length']!(visitor, builder), 3);
      expect(bridge.getters['isEmpty']!(visitor, builder), isFalse);
      expect(bridge.getters['isNotEmpty']!(visitor, builder), isTrue);
      expect(
        bridge.methods['toBytes']!(visitor, builder, [], {}, []),
        orderedEquals(<int>[1, 2, 3]),
      );
    });

    test('F-SC8-AST-7: takeBytes drains but toBytes does not [2026-07-27]', () {
      final bridge = builderBridge();
      final builder = BytesBuilder();
      bridge.methods['add']!(
        visitor,
        builder,
        [
          [1, 2, 3],
        ],
        {},
        [],
      );
      expect(
        bridge.methods['toBytes']!(visitor, builder, [], {}, []),
        orderedEquals(<int>[1, 2, 3]),
      );
      expect(bridge.getters['length']!(visitor, builder), 3);
      expect(
        bridge.methods['takeBytes']!(visitor, builder, [], {}, []),
        orderedEquals(<int>[1, 2, 3]),
      );
      expect(bridge.getters['length']!(visitor, builder), 0);
    });

    test('F-SC8-AST-8: clear empties the builder [2026-07-27]', () {
      final bridge = builderBridge();
      final builder = BytesBuilder();
      bridge.methods['add']!(
        visitor,
        builder,
        [
          [1, 2, 3],
        ],
        {},
        [],
      );
      bridge.methods['clear']!(visitor, builder, [], {}, []);
      expect(bridge.getters['length']!(visitor, builder), 0);
      expect(bridge.getters['isEmpty']!(visitor, builder), isTrue);
    });

    test('F-SC8-AST-9: the members reject bad arguments [2026-07-27]', () {
      final bridge = builderBridge();
      final builder = BytesBuilder();
      expect(
        () => bridge.methods['addByte']!(visitor, builder, ['x'], {}, []),
        throwsA(isA<RuntimeD4rtException>()),
      );
      expect(
        () => bridge.methods['add']!(visitor, builder, [42], {}, []),
        throwsA(isA<RuntimeD4rtException>()),
      );
      // A `List<dynamic>` carrying a non-int must name the bad element rather
      // than surface a host TypeError from the `List<int>` cast.
      expect(
        () => bridge.methods['add']!(
          visitor,
          builder,
          [
            [1, 'x'],
          ],
          {},
          [],
        ),
        throwsA(isA<RuntimeD4rtException>()),
      );
    });

    test('F-SC8-AST-10: the copy: false flavour works past construction '
        '[2026-07-27]', () {
      // The payoff of the second `nativeNames` entry, exercised end to end.
      final bridge = builderBridge();
      final builder =
          bridge.constructors['']!(visitor, [], {'copy': false})
              as BytesBuilder;
      bridge.methods['addByte']!(visitor, builder, [7], {}, []);
      bridge.methods['add']!(
        visitor,
        builder,
        [
          [8, 9],
        ],
        {},
        [],
      );
      expect(
        bridge.methods['takeBytes']!(visitor, builder, [], {}, []),
        orderedEquals(<int>[7, 8, 9]),
      );
      expect(bridge.getters['isEmpty']!(visitor, builder), isTrue);
    });
  });
}
