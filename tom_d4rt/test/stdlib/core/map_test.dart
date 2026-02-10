import '../../interpreter_test.dart';
import 'package:test/test.dart';

void main() {
  group('Map methods - comprehensive', () {
    test('I-COLL-238: AddAll. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Map<int, String> map = {1: 'one'};
        map.addAll({2: 'two', 3: 'three'});
        return map;
      }
      ''';
      expect(execute(source), equals({1: 'one', 2: 'two', 3: 'three'}));
    });

    test('I-COLL-200: Clear. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Map<int, String> map = {1: 'one', 2: 'two'};
        map.clear();
        return map;
      }
      ''';
      expect(execute(source), equals({}));
    });

    test('I-COLL-210: ContainsKey. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Map<int, String> map = {1: 'one', 2: 'two'};
        return [map.containsKey(1), map.containsKey(3)];
      }
      ''';
      expect(execute(source), equals([true, false]));
    });

    test('I-COLL-218: ContainsValue. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Map<int, String> map = {1: 'one', 2: 'two'};
        return [map.containsValue('two'), map.containsValue('three')];
      }
      ''';
      expect(execute(source), equals([true, false]));
    });

    test('I-COLL-227: Remove. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Map<int, String> map = {1: 'one', 2: 'two'};
        map.remove(1);
        return map;
      }
      ''';
      expect(execute(source), equals({2: 'two'}));
    });

    test('I-COLL-236: Length. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Map<int, String> map = {1: 'one', 2: 'two'};
        return map.length;
      }
      ''';
      expect(execute(source), equals(2));
    });

    test('I-COLL-246: IsEmpty and isNotEmpty. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Map<int, String> map = {};
        return [map.isEmpty, map.isNotEmpty];
      }
      ''';
      expect(execute(source), equals([true, false]));
    });

    test('I-COLL-247: Keys and values. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Map<int, String> map = {1: 'one', 2: 'two'};
        return [map.keys.toList(), map.values.toList()];
      }
      ''';
      expect(
          execute(source),
          equals([
            [1, 2],
            ['one', 'two']
          ]));
    });

    test('I-COLL-248: Update. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Map<int, String> map = {1: 'one', 2: 'two'};
        map.update(1, (value) => 'ONE');
        return map;
      }
      ''';
      expect(execute(source), equals({1: 'ONE', 2: 'two'}));
    });

    test('I-COLL-194: PutIfAbsent. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Map<int, String> map = {1: 'one'};
        map.putIfAbsent(2, () => 'two');
        return map;
      }
      ''';
      expect(execute(source), equals({1: 'one', 2: 'two'}));
    });

    test('I-COLL-195: AddEntries. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Map<int, String> map = {1: 'one'};
        map.addEntries([MapEntry(2, 'two'), MapEntry(3, 'three')]);
        return map;
      }
      ''';
      expect(execute(source), equals({1: 'one', 2: 'two', 3: 'three'}));
    });

    test('I-COLL-196: UpdateAll. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Map<int, String> map = {1: 'one', 2: 'two'};
        map.updateAll((key, value) => value.toUpperCase());
        return map;
      }
      ''';
      expect(execute(source), equals({1: 'ONE', 2: 'TWO'}));
    });

    test('I-COLL-197: RemoveWhere. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Map<int, String> map = {1: 'one', 2: 'two', 3: 'three'};
        map.removeWhere((key, value) => key % 2 == 0);
        return map;
      }
      ''';
      expect(execute(source), equals({1: 'one', 3: 'three'}));
    });

    test('I-COLL-198: Map. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Map<int, String> map = {1: 'one', 2: 'two'};
        Map<String, int> newMap = map.map((key, value) => MapEntry(value, key));
        return newMap;
      }
      ''';
      expect(execute(source), equals({'one': 1, 'two': 2}));
    });

    test('I-COLL-199: Entries. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Map<int, String> map = {1: 'one', 2: 'two'};
        return map.entries.map((e) => [e.key, e.value]).toList();
      }
      ''';
      final result = execute(source) as List;
      result.sort((a, b) => (a[0] as int).compareTo(b[0] as int));
      expect(
          result,
          equals([
            [1, 'one'],
            [2, 'two']
          ]));
    });

    test('I-COLL-201: Cast. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Map<dynamic, dynamic> map = {1: 'one', 2: 'two'};
        Map<int, String> castedMap = map.cast<int, String>();
        return castedMap;
      }
      ''';
      expect(execute(source), equals({1: 'one', 2: 'two'}));
    });

    test('I-COLL-202: ForEach. [2026-02-10 06:37] (PASS)', () {
      final source = '''
     main() {
        Map<int, String> map = {1: 'one', 2: 'two'};
        var result = '';
        var sortedKeys = map.keys.toList()..sort();
        sortedKeys.forEach((key) {
           result += '\$key:\${map[key]};';
        });
        return result;
      }
      ''';
      expect(execute(source), equals('1:one;2:two;'));
    });

    test('I-COLL-203: From. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Map<int, String> original = {1: 'one', 2: 'two'};
        Map<int, String> copy = Map.from(original);
        copy[3] = 'three';
        return [original, copy];
      }
      ''';
      expect(
          execute(source),
          equals([
            {1: 'one', 2: 'two'},
            {1: 'one', 2: 'two', 3: 'three'}
          ]));
    });

    test('I-COLL-204: FromEntries. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        List<MapEntry<int, String>> entries = [MapEntry(1, 'one'), MapEntry(2, 'two')];
        Map<int, String> map = Map.fromEntries(entries);
        return map;
      }
      ''';
      expect(execute(source), equals({1: 'one', 2: 'two'}));
    });

    test('I-COLL-205: FromIterable. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        List<int> numbers = [1, 2, 3];
        Map<int, String> map = Map.fromIterable(numbers, key: (item) => item, value: (item) => 'Value \$item');
        return map;
      }
      ''';
      expect(
          execute(source), equals({1: 'Value 1', 2: 'Value 2', 3: 'Value 3'}));
    });

    test('I-COLL-206: FromIterables. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        List<int> keys = [1, 2, 3];
        List<String> values = ['one', 'two', 'three'];
        Map<int, String> map = Map.fromIterables(keys, values);
        return map;
      }
      ''';
      expect(execute(source), equals({1: 'one', 2: 'two', 3: 'three'}));
    });

    test('I-COLL-207: Identity. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Map<int, String> map = Map.identity();
        map[1] = 'one';
        return map;
      }
      ''';
      expect(execute(source), equals({1: 'one'}));
    });

    test('I-COLL-208: Unmodifiable. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Map<int, String> original = {1: 'one', 2: 'two'};
        Map<int, String> unmodifiableMap = Map.unmodifiable(original);
        return unmodifiableMap;
      }
      ''';
      expect(execute(source), equals({1: 'one', 2: 'two'}));
    });
  });

  group('Map with various key and value types', () {
    test('I-COLL-209: Map<String, int>. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        Map<String, int> ages = {'Alice': 30, 'Bob': 25};
        ages['Charlie'] = 35;
        ages.addAll({'Dave': 40, 'Eve': 28});
        return ages;
      }
      ''';
      expect(execute(source),
          equals({'Alice': 30, 'Bob': 25, 'Charlie': 35, 'Dave': 40, 'Eve': 28}));
    });

    test('I-COLL-211: Map<String, String>. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        Map<String, String> translations = {'hello': 'hola', 'world': 'mundo'};
        translations['goodbye'] = 'adios';
        return translations;
      }
      ''';
      expect(execute(source),
          equals({'hello': 'hola', 'world': 'mundo', 'goodbye': 'adios'}));
    });

    test('I-COLL-212: Map<int, List<String>>. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        Map<int, List<String>> groups = {
          1: ['a', 'b'],
          2: ['c', 'd', 'e']
        };
        groups[3] = ['f'];
        return groups[2];
      }
      ''';
      expect(execute(source), equals(['c', 'd', 'e']));
    });

    test('I-COLL-213: Map<String, Map<String, int>>. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        Map<String, Map<String, int>> nested = {
          'scores': {'math': 90, 'english': 85}
        };
        nested['scores']['science'] = 95;
        return nested['scores'];
      }
      ''';
      expect(execute(source), equals({'math': 90, 'english': 85, 'science': 95}));
    });

    test('I-COLL-214: Map<dynamic, dynamic> with mixed types. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        Map<dynamic, dynamic> mixed = {
          'name': 'John',
          42: 'answer',
          true: 100
        };
        mixed[3.14] = 'pi';
        return [mixed['name'], mixed[42], mixed[true], mixed[3.14]];
      }
      ''';
      expect(execute(source), equals(['John', 'answer', 100, 'pi']));
    });
  });

  group('Map update operations', () {
    test('I-COLL-215: Update existing key. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        Map<String, int> counts = {'a': 1, 'b': 2};
        counts.update('a', (v) => v + 10);
        return counts;
      }
      ''';
      expect(execute(source), equals({'a': 11, 'b': 2}));
    });

    test('I-COLL-216: Update with ifAbsent. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        Map<String, int> counts = {'a': 1};
        counts.update('b', (v) => v + 10, ifAbsent: () => 100);
        return counts;
      }
      ''';
      expect(execute(source), equals({'a': 1, 'b': 100}));
    });

    test('I-COLL-217: UpdateAll transforms all values. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        Map<String, int> prices = {'apple': 100, 'banana': 50, 'orange': 75};
        prices.updateAll((key, value) => value * 2);
        return prices;
      }
      ''';
      expect(execute(source), equals({'apple': 200, 'banana': 100, 'orange': 150}));
    });

    test('I-COLL-219: PutIfAbsent does not overwrite existing. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        Map<String, int> map = {'a': 1};
        var result1 = map.putIfAbsent('a', () => 999);
        var result2 = map.putIfAbsent('b', () => 2);
        return [result1, result2, map];
      }
      ''';
      expect(execute(source), equals([1, 2, {'a': 1, 'b': 2}]));
    });
  });

  group('Map removal operations', () {
    test('I-COLL-220: Remove returns removed value. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        Map<String, int> map = {'a': 1, 'b': 2, 'c': 3};
        var removed = map.remove('b');
        return [removed, map];
      }
      ''';
      expect(execute(source), equals([2, {'a': 1, 'c': 3}]));
    });

    test('I-COLL-221: Remove non-existent key returns null. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        Map<String, int> map = {'a': 1};
        var removed = map.remove('z');
        return removed;
      }
      ''';
      expect(execute(source), isNull);
    });

    test('I-COLL-222: RemoveWhere with complex condition. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        Map<String, int> scores = {'Alice': 85, 'Bob': 45, 'Charlie': 92, 'Dave': 38};
        scores.removeWhere((name, score) => score < 50);
        return scores;
      }
      ''';
      expect(execute(source), equals({'Alice': 85, 'Charlie': 92}));
    });

    test('I-COLL-223: Clear empties the map. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        Map<int, String> map = {1: 'one', 2: 'two', 3: 'three'};
        map.clear();
        return [map.isEmpty, map.length];
      }
      ''';
      expect(execute(source), equals([true, 0]));
    });
  });

  group('Map iteration and transformation', () {
    test('I-COLL-224: ForEach iterates all entries. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        Map<String, int> map = {'a': 1, 'b': 2, 'c': 3};
        var sum = 0;
        map.forEach((key, value) {
          sum += value;
        });
        return sum;
      }
      ''';
      expect(execute(source), equals(6));
    });

    test('I-COLL-225: Map transforms to new map. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        Map<int, String> original = {1: 'one', 2: 'two', 3: 'three'};
        var transformed = original.map((k, v) => MapEntry(k * 10, v.toUpperCase()));
        return transformed;
      }
      ''';
      expect(execute(source), equals({10: 'ONE', 20: 'TWO', 30: 'THREE'}));
    });

    test('I-COLL-226: Entries allows manual iteration. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        Map<String, int> map = {'x': 10, 'y': 20};
        var result = [];
        for (var entry in map.entries) {
          result.add('\${entry.key}=\${entry.value}');
        }
        result.sort();
        return result;
      }
      ''';
      expect(execute(source), equals(['x=10', 'y=20']));
    });

    test('I-COLL-228: Keys and values as iterables. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        Map<int, String> map = {1: 'a', 2: 'b', 3: 'c'};
        var keySum = 0;
        for (var k in map.keys) {
          keySum += k;
        }
        var valueConcat = '';
        var sortedKeys = map.keys.toList()..sort();
        for (var k in sortedKeys) {
          valueConcat += map[k];
        }
        return [keySum, valueConcat];
      }
      ''';
      expect(execute(source), equals([6, 'abc']));
    });
  });

  group('Map containment checks', () {
    test('I-COLL-229: ContainsKey with various key types. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        Map<dynamic, String> map = {1: 'int', 'two': 'string', true: 'bool'};
        return [
          map.containsKey(1),
          map.containsKey('two'),
          map.containsKey(true),
          map.containsKey(false),
          map.containsKey('nonexistent')
        ];
      }
      ''';
      expect(execute(source), equals([true, true, true, false, false]));
    });

    test('I-COLL-230: ContainsValue with various value types. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        Map<String, dynamic> map = {'a': 1, 'b': 'hello', 'c': true, 'd': null};
        return [
          map.containsValue(1),
          map.containsValue('hello'),
          map.containsValue(true),
          map.containsValue(null),
          map.containsValue('missing')
        ];
      }
      ''';
      expect(execute(source), equals([true, true, true, true, false]));
    });
  });

  group('MapEntry operations', () {
    test('I-COLL-231: MapEntry creation and access. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        var entry = MapEntry('key', 42);
        return [entry.key, entry.value];
      }
      ''';
      expect(execute(source), equals(['key', 42]));
    });

    test('I-COLL-232: MapEntry in list. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        List<MapEntry<String, int>> entries = [
          MapEntry('first', 1),
          MapEntry('second', 2),
          MapEntry('third', 3)
        ];
        return entries.map((e) => e.value).toList();
      }
      ''';
      expect(execute(source), equals([1, 2, 3]));
    });

    test('I-COLL-233: Map.fromEntries with generated entries. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        var entries = [1, 2, 3].map((n) => MapEntry(n, n * n));
        return Map.fromEntries(entries);
      }
      ''';
      expect(execute(source), equals({1: 1, 2: 4, 3: 9}));
    });

    test('I-COLL-234: AddEntries appends multiple entries. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        Map<String, int> map = {'a': 1};
        var newEntries = ['b', 'c', 'd'].map((s) => MapEntry(s, s.codeUnitAt(0)));
        map.addEntries(newEntries);
        return map.length;
      }
      ''';
      expect(execute(source), equals(4));
    });
  });

  group('Map static constructors', () {
    test('I-COLL-235: Map.from creates mutable copy. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        var original = {'a': 1, 'b': 2};
        var copy = Map.from(original);
        copy['c'] = 3;
        return [original.length, copy.length];
      }
      ''';
      expect(execute(source), equals([2, 3]));
    });

    test('I-COLL-237: Map.of creates mutable copy. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        var original = {1: 'one'};
        var copy = Map.of(original);
        copy[2] = 'two';
        return [original, copy];
      }
      ''';
      expect(execute(source), equals([{1: 'one'}, {1: 'one', 2: 'two'}]));
    });

    test('I-COLL-239: Map.fromIterable with custom key/value. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        var words = ['cat', 'dog', 'elephant'];
        var map = Map.fromIterable(
          words,
          key: (w) => w,
          value: (w) => w.length
        );
        return map;
      }
      ''';
      expect(execute(source), equals({'cat': 3, 'dog': 3, 'elephant': 8}));
    });

    test('I-COLL-240: Map.fromIterables pairs keys and values. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        var keys = ['a', 'b', 'c'];
        var values = [1, 2, 3];
        return Map.fromIterables(keys, values);
      }
      ''';
      expect(execute(source), equals({'a': 1, 'b': 2, 'c': 3}));
    });

    test('I-COLL-241: Map.identity creates identity map. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        var map = Map.identity();
        map['key1'] = 'value1';
        map['key2'] = 'value2';
        return map.length;
      }
      ''';
      expect(execute(source), equals(2));
    });
  });

  group('Map edge cases', () {
    test('I-COLL-242: Empty map properties. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        Map<String, int> empty = {};
        return [
          empty.isEmpty,
          empty.isNotEmpty,
          empty.length,
          empty.keys.isEmpty,
          empty.values.isEmpty
        ];
      }
      ''';
      expect(execute(source), equals([true, false, 0, true, true]));
    });

    test('I-COLL-243: Single entry map. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        Map<String, int> single = {'only': 1};
        return [
          single.keys.single,
          single.values.single,
          single.entries.single.key,
          single.entries.single.value
        ];
      }
      ''';
      expect(execute(source), equals(['only', 1, 'only', 1]));
    });

    test('I-COLL-244: Null key and value. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        Map<String?, int?> map = {null: null, 'key': 42};
        return [map[null], map['key'], map.containsKey(null), map.containsValue(null)];
      }
      ''';
      expect(execute(source), equals([null, 42, true, true]));
    });

    test('I-COLL-245: Overwriting existing key. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        Map<String, int> map = {'a': 1};
        map['a'] = 100;
        map.addAll({'a': 200});
        return map['a'];
      }
      ''';
      expect(execute(source), equals(200));
    });
  });
}

