import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

void main() {
  group('dart:collection - Queue Tests', () {
    D4rt d4rtInstance = D4rt();

    setUp(() {
      d4rtInstance = D4rt();
    });

    dynamic execute(String mainFunctionBody, {List<Object?>? args}) {
      final source =
          '''
        import 'dart:collection';

        main() {
          $mainFunctionBody
        }
      ''';
      return d4rtInstance.execute(
        library: 'd4rt-mem:/main_collection_test.dart',
        name: 'main',
        positionalArgs: args,
        sources: {'d4rt-mem:/main_collection_test.dart': source},
      );
    }

    test(
      'I-COLL-65: Queue() constructor and basic properties. [2026-02-10 06:37] (PASS)',
      () {
        final result = execute('''
        var q = Queue();
        return [q.length, q.isEmpty, q.isNotEmpty];
      ''');
        expect(result, equals([0, true, false]));
      },
    );

    test(
      'I-COLL-66: Queue.from() constructor with an iterable. [2026-02-10 06:37] (PASS)',
      () {
        final result = execute('''
        var q = Queue.from([1, 2, 3]);
        return [q.length, q.first, q.last];
      ''');
        expect(result, equals([3, 1, 3]));
      },
    );

    test(
      'I-COLL-67: Queue.from() with empty iterable. [2026-02-10 06:37] (PASS)',
      () {
        final result = execute('''
        var q = Queue.from([]);
        return q.length;
      ''');
        expect(result, equals(0));
      },
    );

    test(
      'I-COLL-68: Add() and removeFirst() methods. [2026-02-10 06:37] (PASS)',
      () {
        final result = execute('''
        var q = Queue();
        q.add(10);
        q.add(20);
        var r1 = q.removeFirst();
        var r2 = q.removeFirst();
        return [r1, r2, q.length];
      ''');
        expect(result, equals([10, 20, 0]));
      },
    );

    test(
      'I-COLL-69: RemoveFirst() on empty queue throws. [2026-02-10 06:37] (PASS)',
      () {
        expect(
          () => execute('''
          var q = Queue();
          q.removeFirst();
        '''),
          throwsA(
            isA<RuntimeD4rtException>().having(
              (e) => e.message,
              'message',
              contains('Cannot removeFirst from an empty queue.'),
            ),
          ),
        );
      },
    );

    test('I-COLL-70: First and last getters. [2026-02-10 06:37] (PASS)', () {
      final result = execute('''
        var q = Queue.from(['a', 'b', 'c']);
        return [q.first, q.last];
      ''');
      expect(result, equals(['a', 'c']));
    });

    test(
      'I-COLL-71: First getter on empty queue throws. [2026-02-10 06:37] (PASS)',
      () {
        expect(
          () => execute('''
          var q = Queue();
          return q.first;
        '''),
          throwsA(
            isA<RuntimeD4rtException>().having(
              (e) => e.message,
              'message',
              contains('Cannot get first from an empty queue.'),
            ),
          ),
        );
      },
    );

    test(
      'I-COLL-62: Last getter on empty queue throws. [2026-02-10 06:37] (PASS)',
      () {
        expect(
          () => execute('''
          var q = Queue();
          return q.last;
        '''),
          throwsA(
            isA<RuntimeD4rtException>().having(
              (e) => e.message,
              'message',
              contains('Cannot get last from an empty queue.'),
            ),
          ),
        );
      },
    );

    test('I-COLL-63: Clear() method. [2026-02-10 06:37] (PASS)', () {
      final result = execute('''
        var q = Queue.from([1, 2, 3]);
        q.clear();
        return q.length;
      ''');
      expect(result, equals(0));
    });

    test('I-COLL-64: Contains() method. [2026-02-10 06:37] (PASS)', () {
      final result = execute('''
        var q = Queue.from([10, 20, 30]);
        return [q.contains(20), q.contains(40)];
      ''');
      expect(result, equals([true, false]));
    });

    // SCC10: the removal half of Queue's own declared surface. These four are
    // the members `Queue` DECLARES rather than inherits from `Iterable`, which
    // is why the `-> Iterable` edge delivered all 23 of its other members and
    // left exactly these behind. That is the same pattern SCC8 found on
    // `LinkedList`, and it makes the set worth writing by hand predictable
    // rather than a surprise.
    test('F-SCC10-1: remove() takes the first matching element out '
        '[2026-09-04]', () {
      final result = execute('''
        var q = Queue.from([1, 2, 3, 2]);
        final removed = q.remove(2);
        return [removed, q.toList()];
      ''');
      // Only the FIRST match goes — asserting the survivors proves it did not
      // remove both, which a `removeWhere`-based implementation would.
      expect(
        result,
        equals([
          true,
          [1, 3, 2],
        ]),
      );
    });

    test('F-SCC10-2: remove() reports false when nothing matched '
        '[2026-09-04]', () {
      final result = execute('''
        var q = Queue.from([1, 2]);
        return [q.remove(9), q.length];
      ''');
      expect(result, equals([false, 2]));
    });

    test('F-SCC10-3: removeWhere() drops every element the test accepts '
        '[2026-09-04]', () {
      final result = execute('''
        var q = Queue.from([1, 2, 3, 4]);
        q.removeWhere((e) => e % 2 == 0);
        return q.toList();
      ''');
      expect(
        result,
        equals([1, 3]),
        reason: 'the interpreted closure must cross the bridge',
      );
    });

    test('F-SCC10-4: retainWhere() keeps exactly the complement '
        '[2026-09-04]', () {
      final result = execute('''
        var q = Queue.from([1, 2, 3, 4]);
        q.retainWhere((e) => e % 2 == 0);
        return q.toList();
      ''');
      // Paired with F-SCC10-3 deliberately: retainWhere implemented as
      // removeWhere with an un-negated test would pass one and fail the other.
      expect(result, equals([2, 4]));
    });

    test('F-SCC10-5: removeWhere() that matches nothing leaves the queue '
        'alone [2026-09-04]', () {
      final result = execute('''
        var q = Queue.from([1, 3]);
        q.removeWhere((e) => e % 2 == 0);
        return q.toList();
      ''');
      expect(result, equals([1, 3]));
    });

    test('F-SCC10-6: the static castFrom() re-types an existing queue '
        '[2026-09-04]', () {
      // A static, so no supertype edge can ever deliver it — statics are not
      // inherited. That is why it survived the `-> Iterable` edge alongside the
      // three declared instance members.
      final result = execute('''
        final source = Queue.from([1, 2]);
        final cast = Queue.castFrom(source);
        return [cast.length, cast.first];
      ''');
      expect(result, equals([2, 1]));
    });
  });
}
