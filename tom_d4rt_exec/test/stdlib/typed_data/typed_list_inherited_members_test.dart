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

/// DGUC6: this package resolves `tom_d4rt_ast` from pub.dev, currently 0.42.0,
/// and SCC60 — which added the missing `asUint8ListView` adapter — ships in
/// 0.47.0. Exactly one case of this file observes that gap: `Uint8List` alone
/// hand-rolls its adapter map instead of sharing `inheritedListMethods<E>()`,
/// so it is the one variant whose `asUint8ListView` was added by hand and the
/// one the published copy still lacks. The other ten pass here, which is worth
/// stating because it inverts the usual intuition — the most-used variant is
/// the broken one, and a spot-check would read this file as fully green.
///
/// Skipped rather than re-pinned to the pre-fix exception, for the reason the
/// `stdlib/collection` files state at length: a pin keeps the suite green and
/// then needs a hand deletion nobody is watching for, and F-SCC6-5 requires a
/// `KNOWN-GAP` marker in BOTH trees — the reference copy has no gap to mark.
/// Un-skip and delete this constant in the commit that raises exec's
/// `tom_d4rt_ast` floor past 0.46.0.
const _scc60Skip =
    'pinned on the tom_d4rt_ast publish that carries SCC60 (0.47.0); '
    "exec resolves 0.42.0 — see this file's header";

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

  group('typed-data lists: the shared helper is not redundant with List', () {
    // A standing temptation, and one that was measured rather than argued.
    //
    // Since the supertype registry gained `Int8List -> List -> Iterable`
    // edges, a property access that misses on a typed view's own bridge falls
    // back to `lookupOnBridgedSupertypes`, which finds the `List` bridge. A
    // reader who checks only *resolution* concludes the explicit member lists
    // below are dead weight and deletes them.
    //
    // Resolution is not the question. The `List` bridge is generic over
    // `Object?`; a typed-data list is a `List<int>` / `List<double>` whose
    // element type is *reified* at the native boundary. So every member that
    // hands an iterable or a callback *into* the native call needs adapters
    // that supply the concrete `E` — which only a per-element-type adapter
    // can do. Routed through the `List` bridge:
    //
    //   * `followedBy([9])` passes `List<Object?>` where `Iterable<int>` is
    //     required and throws `_TypeError` (F-SCB3-20 covers this one);
    //   * `reduce((a, b) => a + b)` builds a `(dynamic, dynamic) => Object?`
    //     closure where `(int, int) => int` is required, and throws;
    //   * `firstWhere(..., orElse: () => 's')` silently returns the `String`
    //     instead of rejecting it.
    //
    // The two cases not already covered elsewhere are pinned below. They pass
    // today; they fail the moment the explicit lists are pruned, which is
    // exactly the signal a future pruner needs.
    for (final type in _variants) {
      test('F-SCC60-1-$type: reduce() reifies the combine callback to '
          '(E, E) => E [2026-09-06]', () {
        final source =
            '''
        import 'dart:typed_data';
        main() {
          final l = $type.fromList(
              [${_element(type, 1)}, ${_element(type, 2)}, ${_element(type, 3)}]);
          return l.reduce((a, b) => a + b);
        }
        ''';
        expect(
          execute(source),
          equals(type.startsWith('Float') ? 6.0 : 6),
          reason:
              'on $type, reduce() must pass the native call a closure typed '
              'over the element type, not over dynamic',
        );
      });

      test('F-SCC60-2-$type: firstWhere() rejects an orElse of the wrong '
          'element type [2026-09-06]', () {
        // `orElse` supplies the *element*, so a String where an int belongs is
        // a type error in Dart and must stay one here. The generic `List`
        // bridge would hand the String back to the script.
        final source =
            '''
        import 'dart:typed_data';
        main() {
          final l = $type.fromList([${_element(type, 1)}, ${_element(type, 2)}]);
          return l.firstWhere((e) => false, orElse: () => "s");
        }
        ''';
        expect(
          () => execute(source),
          throwsA(isA<TypeError>()),
          reason:
              'on $type, firstWhere() must enforce the element type of the '
              'orElse result',
        );
      });
    }
  });

  group('typed-data lists: asUint8ListView reaches every variant', () {
    // Found by diffing the eleven bridge files of `tom_d4rt` against their
    // `tom_d4rt_ast` twins: `Float64List` was the single file that differed,
    // and it was missing `buffer` and `asUint8ListView` from its `methods:`
    // map. Ten variants had them; one did not, on one side of the mirror only.
    //
    // A per-variant test is what makes that kind of one-off omission visible —
    // a spot-check on `Uint8List` or `Float32List` passes either way.
    for (final type in _variants) {
      test('F-SCC60-3-$type: asUint8ListView() views the whole buffer '
          '[2026-09-06]', () {
        final source =
            '''
        import 'dart:typed_data';
        main() {
          final l = $type.fromList([${_element(type, 1)}, ${_element(type, 2)}]);
          return l.asUint8ListView().length;
        }
        ''';
        expect(
          execute(source),
          equals(2 * _bytesPerElement[type]!),
          reason: 'asUint8ListView() must resolve on $type',
        );
      }, skip: type == 'Uint8List' ? _scc60Skip : null);
    }
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
