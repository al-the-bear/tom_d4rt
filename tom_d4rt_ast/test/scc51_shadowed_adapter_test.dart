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
// one real family, and it keeps working as bridges change, which a name
// allowlist would not.
//
// WHAT IT FOUND. `first`, `last` and `single` were hand-written on six
// collection bridges, and each one caught the SDK's `StateError` (or pre-empted
// it with a length check) and threw a `RuntimeD4rtException` carrying a
// hand-written message instead. So `try { s.single } on StateError catch (e)`
// caught nothing on any `dart:collection` type — while the identical script
// over a `List` worked, because the `List` bridge has no hand-written copy and
// delegates. Seventeen adapters were deleted, plus
// `UnmodifiableMapView.addEntries`, which is byte-for-byte the `.cast()` shape
// SCB17 removed and is unobservable today only because `cast()` is lazy and the
// view throws `UnsupportedError` before it ever iterates.
//
// WHY THIS FILE IS ADAPTER-LEVEL, not script-level like its `tom_d4rt` twin:
// this package has no parser, so there is no `execute(source: ...)` to write
// `try { ... } on StateError catch` in. The adapters are invoked directly
// instead, which measures exactly the same thing one layer down — the exception
// family that escapes the adapter is the family the script's handler sees.

import 'dart:collection';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/src/runtime/bridge/bridged_types.dart';
import 'package:tom_d4rt_ast/src/runtime/environment.dart';
import 'package:tom_d4rt_ast/src/runtime/interpreter_visitor.dart';
import 'package:tom_d4rt_ast/src/runtime/module_context.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/collection.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/collection/linked_list.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/stdlib.dart';

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

Environment _stdlibEnvironment() {
  final env = Environment();
  Stdlib(env).register();
  CollectionStdlib.register(env);
  return env;
}

