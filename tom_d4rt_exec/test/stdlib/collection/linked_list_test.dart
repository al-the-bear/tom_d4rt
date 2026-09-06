// SCC8 finished the LinkedList surface. The class reached 25 of its 27 missing
// members through the `LinkedList -> Iterable` supertype edge — one registered
// edge rather than 25 adapters — which left exactly the two members that are
// LinkedList's own and cannot be inherited from anywhere: `addAll` and
// `addFirst`. The F-SCC8 cases below pin those two.
//
// It also removed `removeFirst`, which the bridge offered and Dart's LinkedList
// does not have. That direction of error has no test to fail: a member the SDK
// lacks makes every script using it green here and uncompilable as Dart, and
// nothing notices until someone moves the script. F-SCC8-5 pins the absence so
// the convenience cannot be reinstated by someone reading `Queue.removeFirst`
// and assuming the omission was an oversight. I-COLL-42 keeps asserting the
// same behaviour through `list.first.unlink()`, the idiom real Dart uses.

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

void main() {
  final d4rt = D4rt();
  const String testLibPath = 'd4rt-mem:/linked_list_test.dart';

  dynamic executeTestScript(String scriptBody) {
    final fullScript =
        '''
      import 'dart:collection';

      main() {
        $scriptBody
      }
    ''';
    return d4rt.execute(
      library: testLibPath,
      name: 'main',
      sources: {testLibPath: fullScript},
    );
  }

  group('LinkedList and LinkedListEntry Tests', () {
    test(
      'I-COLL-47: Create LinkedList, add entries, check properties. [2026-02-10 06:37] (PASS)',
      () {
        final result = executeTestScript('''
        var list = LinkedList();
        var entry1 = LinkedListEntry('apple');
        var entry2 = LinkedListEntry(123);
        
        list.add(entry1);
        list.add(entry2);
        
        return {
          'length': list.length,
          'isEmpty': list.isEmpty,
          'isNotEmpty': list.isNotEmpty,
          'firstValue': list.first.value,
          'lastValue': list.last.value,
          'entry1InList': entry1.list != null,
          'entry2NextIsNull': entry2.next == null,
          'entry1PrevIsNull': entry1.previous == null,
          'entry1NextIsEntry2': entry1.next == entry2,
          'entry2PrevIsEntry1': entry2.previous == entry1,
        };
      ''');
        expect(result['length'], 2);
        expect(result['isEmpty'], false);
        expect(result['isNotEmpty'], true);
        expect(result['firstValue'], 'apple');
        expect(result['lastValue'], 123);
        expect(result['entry1InList'], true);
        expect(result['entry2NextIsNull'], true);
        expect(result['entry1PrevIsNull'], true);
        expect(result['entry1NextIsEntry2'], true);
        expect(result['entry2PrevIsEntry1'], true);
      },
    );

    test('I-COLL-48: LinkedListEntry unlink. [2026-02-10 06:37] (PASS)', () {
      final result = executeTestScript('''
        var list = LinkedList();
        var entry1 = LinkedListEntry('a');
        var entry2 = LinkedListEntry('b');
        list.add(entry1);
        list.add(entry2);
        
        entry1.unlink(); // Unlink first
        
        return {
          'listLength': list.length,
          'firstValue': list.first.value,
          'entry1ListIsNull': entry1.list == null,
          'entry1PrevIsNull': entry1.previous == null,
          'entry1NextIsNull': entry1.next == null,
        };
      ''');
      expect(result['listLength'], 1);
      expect(result['firstValue'], 'b');
      expect(result['entry1ListIsNull'], true);
      expect(result['entry1PrevIsNull'], true);
      expect(result['entry1NextIsNull'], true);
    });

    test('I-COLL-49: LinkedList remove entry. [2026-02-10 06:37] (PASS)', () {
      final result = executeTestScript('''
        var list = LinkedList();
        var entry1 = LinkedListEntry(1);
        var entry2 = LinkedListEntry(2);
        var entry3 = LinkedListEntry(3);
        list.add(entry1);
        list.add(entry2);
        list.add(entry3);
        
        var removed = list.remove(entry2); // Remove middle
        
        return {
          'removedResult': removed,
          'listLength': list.length,
          'firstValue': list.first.value,
          'lastValue': list.last.value,
          'entry2ListIsNull': entry2.list == null,
          'entry1NextIsEntry3': entry1.next == entry3,
          'entry3PrevIsEntry1': entry3.previous == entry1,
        };
      ''');
      expect(result['removedResult'], true);
      expect(result['listLength'], 2);
      expect(result['firstValue'], 1);
      expect(result['lastValue'], 3);
      expect(result['entry2ListIsNull'], true);
      expect(result['entry1NextIsEntry3'], true);
      expect(result['entry3PrevIsEntry1'], true);
    });

    test(
      'I-COLL-42: the head entry is removed by unlinking it. [2026-09-04]',
      () {
        // Restated by SCC8. This case used to call `list.removeFirst()`; the
        // behaviour it asserts is unchanged — the head goes, the rest shifts up,
        // the removed entry is detached — only the spelling is now the one real
        // Dart accepts.
        final result = executeTestScript('''
        var list = LinkedList();
        var entry1 = LinkedListEntry('x');
        var entry2 = LinkedListEntry('y');
        list.add(entry1);
        list.add(entry2);

        var removedEntry = list.first;
        removedEntry.unlink();

        return {
          'removedValue': removedEntry.value,
          'removedEntryIsEntry1': removedEntry == entry1,
          'listLength': list.length,
          'firstValue': list.first.value,
          'entry1ListIsNull': entry1.list == null,
        };
      ''');
        expect(result['removedValue'], 'x');
        expect(result['removedEntryIsEntry1'], true);
        expect(result['listLength'], 1);
        expect(result['firstValue'], 'y');
        expect(result['entry1ListIsNull'], true);
      },
    );

    test('I-COLL-43: LinkedList clear. [2026-02-10 06:37] (PASS)', () {
      final result = executeTestScript('''
        var list = LinkedList();
        var entry1 = LinkedListEntry(100);
        list.add(entry1);
        list.clear();
        
        return {
          'listLength': list.length,
          'isEmpty': list.isEmpty,
          'entry1ListIsNull': entry1.list == null,
        };
      ''');
      expect(result['listLength'], 0);
      expect(result['isEmpty'], true);
      expect(result['entry1ListIsNull'], true);
    });

    test(
      'I-COLL-44: Accessing first/last on empty list throws error. [2026-02-10 06:37] (PASS)',
      () {
        // SCC51: the expected family changed from RuntimeD4rtException to
        // StateError. The bridge used to catch the SDK's StateError and rethrow
        // a hand-written message; it now inherits Iterable's delegating
        // adapter, so the SDK's own error reaches the script and the
        // `on StateError catch` a Dart author writes actually fires.
        expect(
          () =>
              executeTestScript('var list = LinkedList(); return list.first;'),
          throwsA(isA<StateError>()),
        );
        expect(
          () => executeTestScript('var list = LinkedList(); return list.last;'),
          throwsA(isA<StateError>()),
        );
      },
    );

    test(
      'I-COLL-46: Unlink entry not in a list throws error. [2026-02-10 06:37] (PASS)',
      () {
        // Unlinking an entry that was never added
        expect(
          () => executeTestScript(
            'var entry = LinkedListEntry(0); entry.unlink();',
          ),
          throwsA(isA<RuntimeD4rtException>()),
        );

        // Unlinking an entry that was already unlinked
        expect(
          () => executeTestScript('''
          var list = LinkedList();
          var entry = LinkedListEntry(0);
          list.add(entry);
          entry.unlink(); // First unlink
          entry.unlink(); // Second unlink, should throw
        '''),
          throwsA(isA<RuntimeD4rtException>()),
        );
      },
    );

    test(
      'F-SCC8-1: addAll links every entry, in order, at the tail [2026-09-04]',
      () {
        // Order and tail-placement together: `addAll` on a list that is ALREADY
        // non-empty is the case that separates appending from prepending, and a
        // case starting from an empty list would pass either way.
        final result = executeTestScript('''
        var list = LinkedList();
        var head = LinkedListEntry('head');
        list.add(head);
        list.addAll([LinkedListEntry('a'), LinkedListEntry('b')]);

        var values = [];
        for (var entry in list) {
          values.add(entry.value);
        }
        return {
          'values': values,
          'length': list.length,
          'headStillFirst': list.first == head,
          'lastValue': list.last.value,
        };
      ''');
        expect(result['values'], orderedEquals(['head', 'a', 'b']));
        expect(result['length'], 3);
        expect(result['headStillFirst'], true);
        expect(result['lastValue'], 'b');
      },
    );

    test(
      'F-SCC8-2: addAll accepts any Iterable, not only a list literal [2026-09-04]',
      () {
        // The SDK signature is `addAll(Iterable<E>)`, so a lazy iterable has to
        // work. It also has to be MATERIALISED before linking — `addAll` links as
        // it walks, and a lazy iterable derived from the same list would otherwise
        // mutate what it is iterating.
        final result = executeTestScript('''
        var list = LinkedList();
        list.addAll([1, 2, 3].map((n) => LinkedListEntry(n * 10)));
        var values = [];
        for (var entry in list) {
          values.add(entry.value);
        }
        return {'values': values, 'length': list.length};
      ''');
        expect(result['values'], orderedEquals([10, 20, 30]));
        expect(result['length'], 3);
      },
    );

    test('F-SCC8-3: addAll of an empty iterable is a no-op [2026-09-04]', () {
      final result = executeTestScript('''
        var list = LinkedList();
        var only = LinkedListEntry('only');
        list.add(only);
        list.addAll([]);
        return {'length': list.length, 'firstValue': list.first.value};
      ''');
      expect(result['length'], 1);
      expect(result['firstValue'], 'only');
    });

    test(
      'F-SCC8-4: addFirst prepends and relinks the previous head [2026-09-04]',
      () {
        final result = executeTestScript('''
        var list = LinkedList();
        var second = LinkedListEntry('second');
        list.add(second);
        var first = LinkedListEntry('first');
        list.addFirst(first);

        return {
          'length': list.length,
          'firstValue': list.first.value,
          'lastValue': list.last.value,
          'firstPreviousIsNull': first.previous == null,
          'firstNextIsSecond': first.next == second,
          'secondPreviousIsFirst': second.previous == first,
        };
      ''');
        expect(result['length'], 2);
        expect(result['firstValue'], 'first');
        expect(result['lastValue'], 'second');
        expect(result['firstPreviousIsNull'], true);
        expect(result['firstNextIsSecond'], true);
        expect(result['secondPreviousIsFirst'], true);
      },
    );

    test(
      'F-SCC8-5: removeFirst is absent, because Dart LinkedList has no such member [2026-09-04]',
      () {
        // The bridge used to offer it. Removing it is the point of the case: the
        // member is not in the SDK, so a script calling it runs here and does not
        // compile as Dart, and no test can fail on that by itself. The portable
        // idiom is the one I-COLL-42 now uses.
        expect(
          () => executeTestScript('''
          var list = LinkedList();
          list.add(LinkedListEntry('x'));
          return list.removeFirst();
        '''),
          // `NoSuchMethodError`, not `RuntimeD4rtException`: a missing member is
          // the same failure real Dart reports at runtime, and asserting the SDK
          // supertype means a script can catch it the way it would catch the
          // real one.
          throwsA(
            isA<NoSuchMethodError>().having(
              (e) => e.toString(),
              'message',
              contains('removeFirst'),
            ),
          ),
        );
      },
    );

    test(
      'F-SCC8-6: addAll rejects a non-entry element without linking any [2026-09-04]',
      () {
        // Real Dart rejects this statically, so the interpreter has to reject it
        // at runtime — and ALL-OR-NOTHING, or a bad element three in leaves the
        // first two linked and the script holding a half-applied addAll. That
        // partial state is unreachable in any program the Dart compiler accepts,
        // so validating up front costs nothing and removes it here too.
        final result = executeTestScript('''
        var list = LinkedList();
        var ok = LinkedListEntry('ok');
        try {
          list.addAll([ok, 'not an entry']);
        } catch (e) {
          return {'threw': true, 'length': list.length, 'okLinked': ok.list != null};
        }
        return {'threw': false, 'length': list.length, 'okLinked': ok.list != null};
      ''');
        expect(result['threw'], true);
        expect(
          result['length'],
          0,
          reason: 'nothing may be linked on rejection',
        );
        expect(result['okLinked'], false);
      },
    );
  });
}
