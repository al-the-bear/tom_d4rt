import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

/// SC2 — `dart:collection` `SplayTreeSet` bridge.
///
/// The defining property is that iteration is *sorted*, independent of
/// insertion order, and that the ordering is user-overridable through the
/// optional `compare` argument. Every assertion below therefore uses
/// `orderedEquals` on a deliberately shuffled input — an unordered assertion
/// would pass against any `Set` bridge and pin nothing.
void main() {
  final d4rt = D4rt();

  group('SC2: SplayTreeSet collection bridge', () {
    test(
      'F-SC2-11: SplayTreeSet() iterates in natural sorted order [2026-07-27]',
      () {
        final result =
            d4rt.execute(
                  source: '''
          import 'dart:collection';
          main() {
            final set = SplayTreeSet();
            set.add(30);
            set.add(10);
            set.add(20);
            return [set.toList(), set.length, set.first, set.last];
          }
        ''',
                )
                as List;
        expect(
          result[0],
          orderedEquals([10, 20, 30]),
          reason: 'sorted regardless of insertion order',
        );
        expect(result[1], 3, reason: 'length');
        expect(result[2], 10, reason: 'first is the smallest');
        expect(result[3], 30, reason: 'last is the largest');
      },
    );

    test(
      'F-SC2-12: SplayTreeSet(compare) honours a custom comparator [2026-07-27]',
      () {
        final result =
            d4rt.execute(
                  source: '''
          import 'dart:collection';
          main() {
            final set = SplayTreeSet((a, b) => (b as int).compareTo(a as int));
            set.addAll([1, 3, 2]);
            return [set.toList(), set.first, set.last];
          }
        ''',
                )
                as List;
        expect(result[0], orderedEquals([3, 2, 1]), reason: 'reverse order');
        expect(result[1], 3, reason: 'first under the reverse comparator');
        expect(result[2], 1, reason: 'last under the reverse comparator');
      },
    );

    test(
      'F-SC2-13: SplayTreeSet.from() / .of(), with and without a comparator [2026-07-27]',
      () {
        final result =
            d4rt.execute(
                  source: '''
          import 'dart:collection';
          main() {
            final a = SplayTreeSet.from([5, 1, 3, 1]);
            final b = SplayTreeSet.of(['pear', 'fig', 'banana']);
            final c = SplayTreeSet.from(
                [5, 1, 3], (x, y) => (y as int).compareTo(x as int));
            return [a.toList(), b.toList(), c.toList()];
          }
        ''',
                )
                as List;
        expect(
          result[0],
          orderedEquals([1, 3, 5]),
          reason: 'from() dedups and sorts',
        );
        expect(
          result[1],
          orderedEquals(['banana', 'fig', 'pear']),
          reason: 'of() sorts strings',
        );
        expect(
          result[2],
          orderedEquals([5, 3, 1]),
          reason: 'from() with a comparator',
        );
      },
    );

    test(
      'F-SC2-14: sort order is maintained across add / remove / clear [2026-07-27]',
      () {
        final result =
            d4rt.execute(
                  source: '''
          import 'dart:collection';
          main() {
            final set = SplayTreeSet.from([50, 10, 30]);
            set.add(20);
            set.add(40);
            final removed = set.remove(30);
            final missing = set.remove(99);
            final order = set.toList();
            set.clear();
            return [removed, missing, order, set.isEmpty, set.isNotEmpty];
          }
        ''',
                )
                as List;
        expect(result[0], true, reason: 'remove existing');
        expect(result[1], false, reason: 'remove absent');
        expect(
          result[2],
          orderedEquals([10, 20, 40, 50]),
          reason: 'still sorted after interleaved add/remove',
        );
        expect(result[3], true, reason: 'isEmpty after clear');
        expect(result[4], false, reason: 'isNotEmpty after clear');
      },
    );

    test(
      'F-SC2-15: forEach / map / where iterate in sorted order [2026-07-27]',
      () {
        final result =
            d4rt.execute(
                  source: '''
          import 'dart:collection';
          main() {
            final set = SplayTreeSet.from([3, 1, 4, 1, 5, 9]);
            final seen = [];
            set.forEach((e) { seen.add(e); });
            final doubled = set.map((e) => e * 2).toList();
            final odd = set.where((e) => e % 2 == 1).toList();
            return [seen, doubled, odd];
          }
        ''',
                )
                as List;
        expect(
          result[0],
          orderedEquals([1, 3, 4, 5, 9]),
          reason: 'forEach order',
        );
        expect(
          result[1],
          orderedEquals([2, 6, 8, 10, 18]),
          reason: 'map order',
        );
        expect(result[2], orderedEquals([1, 3, 5, 9]), reason: 'where order');
      },
    );

    test(
      'F-SC2-16: set algebra — containsAll / removeAll / retainAll [2026-07-27]',
      () {
        final result =
            d4rt.execute(
                  source: '''
          import 'dart:collection';
          main() {
            final a = SplayTreeSet.from(['d', 'b', 'a', 'c']);
            final all = a.containsAll(['b', 'd']);
            final none = a.containsAll(['b', 'z']);
            a.removeAll(['a', 'c']);
            final afterRemove = a.toList();

            final b = SplayTreeSet.from([5, 4, 3, 2, 1]);
            b.retainAll([5, 2]);
            return [all, none, afterRemove, b.toList()];
          }
        ''',
                )
                as List;
        expect(result[0], true, reason: 'containsAll present');
        expect(result[1], false, reason: 'containsAll with an absent element');
        expect(result[2], orderedEquals(['b', 'd']), reason: 'after removeAll');
        expect(
          result[3],
          orderedEquals([2, 5]),
          reason: 'retainAll stays sorted',
        );
      },
    );

    test(
      'F-SC2-17: removeWhere / retainWhere / any / every / fold [2026-07-27]',
      () {
        final result =
            d4rt.execute(
                  source: '''
          import 'dart:collection';
          main() {
            final a = SplayTreeSet.from([6, 5, 4, 3, 2, 1]);
            a.removeWhere((e) => e % 2 == 0);
            final b = SplayTreeSet.from([6, 5, 4, 3, 2, 1]);
            b.retainWhere((e) => e > 4);
            final c = SplayTreeSet.from([6, 4, 2]);
            return [
              a.toList(), b.toList(),
              c.any((e) => e > 5), c.any((e) => e > 9),
              c.every((e) => e % 2 == 0),
              c.fold(0, (acc, e) => acc + e),
            ];
          }
        ''',
                )
                as List;
        expect(result[0], orderedEquals([1, 3, 5]), reason: 'removeWhere');
        expect(result[1], orderedEquals([5, 6]), reason: 'retainWhere');
        expect(result[2], true, reason: 'any true');
        expect(result[3], false, reason: 'any false');
        expect(result[4], true, reason: 'every');
        expect(result[5], 12, reason: 'fold');
      },
    );

    test('F-SC2-18: lookup / elementAt / join / take / skip [2026-07-27]', () {
      final result =
          d4rt.execute(
                source: '''
          import 'dart:collection';
          main() {
            final set = SplayTreeSet.from(['three', 'one', 'two']);
            return [
              set.lookup('two'),
              set.lookup('four'),
              set.elementAt(0),
              set.join('-'),
              set.take(2).toList(),
              set.skip(2).toList(),
            ];
          }
        ''',
              )
              as List;
      expect(result[0], 'two', reason: 'lookup hit');
      expect(result[1], null, reason: 'lookup miss');
      expect(result[2], 'one', reason: 'elementAt follows sorted order');
      expect(result[3], 'one-three-two', reason: 'join follows sorted order');
      expect(result[4], orderedEquals(['one', 'three']), reason: 'take');
      expect(result[5], orderedEquals(['two']), reason: 'skip');
    });

    test(
      'F-SC2-19: first on an empty set raises a StateError [2026-07-27]',
      () {
        // SCC51: the expected family changed from RuntimeD4rtException to
        // StateError. The bridge used to catch the SDK's StateError and rethrow
        // a hand-written message; it now inherits Set's delegating adapter, so
        // the SDK's own error reaches the script and the `on StateError catch`
        // a Dart author writes actually fires.
        expect(
          () => d4rt.execute(
            source: '''
          import 'dart:collection';
          main() { return SplayTreeSet().first; }
        ''',
          ),
          throwsA(isA<StateError>()),
        );
      },
    );

    test(
      'F-SC2-20: a non-function compare argument is rejected [2026-07-27]',
      () {
        expect(
          () => d4rt.execute(
            source: '''
          import 'dart:collection';
          main() { return SplayTreeSet(42); }
        ''',
          ),
          throwsA(isA<RuntimeD4rtException>()),
        );
      },
    );
  });

  // SCC50: the members `SplayTreeSet` declares ITSELF, as opposed to the
  // `Iterable` conveniences the bridge also carries.
  //
  // WHY THIS GROUP EXISTS, AND WHY IT IS NOT WHAT WAS EXPECTED. It was filed as
  // "bridge `SplayTreeSet.firstAfter` / `lastBefore`, the ordered neighbour
  // queries that are the whole reason to pick a splay tree". Those members do
  // not exist. Measured against the Dart 3.12.2 SDK
  // (`dart-sdk/lib/collection/splay_tree.dart`): `firstKeyAfter` /
  // `lastKeyBefore` are declared on `SplayTreeMap` only, and `SplayTreeSet`'s
  // complete public surface is
  //
  //     cast iterator length isEmpty isNotEmpty first last single contains
  //     add remove addAll removeAll retainAll lookup intersection difference
  //     union clear toSet toString
  //
  // — every one of which `Set` also declares. So `SplayTreeSet` has NO
  // leaf-only member, the bridge was never missing one, and a member-level
  // discrimination test for this type cannot be written at all. This is a
  // property of the SDK, not a gap in the bridge.
  //
  // WHAT IS ACTUALLY WORTH PINNING, then, is not which members exist but what
  // they RETURN. `union` / `intersection` / `difference` / `toSet` are declared
  // on `Set` returning `Set`, and `SplayTreeSet` overrides all four to return a
  // *sorted* set (`_filter` and `_clone` both build a `SplayTreeSet`). That
  // override is the leaf behaviour, it is observable from a script, and none of
  // it had coverage — the bridge routes these through `setAlgebraMethods`,
  // whose `coerce` is `(t) => t as Set`, so an implementation that copied into
  // a plain `Set` first would lose the ordering silently and every existing
  // assertion in this file would still pass.
  group('SCC50: the leaf-declared surface of SplayTreeSet', () {
    // Inserted out of order throughout, so a result that merely echoed
    // insertion order would be visible.
    const build = 'final s = SplayTreeSet(); s.addAll([5, 1, 9, 3]); ';

    Object? run(String body) =>
        d4rt.execute(source: "import 'dart:collection';\nmain() {\n$body\n}\n");

    test('F-SCC50-1: union() returns a sorted set [2026-09-06]', () {
      expect(
        run('$build return s.union({7, 0}).toList();'),
        orderedEquals([0, 1, 3, 5, 7, 9]),
        reason:
            'THE LEAF ASSERTION. `SplayTreeSet.union` is `_clone()..addAll`, '
            'so the result is a SplayTreeSet and the added elements sort into '
            'place. A LinkedHashSet given the same input yields '
            '[5, 1, 9, 3, 7, 0] — F-SCB17-7 uses exactly that contrast as the '
            'set-side dispatch discriminator.',
      );
    });

    test('F-SCC50-2: intersection() returns a sorted set [2026-09-06]', () {
      expect(
        run('$build return s.intersection({9, 1, 4}).toList();'),
        orderedEquals([1, 9]),
        reason:
            'The argument is written {9, 1, 4} rather than {1, 9, 4} so that '
            'an implementation iterating the ARGUMENT and collecting hits '
            'would produce [9, 1] and fail here.',
      );
    });

    test('F-SCC50-3: difference() returns a sorted set [2026-09-06]', () {
      expect(
        run('$build return s.difference({1, 9}).toList();'),
        orderedEquals([3, 5]),
      );
    });

    test(
      'F-SCC50-4: toSet() returns a sorted, independent copy [2026-09-06]',
      () {
        expect(
          run(
            '$build final copy = s.toSet(); s.add(2); '
            'return [copy.toList(), s.toList()];',
          ),
          equals([
            [1, 3, 5, 9],
            [1, 2, 3, 5, 9],
          ]),
          reason:
              'Two claims in one: the copy is sorted, and it is a copy — '
              '`toSet()` is `_clone()`, so a later mutation of the original must '
              'not reach it. An adapter returning `target` itself would pass a '
              'sortedness check alone.',
        );
      },
    );

    test('F-SCC50-5: cast() preserves the sorted order [2026-09-06]', () {
      // `cast` is the one member of the four that does NOT return a
      // SplayTreeSet — the SDK gives a lazy `CastSet` view over it — so the
      // ordering survives by delegation rather than by type.
      expect(
        run('$build return s.cast().toList();'),
        orderedEquals([1, 3, 5, 9]),
      );
    });

    test('F-SCC50-6: single and clear behave on the leaf [2026-09-06]', () {
      expect(run('final s = SplayTreeSet(); s.add(4); return s.single;'), 4);
      expect(
        run('$build s.clear(); return [s.length, s.isEmpty, s.toList()];'),
        equals([0, true, []]),
      );
    });

    test('F-SCC50-7: lookup() returns null for a miss [2026-09-06]', () {
      // `E? lookup(Object?)` — declared nullable in the SDK. Guarding this the
      // way `firstKey` was once guarded (throw "set is empty") is the mistake
      // I-COLL-78 had to undo on the map side; this pins that it was not
      // repeated here.
      expect(
        run('$build return [s.lookup(9), s.lookup(4)];'),
        equals([9, null]),
      );
    });

    test('F-SCC50-8: the SDK declares no firstAfter / lastBefore '
        '[2026-09-06]', () {
      // NOT a wish-list item, and deliberately asserted rather than left as a
      // comment. This todo was filed on the belief that these two members exist
      // and were unbridged; they do not exist, so bridging them would invent
      // API that native Dart does not have. If a future SDK adds them this test
      // still passes — the interpreter would need the adapter before the call
      // resolves — but the reasoning above it is what a reader needs, and it is
      // anchored to a failing call rather than floating in prose.
      expect(
        () => run('$build return s.firstAfter(3);'),
        throwsA(anything),
        reason:
            'SplayTreeSet.firstAfter is not a Dart member; `dart analyze` '
            'rejects the same call in native code',
      );
      expect(() => run('$build return s.lastBefore(3);'), throwsA(anything));
    });
  });
}