void main() {
  final env = _stdlibEnvironment();
  final visitor = InterpreterVisitor(
    globalEnvironment: env,
    moduleContext: NoOpModuleContext(globalEnvironment: env),
  );

  /// Resolves `<className>.<getter>` the way a script would — through the
  /// bridge for [className], falling back to its registered supertypes — and
  /// reports which exception family escaped.
  Object? read(String className, Object target, String getter) {
    for (final name in [
      className,
      ...BridgedClass.transitiveSupertypeNames(className),
    ]) {
      final adapter = env.findBridgedClassByName(name)?.getters[getter];
      if (adapter != null) return adapter(visitor, target);
    }
    fail('no bridge on $className or its supertypes declares `$getter`');
  }

  String kind(String className, Object target, String getter) {
    try {
      return 'no-throw:${read(className, target, getter)}';
    } on StateError {
      return 'StateError';
    } catch (e) {
      return 'OTHER:${e.runtimeType}';
    }
  }

  // Every bridged collection, paired with an empty and a two-element form.
  // `List` is included deliberately: it is the one that already behaved
  // correctly, so it is the control that says the expectation below is
  // reachable rather than aspirational.
  final nonEmpty = <String, Object Function()>{
    'HashSet': () => HashSet<int>.of([1, 2]),
    'LinkedHashSet': () => <int>{1, 2},
    'SplayTreeSet': () => SplayTreeSet<int>.of([1, 2]),
    'ListQueue': () => ListQueue<int>.of([1, 2]),
    'DoubleLinkedQueue': () => DoubleLinkedQueue<int>.of([1, 2]),
    'UnmodifiableListView': () => UnmodifiableListView<int>([1, 2]),
    'UnmodifiableSetView': () => UnmodifiableSetView<int>(<int>{1, 2}),
    'Set': () => <int>{1, 2},
    'List': () => <int>[1, 2],
  };
  final empty = <String, Object Function()>{
    'HashSet': () => HashSet<int>(),
    'LinkedHashSet': () => <int>{},
    'SplayTreeSet': () => SplayTreeSet<int>(),
    'ListQueue': () => ListQueue<int>(),
    'DoubleLinkedQueue': () => DoubleLinkedQueue<int>(),
    'UnmodifiableListView': () => UnmodifiableListView<int>([]),
    'UnmodifiableSetView': () => UnmodifiableSetView<int>(<int>{}),
    'Set': () => <int>{},
    'List': () => <int>[],
  };

  group('SCC51: shadowed adapters preserve the SDK contract', () {
    test('F-SCC51-1: `single` on a multi-element collection throws a catchable '
        'StateError [2026-09-06]', () {
      for (final e in nonEmpty.entries) {
        expect(
          kind(e.key, e.value(), 'single'),
          'StateError',
          reason:
              '${e.key}.single threw something a script cannot catch as '
              'StateError. Native Dart throws StateError("Too many elements"); '
              'a hand-written RuntimeD4rtException is not catchable by the '
              'handler a Dart author would write.',
        );
      }
    });

    test(
      'F-SCC51-2: `single` on an empty collection throws StateError [2026-09-06]',
      () {
        for (final e in empty.entries) {
          expect(kind(e.key, e.value(), 'single'), 'StateError', reason: e.key);
        }
      },
    );

    test(
      'F-SCC51-3: `first` on an empty collection throws StateError [2026-09-06]',
      () {
        for (final e in empty.entries) {
          expect(kind(e.key, e.value(), 'first'), 'StateError', reason: e.key);
        }
      },
    );

    test(
      'F-SCC51-4: `last` on an empty collection throws StateError [2026-09-06]',
      () {
        for (final e in empty.entries) {
          expect(kind(e.key, e.value(), 'last'), 'StateError', reason: e.key);
        }
      },
    );

    test('F-SCC51-5: LinkedList first/last throw StateError when empty '
        '[2026-09-06]', () {
      // Separated because `LinkedList<E extends LinkedListEntry<E>>` cannot be
      // built from an int, so it does not fit the tables above. It has no
      // `single` adapter to begin with and inherits `Iterable`'s.
      final list = LinkedList<BridgedLinkedListEntry>();
      expect(kind('LinkedList', list, 'first'), 'StateError');
      expect(kind('LinkedList', list, 'last'), 'StateError');
    });

    test('F-SCC51-6: the happy path still returns the element [2026-09-06]', () {
      // The non-vacuity guard. Deleting the shadow adapters must not make the
      // members throw where they previously worked — an inherited adapter that
      // failed to resolve would satisfy every StateError assertion above.
      for (final e in nonEmpty.entries) {
        expect(kind(e.key, e.value(), 'first'), 'no-throw:1', reason: e.key);
        expect(kind(e.key, e.value(), 'last'), 'no-throw:2', reason: e.key);
      }
      expect(kind('List', <int>[7], 'single'), 'no-throw:7');
      expect(kind('HashSet', HashSet<int>.of([7]), 'single'), 'no-throw:7');
    });

    test('F-SCC51-7: ordered collections still report THEIR first and last '
        '[2026-09-06]', () {
      // The sharper non-vacuity guard, and the one that pins that dispatch
      // still lands on the right native object. `SplayTreeSet` sorts, so its
      // `first` is the smallest rather than the first inserted; a
      // `LinkedHashSet` on the same input reports insertion order. If the
      // inherited adapter were somehow reading a copy, these would agree.
      final splay = SplayTreeSet<int>.of([5, 1, 9]);
      expect(read('SplayTreeSet', splay, 'first'), 1);
      expect(read('SplayTreeSet', splay, 'last'), 9);
      final linked = <int>{5, 1, 9};
      expect(read('LinkedHashSet', linked, 'first'), 5);
      expect(read('LinkedHashSet', linked, 'last'), 9);
      expect(read('ListQueue', ListQueue<int>.of([5, 1, 9]), 'first'), 5);
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
      // `first`/`last`/`single` above), so a new entry here is a finding, not a
      // line to append. If a subtype ever genuinely needs different behaviour,
      // the deliberate way to express it is to make the difference invisible to
      // this harness — as `setAlgebraMethods` does by coercing rather than
      // copying, so the native leaf's override runs and `SplayTreeSet.union`
      // stays sorted while sharing one adapter body.
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
            'compared=$compared skipped=$skipped — the differential walk found '
            'far fewer shadowed pairs than the ~280 known to exist, so the '
            'supertype registry or the bridge registration changed shape.',
      );
    });
  });
}
