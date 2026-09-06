// SCB17: the reachable surface of the bridged `dart:collection` map and set
// types, once the hierarchy edges exist.
//
// SCB17 was filed as a hierarchy bug — "`HashMap is Map` is false and the
// inherited surface is unreachable". The hierarchy half was closed by SCB7,
// which added `CollectionHierarchyCollection`; probing every map and set bridge
// member-by-member confirms it. What the probe found instead were three
// defects in a DIFFERENT family, none of which the queue findings predicted:
//
//   1. **A hand-written adapter shadows a correct inherited one.** `HashMap`
//      and `LinkedHashMap` each carry their own `addEntries`, and both do
//      `newEntries.cast()` — which does not unwrap a `BridgedInstance<MapEntry>`
//      produced by interpreted `MapEntry("a", 1)`. `MapCore.addEntries` unwraps
//      correctly, and `SplayTreeMap` — which has no `addEntries` adapter of its
//      own — worked precisely because the SCB7 edge let it inherit that one.
//      So the hierarchy fix did not just enable the inherited surface; it made
//      the duplicated copies redundant, and the redundant copies were the buggy
//      ones. The fix deletes them rather than adding a third copy of the
//      unwrap.
//
//   2. **`Iterator` implementation types are a hand-maintained allowlist.**
//      `BridgedClass.nativeNames` enumerates the SDK's private iterator classes
//      by name, and it listed three. Everything else — `_CompactIterator`
//      (every `LinkedHashSet`, `UnmodifiableSetView` and map key/value view),
//      `_SplayTreeKeyIterator`, `_HashMapKeyIterator` — failed with "Undefined
//      property or method 'moveNext'". Manual iteration was therefore
//      impossible for all but a `List`.
//
//   3. **`_SplayTreeMapEntryIterable` was missing from the `Iterable`
//      allowlist**, so `SplayTreeMap.entries` was unusable while
//      `HashMap.entries` was fine.
//
// The allowlist is structurally wrong — it can only ever be as complete as the
// last person to hit a gap — but widening it is the narrow fix, and replacing
// it with a native-`is` fallback would change which bridge OWNS an object,
// which is the exact hazard `CollectionHierarchyCollection` documents. That
// replacement is tracked separately.

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

