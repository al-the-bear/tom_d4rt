import 'dart:collection';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';
// `CollectionStdlib` — like every other stdlib registrar — is deliberately not
// re-exported from `runtime.dart`; `dart:collection` is registered lazily by
// `ast_module_loader.dart` when a script imports it. Driving that path from a
// unit test would mean building a parsed AST module, so we reach for the
// same-package registrar directly instead of widening the published API.
import 'package:tom_d4rt_ast/src/runtime/stdlib/collection.dart';
// `Map`, `List` and `Iterable` are `dart:core` bridges, not `dart:collection`
// ones, so the tops of the three view hierarchies only exist once `CoreStdlib`
// has run too. A script gets both because it imports both; a
// registration-level test has to say so — and it matters here because SCC51
// moved several members up onto those very bridges.
import 'package:tom_d4rt_ast/src/runtime/stdlib/core.dart';

import '../bridge_reachability.dart';

/// SC3 mirror coverage for `tom_d4rt_ast`.
///
/// Registration-level rather than script-level: the script-level equivalents
/// live in `tom_d4rt/test/stdlib/collection/`, and `tom_d4rt_exec` (the runner
/// that could execute a script against *this* tree) resolves `tom_d4rt_ast`
/// from pub.dev rather than by path, so it cannot see unpublished local edits.
/// What we can pin here is that all three bridges are registered, expose the
/// surface the script tests exercise, read through to the native view, and let
/// the native `UnsupportedError` escape from the mutating members.
///
/// COVERS THE FAMILY, NOT THE CASE THAT PROMPTED IT. This file was added for
/// the map and set views and its name read as if it covered all three, so the
/// list view went uncovered for months while the file passed. A suite named
/// after a family is checked against the family.
///
/// AND AT THE SAME DEPTH ACROSS IT. scc16 fixed the coverage; SCD56 fixed the
/// depth. The map and set groups asserted seventeen mutators were PRESENT and
/// invoked four of them, so thirteen were pinned by key alone — and a key is
/// what an adapter dropped and re-added as `throw RuntimeD4rtException(...)`
/// keeps. The mutation still fails, so a test that only checks for failure
/// cannot tell delegation from interception, which is the whole scb6 contract.
/// All seventeen are invoked now, generated from the tables at the foot of
/// this file, so a new mutator is covered by adding one row.
///
/// VERIFIED BY DOING IT. Reverting a mutator to a D4rt-specific throw reds
/// exactly one case and names the member — measured 2026-09-12 on seven of
/// them: `update`, `removeWhere`, `putIfAbsent` on the map view; `add`,
/// `removeWhere`, `retainAll` on the set view; and `addEntries`, which is the
/// interesting one because no bridge here declares it. Intercepting `Map`'s
/// copy — the one that actually answers — reds `F-SC3-AST-18/addEntries` and
/// nothing else, which is what the reachability resolution is for. Each run
/// went `+52 -1`, so "exactly one" is measured rather than assumed.
void main() {
  late Environment env;
  late InterpreterVisitor visitor;

  setUp(() {
    env = Environment();
    CoreStdlib.register(env);
    CollectionStdlib.register(env);
    // Method adapters take a non-nullable visitor (only getters accept `null`),
    // so the mutator tests need a real one. None of the members exercised here
    // resolves a name or loads a module, so an empty loader is enough.
    visitor = InterpreterVisitor(
      globalEnvironment: env,
      moduleContext: AstModuleLoader(
        modules: const {},
        globalEnvironment: env,
        runner: D4rtRunner(),
      ),
    );
  });

  group('SC3: UnmodifiableMapView collection bridge', () {
    test(
      'F-SC3-AST-1: is registered under the name UnmodifiableMapView [2026-07-27]',
      () {
        final bridge = env.findBridgedClassByName('UnmodifiableMapView');
        expect(bridge, isNotNull);
        expect(bridge!.nativeType, UnmodifiableMapView);
        expect(bridge.typeParameterCount, 2);
        expect(
          bridge.isAssignable?.call(UnmodifiableMapView<String, int>({'a': 1})),
          isTrue,
        );
        expect(bridge.isAssignable?.call(<String, int>{'a': 1}), isFalse);
      },
    );

    test('F-SC3-AST-2: exposes the wrapping constructor [2026-07-27]', () {
      final bridge = env.findBridgedClassByName('UnmodifiableMapView')!;
      expect(bridge.constructors.keys, contains(''));
    });

    test(
      'F-SC3-AST-3: exposes the read and mutating Map surface [2026-07-27]',
      () {
        // Reachable, not declared. SCC51 deleted this bridge's local
        // `addEntries` — byte-for-byte the `.cast()` shape SCB17 removed from
        // `HashMap`/`LinkedHashMap`, which cannot unwrap a
        // `BridgedInstance<MapEntry>` — so `Map`'s copy, which unwraps
        // correctly, answers now. What a script can call is the contract;
        // which bridge in the chain declares it is not, and pinning the latter
        // is what would make a correct deletion look like a regression.
        expect(
          reachableMethodNames(env, 'UnmodifiableMapView'),
          containsAll(<String>[
            // read-through
            '[]', 'containsKey', 'containsValue', 'forEach', 'map', 'cast',
            // Delegated so the native view raises UnsupportedError. Taken from
            // the table the delegation cases below are generated from, so the
            // surface assertion and the behaviour assertion cannot disagree
            // about which members are mutators — listing them twice is how
            // they would.
            ..._mutatingMapCalls.keys,
          ]),
        );
      },
    );

    test(
      'F-SC3-AST-4: the getters read through to the backing map [2026-07-27]',
      () {
        final bridge = env.findBridgedClassByName('UnmodifiableMapView')!;
        final view = UnmodifiableMapView<dynamic, dynamic>({'a': 1, 'b': 2});
        expect(bridge.getters['length']!(null, view), 2);
        expect(bridge.getters['isEmpty']!(null, view), isFalse);
        expect(bridge.getters['isNotEmpty']!(null, view), isTrue);
        expect(bridge.getters['keys']!(null, view), orderedEquals(['a', 'b']));
        expect(bridge.getters['values']!(null, view), orderedEquals([1, 2]));
      },
    );

    test(
      'F-SC3-AST-5: the mutators delegate, so the SDK error surfaces [2026-07-27]',
      () {
        // The whole point of delegating rather than intercepting: scripts catch
        // `UnsupportedError`, not a D4rt-specific exception.
        final bridge = env.findBridgedClassByName('UnmodifiableMapView')!;
        final view = UnmodifiableMapView<dynamic, dynamic>({'a': 1});
        expect(
          () => bridge.methods['clear']!(visitor, view, [], {}, []),
          throwsUnsupportedError,
        );
        expect(
          () => bridge.methods['[]=']!(visitor, view, ['b', 2], {}, []),
          throwsUnsupportedError,
        );
        // ... while the read-through members on the same bridge still work.
        expect(bridge.methods['[]']!(visitor, view, ['a'], {}, []), 1);
      },
    );

    // SCD56. F-SC3-AST-3 asserts nine mutators are PRESENT and F-SC3-AST-5
    // invoked two of them, so seven were pinned by key alone — and a key is
    // exactly what an adapter dropped and re-added as
    // `throw RuntimeD4rtException(...)` keeps. The mutation still fails, so a
    // test that only checks for failure cannot tell delegation from
    // interception. Every one is invoked now, with arguments that survive its
    // own validation: an argument the adapter rejects reports the argument
    // problem and never reaches the native view, which would make the case
    // pass for the wrong reason.
    //
    // RESOLVED BY REACHABILITY, not off this bridge. `addEntries` is not
    // declared here — SCC51 deleted the local copy because it could not unwrap
    // a `BridgedInstance<MapEntry>`, and `Map`'s copy answers instead. What a
    // script can call is the contract; which bridge declares it is not.
    for (final entry in _mutatingMapCalls.entries) {
      test('F-SC3-AST-18/${entry.key}: the mutating method delegates, so the '
          'SDK error surfaces [2026-09-12]', () {
        final adapter = findReachableMethod(
          env,
          'UnmodifiableMapView',
          entry.key,
        );
        expect(
          adapter,
          isNotNull,
          reason:
              'no bridge on UnmodifiableMapView\'s chain declares '
              '`${entry.key}`',
        );
        final view = UnmodifiableMapView<dynamic, dynamic>({'a': 1, 'b': 2});
        expect(
          () => adapter!(visitor, view, entry.value, {}, []),
          throwsUnsupportedError,
          reason:
              '`${entry.key}` must delegate to the native view, not throw a '
              'D4rt-specific exception',
        );
      });
    }
  });

  group('SC3: UnmodifiableSetView collection bridge', () {
    test(
      'F-SC3-AST-6: is registered under the name UnmodifiableSetView [2026-07-27]',
      () {
        final bridge = env.findBridgedClassByName('UnmodifiableSetView');
        expect(bridge, isNotNull);
        expect(bridge!.nativeType, UnmodifiableSetView);
        expect(bridge.typeParameterCount, 1);
        expect(
          bridge.isAssignable?.call(UnmodifiableSetView<int>({1})),
          isTrue,
        );
        expect(bridge.isAssignable?.call(<int>{1}), isFalse);
      },
    );

    test(
      'F-SC3-AST-7: exposes the read and mutating Set surface [2026-07-27]',
      () {
        final bridge = env.findBridgedClassByName('UnmodifiableSetView')!;
        expect(
          bridge.methods.keys,
          containsAll(<String>[
            // read-through
            'contains', 'containsAll', 'lookup', 'difference', 'intersection',
            'union',
            'forEach',
            'map',
            'where',
            'fold',
            'join',
            'toList',
            'toSet',
            // Delegated so the native view raises UnsupportedError; taken
            // from the table below for the same reason as the map view's.
            ..._mutatingSetCalls.keys,
          ]),
        );
      },
    );

    test(
      'F-SC3-AST-8: the getters read through to the backing set [2026-07-27]',
      () {
        final bridge = env.findBridgedClassByName('UnmodifiableSetView')!;
        final view = UnmodifiableSetView<dynamic>({'x', 'y'});
        expect(bridge.getters['length']!(null, view), 2);
        expect(bridge.getters['isEmpty']!(null, view), isFalse);
        expect(bridge.getters['first']!(null, view), 'x');
        expect(bridge.getters['last']!(null, view), 'y');
      },
    );

    test(
      'F-SC3-AST-9: the mutators delegate, so the SDK error surfaces [2026-07-27]',
      () {
        final bridge = env.findBridgedClassByName('UnmodifiableSetView')!;
        final view = UnmodifiableSetView<dynamic>({1});
        expect(
          () => bridge.methods['add']!(visitor, view, [2], {}, []),
          throwsUnsupportedError,
        );
        expect(
          () => bridge.methods['clear']!(visitor, view, [], {}, []),
          throwsUnsupportedError,
        );
        // ... while the read-through members on the same bridge still work.
        expect(bridge.methods['contains']!(visitor, view, [1], {}, []), isTrue);
      },
    );

    // SCD56, for the same reason as the map view's generated cases above: six
    // of these eight were pinned by key and never called.
    for (final entry in _mutatingSetCalls.entries) {
      test('F-SC3-AST-19/${entry.key}: the mutating method delegates, so the '
          'SDK error surfaces [2026-09-12]', () {
        final adapter = findReachableMethod(
          env,
          'UnmodifiableSetView',
          entry.key,
        );
        expect(
          adapter,
          isNotNull,
          reason:
              'no bridge on UnmodifiableSetView\'s chain declares '
              '`${entry.key}`',
        );
        final view = UnmodifiableSetView<dynamic>({1, 2});
        expect(
          () => adapter!(visitor, view, entry.value, {}, []),
          throwsUnsupportedError,
          reason:
              '`${entry.key}` must delegate to the native view, not throw a '
              'D4rt-specific exception',
        );
      });
    }
  });

  group('SC3: UnmodifiableListView collection bridge', () {
    test(
      'F-SC3-AST-11: is registered under the name UnmodifiableListView [2026-09-04]',
      () {
        final bridge = env.findBridgedClassByName('UnmodifiableListView');
        expect(bridge, isNotNull);
        expect(bridge!.nativeType, UnmodifiableListView);
        expect(bridge.typeParameterCount, 1);
        expect(
          bridge.isAssignable?.call(UnmodifiableListView<int>([1])),
          isTrue,
        );
        expect(bridge.isAssignable?.call(<int>[1]), isFalse);
      },
    );

    test('F-SC3-AST-12: exposes the wrapping constructor [2026-09-04]', () {
      final bridge = env.findBridgedClassByName('UnmodifiableListView')!;
      expect(bridge.constructors.keys, contains(''));
    });

    test(
      'F-SC3-AST-13: exposes the read and mutating List surface [2026-09-04]',
      () {
        final bridge = env.findBridgedClassByName('UnmodifiableListView')!;
        expect(
          bridge.methods.keys,
          containsAll(<String>[
            // read-through
            '[]', 'contains', 'indexOf', 'lastIndexOf', 'elementAt', 'sublist',
            'getRange', 'forEach', 'map', 'where', 'fold', 'join', 'toList',
            'toSet', 'cast', 'asMap', 'reversed',
            // delegated so the native view raises UnsupportedError
            ..._mutatingListCalls.keys,
          ]),
        );
        expect(bridge.setters.keys, containsAll(_mutatingListSetters.keys));
      },
    );

    test(
      'F-SC3-AST-14: the getters read through to the backing list [2026-09-04]',
      () {
        // Reachability-resolved: SCC51 deleted this bridge's `first`/`last`
        // copies, which pre-empted the SDK with a `RuntimeD4rtException` where
        // native Dart raises `StateError`. `Iterable`'s delegating adapters
        // answer now. The read-through behaviour asserted below is unchanged —
        // only the declaring bridge moved, which is why this reads by
        // reachability instead.
        final view = UnmodifiableListView<dynamic>(['a', 'b']);
        Object? read(String m) =>
            readReachable(env, 'UnmodifiableListView', view, m);
        expect(read('length'), 2);
        expect(read('isEmpty'), isFalse);
        expect(read('isNotEmpty'), isTrue);
        expect(read('first'), 'a');
        expect(read('last'), 'b');
        expect(read('reversed'), orderedEquals(['b', 'a']));
      },
    );

    // Asserting the KEY is present would pass for an adapter that was dropped
    // and re-added as a D4rt-specific throw — the mutation still "fails", so a
    // test that only checks for failure cannot tell the two apart. Every
    // mutating member is therefore invoked with arguments that survive its own
    // validation, so what is pinned is that the call reaches the native view
    // and the SDK's own error comes back out. That is the scb6 contract.
    for (final entry in _mutatingListCalls.entries) {
      test('F-SC3-AST-15/${entry.key}: the mutating method delegates, so the '
          'SDK error surfaces [2026-09-04]', () {
        final bridge = env.findBridgedClassByName('UnmodifiableListView')!;
        final view = UnmodifiableListView<dynamic>(['a', 'b']);
        expect(
          () => bridge.methods[entry.key]!(visitor, view, entry.value, {}, []),
          throwsUnsupportedError,
          reason:
              '`${entry.key}` must delegate to the native view, not throw a '
              'D4rt-specific exception',
        );
      });
    }

    for (final entry in _mutatingListSetters.entries) {
      test('F-SC3-AST-16/${entry.key}=: the mutating setter delegates, so the '
          'SDK error surfaces [2026-09-04]', () {
        final bridge = env.findBridgedClassByName('UnmodifiableListView')!;
        final view = UnmodifiableListView<dynamic>(['a', 'b']);
        expect(
          () => bridge.setters[entry.key]!(visitor, view, entry.value),
          throwsUnsupportedError,
          reason: '`${entry.key}=` must delegate to the native view',
        );
      });
    }

    test('F-SC3-AST-17: the read-through members still work on the same bridge '
        '[2026-09-04]', () {
      // Guards against "make the mutators throw" being satisfied by a bridge
      // that throws for everything.
      final bridge = env.findBridgedClassByName('UnmodifiableListView')!;
      final view = UnmodifiableListView<dynamic>(['a', 'b']);
      expect(bridge.methods['[]']!(visitor, view, [1], {}, []), 'b');
      expect(bridge.methods['contains']!(visitor, view, ['a'], {}, []), isTrue);
      expect(bridge.methods['indexOf']!(visitor, view, ['b'], {}, []), 1);
      expect(bridge.methods['join']!(visitor, view, ['-'], {}, []), 'a-b');
    });
  });

  group('SC3: the unmodifiable view bridges stay distinct', () {
    // Cross-family, so it belongs to none of the three groups above.
    test('F-SC3-AST-10: the three views stay distinct bridges [2026-07-27]', () {
      // If one bridge captured another's native type, dispatch would offer the
      // wrong member surface for whichever type lost.
      final mapView = env.findBridgedClassByName('UnmodifiableMapView')!;
      final setView = env.findBridgedClassByName('UnmodifiableSetView')!;
      final listView = env.findBridgedClassByName('UnmodifiableListView')!;
      final map = UnmodifiableMapView<String, int>({'a': 1});
      final set = UnmodifiableSetView<int>({1});
      final list = UnmodifiableListView<int>([1]);

      expect(mapView.isAssignable!(map), isTrue);
      expect(mapView.isAssignable!(set), isFalse);
      expect(mapView.isAssignable!(list), isFalse);

      expect(setView.isAssignable!(set), isTrue);
      expect(setView.isAssignable!(map), isFalse);
      expect(setView.isAssignable!(list), isFalse);

      expect(listView.isAssignable!(list), isTrue);
      expect(listView.isAssignable!(map), isFalse);
      expect(listView.isAssignable!(set), isFalse);
    });
  });
}

