// SCC51: adapters a subtype bridge redeclares from its supertype bridge.
//
// SCB17 found one by accident. `HashMap` and `LinkedHashMap` each carried a
// local `addEntries` doing `newEntries.cast()`, which cannot unwrap the
// `BridgedInstance<MapEntry>` an interpreted `MapEntry(...)` produces, while
// `MapCore`'s copy unwraps correctly. `SplayTreeMap` had no local copy and
// therefore already worked. The defect was visible only because one of three
// siblings lacked the duplicate; where every sibling carries the same divergent
// copy there is no asymmetry and nothing to notice.
//
// WHAT THE CENSUS MEASURED (2026-09-06). Intersecting each collection bridge's
// adapter keys with its registered supertypes' gives **315 shadowed members** —
// far too many to diff by hand, and far too many for the "assert the shadow set
// is empty except for an allowlist" test this was originally scoped as. An
// allowlist of three hundred names is noise a reader learns to skip.
//
// So the shadow set is not the measurement. Two adapters having the same NAME
// costs nothing; only their behaving DIFFERENTLY does. `F-SCC51-8` below is
// therefore differential: it invokes both adapters on the same native object
// with the same arguments and compares the outcomes. That reduced 315 pairs to
// a handful of real differences, and it keeps working as bridges change,
// which a name allowlist would not.
//
// WHAT IT FOUND. `first`, `last` and `single` were hand-written on six
// collection bridges, and each one caught the SDK's `StateError` (or
// pre-empted it with a length check) and threw a `RuntimeD4rtException`
// carrying a hand-written message instead. So:
//
//     try { return s.single; } on StateError catch (e) { ... }
//
// caught nothing on any `dart:collection` type, and nothing on a set literal
// either — while the identical script over a `List` worked, because the `List`
// bridge has no hand-written copy and delegates. Seventeen adapters across
// `hash_set`, `linked_hash_set`, `splay_tree_set`, `list_queue`,
// `double_linked_queue`, `queue`, `linked_list` and `unmodifiable_list_view`.
//
// This is the same instinct that produced the SCC10 finding — `SplayTreeMap`'s
// `firstKey` hand-throwing "Map is empty" where the SDK returns `null` — and
// the same instinct behind `addEntries`: a local copy written to improve on the
// SDK, which silently changes the contract. The fix deletes the copies rather
// than correcting them in place, because the inherited one is already right.
//
// `UnmodifiableMapView.addEntries` went with them: byte-for-byte the `.cast()`
// shape SCB17 deleted from `HashMap` and `LinkedHashMap`, unobservable today
// only because `cast()` is lazy and the view throws `UnsupportedError` before
// it ever iterates.
//
// AFTER THE DELETIONS the differential set is EMPTY — 281 shadowed pairs, zero
// behavioural differences — so `F-SCC51-8` asserts emptiness with no allowlist
// at all. 261 further pairs are skipped because their arguments are callbacks
// the harness cannot synthesise natively; that gap is real and tracked.

import 'dart:collection';

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/src/module_loader.dart';
import 'package:tom_d4rt/src/stdlib/collection.dart';

/// A fresh native fixture per call, so a mutating member cannot leak state from
/// the subtype invocation into the supertype one.
typedef Fixture = Object Function();

final Map<String, Fixture> _fixtures = {
  'HashMap': () => HashMap<dynamic, dynamic>.from({'a': 1, 'b': 2}),
  'LinkedHashMap': () => LinkedHashMap<dynamic, dynamic>.from({'a': 1, 'b': 2}),
  'SplayTreeMap': () => SplayTreeMap<dynamic, dynamic>.from({'a': 1, 'b': 2}),
  'UnmodifiableMapView': () =>
      UnmodifiableMapView<dynamic, dynamic>({'a': 1, 'b': 2}),
  'HashSet': () => HashSet<dynamic>.of([3, 1, 2]),
  // A Dart set literal already *is* a `LinkedHashSet` — which is why spelling
  // the constructor out here trips `prefer_collection_literals`. Same value as
  // 'Set' below, reached through the other bridge name on purpose.
  'LinkedHashSet': () => <dynamic>{3, 1, 2},
  'SplayTreeSet': () => SplayTreeSet<dynamic>.of([3, 1, 2]),
  'UnmodifiableSetView': () => UnmodifiableSetView<dynamic>(<dynamic>{3, 1, 2}),
  'UnmodifiableListView': () => UnmodifiableListView<dynamic>([3, 1, 2]),
  'DoubleLinkedQueue': () => DoubleLinkedQueue<dynamic>.of([3, 1, 2]),
  'ListQueue': () => ListQueue<dynamic>.of([3, 1, 2]),
  'Set': () => <dynamic>{3, 1, 2},
  'List': () => <dynamic>[3, 1, 2],
};