void main() {
  Object? run(String body) => D4rt().execute(
    source:
        '''
          import 'dart:collection';
          main() {
            $body
          }
        ''',
  );

  group('SCB17: inherited surface of bridged maps and sets', () {
    test('F-SCB17-1: addEntries accepts an interpreted MapEntry on every '
        'mutable map [2026-07-28]', () {
      for (final ctor in [
        'HashMap<String, int>()',
        'LinkedHashMap<String, int>()',
        'SplayTreeMap<String, int>()',
        '<String, int>{}', // a map literal is a LinkedHashMap
      ]) {
        expect(
          run(
            'final m = $ctor; '
            'm.addEntries([MapEntry("a", 1), MapEntry("b", 2)]); '
            'return m["a"] + m["b"];',
          ),
          3,
          reason: '$ctor.addEntries should unwrap interpreted MapEntry values',
        );
      }
    });

    test('F-SCB17-2: addEntries still accepts native entries from another '
        "map's .entries [2026-07-28]", () {
      // The pre-existing route, which worked before the shadowing adapters
      // were removed. It must keep working.
      expect(
        run(
          'final m = HashMap<String, int>(); '
          'm.addEntries(<String, int>{"a": 1}.entries); return m["a"];',
        ),
        1,
      );
    });

    test(
      'F-SCB17-3: `.iterator` is usable on every bridged set [2026-07-28]',
      () {
        for (final ctor in [
          'HashSet<int>()',
          'LinkedHashSet<int>()',
          'SplayTreeSet<int>()',
          '<int>{}', // a set literal is a LinkedHashSet
        ]) {
          expect(
            run(
              'final s = $ctor..addAll([7]); '
              'final it = s.iterator; '
              'return it.moveNext() ? it.current : -1;',
            ),
            7,
            reason: '$ctor.iterator should be able to move and read',
          );
        }
        expect(
          run(
            'final s = UnmodifiableSetView<int>(<int>{7}); '
            'final it = s.iterator; '
            'return it.moveNext() ? it.current : -1;',
          ),
          7,
        );
      },
    );

    test('F-SCB17-4: `.iterator` is usable on every map key/value/entry view '
        '[2026-07-28]', () {
      for (final ctor in [
        'HashMap<String, int>()',
        'LinkedHashMap<String, int>()',
        'SplayTreeMap<String, int>()',
      ]) {
        expect(
          run(
            'final m = $ctor..addAll({"a": 1}); '
            'final it = m.keys.iterator; '
            'return it.moveNext() ? it.current : "none";',
          ),
          'a',
          reason: '$ctor.keys.iterator should move',
        );
        expect(
          run(
            'final m = $ctor..addAll({"a": 1}); '
            'final it = m.values.iterator; '
            'return it.moveNext() ? it.current : -1;',
          ),
          1,
          reason: '$ctor.values.iterator should move',
        );
        expect(
          run(
            'final m = $ctor..addAll({"a": 1}); '
            'final it = m.entries.iterator; '
            'return it.moveNext() ? it.current.key : "none";',
          ),
          'a',
          reason: '$ctor.entries.iterator should move',
        );
      }
    });

    test(
      'F-SCB17-5: SplayTreeMap.entries is a usable Iterable [2026-07-28]',
      () {
        expect(
          run(
            'final m = SplayTreeMap<String, int>()..addAll({"b": 2, "a": 1}); '
            'return m.entries.length;',
          ),
          2,
        );
        expect(
          run(
            'final m = SplayTreeMap<String, int>()..addAll({"b": 2, "a": 1}); '
            'return m.entries.first.key;',
          ),
          'a',
        );
        expect(
          run(
            'final m = SplayTreeMap<String, int>()..addAll({"b": 2, "a": 1}); '
            'return m.entries.map((e) => e.value).toList();',
          ),
          [1, 2],
        );
      },
    );

    test('F-SCB17-6: `.iterator` reaches the end and stops [2026-07-28]', () {
      // Guards against an adapter that returns a fresh iterator per access —
      // the loop would never terminate.
      expect(
        run(
          'final s = LinkedHashSet<int>()..addAll([1, 2, 3]); '
          'final it = s.iterator; '
          'var total = 0; '
          'while (it.moveNext()) { total += it.current; } '
          'return total;',
        ),
        6,
      );
    });

    test('F-SCB17-7: widening the allowlist does not cost leaf dispatch '
        '[2026-07-28]', () {
      // The SC7 analogue of F-SC7-5. Claiming a native object for a supertype
      // bridge would let the supertype steal dispatch from the concrete one;
      // these are the members that only exist on the leaf.
      expect(
        run(
          'final m = SplayTreeMap<String, int>()..addAll({"b": 2, "a": 1}); '
          'return m.firstKey();',
        ),
        'a',
      );
      expect(
        () => run('final m = HashMap<String, int>(); return m.firstKey();'),
        throwsA(anything),
        reason: 'HashMap must not inherit SplayTreeMap members',
      );
      // The set side, which needs a different shape of assertion. `SplayTreeSet`
      // declares no leaf-only MEMBER — measured against the Dart 3.12.2 SDK, its
      // entire public surface is also on `Set` — so there is no set-side
      // analogue of `firstKey` to call and no member-existence test to write.
      // (An earlier note here claimed the ordered surface `firstAfter` /
      // `lastBefore` was missing from the bridge and tracked that as a gap.
      // Those members do not exist in Dart at all; nothing was missing.)
      //
      // What the leaf does own is BEHAVIOUR: `union` / `intersection` /
      // `difference` / `toSet` are overridden to return a sorted set, so the
      // same call through a supertype-coerced `LinkedHashSet` gives insertion
      // order. That contrast discriminates dispatch just as sharply as a
      // missing member, and unlike a member check it cannot pass vacuously.
      expect(
        run(
          'final s = SplayTreeSet<int>()..addAll([5, 1, 9]); '
          'return s.union(<int>{7, 0}).toList();',
        ),
        orderedEquals([0, 1, 5, 7, 9]),
        reason: 'the SplayTreeSet leaf sorts the union',
      );
      expect(
        run(
          'final s = LinkedHashSet<int>()..addAll([5, 1, 9]); '
          'return s.union(<int>{7, 0}).toList();',
        ),
        orderedEquals([5, 1, 9, 7, 0]),
        reason:
            'the non-vacuity guard: if this also came back sorted, the '
            'assertion above would be measuring the SDK rather than dispatch',
      );
      expect(
        () => run(
          'final s = UnmodifiableSetView<int>(<int>{1}); '
          'return s.add(2);',
        ),
        throwsA(anything),
        reason: 'the unmodifiable view must keep its own rejecting add',
      );
    });
  });
}
