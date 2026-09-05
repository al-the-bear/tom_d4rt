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

/// The element literal each variant's constructor accepts. Float variants
/// reject `int` literals, so the source has to be generated per element type
/// rather than shared.
String _element(String type, num value) =>
    type.startsWith('Float') ? '${value.toDouble()}' : '${value.toInt()}';

/// Every `List` operation that changes the length, and a call that genuinely
/// forces the change.
///
/// The forcing matters: `ListMixin` short-circuits several of these before it
/// ever reaches the length setter — `remove` on an absent element, `addAll([])`
/// and a `removeWhere` that removes nothing all return without touching the
/// length, so a careless call passes on a broken bridge. Each entry below
/// removes or adds at least one element.
Map<String, String> _lengthChangingCalls(String type) {
  final e = _element(type, 1);
  return {
    'add': 'l.add($e)',
    'addAll': 'l.addAll([$e])',
    'clear': 'l.clear()',
    'insert': 'l.insert(0, $e)',
    'insertAll': 'l.insertAll(0, [$e])',
    'remove': 'l.remove(l[0])',
    'removeAt': 'l.removeAt(0)',
    'removeLast': 'l.removeLast()',
    'removeRange': 'l.removeRange(0, 1)',
    'removeWhere': 'l.removeWhere((e) => true)',
    'replaceRange': 'l.replaceRange(0, 1, [$e, $e])',
    'retainWhere': 'l.retainWhere((e) => false)',
  };
}

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
        final source =
            '''
        import 'dart:typed_data';
        main() {
          final l = $type.fromList([3, 1, 2]);
          l.sort();
          return [l[0], l[1], l[2]];
        }
        ''';
        expect(
          execute(source),
          equals([1, 2, 3]),
          reason: 'sort() must resolve and reorder on $type',
        );
      });

      test(
        'F-SCB3-14-$type: sort() honours a custom comparator [2026-07-28]',
        () {
          final source =
              '''
        import 'dart:typed_data';
        main() {
          final l = $type.fromList([1, 3, 2]);
          l.sort((a, b) => b.compareTo(a));
          return [l[0], l[1], l[2]];
        }
        ''';
          expect(
            execute(source),
            equals([3, 2, 1]),
            reason: 'the comparator callback must cross the bridge on $type',
          );
        },
      );

      test(
        'F-SCB3-15-$type: shuffle() preserves the multiset [2026-07-28]',
        () {
          // Order after shuffling is not deterministic, so assert the invariant
          // that actually matters: nothing is lost or invented.
          final source =
              '''
        import 'dart:typed_data';
        main() {
          final l = $type.fromList([1, 2, 3, 4]);
          l.shuffle();
          final copy = l.toList();
          copy.sort();
          return [l.length, copy];
        }
        ''';
          expect(
            execute(source),
            equals([
              4,
              [1, 2, 3, 4],
            ]),
            reason: 'shuffle() must resolve on $type',
          );
        },
      );

      test('F-SCB3-16-$type: asUnmodifiableView() reads but rejects writes '
          '[2026-07-28]', () {
        final source =
            '''
        import 'dart:typed_data';
        main() {
          final l = $type.fromList([1, 2]);
          final v = l.asUnmodifiableView();
          var threw = false;
          try { v[0] = 9; } catch (e) { threw = true; }
          return [v.length, v[0], v[1], threw];
        }
        ''';
        expect(
          execute(source),
          equals([2, 1, 2, true]),
          reason: 'asUnmodifiableView() must resolve on $type',
        );
      });

      test('F-SCB3-17-$type: bytesPerElement is readable as a static '
          '[2026-07-28]', () {
        final source =
            '''
        import 'dart:typed_data';
        main() {
          return $type.bytesPerElement;
        }
        ''';
        expect(
          execute(source),
          equals(_bytesPerElement[type]),
          reason: '$type.bytesPerElement must resolve as a static',
        );
      });
    }
  });

  group('typed-data lists: length-changing operations still refuse', () {
    // The helper's exclusion rationale is corrected, not discarded: growing
    // operations genuinely are unsupported and must keep failing. Without this
    // the fix could over-reach and silently expose broken adapters.
    //
    // "Still refuses" is not enough, though. A script that guards a
    // fixed-length list defensively writes
    //
    //     try { list.addAll(more); } on UnsupportedError { … }
    //
    // and that only works if the *type* of the error is the SDK's. A bare
    // `catch (e)` assertion passes just as happily when the bridge raises
    // `RuntimeD4rtException` ("has no instance method named 'addAll'") or a
    // `_TypeError` from a failed argument cast — in both of those cases the
    // script above dies instead of taking its recovery path. So each case
    // below asserts the error type, not merely that something was thrown.
    //
    // One test per variant covering all twelve mutators, rather than 132
    // separate tests: the result map names the mutator that regressed, which
    // is the information a per-mutator test would have carried anyway.
    for (final type in _variants) {
      test('F-SCB3-18-$type: every length-changing operation raises a '
          'catchable UnsupportedError [2026-09-04]', () {
        final calls = _lengthChangingCalls(type);
        final e = _element(type, 1);
        final probes = calls.entries
            .map(
              (entry) =>
                  '''
          try {
            final l = $type.fromList([$e, $e, $e]);
            ${entry.value};
            out['${entry.key}'] = 'NO THROW';
          } on UnsupportedError catch (_) {
            out['${entry.key}'] = 'UnsupportedError';
          } catch (err) {
            out['${entry.key}'] = 'OTHER: ' + err.runtimeType.toString();
          }
''',
            )
            .join();
        final source =
            '''
        import 'dart:typed_data';
        main() {
          final out = <String, String>{};
$probes
          return out;
        }
        ''';
        expect(
          execute(source),
          equals({for (final name in calls.keys) name: 'UnsupportedError'}),
          reason:
              'on $type, each length-changing operation must let the '
              "native list's UnsupportedError reach the script",
        );
      });
    }
  });

  group(
    'typed-data lists: an interpreted list literal is a valid argument',
    () {
      // d4rt evaluates a list literal to `List<Object?>` — element types are
      // erased, and elements can arrive as `BridgedInstance` wrappers. An
      // adapter that writes `positionalArgs[0] as Iterable<int>` therefore
      // throws `_TypeError` before the native call happens, so
      //
      //   * members that should succeed fail outright, and
      //   * members that should raise `UnsupportedError` raise the wrong error.
      //
      // Passing a typed-data list instead of a literal masks the whole class of
      // bug (`l.followedBy(Uint8List.fromList([9]))` works fine), so every case
      // here deliberately passes a literal.
      for (final type in _variants) {
        test(
          'F-SCB3-20-$type: followedBy() accepts a list literal [2026-09-04]',
          () {
            final source =
                '''
        import 'dart:typed_data';
        main() {
          final l = $type.fromList([${_element(type, 1)}, ${_element(type, 2)}]);
          return l.followedBy([${_element(type, 9)}]).toList();
        }
        ''';
            expect(
              execute(source),
              equals([1, 2, 9]),
              reason: 'followedBy() must coerce the literal on $type',
            );
          },
        );

        test(
          'F-SCB3-21-$type: setAll() accepts a list literal [2026-09-04]',
          () {
            final source =
                '''
        import 'dart:typed_data';
        main() {
          final l = $type.fromList(
              [${_element(type, 1)}, ${_element(type, 2)}, ${_element(type, 3)}]);
          l.setAll(0, [${_element(type, 7)}, ${_element(type, 8)}]);
          return l.toList();
        }
        ''';
            expect(
              execute(source),
              equals([7, 8, 3]),
              reason: 'setAll() must coerce the literal on $type',
            );
          },
        );

        test(
          'F-SCB3-22-$type: setRange() accepts a list literal [2026-09-04]',
          () {
            final source =
                '''
        import 'dart:typed_data';
        main() {
          final l = $type.fromList(
              [${_element(type, 1)}, ${_element(type, 2)}, ${_element(type, 3)}]);
          l.setRange(0, 2, [${_element(type, 7)}, ${_element(type, 8)}]);
          return l.toList();
        }
        ''';
            expect(
              execute(source),
              equals([7, 8, 3]),
              reason: 'setRange() must coerce the literal on $type',
            );
          },
        );

        test(
          'F-SCB3-23-$type: operator+ accepts a list literal [2026-09-04]',
          () {
            final source =
                '''
        import 'dart:typed_data';
        main() {
          final l = $type.fromList([${_element(type, 1)}, ${_element(type, 2)}]);
          return (l + [${_element(type, 9)}]).toList();
        }
        ''';
            expect(
              execute(source),
              equals([1, 2, 9]),
              reason: 'operator+ must coerce the literal on $type',
            );
          },
        );
      }
    },
  );

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