/// A callable the two `*Where` mutators accept, so the call reaches the native
/// view instead of stopping at their argument narrowing.
///
/// The native view rejects the mutation before touching the backing list, so
/// this is never actually invoked.
final _alwaysTrue = NativeFunction(
  (visitor, positional, named, types) => true,
  arity: 1,
  name: 'alwaysTrue',
);

/// A two-argument callable, for the map mutators whose callback takes `(k, v)`.
final _alwaysTrue2 = NativeFunction(
  (visitor, positional, named, types) => true,
  arity: 2,
  name: 'alwaysTrue2',
);

/// A one-argument callable that returns a value, for `update` / `putIfAbsent`.
final _returnsValue = NativeFunction(
  (visitor, positional, named, types) => 99,
  arity: 1,
  name: 'returnsValue',
);

/// The nine mutating methods on the map view, each with arguments that pass its
/// own validation.
///
/// The arguments matter as much as the names. `update` narrows its second
/// positional to a `Callable` before delegating, so passing a plain value would
/// report an argument problem and the delegation would never be reached — the
/// case would then pass without having tested anything. Same for `putIfAbsent`,
/// `removeWhere` and `updateAll`.
final Map<String, List<Object?>> _mutatingMapCalls = {
  '[]=': ['c', 3],
  'addAll': [
    {'c': 3},
  ],
  // `Map`'s adapter answers this one, not the view's; it takes an iterable of
  // entries and unwraps a `BridgedInstance<MapEntry>`. A native entry is what
  // a script's `{'c': 3}.entries` becomes by the time it arrives.
  'addEntries': [
    [MapEntry<dynamic, dynamic>('c', 3)],
  ],
  'clear': [],
  'putIfAbsent': ['c', _returnsValue],
  'remove': ['a'],
  'removeWhere': [_alwaysTrue2],
  'update': ['a', _returnsValue],
  'updateAll': [_alwaysTrue2],
};

