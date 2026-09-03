// SCB3: in-place List operations and `bytesPerElement` must be reachable on
// every typed-data list, not just Uint8List.
//
// The mechanical member diff (tool/stdlib_member_diff.dart) found a systematic
// asymmetry: `sort`, `shuffle` and `asUnmodifiableView` resolved on `Uint8List`
// but on none of the other nine typed lists. The cause is that `Uint8List`
// hand-rolls its whole adapter map while the others share
// `inheritedListMethods<E>()`, whose doc comment excluded "mutating" operations
// on the stated grounds that typed-data lists are fixed-length and such calls
// "would throw UnsupportedError at runtime".
//
// That rationale conflates two different things. Typed-data lists are
// fixed-*length*, not immutable — `sort` and `shuffle` reorder in place without
// changing length and are fully supported by the SDK (which is exactly why
// `Uint8List` could carry its own `sort`). Only the length-*changing*
// operations (`add`, `insert`, `remove`, `clear`, …) throw.
//
// A spot-check would never have caught this: `Uint8List` is by far the most
// commonly used typed list, and it is the one variant that worked.
//
// PINNED TO THE PUBLISHED INTERPRETER — this file is deliberately one revision
// behind its `tom_d4rt` twin, and it is registered in `_divergentBaseline` in
// `test/conformance_drift_test.dart` for that reason.
//
// `tom_d4rt_exec` resolves `tom_d4rt_ast` from pub.dev, not from the working
// tree, so this suite measures the PUBLISHED bridge. The twin now asserts that
// every length-changing operation raises a *catchable* `UnsupportedError` and
// that `followedBy` / `setAll` / `setRange` / `operator+` accept an interpreted
// list literal; the published typed-data bridge still casts its element
// argument (`positionalArgs[n] as Iterable<E>`) and so fails all of those with
// a `_TypeError`. Measured 2026-09-04: copying the twin over this file gives 66
// pass / 45 fail, all 45 for that dependency reason rather than an assertion
// reason — which is the one failure mode that teaches a reader to ignore the
// suite.
//
// FLIP CONDITION: the next `tom_d4rt_ast` publish that carries the coercion
// fix, plus the constraint bump in this package's `pubspec.yaml`. At that point
// copy `tom_d4rt/test/stdlib/typed_data/typed_list_inherited_members_test.dart`
// over this file verbatim, rewrite the interpreter import, and drop the
// `_divergentBaseline` entry — the port recipe, unchanged.

import '../../interpreter_test.dart';
import 'package:test/test.dart';

/// Every typed-data list variant, with a literal the constructor accepts.
const _variants = <String>[
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

/// `bytesPerElement` is a `static const int` on each variant — a different
/// value per type, which is the whole point of reading it.
const _bytesPerElement = <String, int>{
  'Uint8List': 1,
  'Uint8ClampedList': 1,
  'Uint16List': 2,
  'Uint32List': 4,
  'Uint64List': 8,
  'Int8List': 1,
  'Int16List': 2,
  'Int32List': 4,
  'Int64List': 8,
  'Float32List': 4,
  'Float64List': 8,
};

void main() {
  group('typed-data lists: in-place List operations', () {
    // One test per variant rather than one loop inside a single test, so a
    // failure names the variant that regressed instead of just the first.
    for (final type in _variants) {
      test('F-SCB3-13-$type: sort() orders in place [2026-07-28]', () {
        final source = '''
        import 'dart:typed_data';
        main() {
          final l = $type.fromList([3, 1, 2]);
          l.sort();
          return [l[0], l[1], l[2]];
        }
        ''';
        expect(execute(source), equals([1, 2, 3]),
            reason: 'sort() must resolve and reorder on $type');
      });

      test('F-SCB3-14-$type: sort() honours a custom comparator [2026-07-28]',
          () {
        final source = '''
        import 'dart:typed_data';
        main() {
          final l = $type.fromList([1, 3, 2]);
          l.sort((a, b) => b.compareTo(a));
          return [l[0], l[1], l[2]];
        }
        ''';
        expect(execute(source), equals([3, 2, 1]),
            reason: 'the comparator callback must cross the bridge on $type');
      });

      test('F-SCB3-15-$type: shuffle() preserves the multiset [2026-07-28]',
          () {
        // Order after shuffling is not deterministic, so assert the invariant
        // that actually matters: nothing is lost or invented.
        final source = '''
        import 'dart:typed_data';
        main() {
          final l = $type.fromList([1, 2, 3, 4]);
          l.shuffle();
          final copy = l.toList();
          copy.sort();
          return [l.length, copy];
        }
        ''';
        expect(execute(source), equals([4, [1, 2, 3, 4]]),
            reason: 'shuffle() must resolve on $type');
      });

      test('F-SCB3-16-$type: asUnmodifiableView() reads but rejects writes '
          '[2026-07-28]', () {
        final source = '''
        import 'dart:typed_data';
        main() {
          final l = $type.fromList([1, 2]);
          final v = l.asUnmodifiableView();
          var threw = false;
          try { v[0] = 9; } catch (e) { threw = true; }
          return [v.length, v[0], v[1], threw];
        }
        ''';
        expect(execute(source), equals([2, 1, 2, true]),
            reason: 'asUnmodifiableView() must resolve on $type');
      });

      test('F-SCB3-17-$type: bytesPerElement is readable as a static '
          '[2026-07-28]', () {
        final source = '''
        import 'dart:typed_data';
        main() {
          return $type.bytesPerElement;
        }
        ''';
        expect(execute(source), equals(_bytesPerElement[type]),
            reason: '$type.bytesPerElement must resolve as a static');
      });
    }
  });

  group('typed-data lists: length-changing operations still refuse', () {
    // The helper's exclusion rationale is corrected, not discarded: growing
    // operations genuinely are unsupported and must keep failing. Without this
    // the fix could over-reach and silently expose broken adapters.
    test('F-SCB3-18: add() on a fixed-length typed list throws [2026-07-28]',
        () {
      const source = '''
      import 'dart:typed_data';
      main() {
        final l = Float32List.fromList([1.0]);
        var threw = false;
        try { l.add(2.0); } catch (e) { threw = true; }
        return threw;
      }
      ''';
      expect(execute(source), isTrue);
    });
  });

  group('typed-data lists: sort is not accidentally aliased', () {
    test('F-SCB3-19: Float32List sorts by numeric value, not lexically '
        '[2026-07-28]', () {
      // 10 vs 9 distinguishes a real numeric sort from a string comparison.
      const source = '''
      import 'dart:typed_data';
      main() {
        final l = Float32List.fromList([10.0, 9.0, 100.0]);
        l.sort();
        return [l[0], l[1], l[2]];
      }
      ''';
      expect(execute(source), equals([9.0, 10.0, 100.0]));
    });
  });
}