/// Positional arguments by member name. Members absent here take none.
final Map<String, List<Object?>> _args = {
  '[]': ['a'],
  'containsKey': ['a'],
  'containsValue': [1],
  'remove': ['a'],
  'contains': [1],
  'add': [9],
  'lookup': [1],
  'elementAt': [0],
  'skip': [1],
  'take': [1],
  'join': ['-'],
  'indexOf': [1],
  'lastIndexOf': [1],
  'removeAt': [0],
  'sublist': [0, 1],
  'getRange': [0, 2],
  'containsAll': [
    <dynamic>[1],
  ],
  'removeAll': [
    <dynamic>[1],
  ],
  'retainAll': [
    <dynamic>[1, 2, 3],
  ],
  'union': [
    <dynamic>{7},
  ],
  'intersection': [
    <dynamic>{1},
  ],
  'difference': [
    <dynamic>{1},
  ],
  'addAll': [
    <dynamic>[9],
  ],
};

/// Per-`<class>.<member>` overrides, for members whose argument type depends on
/// the receiver — `Map.addAll` takes a map where `Iterable.addAll` takes a list.
final Map<String, List<Object?>> _classArgs = {
  for (final m in [
    'HashMap',
    'LinkedHashMap',
    'SplayTreeMap',
    'UnmodifiableMapView',
  ])
    '$m.addAll': [
      <dynamic, dynamic>{'c': 3},
    ],
};

/// Members taking a callback or otherwise needing an interpreted value the
/// harness cannot synthesise natively. These are counted, not silently dropped,
/// so the coverage gap stays visible in the test output.
const _needsCallable = {
  'map',
  'where',
  'forEach',
  'any',
  'every',
  'firstWhere',
  'lastWhere',
  'singleWhere',
  'fold',
  'reduce',
  'expand',
  'removeWhere',
  'retainWhere',
  'skipWhile',
  'takeWhile',
  'whereType',
  'cast',
  'putIfAbsent',
  'update',
  'updateAll',
  'sort',
  'shuffle',
  'followedBy',
  'addEntries',
  '[]=',
  'setAll',
  'setRange',
  'fillRange',
  'replaceRange',
  'insert',
  'insertAll',
  'asMap',
  'clear',
  'removeLast',
  'removeRange',
  'addFirst',
  'addLast',
  'removeFirst',
};

