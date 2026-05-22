/// Tests for the inherited `Iterable<E>` / `List<E>` read-only methods
/// that the per-typed-data-variant bridges merge in from
/// `lib/src/stdlib/typed_data/inherited_list_methods.dart`.
///
/// Cluster D (see `tom_d4rt_flutter_ast/doc/testlog_20260522-1328-issue-analysis/error_analysis.md`):
/// the bridge resolver does no supertype walk, so `Float64List.toList()`,
/// `Int32List.map(...)`, etc. were missing. The helper centralises ~25
/// adapter implementations; these tests exercise the helper through a
/// representative subset of the typed-data variants.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

void main() {
  final d4rt = D4rt();
  const String testLibPath = 'd4rt-mem:/inherited_list_methods_test.dart';

  dynamic execute(String scriptBody) {
    final fullScript = '''
      import 'dart:typed_data';
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

  group('Float64List — inherited methods', () {
    test('toList() — covers Cluster D (foundation/buffers_misc, read_buffer)',
        () {
      final result = execute('''
        var list = Float64List.fromList([1.5, 2.5, 3.5]);
        var copy = list.toList();
        return {
          'isList': copy is List,
          'length': copy.length,
          'val0': copy[0],
          'val2': copy[2],
        };
      ''');
      expect(result['isList'], true);
      expect(result['length'], 3);
      expect(result['val0'], 1.5);
      expect(result['val2'], 3.5);
    });

    test('map() — covers Cluster D (gestures/polynomial_fit)', () {
      final result = execute('''
        var list = Float64List.fromList([1.0, 2.0, 3.0]);
        var doubled = list.map((double v) => v * 2).toList();
        return {'v0': doubled[0], 'v1': doubled[1], 'v2': doubled[2]};
      ''');
      expect(result['v0'], 2.0);
      expect(result['v1'], 4.0);
      expect(result['v2'], 6.0);
    });

    test('where() filters elements', () {
      final result = execute('''
        var list = Float64List.fromList([1.0, 2.0, 3.0, 4.0]);
        var filtered = list.where((v) => v > 2.0).toList();
        return filtered;
      ''');
      expect(result, [3.0, 4.0]);
    });

    test('forEach() iterates all elements', () {
      final result = execute('''
        var list = Float64List.fromList([1.0, 2.0, 3.0]);
        var sum = 0.0;
        list.forEach((v) { sum += v; });
        return sum;
      ''');
      expect(result, 6.0);
    });

    test('reduce() folds without initial value', () {
      final result = execute('''
        var list = Float64List.fromList([1.0, 2.0, 3.0, 4.0]);
        return list.reduce((a, b) => a + b);
      ''');
      expect(result, 10.0);
    });

    test('fold() folds with an initial value', () {
      final result = execute('''
        var list = Float64List.fromList([1.0, 2.0, 3.0]);
        return list.fold(10.0, (acc, v) => acc + v);
      ''');
      expect(result, 16.0);
    });

    test('any() / every() quantifiers', () {
      final result = execute('''
        var list = Float64List.fromList([1.0, 2.0, 3.0]);
        return {
          'anyAbove2': list.any((v) => v > 2.0),
          'everyPositive': list.every((v) => v > 0.0),
          'everyAbove2': list.every((v) => v > 2.0),
        };
      ''');
      expect(result['anyAbove2'], true);
      expect(result['everyPositive'], true);
      expect(result['everyAbove2'], false);
    });

    test('contains() finds element', () {
      final result = execute('''
        var list = Float64List.fromList([1.0, 2.0, 3.0]);
        return {'has2': list.contains(2.0), 'has5': list.contains(5.0)};
      ''');
      expect(result['has2'], true);
      expect(result['has5'], false);
    });

    test('join() concatenates with separator', () {
      final result = execute('''
        var list = Float64List.fromList([1.0, 2.0, 3.0]);
        return list.join('-');
      ''');
      expect(result, '1.0-2.0-3.0');
    });

    test('single / iterator / reversed getters', () {
      final result = execute('''
        var one = Float64List.fromList([42.0]);
        var many = Float64List.fromList([1.0, 2.0, 3.0]);
        return {
          'single': one.single,
          'reversed': many.reversed.toList(),
          'hasIterator': many.iterator != null,
        };
      ''');
      expect(result['single'], 42.0);
      expect(result['reversed'], [3.0, 2.0, 1.0]);
      expect(result['hasIterator'], true);
    });
  });

  group('Int32List — inherited methods', () {
    test('toList() returns a List<int>', () {
      final result = execute('''
        var list = Int32List.fromList([10, 20, 30]);
        var copy = list.toList();
        return {'isList': copy is List, 'length': copy.length, 'v1': copy[1]};
      ''');
      expect(result['isList'], true);
      expect(result['length'], 3);
      expect(result['v1'], 20);
    });

    test('map() transforms ints', () {
      final result = execute('''
        var list = Int32List.fromList([1, 2, 3]);
        return list.map((int v) => v + 10).toList();
      ''');
      expect(result, [11, 12, 13]);
    });

    test('indexOf() / indexWhere() / lastIndexOf()', () {
      final result = execute('''
        var list = Int32List.fromList([1, 2, 3, 2, 1]);
        return {
          'idx2': list.indexOf(2),
          'lastIdx2': list.lastIndexOf(2),
          'idxGt2': list.indexWhere((v) => v > 2),
        };
      ''');
      expect(result['idx2'], 1);
      expect(result['lastIdx2'], 3);
      expect(result['idxGt2'], 2);
    });

    test('take() / skip() slicing', () {
      final result = execute('''
        var list = Int32List.fromList([1, 2, 3, 4, 5]);
        return {
          'take2': list.take(2).toList(),
          'skip2': list.skip(2).toList(),
        };
      ''');
      expect(result['take2'], [1, 2]);
      expect(result['skip2'], [3, 4, 5]);
    });

    test('firstWhere() with and without orElse', () {
      final result = execute('''
        var list = Int32List.fromList([1, 2, 3, 4]);
        return {
          'found': list.firstWhere((v) => v > 2),
          'fallback': list.firstWhere((v) => v > 99, orElse: () => -1),
        };
      ''');
      expect(result['found'], 3);
      expect(result['fallback'], -1);
    });

    test('asMap() returns Map<int, int>', () {
      final result = execute('''
        var list = Int32List.fromList([10, 20, 30]);
        var m = list.asMap();
        return {'len': m.length, 'k0': m[0], 'k2': m[2]};
      ''');
      expect(result['len'], 3);
      expect(result['k0'], 10);
      expect(result['k2'], 30);
    });
  });

  group('Int64List — inherited methods', () {
    test('toList() and map() work', () {
      final result = execute('''
        var list = Int64List.fromList([100, 200, 300]);
        var doubled = list.map((int v) => v * 2).toList();
        return {'orig': list.toList(), 'doubled': doubled};
      ''');
      expect(result['orig'], [100, 200, 300]);
      expect(result['doubled'], [200, 400, 600]);
    });
  });

  group('Uint8ClampedList — inherited methods', () {
    test('toList() and forEach() work', () {
      final result = execute('''
        var list = Uint8ClampedList.fromList([1, 2, 3]);
        var sum = 0;
        list.forEach((v) { sum += v; });
        return {'copy': list.toList(), 'sum': sum};
      ''');
      expect(result['copy'], [1, 2, 3]);
      expect(result['sum'], 6);
    });
  });
}
