import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';
// Same reason as the SC7/SCB17 mirrors: the stdlib registrars are not
// re-exported from `runtime.dart`.
import 'package:tom_d4rt_ast/src/runtime/stdlib/core.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/typed_data.dart';

/// SCB20 mirror coverage for `tom_d4rt_ast`.
///
/// Registration-level rather than script-level, for the reason the SC5/SC6/SC7
/// mirrors give: `tom_d4rt_exec` — the only runner that could execute a script
/// against *this* tree — resolves `tom_d4rt_ast` from pub.dev rather than by
/// path, so it cannot see unpublished local edits. The script-level equivalent
/// is `tom_d4rt/test/stdlib/typed_data/typed_data_hierarchy_test.dart`.
///
/// This mirror is stronger than a pure "is it registered" check, because
/// `BridgedClass.isSubtypeOf` is the exact function the interpreter calls to
/// answer `is`. Driving it directly tests the decision, not just the data that
/// feeds it — so a regression in the registry *walk* is caught here too, not
/// only a missing edge.
///
/// SCB20's three findings:
///   * `TypedData` was unbridged, so `is TypedData` threw rather than answered.
///   * The eleven views had no `-> Iterable` edge.
///   * `is List` already worked via the `isAssignable` fallback — the original
///     report claimed it was broken, and F-SCB20-AST-3 pins the correction.
void main() {
  late Environment env;

  setUp(() {
    env = Environment();
    CoreStdlib.register(env);
    TypedDataStdlib.register(env);
  });

  BridgedClass bridgeNamed(String name) => env.findBridgedClassByName(name)!;

  /// The eleven list views, each with a native instance to feed `isSubtypeOf`
  /// — the value matters, because the `isAssignable` fallback consults it.
  Map<String, TypedData> views() => <String, TypedData>{
        'Uint8List': Uint8List.fromList([1, 2, 3]),
        'Uint8ClampedList': Uint8ClampedList.fromList([1, 2, 3]),
        'Uint16List': Uint16List.fromList([1, 2, 3]),
        'Uint32List': Uint32List.fromList([1, 2, 3]),
        'Uint64List': Uint64List.fromList([1, 2, 3]),
        'Int8List': Int8List.fromList([1, 2, 3]),
        'Int16List': Int16List.fromList([1, 2, 3]),
        'Int32List': Int32List.fromList([1, 2, 3]),
        'Int64List': Int64List.fromList([1, 2, 3]),
        'Float32List': Float32List.fromList([1.0, 2.0]),
        'Float64List': Float64List.fromList([1.0, 2.0]),
      };

  group('SCB20: the TypedData root is bridged', () {
    test('F-SCB20-AST-1: TypedData is registered as a bridge [2026-07-28]', () {
      final bridge = env.findBridgedClassByName('TypedData');
      expect(bridge, isNotNull,
          reason: 'without this bridge `is TypedData` throws '
              '"Undefined variable: TypedData" instead of answering');
      expect(bridge!.nativeType, equals(TypedData));
    });

    test('F-SCB20-AST-2: the TypedData bridge declares no isAssignable '
        '[2026-07-28]', () {
      // Deliberate, and load-bearing: `isAssignable` is what
      // `Environment.toBridgedInstance` consults to decide which bridge OWNS a
      // native object. A root claiming `(v) => v is TypedData` would compete
      // with the eleven views and ByteData for every typed buffer. The subtype
      // answers come from the registry instead. If someone adds a predicate
      // here "to make `is` work", this test explains why it already does.
      expect(bridgeNamed('TypedData').isAssignable, isNull);
    });

    test('F-SCB20-AST-6: the TypedData bridge exposes the whole interface '
        '[2026-07-28]', () {
      expect(
        bridgeNamed('TypedData').getters.keys,
        containsAll(<String>[
          'buffer',
          'lengthInBytes',
          'offsetInBytes',
          'elementSizeInBytes',
        ]),
      );
    });
  });

  group('SCB20: supertype edges resolve through isSubtypeOf', () {
    test('F-SCB20-AST-4: every view is a subtype of TypedData [2026-07-28]',
        () {
      final typedData = bridgeNamed('TypedData');
      for (final entry in views().entries) {
        expect(
          bridgeNamed(entry.key).isSubtypeOf(typedData, value: entry.value),
          isTrue,
          reason: '${entry.key} implements TypedData',
        );
      }
    });

    test('F-SCB20-AST-5: every view is a subtype of Iterable [2026-07-28]', () {
      // The edge that had to be declared: `Iterable`'s bridge carries no
      // `isAssignable`, so no fallback can rescue this one.
      final iterable = bridgeNamed('Iterable');
      for (final entry in views().entries) {
        expect(
          bridgeNamed(entry.key).isSubtypeOf(iterable, value: entry.value),
          isTrue,
          reason: '${entry.key} implements List which implements Iterable',
        );
      }
    });

    test('F-SCB20-AST-3: every view is a subtype of List, as it always was '
        '[2026-07-28]', () {
      // Regression guard on behaviour that predates SCB20 and that SCB20
      // wrongly reported as broken. It works through the `isAssignable`
      // fallback (GEN-075/GEN-081) plus the `List` bridge's predicate
      // (GEN-C3c), and now also through a declared edge. Either mechanism
      // alone suffices; this asserts the answer, not the route.
      final list = bridgeNamed('List');
      for (final entry in views().entries) {
        expect(
          bridgeNamed(entry.key).isSubtypeOf(list, value: entry.value),
          isTrue,
          reason: '${entry.key} is a native List',
        );
      }
    });

    test('F-SCB20-AST-7: ByteData is a TypedData but not a List [2026-07-28]',
        () {
      // ByteData is the member of the hierarchy that is not a list, so it is
      // the case that proves these are real edges rather than the List
      // fallback in disguise.
      final byteData = bridgeNamed('ByteData');
      final value = ByteData(8);
      expect(byteData.isSubtypeOf(bridgeNamed('TypedData'), value: value),
          isTrue);
      expect(byteData.isSubtypeOf(bridgeNamed('List'), value: value), isFalse);
      expect(
          byteData.isSubtypeOf(bridgeNamed('Iterable'), value: value), isFalse);
    });

    test('F-SCB20-AST-8: ByteBuffer and BytesBuilder are not TypedData '
        '[2026-07-28]', () {
      // The negatives that stop the edges being over-declared. Both look like
      // they belong in this hierarchy; neither implements the interface.
      final typedData = bridgeNamed('TypedData');
      final buffer = Uint8List.fromList([1, 2]).buffer;
      expect(bridgeNamed('ByteBuffer').isSubtypeOf(typedData, value: buffer),
          isFalse);
      expect(
        bridgeNamed('BytesBuilder')
            .isSubtypeOf(typedData, value: BytesBuilder()),
        isFalse,
      );
    });

    test('F-SCB20-AST-9: a plain List is not a TypedData [2026-07-28]', () {
      expect(
        bridgeNamed('List')
            .isSubtypeOf(bridgeNamed('TypedData'), value: <int>[1, 2, 3]),
        isFalse,
      );
    });
  });
}
