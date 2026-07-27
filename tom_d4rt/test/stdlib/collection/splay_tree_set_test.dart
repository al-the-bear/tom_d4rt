import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// SC2 — `dart:collection` `SplayTreeSet` bridge.
///
/// The defining property is that iteration is *sorted*, independent of
/// insertion order, and that the ordering is user-overridable through the
/// optional `compare` argument. Every assertion below therefore uses
/// `orderedEquals` on a deliberately shuffled input — an unordered assertion
/// would pass against any `Set` bridge and pin nothing.
void main() {
  final d4rt = D4rt();

  group('SC2: SplayTreeSet collection bridge', () {
    test('F-SC2-11: SplayTreeSet() iterates in natural sorted order [2026-07-27]',
        () {
      final result = d4rt.execute(
        source: '''
          import 'dart:collection';
          main() {
            final set = SplayTreeSet();
            set.add(30);
            set.add(10);
            set.add(20);
            return [set.toList(), set.length, set.first, set.last];
          }
        ''',
      ) as List;
      expect(result[0], orderedEquals([10, 20, 30]),
          reason: 'sorted regardless of insertion order');
      expect(result[1], 3, reason: 'length');
      expect(result[2], 10, reason: 'first is the smallest');
      expect(result[3], 30, reason: 'last is the largest');
    });

    test('F-SC2-12: SplayTreeSet(compare) honours a custom comparator [2026-07-27]',
        () {
      final result = d4rt.execute(
        source: '''
          import 'dart:collection';
          main() {
            final set = SplayTreeSet((a, b) => (b as int).compareTo(a as int));
            set.addAll([1, 3, 2]);
            return [set.toList(), set.first, set.last];
          }
        ''',
      ) as List;
      expect(result[0], orderedEquals([3, 2, 1]), reason: 'reverse order');
      expect(result[1], 3, reason: 'first under the reverse comparator');
      expect(result[2], 1, reason: 'last under the reverse comparator');
    });

    test(
        'F-SC2-13: SplayTreeSet.from() / .of(), with and without a comparator [2026-07-27]',
        () {
      final result = d4rt.execute(
        source: '''
          import 'dart:collection';
          main() {
            final a = SplayTreeSet.from([5, 1, 3, 1]);
            final b = SplayTreeSet.of(['pear', 'fig', 'banana']);
            final c = SplayTreeSet.from(
                [5, 1, 3], (x, y) => (y as int).compareTo(x as int));
            return [a.toList(), b.toList(), c.toList()];
          }
        ''',
      ) as List;
      expect(result[0], orderedEquals([1, 3, 5]),
          reason: 'from() dedups and sorts');
      expect(result[1], orderedEquals(['banana', 'fig', 'pear']),
          reason: 'of() sorts strings');
      expect(result[2], orderedEquals([5, 3, 1]),
          reason: 'from() with a comparator');
    });

    test(
        'F-SC2-14: sort order is maintained across add / remove / clear [2026-07-27]',
        () {
      final result = d4rt.execute(
        source: '''
          import 'dart:collection';
          main() {
            final set = SplayTreeSet.from([50, 10, 30]);
            set.add(20);
            set.add(40);
            final removed = set.remove(30);
            final missing = set.remove(99);
            final order = set.toList();
            set.clear();
            return [removed, missing, order, set.isEmpty, set.isNotEmpty];
          }
        ''',
      ) as List;
      expect(result[0], true, reason: 'remove existing');
      expect(result[1], false, reason: 'remove absent');
      expect(result[2], orderedEquals([10, 20, 40, 50]),
          reason: 'still sorted after interleaved add/remove');
      expect(result[3], true, reason: 'isEmpty after clear');
      expect(result[4], false, reason: 'isNotEmpty after clear');
    });

    test('F-SC2-15: forEach / map / where iterate in sorted order [2026-07-27]',
        () {
      final result = d4rt.execute(
        source: '''
          import 'dart:collection';
          main() {
            final set = SplayTreeSet.from([3, 1, 4, 1, 5, 9]);
            final seen = [];
            set.forEach((e) { seen.add(e); });
            final doubled = set.map((e) => e * 2).toList();
            final odd = set.where((e) => e % 2 == 1).toList();
            return [seen, doubled, odd];
          }
        ''',
      ) as List;
      expect(result[0], orderedEquals([1, 3, 4, 5, 9]), reason: 'forEach order');
      expect(result[1], orderedEquals([2, 6, 8, 10, 18]), reason: 'map order');
      expect(result[2], orderedEquals([1, 3, 5, 9]), reason: 'where order');
    });

    test('F-SC2-16: set algebra — containsAll / removeAll / retainAll [2026-07-27]',
        () {
      final result = d4rt.execute(
        source: '''
          import 'dart:collection';
          main() {
            final a = SplayTreeSet.from(['d', 'b', 'a', 'c']);
            final all = a.containsAll(['b', 'd']);
            final none = a.containsAll(['b', 'z']);
            a.removeAll(['a', 'c']);
            final afterRemove = a.toList();

            final b = SplayTreeSet.from([5, 4, 3, 2, 1]);
            b.retainAll([5, 2]);
            return [all, none, afterRemove, b.toList()];
          }
        ''',
      ) as List;
      expect(result[0], true, reason: 'containsAll present');
      expect(result[1], false, reason: 'containsAll with an absent element');
      expect(result[2], orderedEquals(['b', 'd']), reason: 'after removeAll');
      expect(result[3], orderedEquals([2, 5]), reason: 'retainAll stays sorted');
    });

    test('F-SC2-17: removeWhere / retainWhere / any / every / fold [2026-07-27]',
        () {
      final result = d4rt.execute(
        source: '''
          import 'dart:collection';
          main() {
            final a = SplayTreeSet.from([6, 5, 4, 3, 2, 1]);
            a.removeWhere((e) => e % 2 == 0);
            final b = SplayTreeSet.from([6, 5, 4, 3, 2, 1]);
            b.retainWhere((e) => e > 4);
            final c = SplayTreeSet.from([6, 4, 2]);
            return [
              a.toList(), b.toList(),
              c.any((e) => e > 5), c.any((e) => e > 9),
              c.every((e) => e % 2 == 0),
              c.fold(0, (acc, e) => acc + e),
            ];
          }
        ''',
      ) as List;
      expect(result[0], orderedEquals([1, 3, 5]), reason: 'removeWhere');
      expect(result[1], orderedEquals([5, 6]), reason: 'retainWhere');
      expect(result[2], true, reason: 'any true');
      expect(result[3], false, reason: 'any false');
      expect(result[4], true, reason: 'every');
      expect(result[5], 12, reason: 'fold');
    });

    test('F-SC2-18: lookup / elementAt / join / take / skip [2026-07-27]', () {
      final result = d4rt.execute(
        source: '''
          import 'dart:collection';
          main() {
            final set = SplayTreeSet.from(['three', 'one', 'two']);
            return [
              set.lookup('two'),
              set.lookup('four'),
              set.elementAt(0),
              set.join('-'),
              set.take(2).toList(),
              set.skip(2).toList(),
            ];
          }
        ''',
      ) as List;
      expect(result[0], 'two', reason: 'lookup hit');
      expect(result[1], null, reason: 'lookup miss');
      expect(result[2], 'one', reason: 'elementAt follows sorted order');
      expect(result[3], 'one-three-two', reason: 'join follows sorted order');
      expect(result[4], orderedEquals(['one', 'three']), reason: 'take');
      expect(result[5], orderedEquals(['two']), reason: 'skip');
    });

    test('F-SC2-19: first on an empty set raises a D4rt error [2026-07-27]', () {
      expect(
        () => d4rt.execute(source: '''
          import 'dart:collection';
          main() { return SplayTreeSet().first; }
        '''),
        throwsA(isA<RuntimeD4rtException>()),
      );
    });

    test('F-SC2-20: a non-function compare argument is rejected [2026-07-27]',
        () {
      expect(
        () => d4rt.execute(source: '''
          import 'dart:collection';
          main() { return SplayTreeSet(42); }
        '''),
        throwsA(isA<RuntimeD4rtException>()),
      );
    });
  });
}
