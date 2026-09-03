// SCB20: the `dart:typed_data` views had no supertype edges, and `TypedData`
// — the interface every one of them implements — was not bridged at all.
//
// Two distinct symptoms, which is why this file asserts both directions:
//
//   * `Uint8List(...) is Iterable` answered **false**. Nothing connected the
//     concrete view to the interface, so the registry walk in
//     `BridgedClass.isSubtypeOf` found no edge to follow.
//   * `Uint8List(...) is TypedData` did not answer *at all* — it threw
//     `Undefined variable: TypedData`, because the root of the hierarchy was
//     never registered as a bridge. A type test that throws is worse than one
//     that answers wrongly: `is` is total in Dart and scripts reasonably assume
//     it cannot fail.
//
// `is List`, by contrast, ALREADY WORKED and must keep working. It does not
// depend on any edge: `BridgedClass.isSubtypeOf` falls back to asking the
// target's `isAssignable` predicate about the native value (GEN-075 /
// GEN-081), and the `List` bridge carries `isAssignable: (v) => v is List`
// (GEN-C3c). A native `Uint8List` *is* a native `List`, so the fallback
// answers true with no edge present. `Iterable`'s bridge has no such
// predicate, which is exactly why the two behaved differently. SCB20's own
// text recorded `is List` as false; that was wrong when written, and the
// F-SCB20-2 cases below exist to keep it from being "fixed" back.
//
// The members were never the problem — each view declares its ~40 inherited
// List members explicitly — so the F-SCB20-2x cases are dispatch regression
// guards, not new coverage. Feeding the supertype registry changes which
// bridge wins in `_filterToMostSpecific`, so the risk of this change is that
// a *supertype* bridge starts winning dispatch and the concrete members stop
// resolving. That is the failure mode those cases exist to catch.

import '../../interpreter_test.dart';
import 'package:test/test.dart';

/// Every typed-data list view. All eleven implement `TypedData` and `List<int>`
/// or `List<double>`, so all eleven must answer identically to every case here
/// — a per-variant loop rather than a spot-check on `Uint8List`, which is the
/// one variant that historically behaved differently (see SCB3).
const _views = <String>[
  'Uint8List',
  'Uint8ClampedList',
  'Uint16List',
  'Uint32List',
  'Uint64List',
  'Int8List',
  'Int16List',
  'Int32List',
  'Int64List',
  'Float32List',
  'Float64List',
];

