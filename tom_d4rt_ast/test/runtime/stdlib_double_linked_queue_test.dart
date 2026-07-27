import 'dart:collection';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';
// `CollectionStdlib` — like every other stdlib registrar — is deliberately not
// re-exported from `runtime.dart`; `dart:collection` is registered lazily by
// `ast_module_loader.dart` when a script imports it. Driving that path from a
// unit test would mean building a parsed AST module, so we reach for the
// same-package registrar directly rather than widening the published API.
import 'package:tom_d4rt_ast/src/runtime/stdlib/collection.dart';
// `Iterable` is a `dart:core` bridge, not a `dart:collection` one, so the top
// of the queue hierarchy only exists once `CoreStdlib` has run too. A script
// gets both because it imports both; a registration-level test has to say so.
import 'package:tom_d4rt_ast/src/runtime/stdlib/core.dart';

/// SC7 mirror coverage for `tom_d4rt_ast` — `DoubleLinkedQueue`, its
/// `DoubleLinkedQueueEntry` cursor, and the queue supertype hierarchy.
///
/// Registration-level rather than script-level, for the same reason as the SC5
/// and SC6 mirrors: the script-level equivalents live in
/// `tom_d4rt/test/stdlib/collection/double_linked_queue_test.dart`, and
/// `tom_d4rt_exec` — the only runner that could execute a script against *this*
/// tree — resolves `tom_d4rt_ast` from pub.dev rather than by path, so it cannot
/// see unpublished local edits.
///
/// What is observable without an interpreter is exactly the set of decisions
/// SC7 made: which bridges exist, which native names route where, which
/// supertype edges were registered, and — because the adapters read straight
/// through to the native collection — that the deque and entry surfaces
/// actually work.
void main() {
  late Environment env;
  late InterpreterVisitor visitor;

  setUp(() {
    env = Environment();
    CoreStdlib.register(env);
    CollectionStdlib.register(env);
    // Method adapters take a non-nullable visitor (only getters accept `null`).
    // None of the members exercised here resolves a name or loads a module, so
    // an empty loader is enough.
    visitor = InterpreterVisitor(
      globalEnvironment: env,
      moduleContext: AstModuleLoader(
        modules: const {},
        globalEnvironment: env,
        runner: D4rtRunner(),
      ),
    );
  });

  BridgedClass queueBridge() =>
      env.findBridgedClassByName('DoubleLinkedQueue')!;
  BridgedClass entryBridge() =>
      env.findBridgedClassByName('DoubleLinkedQueueEntry')!;

  group('SC7: DoubleLinkedQueue collection bridge', () {
    test('F-SC7-AST-1: is registered under the name DoubleLinkedQueue [2026-07-27]',
        () {
      final bridge = env.findBridgedClassByName('DoubleLinkedQueue');
      expect(bridge, isNotNull);
      expect(bridge!.nativeType, DoubleLinkedQueue);
      expect(bridge.typeParameterCount, 1);
      expect(bridge.constructors.keys, containsAll(<String>['', 'from', 'of']));
    });

    test('F-SC7-AST-2: declares isAssignable, unlike the abstract bridges [2026-07-27]',
        () {
      // Safe because the class is concrete and a leaf: it cannot shadow a more
      // specific bridge. It does tie with `Queue`'s predicate, which is what
      // F-SC7-AST-7's registry edge exists to break.
      final bridge = queueBridge();
      expect(bridge.isAssignable, isNotNull);
      expect(bridge.isAssignable!(DoubleLinkedQueue<dynamic>()), isTrue);
      expect(bridge.isAssignable!(ListQueue<dynamic>()), isFalse);
    });

    test('F-SC7-AST-3: constructs from the three constructors [2026-07-27]', () {
      final bridge = queueBridge();
      expect(bridge.constructors['']!(visitor, [], {}), isA<DoubleLinkedQueue>());
      expect(
        (bridge.constructors['from']!(visitor, [
          [1, 2, 3]
        ], {}) as DoubleLinkedQueue)
            .length,
        3,
      );
      expect(
        (bridge.constructors['of']!(visitor, [
          [1, 2]
        ], {}) as DoubleLinkedQueue)
            .length,
        2,
      );
    });

    test('F-SC7-AST-4: the constructors reject a non-Iterable [2026-07-27]', () {
      final bridge = queueBridge();
      expect(() => bridge.constructors['from']!(visitor, [42], {}),
          throwsA(isA<RuntimeD4rtException>()));
      expect(() => bridge.constructors['of']!(visitor, [42], {}),
          throwsA(isA<RuntimeD4rtException>()));
      expect(() => bridge.constructors['']!(visitor, [1], {}),
          throwsA(isA<RuntimeD4rtException>()));
    });

    test('F-SC7-AST-5: the deque surface mutates both ends [2026-07-27]', () {
      final bridge = queueBridge();
      final queue = DoubleLinkedQueue<dynamic>();
      bridge.methods['addLast']!(visitor, queue, [2], {}, []);
      bridge.methods['addFirst']!(visitor, queue, [1], {}, []);
      bridge.methods['add']!(visitor, queue, [3], {}, []);
      expect(bridge.methods['toList']!(visitor, queue, [], {}, []),
          orderedEquals([1, 2, 3]));
      expect(bridge.methods['removeFirst']!(visitor, queue, [], {}, []), 1);
      expect(bridge.methods['removeLast']!(visitor, queue, [], {}, []), 3);
      expect(bridge.getters['length']!(visitor, queue), 1);
    });

    test('F-SC7-AST-6: removeFirst and removeLast guard an empty queue [2026-07-27]',
        () {
      final bridge = queueBridge();
      final queue = DoubleLinkedQueue<dynamic>();
      expect(() => bridge.methods['removeFirst']!(visitor, queue, [], {}, []),
          throwsA(isA<RuntimeD4rtException>()));
      expect(() => bridge.methods['removeLast']!(visitor, queue, [], {}, []),
          throwsA(isA<RuntimeD4rtException>()));
      expect(() => bridge.getters['first']!(visitor, queue),
          throwsA(isA<RuntimeD4rtException>()));
    });
  });

  group('SC7: queue supertype hierarchy', () {
    test('F-SC7-AST-7: the DoubleLinkedQueue -> Queue -> Iterable chain is registered [2026-07-27]',
        () {
      // Load-bearing twice over: it is what makes `q is Iterable` true, and
      // what lets the bridged-supertype walk reach the ~30-member `Iterable`
      // surface the deque inherits but does not declare.
      expect(BridgedClass.transitiveSupertypeNames('DoubleLinkedQueue'),
          containsAll(<String>['Queue', 'Iterable']));
      expect(
        queueBridge().isSubtypeOf(env.findBridgedClassByName('Queue')!),
        isTrue,
      );
      expect(
        queueBridge().isSubtypeOf(env.findBridgedClassByName('Iterable')!),
        isTrue,
      );
    });

    test('F-SC7-AST-8: the ListQueue edges were registered too [2026-07-27]', () {
      // The realignment half of SC7: the shipped `ListQueue` bridge never
      // declared `contains`/`join`/`where`/`map` and had no hierarchy to reach
      // them through, so they failed outright. Pinned here so the recovery is
      // not silently dropped.
      expect(BridgedClass.transitiveSupertypeNames('ListQueue'),
          containsAll(<String>['Queue', 'Iterable']));
      expect(BridgedClass.transitiveSupertypeNames('Queue'),
          contains('Iterable'));
    });

    test('F-SC7-AST-9: DoubleLinkedQueue and ListQueue stay distinct [2026-07-27]',
        () {
      // Siblings, not sub/supertypes — the guard against having expressed the
      // hierarchy by widening `isAssignable` instead of using the registry.
      expect(BridgedClass.transitiveSupertypeNames('DoubleLinkedQueue'),
          isNot(contains('ListQueue')));
      expect(
        queueBridge()
            .isSubtypeOf(env.findBridgedClassByName('ListQueue')!),
        isFalse,
      );
    });
  });

  group('SC7: DoubleLinkedQueueEntry bridge', () {
    test('F-SC7-AST-10: is registered and routes the private element type [2026-07-27]',
        () {
      // `firstEntry()` returns `_DoubleLinkedQueueElement`, not a
      // `DoubleLinkedQueueEntry`. Without this routing every accessor on the
      // result would reach no bridge at all.
      final bridge = env.findBridgedClassByName('DoubleLinkedQueueEntry');
      expect(bridge, isNotNull);
      expect(bridge!.nativeType, DoubleLinkedQueueEntry);
      expect(bridge.nativeNames, contains('_DoubleLinkedQueueElement'));
      final resolved =
          env.getRuntimeType(DoubleLinkedQueue<dynamic>.from([1]).firstEntry());
      expect(resolved, isA<BridgedClass>());
      expect((resolved as BridgedClass).name, 'DoubleLinkedQueueEntry');
    });

    test('F-SC7-AST-11: firstEntry and lastEntry navigate the chain [2026-07-27]',
        () {
      final queue = DoubleLinkedQueue<dynamic>.from([1, 2, 3]);
      final entries = entryBridge();
      final first =
          queueBridge().methods['firstEntry']!(visitor, queue, [], {}, [])!;
      expect(entries.getters['element']!(visitor, first), 1);
      final second = entries.methods['nextEntry']!(visitor, first, [], {}, [])!;
      expect(entries.getters['element']!(visitor, second), 2);
      expect(entries.methods['previousEntry']!(visitor, first, [], {}, []),
          isNull);
      final last =
          queueBridge().methods['lastEntry']!(visitor, queue, [], {}, [])!;
      expect(entries.getters['element']!(visitor, last), 3);
    });

    test('F-SC7-AST-12: append and prepend splice into the queue [2026-07-27]',
        () {
      // The entire reason DoubleLinkedQueue exists rather than ListQueue.
      final queue = DoubleLinkedQueue<dynamic>.from([1, 3]);
      final entries = entryBridge();
      final first =
          queueBridge().methods['firstEntry']!(visitor, queue, [], {}, [])!;
      entries.methods['append']!(visitor, first, [2], {}, []);
      expect(queue.toList(), orderedEquals([1, 2, 3]));
      final last =
          queueBridge().methods['lastEntry']!(visitor, queue, [], {}, [])!;
      entries.methods['prepend']!(visitor, last, [9], {}, []);
      expect(queue.toList(), orderedEquals([1, 2, 9, 3]));
    });

    test('F-SC7-AST-13: remove unlinks and element is settable [2026-07-27]',
        () {
      final queue = DoubleLinkedQueue<dynamic>.from([1, 2, 3]);
      final entries = entryBridge();
      final first =
          queueBridge().methods['firstEntry']!(visitor, queue, [], {}, [])!;
      expect(entries.methods['remove']!(visitor, first, [], {}, []), 1);
      final newFirst =
          queueBridge().methods['firstEntry']!(visitor, queue, [], {}, [])!;
      entries.setters['element']!(visitor, newFirst, 99);
      expect(queue.toList(), orderedEquals([99, 3]));
    });

    test('F-SC7-AST-14: a standalone entry is constructible [2026-07-27]', () {
      // Legal in the SDK and fully functional, so the constructor is bridged
      // rather than making the type obtainable only from a queue.
      final entries = entryBridge();
      final entry = entries.constructors['']!(visitor, [5], {})!;
      expect(entry, isA<DoubleLinkedQueueEntry>());
      expect(entries.getters['element']!(visitor, entry), 5);
      expect(() => entries.constructors['']!(visitor, [], {}),
          throwsA(isA<RuntimeD4rtException>()));
    });

    test('F-SC7-AST-15: forEachEntry visits every entry, empty yields null [2026-07-27]',
        () {
      // `firstEntry()` returning null on an empty queue is the SDK contract —
      // it is why these are methods rather than throwing getters.
      final queue = DoubleLinkedQueue<dynamic>.from([1, 2, 3]);
      final entries = entryBridge();
      final seen = <Object?>[];
      queueBridge().methods['forEachEntry']!(
        visitor,
        queue,
        [
          NativeFunction((_, positional, _, _) {
            seen.add(entries.getters['element']!(visitor, positional.first!));
            return null;
          }, arity: 1, name: 'collect')
        ],
        {},
        [],
      );
      expect(seen, orderedEquals([1, 2, 3]));
      expect(
        queueBridge().methods['firstEntry']!(
            visitor, DoubleLinkedQueue<dynamic>(), [], {}, []),
        isNull,
      );
    });
  });
}