/// The eight mutating methods on the set view.
final Map<String, List<Object?>> _mutatingSetCalls = {
  'add': [3],
  'addAll': [
    [3],
  ],
  'remove': [1],
  'removeAll': [
    [1],
  ],
  'retainAll': [
    [1],
  ],
  'removeWhere': [_alwaysTrue],
  'retainWhere': [_alwaysTrue],
  'clear': [],
};

/// The 18 mutating methods scb6 rewrote to delegate, each with arguments that
/// pass its own validation — otherwise the adapter would report the argument
/// problem and the delegation would never be reached.
final Map<String, List<Object?>> _mutatingListCalls = {
  '[]=': [0, 'z'],
  'add': ['z'],
  'addAll': [
    ['z'],
  ],
  'clear': [],
  'insert': [0, 'z'],
  'insertAll': [
    0,
    ['z'],
  ],
  'remove': ['a'],
  'removeAt': [0],
  'removeLast': [],
  'removeRange': [0, 1],
  'removeWhere': [_alwaysTrue],
  'replaceRange': [
    0,
    1,
    ['z'],
  ],
  'retainWhere': [_alwaysTrue],
  'fillRange': [0, 1, 'z'],
  'setAll': [
    0,
    ['z'],
  ],
  'setRange': [
    0,
    1,
    ['z'],
  ],
  'shuffle': [],
  'sort': [],
};

/// The three mutating setters scb6 rewrote alongside the methods.
final Map<String, Object?> _mutatingListSetters = {
  'length': 0,
  'first': 'z',
  'last': 'z',
};
