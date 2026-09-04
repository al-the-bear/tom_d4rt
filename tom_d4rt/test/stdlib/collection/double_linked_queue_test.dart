import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// SC7 — `DoubleLinkedQueue`, its `DoubleLinkedQueueEntry` cursor, and the
/// queue hierarchy that makes both usable.
///
/// **Why the entry type is here too.** `DoubleLinkedQueue` differs from the
/// already-bridged `ListQueue` in exactly one way: `firstEntry`/`lastEntry`/
/// `forEachEntry` hand out cursors that splice in place. Bridging the queue
/// without the cursor would have shipped a slower `ListQueue` with no reason to
/// exist, so both are registered. The cursor needs
/// `nativeNames: ['_DoubleLinkedQueueElement']` because `firstEntry()` returns
/// that private subclass, not a `DoubleLinkedQueueEntry` — without the routing
/// the entry API would hand back objects that reach no bridge at all.
///
/// **What the hierarchy block fixes, beyond the new type.** Bridges are
/// registered flat and dispatch is per-bridge, so a queue could not reach the
/// ~30-member `Iterable` surface it inherits. That was already broken for the
/// shipped `ListQueue` bridge — `.where`, `.join`, `.map` and even `.contains`
/// all failed with "has no instance method named", and `q is Iterable` was
/// false. `QueueHierarchyCollection` declares the edges to
/// `BridgedClass.registerSupertypes`, which both answers `is` correctly and
/// lets the bridged-supertype walk find the inherited members. F-SC7-16/17 pin
/// the recovered `ListQueue` behaviour so the fix cannot silently regress.
///
/// The edges are deliberately NOT expressed by widening any `isAssignable`:
/// that predicate decides which bridge *owns* a native object in
/// `Environment.toBridgedInstance`, where every hand-written stdlib bridge ties
/// at `hierarchyDepth == 0`. Feeding the registry instead lets the
/// `_filterToMostSpecific` pass use the hierarchy to drop supertype matches, so
/// it makes dispatch more exact rather than less — F-SC7-5 pins that a deque is
/// not mistaken for a `ListQueue`.
void main() {
  final d4rt = D4rt();

  Object? run(String body) => d4rt.execute(
    source:
        '''
        import 'dart:collection';
        $body
      ''',
  );

  group('SC7: DoubleLinkedQueue construction', () {
    test('F-SC7-1: DoubleLinkedQueue() starts empty [2026-07-27]', () {
      final result =
          run('''
        main() {
          final q = DoubleLinkedQueue();
          return [q.length, q.isEmpty, q.isNotEmpty];
        }
      ''')
              as List;
      expect(result, orderedEquals([0, true, false]));
    });

    test('F-SC7-2: .from and .of both build from an Iterable [2026-07-27]', () {
      final result =
          run('''
        main() {
          return [
            DoubleLinkedQueue.from([1, 2, 3]).length,
            DoubleLinkedQueue.of([1, 2, 3, 4]).length,
          ];
        }
      ''')
              as List;
      expect(result, orderedEquals([3, 4]));
    });

    test('F-SC7-3: the constructors reject a non-Iterable [2026-07-27]', () {
      final result = run('''
        main() {
          final r = [];
          try { DoubleLinkedQueue.from(42); } catch (e) { r.add('from'); }
          try { DoubleLinkedQueue.of(42); } catch (e) { r.add('of'); }
          try { DoubleLinkedQueue(1); } catch (e) { r.add('unnamed'); }
          return r.join(',');
        }
      ''');
      expect(result, 'from,of,unnamed');
    });
  });

  group('SC7: DoubleLinkedQueue deque surface', () {
    test(
      'F-SC7-4: add/addFirst/addLast and removeFirst/removeLast [2026-07-27]',
      () {
        final result =
            run('''
        main() {
          final q = DoubleLinkedQueue();
          q.addLast(2); q.addLast(3); q.addFirst(1); q.add(4);
          final first = q.removeFirst();
          final last = q.removeLast();
          return [first, last, q.toList().join(','), q.length];
        }
      ''')
                as List;
        expect(result, orderedEquals([1, 4, '2,3', 2]));
      },
    );

    test(
      'F-SC7-5: is Queue and is Iterable, but not is ListQueue [2026-07-27]',
      () {
        // The negative is the load-bearing half: `ListQueue` and
        // `DoubleLinkedQueue` are siblings, and both bridges declare an
        // `isAssignable`. If the hierarchy had been expressed by widening those
        // predicates instead of through the registry, this would flip.
        final result =
            run('''
        main() {
          final q = DoubleLinkedQueue();
          return [q is DoubleLinkedQueue, q is Queue, q is Iterable, q is ListQueue];
        }
      ''')
                as List;
        expect(result, orderedEquals([true, true, true, false]));
      },
    );

    test('F-SC7-6: the inherited Iterable surface dispatches [2026-07-27]', () {
      // None of these is declared on the DoubleLinkedQueue bridge. They are
      // reached through the bridged-supertype walk over the registered
      // `-> Iterable` edge; without it each fails with "has no instance
      // method named".
      final result =
          run('''
        main() {
          final q = DoubleLinkedQueue.from([1, 2, 3, 4]);
          return [
            q.where((e) => e > 2).toList().join(','),
            q.map((e) => e * 2).toList().join(','),
            q.join('-'),
            q.contains(3),
            q.fold(0, (a, b) => a + b),
          ];
        }
      ''')
              as List;
      expect(result, orderedEquals(['3,4', '2,4,6,8', '1-2-3-4', true, 10]));
    });

    test('F-SC7-7: for-in iterates the deque in order [2026-07-27]', () {
      final result = run('''
        main() {
          final seen = [];
          for (final e in DoubleLinkedQueue.from([1, 2, 3])) { seen.add(e); }
          return seen.join(',');
        }
      ''');
      expect(result, '1,2,3');
    });

    test('F-SC7-8: removeWhere and retainWhere [2026-07-27]', () {
      final result =
          run('''
        main() {
          final q = DoubleLinkedQueue.from([1, 2, 3, 4, 5]);
          q.removeWhere((e) => e % 2 == 0);
          final afterRemove = q.toList().join(',');
          q.retainWhere((e) => e > 1);
          return [afterRemove, q.toList().join(',')];
        }
      ''')
              as List;
      expect(result, orderedEquals(['1,3,5', '3,5']));
    });

    test(
      'F-SC7-9: first/last/single/clear and the empty guards [2026-07-27]',
      () {
        final result =
            run('''
        main() {
          final q = DoubleLinkedQueue.from([7]);
          final r = [q.first, q.last, q.single];
          q.clear();
          r.add(q.isEmpty);
          try { q.removeFirst(); } catch (e) { r.add('rf'); }
          try { q.removeLast(); } catch (e) { r.add('rl'); }
          try { q.first; } catch (e) { r.add('first'); }
          return r;
        }
      ''')
                as List;
        expect(result, orderedEquals([7, 7, 7, true, 'rf', 'rl', 'first']));
      },
    );

    test(
      'F-SC7-10: addAll appends and rejects a non-Iterable [2026-07-27]',
      () {
        final result =
            run('''
        main() {
          final q = DoubleLinkedQueue.from([1]);
          q.addAll([2, 3]);
          final ok = q.toList().join(',');
          var threw = false;
          try { q.addAll(42); } catch (e) { threw = true; }
          return [ok, threw];
        }
      ''')
                as List;
        expect(result, orderedEquals(['1,2,3', true]));
      },
    );

    test('F-SC7-11: remove(value) reports whether it removed [2026-07-27]', () {
      final result =
          run('''
        main() {
          final q = DoubleLinkedQueue.from([1, 2, 3]);
          return [q.remove(2), q.remove(9), q.toList().join(',')];
        }
      ''')
              as List;
      expect(result, orderedEquals([true, false, '1,3']));
    });
  });

  group('SC7: DoubleLinkedQueueEntry cursor', () {
    test('F-SC7-12: firstEntry/lastEntry navigate the chain [2026-07-27]', () {
      // Proves the `_DoubleLinkedQueueElement` nativeNames routing: every
      // accessor here is reached on an object whose runtime type is the
      // private subclass, not `DoubleLinkedQueueEntry`.
      final result =
          run('''
        main() {
          final q = DoubleLinkedQueue.from([1, 2, 3]);
          final first = q.firstEntry();
          final second = first.nextEntry();
          return [
            first.element,
            second.element,
            second.nextEntry().element,
            first.previousEntry() == null,
            q.lastEntry().element,
          ];
        }
      ''')
              as List;
      expect(result, orderedEquals([1, 2, 3, true, 3]));
    });

    test('F-SC7-13: append and prepend splice into the queue [2026-07-27]', () {
      // The entire reason DoubleLinkedQueue exists rather than ListQueue.
      final result =
          run('''
        main() {
          final q = DoubleLinkedQueue.from([1, 3]);
          q.firstEntry().append(2);
          final afterAppend = q.toList().join(',');
          q.lastEntry().prepend(9);
          return [afterAppend, q.toList().join(',')];
        }
      ''')
              as List;
      expect(result, orderedEquals(['1,2,3', '1,2,9,3']));
    });

    test(
      'F-SC7-14: entry.remove() unlinks, and element is settable [2026-07-27]',
      () {
        final result =
            run('''
        main() {
          final q = DoubleLinkedQueue.from([1, 2, 3]);
          final removed = q.firstEntry().remove();
          q.firstEntry().element = 99;
          return [removed, q.toList().join(',')];
        }
      ''')
                as List;
        expect(result, orderedEquals([1, '99,3']));
      },
    );

    test(
      'F-SC7-15: forEachEntry, empty-queue null, standalone entry [2026-07-27]',
      () {
        // `firstEntry()` returning null on an empty queue is the SDK contract —
        // it is why these are methods rather than throwing getters.
        final result =
            run('''
        main() {
          final q = DoubleLinkedQueue.from([1, 2, 3]);
          final seen = [];
          q.forEachEntry((e) => seen.add(e.element));
          final standalone = DoubleLinkedQueueEntry(5);
          return [
            seen.join(','),
            DoubleLinkedQueue().firstEntry() == null,
            standalone.element,
            standalone is DoubleLinkedQueueEntry,
          ];
        }
      ''')
                as List;
        expect(result, orderedEquals(['1,2,3', true, 5, true]));
      },
    );
  });

  group('SC7: queue hierarchy realignment', () {
    test(
      'F-SC7-16: ListQueue regains its inherited Iterable surface [2026-07-27]',
      () {
        // Pre-existing breakage, not new: the shipped `ListQueue` bridge never
        // declared these, and before the hierarchy block there was nothing to
        // reach them through. `contains` is the striking one — the `Queue`
        // bridge has always declared it, but a `ListQueue` native dispatches to
        // the `ListQueue` bridge, which did not.
        final result =
            run('''
        main() {
          final q = ListQueue();
          q.addLast(1); q.addLast(2); q.addLast(3);
          return [
            q.contains(2),
            q.join('-'),
            q.where((e) => e > 1).toList().length,
            q.map((e) => e * 2).toList().join(','),
            q is Iterable,
            q is Queue,
          ];
        }
      ''')
                as List;
        expect(result, orderedEquals([true, '1-2-3', 2, '2,4,6', true, true]));
      },
    );

    test(
      'F-SC7-17: Queue() keeps working and gains the same surface [2026-07-27]',
      () {
        // `Queue()` is a factory for `ListQueue`, so this exercises the same
        // dispatch path from the abstract name. Regression guard: the hierarchy
        // block must not disturb the routing that already worked.
        final result =
            run('''
        main() {
          final q = Queue();
          q.add(1); q.addFirst(0);
          return [q.toList().join(','), q is Queue, q is Iterable, q.contains(1)];
        }
      ''')
                as List;
        expect(result, orderedEquals(['0,1', true, true, true]));
      },
    );
  });
}
