import '../../test_helpers.dart';
import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

void main() {
  group('dart:collection - Queue Tests', () {
    D4rt d4rtInstance = D4rt(parseSourceCallback: parseSource);

    setUp(() {
      d4rtInstance = D4rt(parseSourceCallback: parseSource);
    });

    dynamic execute(String mainFunctionBody, {List<Object?>? args}) {
      final source = '''
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

    test('I-COLL-65: Queue() constructor and basic properties. [2026-02-10 06:37] (PASS)', () {
      final result = execute('''
        var q = Queue();
        return [q.length, q.isEmpty, q.isNotEmpty];
      ''');
      expect(result, equals([0, true, false]));
    });

    test('I-COLL-66: Queue.from() constructor with an iterable. [2026-02-10 06:37] (PASS)', () {
      final result = execute('''
        var q = Queue.from([1, 2, 3]);
        return [q.length, q.first, q.last];
      ''');
      expect(result, equals([3, 1, 3]));
    });

    test('I-COLL-67: Queue.from() with empty iterable. [2026-02-10 06:37] (PASS)', () {
      final result = execute('''
        var q = Queue.from([]);
        return q.length;
      ''');
      expect(result, equals(0));
    });

    test('I-COLL-68: Add() and removeFirst() methods. [2026-02-10 06:37] (PASS)', () {
      final result = execute('''
        var q = Queue();
        q.add(10);
        q.add(20);
        var r1 = q.removeFirst();
        var r2 = q.removeFirst();
        return [r1, r2, q.length];
      ''');
      expect(result, equals([10, 20, 0]));
    });

    test('I-COLL-69: RemoveFirst() on empty queue throws. [2026-02-10 06:37] (PASS)', () {
      expect(
        () => execute('''
          var q = Queue();
          q.removeFirst();
        '''),
        throwsA(isA<RuntimeD4rtException>().having(
          (e) => e.message,
          'message',
          contains('Cannot removeFirst from an empty queue.'),
        )),
      );
    });

    test('I-COLL-70: First and last getters. [2026-02-10 06:37] (PASS)', () {
      final result = execute('''
        var q = Queue.from(['a', 'b', 'c']);
        return [q.first, q.last];
      ''');
      expect(result, equals(['a', 'c']));
    });

    test('I-COLL-71: First getter on empty queue throws. [2026-02-10 06:37] (PASS)', () {
      expect(
        () => execute('''
          var q = Queue();
          return q.first;
        '''),
        throwsA(isA<RuntimeD4rtException>().having(
          (e) => e.message,
          'message',
          contains('Cannot get first from an empty queue.'),
        )),
      );
    });

    test('I-COLL-62: Last getter on empty queue throws. [2026-02-10 06:37] (PASS)', () {
      expect(
        () => execute('''
          var q = Queue();
          return q.last;
        '''),
        throwsA(isA<RuntimeD4rtException>().having(
          (e) => e.message,
          'message',
          contains('Cannot get last from an empty queue.'),
        )),
      );
    });

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
  });
}