void main() {
  group('typed_data hierarchy: the TypedData root', () {
    for (final type in _views) {
      test('F-SCB20-1-$type: is TypedData answers true [2026-07-28]', () {
        final source = '''
        import 'dart:typed_data';
        main() {
          final l = $type.fromList([1, 2, 3]);
          return l is TypedData;
        }
        ''';
        expect(execute(source), isTrue,
            reason: '$type implements TypedData; before SCB20 this threw '
                '"Undefined variable: TypedData" rather than answering');
      });
    }

    test('F-SCB20-3: ByteData is a TypedData but not a List [2026-07-28]', () {
      // ByteData is the non-List member of the hierarchy — it implements
      // TypedData without implementing List. It is the case that proves the
      // `-> TypedData` edges are real edges and not an accident of the
      // List/isAssignable fallback that covers the eleven views.
      final source = '''
      import 'dart:typed_data';
      main() {
        final d = ByteData(8);
        return [d is TypedData, d is List, d is Iterable];
      }
      ''';
      expect(execute(source), equals([true, false, false]));
    });

    test('F-SCB20-4: ByteBuffer is NOT a TypedData [2026-07-28]', () {
      // The negative that stops the edges being over-declared: a ByteBuffer
      // holds typed data but does not implement the interface.
      final source = '''
      import 'dart:typed_data';
      main() {
        final b = Uint8List.fromList([1, 2]).buffer;
        return b is TypedData;
      }
      ''';
      expect(execute(source), isFalse);
    });

    test('F-SCB20-5: BytesBuilder is NOT a TypedData [2026-07-28]', () {
      // Explicitly out of scope per SCB20, pinned so a later "complete the
      // hierarchy" pass does not sweep it in.
      final source = '''
      import 'dart:typed_data';
      main() {
        final b = BytesBuilder();
        b.addByte(1);
        return b is TypedData;
      }
      ''';
      expect(execute(source), isFalse);
    });

    test('F-SCB20-6: a plain List is not a TypedData [2026-07-28]', () {
      final source = '''
      import 'dart:typed_data';
      main() => [1, 2, 3] is TypedData;
      ''';
      expect(execute(source), isFalse);
    });
  });

  group('typed_data hierarchy: List and Iterable edges', () {
    for (final type in _views) {
      test('F-SCB20-2-$type: is List stays true [2026-07-28]', () {
        // Regression guard on behaviour that already worked via the
        // isAssignable fallback, NOT a new assertion. See the header.
        final source = '''
        import 'dart:typed_data';
        main() {
          final l = $type.fromList([1, 2, 3]);
          return l is List;
        }
        ''';
        expect(execute(source), isTrue,
            reason: '$type is a native List; the isAssignable fallback '
                'answered this correctly even before any edge existed');
      });

      test('F-SCB20-7-$type: is Iterable answers true [2026-07-28]', () {
        final source = '''
        import 'dart:typed_data';
        main() {
          final l = $type.fromList([1, 2, 3]);
          return l is Iterable;
        }
        ''';
        expect(execute(source), isTrue,
            reason: '$type implements List which implements Iterable; '
                'Iterable has no isAssignable predicate, so this needs a '
                'registered edge');
      });

      test('F-SCB20-8-$type: `is` narrows in a control-flow position '
          '[2026-07-28]', () {
        // `is` answering true in isolation is not the same as the interpreter
        // using it — this exercises the type test where a script would put it.
        final source = '''
        import 'dart:typed_data';
        String describe(Object o) {
          if (o is Iterable) return 'iterable';
          return 'other';
        }
        main() => describe($type.fromList([1, 2]));
        ''';
        expect(execute(source), equals('iterable'));
      });
    }
  });

  group('typed_data hierarchy: dispatch must not regress', () {
    // These four cases are the point of the whole group: registering supertype
    // edges changes `_filterToMostSpecific`, so the concrete view must still
    // win dispatch over List/Iterable/TypedData for its own members.
    for (final type in _views) {
      test('F-SCB20-20-$type: concrete members still resolve [2026-07-28]', () {
        final source = '''
        import 'dart:typed_data';
        main() {
          final l = $type.fromList([3, 1, 2]);
          l.sort();
          return [l[0], l.length, l.first];
        }
        ''';
        expect(execute(source), equals([1, 3, 1]),
            reason: 'the $type bridge must still own dispatch for its own '
                'members after the supertype edges are registered');
      });

      test('F-SCB20-21-$type: Iterable members still resolve [2026-07-28]',
          () {
        final source = '''
        import 'dart:typed_data';
        main() {
          final l = $type.fromList([1, 2, 3]);
          return [l.where((e) => e > 1).length, l.map((e) => e).length];
        }
        ''';
        expect(execute(source), equals([2, 3]));
      });

      test('F-SCB20-22-$type: bytesPerElement still resolves [2026-07-28]', () {
        // A typed-data-specific static, the member most likely to be lost if a
        // supertype bridge started winning.
        final source = '''
        import 'dart:typed_data';
        main() => $type.fromList([1, 2]).elementSizeInBytes;
        ''';
        expect(execute(source), isA<int>());
      });
    }

    test('F-SCB20-23: ByteData members still resolve [2026-07-28]', () {
      final source = '''
      import 'dart:typed_data';
      main() {
        final d = ByteData(8);
        d.setUint32(0, 42);
        return [d.getUint32(0), d.lengthInBytes];
      }
      ''';
      expect(execute(source), equals([42, 8]));
    });
  });
}