/// Stringifies an invocation so two adapters can be compared for behavioural
/// equality — including which exception family escaped, which is the whole
/// point of F-SCC51-1..5.
String _outcome(Object? Function() f) {
  try {
    final v = f();
    if (v is Iterable) return 'Iterable(${v.toList()})';
    if (v is Map) return 'Map($v)';
    return '${v.runtimeType}($v)';
  } catch (e) {
    return 'THROW ${e.runtimeType}';
  }
}

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

  /// Evaluates `<expr>.<member>` under a `on StateError` handler, reporting
  /// which exception family actually escaped.
  Object? catchKind(String expr, String member) => run(
    'try { final x = ($expr).$member; return "no-throw:\$x"; } '
    'on StateError catch (e) { return "StateError"; } '
    'catch (e) { return "OTHER"; }',
  );

  // Every bridged collection, paired with an empty and a two-element form.
  // `List` is included deliberately: it is the one that already behaved
  // correctly, so it is the control that says the expectation below is
  // reachable rather than aspirational.
  const nonEmpty = <String, String>{
    'HashSet': 'HashSet<int>()..addAll([1, 2])',
    'LinkedHashSet': 'LinkedHashSet<int>()..addAll([1, 2])',
    'SplayTreeSet': 'SplayTreeSet<int>()..addAll([1, 2])',
    'ListQueue': 'ListQueue<int>()..addAll([1, 2])',
    'DoubleLinkedQueue': 'DoubleLinkedQueue<int>()..addAll([1, 2])',
    'UnmodifiableListView': 'UnmodifiableListView<int>([1, 2])',
    'UnmodifiableSetView': 'UnmodifiableSetView<int>(<int>{1, 2})',
    'set literal': '<int>{1, 2}',
    'List': '<int>[1, 2]',
  };
  const empty = <String, String>{
    'HashSet': 'HashSet<int>()',
    'LinkedHashSet': 'LinkedHashSet<int>()',
    'SplayTreeSet': 'SplayTreeSet<int>()',
    'ListQueue': 'ListQueue<int>()',
    'DoubleLinkedQueue': 'DoubleLinkedQueue<int>()',
    'UnmodifiableListView': 'UnmodifiableListView<int>([])',
    'UnmodifiableSetView': 'UnmodifiableSetView<int>(<int>{})',
    'set literal': '<int>{}',
    'List': '<int>[]',
  };

  group('SCC51: shadowed adapters preserve the SDK contract', () {
    test('F-SCC51-1: `single` on a multi-element collection throws a catchable '
        'StateError [2026-09-06]', () {
      for (final entry in nonEmpty.entries) {
        expect(
          catchKind(entry.value, 'single'),
          'StateError',
          reason:
              '${entry.key}.single threw something a script cannot catch as '
              'StateError. Native Dart throws StateError("Too many '
              'elements"); a hand-written RuntimeD4rtException is not '
              'catchable by the handler a Dart author would write.',
        );
      }
    });

    test(
      'F-SCC51-2: `single` on an empty collection throws StateError [2026-09-06]',
      () {
        for (final entry in empty.entries) {
          expect(
            catchKind(entry.value, 'single'),
            'StateError',
            reason: '${entry.key}.single on an empty collection',
          );
        }
      },
    );

    test(
      'F-SCC51-3: `first` on an empty collection throws StateError [2026-09-06]',
      () {
        for (final entry in empty.entries) {
          expect(
            catchKind(entry.value, 'first'),
            'StateError',
            reason: '${entry.key}.first on an empty collection',
          );
        }
      },
    );

    test(
      'F-SCC51-4: `last` on an empty collection throws StateError [2026-09-06]',
      () {
        for (final entry in empty.entries) {
          expect(
            catchKind(entry.value, 'last'),
            'StateError',
            reason: '${entry.key}.last on an empty collection',
          );
        }
      },
    );

    test('F-SCC51-5: LinkedList first/last throw StateError when empty '
        '[2026-09-06]', () {
      // Separated because `LinkedList<E extends LinkedListEntry<E>>` cannot be
      // built from an int literal, so it does not fit the table above. It has
      // no `single` adapter to begin with and inherits `Iterable`'s.
      expect(catchKind('LinkedList()', 'first'), 'StateError');
      expect(catchKind('LinkedList()', 'last'), 'StateError');
    });

    test('F-SCC51-6: the happy path still returns the element [2026-09-06]', () {
      // The non-vacuity guard. Deleting the shadow adapters must not make the
      // members throw where they previously worked — an inherited adapter that
      // failed to resolve would satisfy every StateError assertion above.
      for (final entry in nonEmpty.entries) {
        expect(
          catchKind(entry.value, 'first'),
          'no-throw:1',
          reason: '${entry.key}.first',
        );
        expect(
          catchKind(entry.value, 'last'),
          'no-throw:2',
          reason: '${entry.key}.last',
        );
      }
      expect(catchKind('<int>[7]', 'single'), 'no-throw:7');
      expect(catchKind('HashSet<int>()..add(7)', 'single'), 'no-throw:7');
    });

    test('F-SCC51-7: ordered collections still report THEIR first and last '
        '[2026-09-06]', () {
      // The sharper non-vacuity guard, and the one that pins that dispatch
      // still lands on the right native object. `SplayTreeSet` sorts, so its
      // `first` is the smallest rather than the first inserted; a
      // `LinkedHashSet` on the same input reports insertion order. If the
      // inherited adapter were somehow reading a copy, these would agree.
      expect(
        run(
          'final s = SplayTreeSet<int>()..addAll([5, 1, 9]); return s.first;',
        ),
        1,
      );
      expect(
        run('final s = SplayTreeSet<int>()..addAll([5, 1, 9]); return s.last;'),
        9,
      );
      expect(
        run(
          'final s = LinkedHashSet<int>()..addAll([5, 1, 9]); return s.first;',
        ),
        5,
      );
      expect(
        run(
          'final s = LinkedHashSet<int>()..addAll([5, 1, 9]); return s.last;',
        ),
        9,
      );
      expect(
        run('final q = ListQueue<int>()..addAll([5, 1, 9]); return q.first;'),
        5,
      );
    });

    test('F-SCC51-8: no shadowed adapter behaves differently from the '
        'supertype adapter it hides [2026-09-06]', () {
      // The standing guard, and the reason this file is not a 300-name
      // allowlist. For every member a subtype bridge redeclares from a
      // registered supertype, invoke BOTH adapters on the SAME native object
      // with the SAME arguments and compare the outcomes. A name collision
      // costs nothing; only a behavioural divergence does.
      //
      // The expected set is EMPTY, not an allowlist. Every divergence found so
      // far has been a defect (`addEntries` in SCB17, `firstKey` in SCC10,
      // `first`/`last`/`single` above), so a new entry here is a finding, not
      // a line to append. If a subtype ever genuinely needs different
      // behaviour, the deliberate way to express it is to make the difference
      // invisible to this harness — as `setAlgebraMethods` does by coercing
      // rather than copying, so the native leaf's override runs and
      // `SplayTreeSet.union` stays sorted while sharing one adapter body.
      final env = Environment();
      Stdlib(env).register();
      CollectionStdlib.register(env);
      final visitor = InterpreterVisitor(
        globalEnvironment: env,
        moduleLoader: ModuleLoader(env, {}, {}, {}),
      );

      var compared = 0;
      var skipped = 0;
      final diffs = <String>[];

      for (final name in _fixtures.keys) {
        final sub = env.findBridgedClassByName(name);
        if (sub == null) continue;
        for (final sname in BridgedClass.transitiveSupertypeNames(name)) {
          final sup = env.findBridgedClassByName(sname);
          if (sup == null) continue;

          for (final m in sub.methods.keys.toSet().intersection(
            sup.methods.keys.toSet(),
          )) {
            if (_needsCallable.contains(m)) {
              skipped++;
              continue;
            }
            final args =
                _classArgs['$name.$m'] ?? _args[m] ?? const <Object?>[];
            final a = _outcome(
              () => sub.methods[m]!(visitor, _fixtures[name]!(), args, {}, []),
            );
            final b = _outcome(
              () => sup.methods[m]!(visitor, _fixtures[name]!(), args, {}, []),
            );
            compared++;
            if (a != b) {
              diffs.add('$name -> $sname .$m()  sub: $a  sup: $b');
            }
          }

          for (final g in sub.getters.keys.toSet().intersection(
            sup.getters.keys.toSet(),
          )) {
            // One shared instance: `hashCode` would differ on two separately
            // constructed fixtures for reasons that say nothing about the
            // adapters.
            final shared = _fixtures[name]!();
            final a = _outcome(() => sub.getters[g]!(visitor, shared));
            final b = _outcome(() => sup.getters[g]!(visitor, shared));
            compared++;
            if (a != b) {
              diffs.add('$name -> $sname .$g  sub: $a  sup: $b');
            }
          }
        }
      }

      expect(
        diffs,
        isEmpty,
        reason:
            'A subtype bridge adapter behaves differently from the supertype '
            'adapter it shadows. Either the subtype copy is a latent defect '
            '(delete it — the inherited one is right), or the difference is '
            'deliberate and belongs in a coercing shared adapter rather than a '
            'divergent copy.',
      );

      // Non-vacuity: the walk must actually reach the shadowed pairs. A
      // registry that silently stopped returning supertypes would make the
      // assertion above pass by comparing nothing.
      expect(
        compared,
        greaterThan(200),
        reason:
            'compared=$compared skipped=$skipped — the differential walk '
            'found far fewer shadowed pairs than the ~280 known to exist, so '
            'the supertype registry or the bridge registration changed shape.',
      );
    });
  });
}
