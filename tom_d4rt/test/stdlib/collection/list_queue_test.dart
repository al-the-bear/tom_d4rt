import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

void main() {
  final d4rt = D4rt();

  group('ListQueue Tests', () {
    test('I-COLL-60: ListQueue() constructor and basic properties. [2026-02-10 06:37] (PASS)', () {
      final result = d4rt.execute(
        source: '''
          import 'dart:collection';
          main() {
            final queue = ListQueue();
            return [queue.length, queue.isEmpty, queue.isNotEmpty];
          }
        ''',
      ) as List;
      expect(result[0], 0);
      expect(result[1], true);
      expect(result[2], false);
    });

    test('I-COLL-56: ListQueue(initialCapacity) constructor. [2026-02-10 06:37] (PASS)', () {
      // Note: Testing initialCapacity is tricky without exposing internal details.
      // We mainly test that it doesn't crash and basic operations work.
      final result = d4rt.execute(
        source: '''
          import 'dart:collection';
          main() {
            final queue = ListQueue(5);
            queue.add(1);
            return [queue.length, queue.first];
          }
        ''',
      ) as List;
      expect(result[0], 1);
      expect(result[1], 1);
    });

    test('I-COLL-58: ListQueue.from() constructor. [2026-02-10 06:37] (PASS)', () {
      final result = d4rt.execute(
        source: '''
          import 'dart:collection';
          main() {
            final sourceList = [1, 2, 3];
            final queue = ListQueue.from(sourceList);
            return [queue.length, queue.first, queue.last, queue.toList()];
          }
        ''',
      ) as List;
      expect(result[0], 3, reason: "Length from list");
      expect(result[1], 1, reason: "First element");
      expect(result[2], 3, reason: "Last element");
      expect(result[3], orderedEquals([1, 2, 3]), reason: "toList from list");
    });

    test('I-COLL-59: Add, addFirst, addLast, length, first, last. [2026-02-10 06:37] (PASS)', () {
      final result = d4rt.execute(
        source: '''
          import 'dart:collection';
          main() {
            final queue = ListQueue();
            queue.add(10); // {10}
            final l1 = queue.length;
            final f1 = queue.first;
            final la1 = queue.last;

            queue.addFirst(5); // {5, 10}
            final l2 = queue.length;
            final f2 = queue.first;
            final la2 = queue.last;

            queue.addLast(20); // {5, 10, 20}
            final l3 = queue.length;
            final f3 = queue.first;
            final la3 = queue.last;
            return [l1, f1, la1, l2, f2, la2, l3, f3, la3, queue.toList()];
          }
        ''',
      ) as List;
      expect(result[0], 1, reason: "l1");
      expect(result[1], 10, reason: "f1");
      expect(result[2], 10, reason: "la1");
      expect(result[3], 2, reason: "l2");
      expect(result[4], 5, reason: "f2");
      expect(result[5], 10, reason: "la2");
      expect(result[6], 3, reason: "l3");
      expect(result[7], 5, reason: "f3");
      expect(result[8], 20, reason: "la3");
      expect(result[9], orderedEquals([5, 10, 20]), reason: "toList check");
    });

    test('I-COLL-61: RemoveFirst, removeLast. [2026-02-10 06:37] (PASS)', () {
      final result = d4rt.execute(
        source: '''
          import 'dart:collection';
          main() {
            final queue = ListQueue.from([1, 2, 3, 4]);
            final rf1 = queue.removeFirst(); // 1, queue is {2, 3, 4}
            final rl1 = queue.removeLast();  // 4, queue is {2, 3}
            final rf2 = queue.removeFirst(); // 2, queue is {3}
            final l = queue.length;
            final f = queue.first;
            final la = queue.last;
            final rf3 = queue.removeLast(); // 3, queue is {}
            final isEmpty = queue.isEmpty;
            return [rf1, rl1, rf2, l, f, la, rf3, isEmpty, queue.toList()];
          }
        ''',
      ) as List;
      expect(result[0], 1, reason: "rf1");
      expect(result[1], 4, reason: "rl1");
      expect(result[2], 2, reason: "rf2");
      expect(result[3], 1, reason: "length after removals");
      expect(result[4], 3, reason: "first after removals");
      expect(result[5], 3, reason: "last after removals");
      expect(result[6], 3, reason: "rf3");
      expect(result[7], true, reason: "isEmpty after all removed");
      expect(result[8], orderedEquals([]), reason: "toList empty");
    });

    test('I-COLL-50: RemoveFirst/removeLast on empty queue throws error. [2026-02-10 06:37] (PASS)', () {
      expect(
        () => d4rt.execute(source: '''
          import 'dart:collection';
          main() {
            final queue = ListQueue();
            queue.removeFirst();
          }
        '''),
        throwsA(isA<RuntimeD4rtException>()),
        reason: "removeFirst on empty queue",
      );
      expect(
        () => d4rt.execute(source: '''
          import 'dart:collection';
          main() {
            final queue = ListQueue();
            queue.removeLast();
          }
        '''),
        throwsA(isA<RuntimeD4rtException>()),
        reason: "removeLast on empty queue",
      );
    });

    test('I-COLL-51: Clear() and isEmpty. [2026-02-10 06:37] (PASS)', () {
      final result = d4rt.execute(
        source: '''
          import 'dart:collection';
          main() {
            final queue = ListQueue.from([1, 2, 3]);
            final initialLength = queue.length;
            queue.clear();
            return [initialLength, queue.length, queue.isEmpty];
          }
        ''',
      ) as List;
      expect(result[0], 3, reason: "Initial length");
      expect(result[1], 0, reason: "Length after clear");
      expect(result[2], true, reason: "isEmpty after clear");
    });

    test('I-COLL-52: Remove() specific element. [2026-02-10 06:37] (PASS)', () {
      final result = d4rt.execute(
        source: '''
          import 'dart:collection';
          main() {
            final queue = ListQueue.from([10, 20, 30, 20, 40]);
            final r1 = queue.remove(20); // Removes first 20. Queue: [10, 30, 20, 40]
            final r2 = queue.remove(50); // Non-existent
            final r3 = queue.remove(20); // Removes second 20. Queue: [10, 30, 40]
            return [r1, r2, r3, queue.toList(), queue.length];
          }
        ''',
      ) as List;
      expect(result[0], true, reason: "remove first 20");
      expect(result[1], false, reason: "remove non-existent 50");
      expect(result[2], true, reason: "remove second 20");
      expect(result[3], orderedEquals([10, 30, 40]),
          reason: "toList after removes");
      expect(result[4], 3, reason: "length after removes");
    });

    test('I-COLL-53: AddAll(). [2026-02-10 06:37] (PASS)', () {
      final result = d4rt.execute(
        source: '''
          import 'dart:collection';
          main() {
            final queue = ListQueue.from([1, 2]);
            queue.addAll([3, 4, 5]);
            return queue.toList();
          }
        ''',
      ) as List;
      expect(result, orderedEquals([1, 2, 3, 4, 5]));
    });

    test('I-COLL-54: ForEach() and iterator. [2026-02-10 06:37] (PASS)', () {
      final result = d4rt.execute(
        source: '''
          import 'dart:collection';
          main() {
            final queue = ListQueue.from(['a', 'b', 'c']);
            final forEachElements = [];
            queue.forEach((e) => forEachElements.add(e));

            final iteratorElements = [];
            final iter = queue.iterator;
            while(iter.moveNext()) {
              iteratorElements.add(iter.current);
            }
            return [forEachElements, iteratorElements];
          }
        ''',
      ) as List;
      expect(result[0], orderedEquals(['a', 'b', 'c']),
          reason: "forEachElements");
      expect(result[1], orderedEquals(['a', 'b', 'c']),
          reason: "iteratorElements");
    });

    test('I-COLL-55: Single getter. [2026-02-10 06:37] (PASS)', () {
      d4rt.execute(source: '''
          import 'dart:collection';
          main() {
            final q = ListQueue.from([77]);
            return q.single;
          }
      ''', name: 'main');
      expect(d4rt.execute(source: '''
          import 'dart:collection';
          main() {
            final q = ListQueue.from([77]);
            return q.single;
          }
      ''', name: 'main'), 77);

      expect(() => d4rt.execute(source: '''
            import 'dart:collection';
            main() { ListQueue().single; }
        '''), throwsA(isA<RuntimeD4rtException>()), reason: "single on empty queue");
      expect(() => d4rt.execute(source: '''
            import 'dart:collection';
            main() { ListQueue.from([1,2]).single; }
        '''), throwsA(isA<RuntimeD4rtException>()),
          reason: "single on multi-element queue");
    });

    test('I-COLL-57: ToList() growable. [2026-02-10 06:37] (PASS)', () {
      final result = d4rt.execute(
        source: '''
          import 'dart:collection';
          main() {
            final queue = ListQueue.from([1,2,3]);
            final list1 = queue.toList(); // growable: true by default
            list1.add(4);

            final list2 = queue.toList(growable: false);
            var error = false;
            try {
              list2.add(5);
            } catch (e) {
              error = true;
            }
            return [list1, error];
          }
        ''',
      ) as List;
      expect(result[0], orderedEquals([1, 2, 3, 4]));
      expect(result[1], true, reason: "Error adding to non-growable list");
    });
  });
}
