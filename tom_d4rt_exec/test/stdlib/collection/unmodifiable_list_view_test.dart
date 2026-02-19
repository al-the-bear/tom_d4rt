import '../../test_helpers.dart';
import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

void main() {
  final d4rt = D4rt(parseSourceCallback: parseSource);

  group('UnmodifiableListView Tests', () {
    List<Object?> executeAndGetList(String source) {
      return d4rt.execute(source: source) as List<Object?>;
    }

    dynamic executeAndGetResult(String source) {
      return d4rt.execute(source: source);
    }

    void expectUnsupportedError(Function() action) {
      expect(
          action,
          throwsA(isA<RuntimeD4rtException>().having(
              (e) => e.message,
              'message',
              anyOf(contains('Unsupported operation'),
                  contains('Cannot modify'), contains('Cannot change')))),
          reason:
              "Should throw RuntimeError encapsulating an unmodifiable list error");
    }

    String unmodifiableListViewSource(String listContents, String operations) {
      return '''
        import 'dart:collection';
        main() {
          final source = $listContents;
          final unmodifiable = UnmodifiableListView(source);
          $operations
        }
      ''';
    }

    test('I-COLL-105: Constructor and basic getters. [2026-02-10 06:37] (PASS)', () {
      final result = executeAndGetList(unmodifiableListViewSource('[1, 2, 3]',
          'return [unmodifiable.length, unmodifiable.isEmpty, unmodifiable.isNotEmpty, unmodifiable.first, unmodifiable.last, unmodifiable.singleWhere((e) => e == 2, orElse: () => -1 )];'));
      expect(result[0], 3);
      expect(result[1], false);
      expect(result[2], true);
      expect(result[3], 1);
      expect(result[4], 3);
      expect(result[5], 2);
    });

    test('I-COLL-106: [] operator (getter). [2026-02-10 06:37] (PASS)', () {
      final result = executeAndGetResult(unmodifiableListViewSource(
          '["a", "b", "c"]', 'return unmodifiable[1];'));
      expect(result, 'b');
    });

    test('I-COLL-107: Read-only iteration methods: forEach, map, where, any, every. [2026-02-10 06:37] (PASS)', () {
      final result =
          executeAndGetList(unmodifiableListViewSource('[1, 2, 3, 4]', '''
          final forEachItems = [];
          unmodifiable.forEach((item) => forEachItems.add(item * 2));
          
          final mappedItems = unmodifiable.map((item) => item + 1).toList();
          final whereItems = unmodifiable.where((item) => item % 2 == 0).toList();
          final anyEven = unmodifiable.any((item) => item % 2 == 0);
          final everyEven = unmodifiable.every((item) => item % 2 == 0);
          final everyPositive = unmodifiable.every((item) => item > 0);

          return [forEachItems, mappedItems, whereItems, anyEven, everyEven, everyPositive];
        '''));
      expect(result[0], orderedEquals([2, 4, 6, 8]));
      expect(result[1], orderedEquals([2, 3, 4, 5]));
      expect(result[2], orderedEquals([2, 4]));
      expect(result[3], true); // anyEven
      expect(result[4], false); // everyEven
      expect(result[5], true); // everyPositive
    });

    test(
        'I-COLL-282: Other read-only methods: contains, indexOf, lastIndexOf, join, getRange, sublist, toList, toSet, cast, iterator, reversed. [2026-02-12] (PASS)',
        () {
      final result =
          executeAndGetList(unmodifiableListViewSource('[10, 20, 30, 20]', '''
          final contains20 = unmodifiable.contains(20);
          final indexOf20 = unmodifiable.indexOf(20);
          final lastIndexOf20 = unmodifiable.lastIndexOf(20);
          final joined = unmodifiable.join("-");
          final range = unmodifiable.getRange(1, 3).toList(); // getRange returns Iterable
          final sub = unmodifiable.sublist(1,3);
          final listCopy = unmodifiable.toList(); // Default growable: true
          final setCopy = unmodifiable.toSet();
          final iter = unmodifiable.iterator;
          final iteratedItems = [];
          while(iter.moveNext()) { iteratedItems.add(iter.current); }
          final reversedItems = unmodifiable.reversed.toList();
          listCopy.add(40); // Ensure copy is modifiable

          return [contains20, indexOf20, lastIndexOf20, joined, range, sub, listCopy, setCopy.toList()..sort(), iteratedItems, reversedItems ];
        '''));
      expect(result[0], true, reason: "contains20");
      expect(result[1], 1, reason: "indexOf20");
      expect(result[2], 3, reason: "lastIndexOf20");
      expect(result[3], "10-20-30-20", reason: "joined");
      expect(result[4], orderedEquals([20, 30]), reason: "range");
      expect(result[5], orderedEquals([20, 30]), reason: "sub");
      expect(result[6], orderedEquals([10, 20, 30, 20, 40]),
          reason: "listCopy and modified");
      expect(result[7], orderedEquals([10, 20, 30]), reason: "setCopy sorted");
      expect(result[8], orderedEquals([10, 20, 30, 20]),
          reason: "iteratedItems");
      expect(result[9], orderedEquals([20, 30, 20, 10]),
          reason: "reversedItems");
    });

    test('I-COLL-84: Attempt []= (setter). [2026-02-10 06:37] (PASS)', () {
      expectUnsupportedError(() => executeAndGetResult(
          unmodifiableListViewSource('[1, 2, 3]', 'unmodifiable[0] = 100;')));
    });

    test('I-COLL-85: Attempt length = (setter). [2026-02-10 06:37] (PASS)', () {
      expectUnsupportedError(() => executeAndGetResult(
          unmodifiableListViewSource('[1, 2, 3]', 'unmodifiable.length = 5;')));
    });

    test('I-COLL-86: Attempt first = (setter). [2026-02-10 06:37] (PASS)', () {
      expectUnsupportedError(() => executeAndGetResult(
          unmodifiableListViewSource('[1, 2, 3]', 'unmodifiable.first = 0;')));
    });

    test('I-COLL-87: Attempt last = (setter). [2026-02-10 06:37] (PASS)', () {
      expectUnsupportedError(() => executeAndGetResult(
          unmodifiableListViewSource('[1, 2, 3]', 'unmodifiable.last = 0;')));
    });

    test('I-COLL-88: Attempt add(). [2026-02-10 06:37] (PASS)', () {
      expectUnsupportedError(() => executeAndGetResult(
          unmodifiableListViewSource('[1, 2, 3]', 'unmodifiable.add(4);')));
    });

    test('I-COLL-89: Attempt addAll(). [2026-02-10 06:37] (PASS)', () {
      expectUnsupportedError(() => executeAndGetResult(
          unmodifiableListViewSource(
              '[1, 2, 3]', 'unmodifiable.addAll([4, 5]);')));
    });

    test('I-COLL-90: Attempt clear(). [2026-02-10 06:37] (PASS)', () {
      expectUnsupportedError(() => executeAndGetResult(
          unmodifiableListViewSource('[1, 2, 3]', 'unmodifiable.clear();')));
    });

    test('I-COLL-91: Attempt insert(). [2026-02-10 06:37] (PASS)', () {
      expectUnsupportedError(() => executeAndGetResult(
          unmodifiableListViewSource(
              '[1, 2, 3]', 'unmodifiable.insert(1, 10);')));
    });

    test('I-COLL-92: Attempt insertAll(). [2026-02-10 06:37] (PASS)', () {
      expectUnsupportedError(() => executeAndGetResult(
          unmodifiableListViewSource(
              '[1, 2, 3]', 'unmodifiable.insertAll(1, [10, 11]);')));
    });

    test('I-COLL-93: Attempt remove(). [2026-02-10 06:37] (PASS)', () {
      expectUnsupportedError(() => executeAndGetResult(
          unmodifiableListViewSource('[1, 2, 3]', 'unmodifiable.remove(2);')));
    });

    test('I-COLL-94: Attempt removeAt(). [2026-02-10 06:37] (PASS)', () {
      expectUnsupportedError(() => executeAndGetResult(
          unmodifiableListViewSource(
              '[1, 2, 3]', 'unmodifiable.removeAt(0);')));
    });

    test('I-COLL-95: Attempt removeLast(). [2026-02-10 06:37] (PASS)', () {
      expectUnsupportedError(() => executeAndGetResult(
          unmodifiableListViewSource(
              '[1, 2, 3]', 'unmodifiable.removeLast();')));
    });

    test('I-COLL-96: Attempt removeRange(). [2026-02-10 06:37] (PASS)', () {
      expectUnsupportedError(() => executeAndGetResult(
          unmodifiableListViewSource(
              '[1, 2, 3, 4]', 'unmodifiable.removeRange(1, 3);')));
    });

    test('I-COLL-97: Attempt removeWhere(). [2026-02-10 06:37] (PASS)', () {
      expectUnsupportedError(() => executeAndGetResult(
          unmodifiableListViewSource(
              '[1, 2, 3, 4]', 'unmodifiable.removeWhere((e) => e % 2 == 0);')));
    });

    test('I-COLL-98: Attempt replaceRange(). [2026-02-10 06:37] (PASS)', () {
      expectUnsupportedError(() => executeAndGetResult(
          unmodifiableListViewSource(
              '[1, 2, 3, 4]', 'unmodifiable.replaceRange(1, 3, [8, 9]);')));
    });

    test('I-COLL-99: Attempt retainWhere(). [2026-02-10 06:37] (PASS)', () {
      expectUnsupportedError(() => executeAndGetResult(
          unmodifiableListViewSource(
              '[1, 2, 3, 4]', 'unmodifiable.retainWhere((e) => e % 2 == 0);')));
    });

    test('I-COLL-100: Attempt fillRange(). [2026-02-10 06:37] (PASS)', () {
      expectUnsupportedError(() => executeAndGetResult(
          unmodifiableListViewSource(
              '[1, 2, 3, 4]', 'unmodifiable.fillRange(1, 3, 9);')));
    });

    test('I-COLL-101: Attempt setAll(). [2026-02-10 06:37] (PASS)', () {
      expectUnsupportedError(() => executeAndGetResult(
          unmodifiableListViewSource(
              '[1, 2, 3, 4]', 'unmodifiable.setAll(1, [8,9]);')));
    });

    test('I-COLL-102: Attempt setRange(). [2026-02-10 06:37] (PASS)', () {
      expectUnsupportedError(() => executeAndGetResult(
          unmodifiableListViewSource(
              '[1, 2, 3, 4]', 'unmodifiable.setRange(1, 3, [8, 9, 10], 1);')));
    });

    test('I-COLL-103: Attempt shuffle(). [2026-02-10 06:37] (PASS)', () {
      expectUnsupportedError(() => executeAndGetResult(
          unmodifiableListViewSource(
              '[1, 2, 3, 4]', 'unmodifiable.shuffle();')));
    });

    test('I-COLL-104: Attempt sort(). [2026-02-10 06:37] (PASS)', () {
      expectUnsupportedError(() => executeAndGetResult(
          unmodifiableListViewSource('[3, 1, 2]', 'unmodifiable.sort();')));
    });
  });
}
