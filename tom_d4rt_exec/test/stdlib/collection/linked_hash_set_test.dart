import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

/// SC2 — `dart:collection` `LinkedHashSet` bridge.
///
/// The defining property of `LinkedHashSet` over a plain `HashSet` is that
/// iteration yields elements in *insertion* order, so most assertions here use
/// `orderedEquals` rather than `unorderedEquals`. A test that only checked
/// membership would pass against the `HashSet` bridge too and would therefore
/// not pin the behaviour that makes this class worth bridging at all.
void main() {
  final d4rt = D4rt();

  group('SC2: LinkedHashSet collection bridge', () {
    test(
        'F-SC2-1: LinkedHashSet() iterates in insertion order, not sorted order [2026-07-27]',
        () {
      final result = d4rt.execute(
        source: '''
          import 'dart:collection';
          main() {
            final set = LinkedHashSet();
            set.add('gamma');
            set.add('alpha');
            set.add('beta');
            return [set.toList(), set.length, set.first, set.last];
          }
        ''',
      ) as List;
      expect(result[0], orderedEquals(['gamma', 'alpha', 'beta']),
          reason: 'insertion order preserved');
      expect(result[1], 3, reason: 'length');
      expect(result[2], 'gamma', reason: 'first is the first inserted');
      expect(result[3], 'beta', reason: 'last is the last inserted');
    });

    test(
        'F-SC2-2: re-adding an existing element keeps its original position [2026-07-27]',
        () {
      final result = d4rt.execute(
        source: '''
          import 'dart:collection';
          main() {
            final set = LinkedHashSet();
            set.add(1);
            set.add(2);
            set.add(3);
            final added = set.add(1);
            return [added, set.toList(), set.length];
          }
        ''',
      ) as List;
      expect(result[0], false, reason: 'add() reports the duplicate');
      expect(result[1], orderedEquals([1, 2, 3]),
          reason: 're-add must not move the element to the end');
      expect(result[2], 3, reason: 'length unchanged');
    });

    test(
        'F-SC2-3: LinkedHashSet.from() and .of() preserve source order [2026-07-27]',
        () {
      final result = d4rt.execute(
        source: '''
          import 'dart:collection';
          main() {
            final a = LinkedHashSet.from([5, 1, 3, 1, 5]);
            final b = LinkedHashSet.of(['z', 'y', 'x']);
            b.add('w');
            return [a.toList(), b.toList()];
          }
        ''',
      ) as List;
      expect(result[0], orderedEquals([5, 1, 3]),
          reason: 'from() dedups but keeps first-seen order');
      expect(result[1], orderedEquals(['z', 'y', 'x', 'w']),
          reason: 'of() then append');
    });

    test(
        'F-SC2-4: addAll / remove / contains / clear maintain insertion order [2026-07-27]',
        () {
      final result = d4rt.execute(
        source: '''
          import 'dart:collection';
          main() {
            final set = LinkedHashSet();
            set.addAll([10, 20, 30, 40]);
            final removed = set.remove(20);
            final missing = set.remove(99);
            final has30 = set.contains(30);
            final order = set.toList();
            set.clear();
            return [removed, missing, has30, order, set.isEmpty, set.isNotEmpty];
          }
        ''',
      ) as List;
      expect(result[0], true, reason: 'remove existing');
      expect(result[1], false, reason: 'remove absent');
      expect(result[2], true, reason: 'contains');
      expect(result[3], orderedEquals([10, 30, 40]),
          reason: 'order survives a mid-set removal');
      expect(result[4], true, reason: 'isEmpty after clear');
      expect(result[5], false, reason: 'isNotEmpty after clear');
    });

    test(
        'F-SC2-5: forEach / map / where iterate in insertion order [2026-07-27]',
        () {
      final result = d4rt.execute(
        source: '''
          import 'dart:collection';
          main() {
            final set = LinkedHashSet.from([3, 1, 4, 1, 5, 9]);
            final seen = [];
            set.forEach((e) { seen.add(e); });
            final doubled = set.map((e) => e * 2).toList();
            final odd = set.where((e) => e % 2 == 1).toList();
            return [seen, doubled, odd];
          }
        ''',
      ) as List;
      expect(result[0], orderedEquals([3, 1, 4, 5, 9]), reason: 'forEach order');
      expect(result[1], orderedEquals([6, 2, 8, 10, 18]), reason: 'map order');
      expect(result[2], orderedEquals([3, 1, 5, 9]), reason: 'where order');
    });

    test('F-SC2-6: set algebra — containsAll / removeAll / retainAll [2026-07-27]',
        () {
      final result = d4rt.execute(
        source: '''
          import 'dart:collection';
          main() {
            final a = LinkedHashSet.from(['a', 'b', 'c', 'd']);
            final all = a.containsAll(['b', 'd']);
            final none = a.containsAll(['b', 'z']);
            a.removeAll(['a', 'c']);
            final afterRemove = a.toList();

            final b = LinkedHashSet.from([1, 2, 3, 4, 5]);
            b.retainAll([5, 2]);
            return [all, none, afterRemove, b.toList()];
          }
        ''',
      ) as List;
      expect(result[0], true, reason: 'containsAll present');
      expect(result[1], false, reason: 'containsAll with an absent element');
      expect(result[2], orderedEquals(['b', 'd']), reason: 'after removeAll');
      expect(result[3], orderedEquals([2, 5]),
          reason: 'retainAll keeps the receiver order, not the argument order');
    });

    test('F-SC2-7: removeWhere / retainWhere / any / every / fold [2026-07-27]',
        () {
      final result = d4rt.execute(
        source: '''
          import 'dart:collection';
          main() {
            final a = LinkedHashSet.from([1, 2, 3, 4, 5, 6]);
            a.removeWhere((e) => e % 2 == 0);
            final b = LinkedHashSet.from([1, 2, 3, 4, 5, 6]);
            b.retainWhere((e) => e > 4);
            final c = LinkedHashSet.from([2, 4, 6]);
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

    test('F-SC2-8: lookup / elementAt / join / take / skip [2026-07-27]', () {
      final result = d4rt.execute(
        source: '''
          import 'dart:collection';
          main() {
            final set = LinkedHashSet.from(['one', 'two', 'three']);
            return [
              set.lookup('two'),
              set.lookup('four'),
              set.elementAt(2),
              set.join('-'),
              set.take(2).toList(),
              set.skip(1).toList(),
            ];
          }
        ''',
      ) as List;
      expect(result[0], 'two', reason: 'lookup hit');
      expect(result[1], null, reason: 'lookup miss');
      expect(result[2], 'three', reason: 'elementAt follows insertion order');
      expect(result[3], 'one-two-three', reason: 'join follows insertion order');
      expect(result[4], orderedEquals(['one', 'two']), reason: 'take');
      expect(result[5], orderedEquals(['two', 'three']), reason: 'skip');
    });

    test('F-SC2-9: single / first on an empty set raise a D4rt error [2026-07-27]',
        () {
      expect(
        () => d4rt.execute(source: '''
          import 'dart:collection';
          main() { return LinkedHashSet().first; }
        '''),
        throwsA(isA<RuntimeD4rtException>()),
        reason: 'first on empty',
      );
      expect(
        () => d4rt.execute(source: '''
          import 'dart:collection';
          main() { return LinkedHashSet.from([1, 2]).single; }
        '''),
        throwsA(isA<RuntimeD4rtException>()),
        reason: 'single with more than one element',
      );
    });

    test('F-SC2-10: LinkedHashSet() rejects positional arguments [2026-07-27]',
        () {
      expect(
        () => d4rt.execute(source: '''
          import 'dart:collection';
          main() { return LinkedHashSet([1, 2]); }
        '''),
        throwsA(isA<RuntimeD4rtException>()),
      );
    });
  });
}
