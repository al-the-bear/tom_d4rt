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

/// Interpreter-side callables, by the shape the member expects. SCD152: the
/// differential used to SKIP every member taking one of these — 261 of 542
/// pairs, which is where SCC51 predicted divergence would hide, because
/// unwrapping a callback argument is fiddly and a leaf copy that gets it subtly
/// wrong looks identical from the outside. Both predictions held: driving them
/// found `HashMap.map` and `LinkedHashMap.map` rebuilding the entry as
/// `MapEntry(key, callbackResult)` instead of using the `MapEntry` the callback
/// returns, so `{'a': 1}.map((k, v) => MapEntry(v, k))` produced
/// `{'a': MapEntry(1, 'a')}`. `SplayTreeMap` had no copy and already worked —
/// byte-for-byte the SCB17 `addEntries` asymmetry.
///
/// These are built natively even though this tree HAS a parser, for two
/// reasons. The mirror twin has none, so the same shape keeps the two files
/// diffable; and a script-level probe cannot produce a differential anyway — a
/// script cannot force the SUPERTYPE's adapter to run on a given object, since
/// dispatch resolves by the object's bridged class.
final _pred1 = NativeFunction(
  (visitor, positional, named, types) => true,
  arity: 1,
  name: 'pred1',
);
final _pred2 = NativeFunction(
  (visitor, positional, named, types) => true,
  arity: 2,
  name: 'pred2',
);
final _ident1 = NativeFunction(
  (visitor, positional, named, types) => positional.first,
  arity: 1,
  name: 'ident1',
);
final _combine2 = NativeFunction(
  (visitor, positional, named, types) => positional.first,
  arity: 2,
  name: 'combine2',
);
final _expand1 = NativeFunction(
  (visitor, positional, named, types) => [positional.first],
  arity: 1,
  name: 'expand1',
);
final _supplier0 = NativeFunction(
  (visitor, positional, named, types) => 99,
  arity: 0,
  name: 'supplier0',
);

/// `Map.map` takes `(K, V) => MapEntry`, not a one-argument transform. Getting
/// that wrong is what made the first run of this walk report `HashMap.map` as
/// divergent for the wrong reason — the leaf accepted a 1-arg callable while
/// `Map.map` correctly refused it, which says nothing about entry handling.
final _entry2 = NativeFunction(
  (visitor, positional, named, types) =>
      MapEntry<dynamic, dynamic>(positional[0], positional[1]),
  arity: 2,
  name: 'entry2',
);

/// The fixtures whose member signatures are the `Map` ones — `forEach` takes
/// `(k, v)` here and `(e)` everywhere else.
const _mapFixtures = {
  'HashMap',
  'LinkedHashMap',
  'SplayTreeMap',
  'UnmodifiableMapView',
};

/// Arguments for members the plain `_args` table cannot express, either because
/// one of them has to be a `Callable` or because the argument depends on whether
/// the receiver is a map.
///
/// Returns null for a member with no recipe, which the walk counts rather than
/// silently invoking with no arguments — an adapter called wrongly throws on
/// BOTH sides and would otherwise read as agreement.
List<Object?>? _callableArgs(String cls, String m) {
  final isMap = _mapFixtures.contains(cls);
  switch (m) {
    case 'map':
      return [isMap ? _entry2 : _ident1];
    case 'forEach':
    case 'removeWhere':
      return [isMap ? _pred2 : _pred1];
    case 'where':
    case 'any':
    case 'every':
    case 'firstWhere':
    case 'lastWhere':
    case 'singleWhere':
    case 'retainWhere':
    case 'skipWhile':
    case 'takeWhile':
      return [_pred1];
    case 'fold':
      return [0, _combine2];
    case 'reduce':
      return [_combine2];
    case 'expand':
      return [_expand1];
    case 'putIfAbsent':
      return ['z', _supplier0];
    case 'update':
      return ['a', _ident1];
    case 'updateAll':
      return [_combine2];
    // No callback, and no entry in `_args` either: these were swept into the
    // old skip set alongside the callback-takers, which is why the set was
    // never only about callables.
    case 'sort':
    case 'shuffle':
    case 'asMap':
    case 'clear':
    case 'removeLast':
    case 'removeFirst':
    case 'cast':
    case 'whereType':
    // Genuinely no positional arguments — listed rather than left to a default,
    // because the default is what made `elementAtOrNull` below compare
    // `THROW == THROW` and read as agreement.
    case 'toList':
    case 'toSet':
      return const <Object?>[];
    case 'elementAtOrNull':
      return [0];
    case 'followedBy':
      return [
        <dynamic>[7, 8],
      ];
    case 'addEntries':
      return [
        <dynamic>[const MapEntry<dynamic, dynamic>('c', 3)],
      ];
    case '[]=':
      return isMap ? ['c', 3] : [0, 7];
    case 'setAll':
      return [
        0,
        <dynamic>[7],
      ];
    case 'setRange':
      return [
        0,
        1,
        <dynamic>[7],
      ];
    case 'fillRange':
      return [0, 1, 7];
    case 'replaceRange':
      return [
        0,
        1,
        <dynamic>[7],
      ];
    case 'insert':
      return [0, 7];
    case 'insertAll':
      return [
        0,
        <dynamic>[7],
      ];
    case 'removeRange':
      return [0, 1];
    case 'addFirst':
    case 'addLast':
      return [7];
  }
  return null;
}

/// How a pair of outcomes is counted. Extracted from the walk so the third
/// case is reachable without contriving a registry state that produces it:
/// no ablation of the recipes yields two IDENTICAL `RuntimeD4rtException`s —
/// they differ in message and land in [_PairVerdict.divergent] first — so the
/// branch that keeps `THROW == THROW` from reading as agreement would otherwise
/// be asserted by nothing. `F-SCD152-1` covers it directly.
enum _PairVerdict { compared, divergent, vacuous }

_PairVerdict _verdict(String subOutcome, String supOutcome) {
  if (subOutcome != supOutcome) return _PairVerdict.divergent;
  if (subOutcome.startsWith('THROW RuntimeD4rtException')) {
    return _PairVerdict.vacuous;
  }
  return _PairVerdict.compared;
}

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

    // SCD152. The verdict rule decides what the two counters above mean, and
    // its third case cannot be reached by ablating the recipes — two adapters
    // rejecting the same bad arguments produce DIFFERENT messages, so they are
    // reported as a divergence before the vacuous branch is consulted.
    // Asserted directly for that reason.
    test('F-SCD152-1: identical rejections are not counted as agreement '
        '[2026-09-15]', () {
      expect(
        _verdict('Iterable([1, 2])', 'Iterable([1, 2])'),
        _PairVerdict.compared,
        reason: 'two adapters returning the same value is the passing case',
      );
      expect(
        _verdict('int(3)', 'Null(null)'),
        _PairVerdict.divergent,
        reason:
            'the shape of the `[]=` divergence SCD152 found — same call, '
            'different result',
      );
      expect(
        _verdict('THROW StateError', 'THROW StateError'),
        _PairVerdict.compared,
        reason:
            'an SDK error on both sides IS meaningful agreement: it is what '
            'F-SCC51-1..5 are about, so it must stay a comparison',
      );
      expect(
        _verdict('THROW RuntimeD4rtException', 'THROW RuntimeD4rtException'),
        _PairVerdict.vacuous,
        reason:
            'a D4rt-level rejection on both sides means the harness supplied '
            'arguments neither adapter accepted. Counting that as a comparison '
            'is how a differential hollows out while staying green.',
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
      var undrivable = 0;
      var vacuous = 0;
      final diffs = <String>[];
      final noRecipe = <String>{};

      for (final name in _fixtures.keys) {
        final sub = env.findBridgedClassByName(name);
        if (sub == null) continue;
        for (final sname in BridgedClass.transitiveSupertypeNames(name)) {
          final sup = env.findBridgedClassByName(sname);
          if (sup == null) continue;

          for (final m in sub.methods.keys.toSet().intersection(
            sup.methods.keys.toSet(),
          )) {
            // SCD152: a member with no recipe is COUNTED, never invoked with
            // whatever `_args` happens to hold. An adapter called with the
            // wrong arguments throws on both sides, and THROW == THROW would be
            // recorded as agreement — the quietest way for this guard to hollow
            // out as the bridges grow.
            final args =
                _classArgs['$name.$m'] ?? _args[m] ?? _callableArgs(name, m);
            if (args == null) {
              undrivable++;
              noRecipe.add(m);
              continue;
            }
            final a = _outcome(
              () => sub.methods[m]!(visitor, _fixtures[name]!(), args, {}, []),
            );
            final b = _outcome(
              () => sup.methods[m]!(visitor, _fixtures[name]!(), args, {}, []),
            );
            switch (_verdict(a, b)) {
              case _PairVerdict.divergent:
                diffs.add('$name -> $sname .$m()  sub: $a  sup: $b');
              case _PairVerdict.vacuous:
                // Both adapters rejected the arguments. That is agreement about
                // nothing, so it is not counted as a comparison.
                vacuous++;
              case _PairVerdict.compared:
                compared++;
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
      //
      // SCD152 raised this floor from 200 to 500. The old number was set when
      // 261 of 542 pairs were skipped, so it had to sit below half the surface
      // to pass at all; with every pair driven the walk compares 537 and the
      // floor can sit just under that. The 5 missing from 542 are the shadowed
      // pairs this todo DELETED — `map` on two map bridges and `[]=` on three —
      // so the arithmetic is the audit trail.
      expect(
        compared,
        greaterThan(500),
        reason:
            'compared=$compared undrivable=$undrivable vacuous=$vacuous — '
            'the differential walk found far fewer shadowed pairs than the '
            '~537 known to exist, so the supertype registry or the bridge '
            'registration changed shape.',
      );

      // SCD152. The two ways this guard can stop measuring without failing,
      // both counted rather than assumed away. `undrivable` is a shadowed
      // member `_callableArgs` has no recipe for; `vacuous` is a pair where
      // both adapters rejected the arguments, which is agreement about
      // nothing. Both are zero today, and an assertion is the only thing that
      // keeps them so — the old skip set reached 261 precisely because nothing
      // objected to it growing.
      expect(
        undrivable,
        isZero,
        reason:
            'No recipe for: $noRecipe. Add one to `_callableArgs` — a member '
            'left out is a member this guard does not check, which is how the '
            'callback-taking half of the surface went unmeasured until SCD152.',
      );
      expect(
        vacuous,
        isZero,
        reason:
            '$vacuous shadowed pairs threw `RuntimeD4rtException` on BOTH '
            'sides, so they agree only about rejecting the arguments the '
            'harness supplied. Fix the recipe in `_callableArgs` rather than '
            'reading THROW == THROW as a passing comparison.',
      );
    });
  });
}
