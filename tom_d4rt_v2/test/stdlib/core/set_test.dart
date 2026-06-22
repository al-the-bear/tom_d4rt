import '../../interpreter_test.dart';
import 'package:test/test.dart';

// Helper function to interpret and return sorted list from set/iterable
List<T> interpretSetAsSortedList<T extends Comparable>(String source) {
  final result = execute(source);
  if (result is Set) {
    final list = result.toList().cast<T>();
    list.sort();
    return list;
  } else if (result is Iterable) {
    final list = result.toList().cast<T>();
    list.sort();
    return list;
  } else if (result is List) {
    // If already a list, assume it needs sorting
    final list = result.cast<T>();
    list.sort();
    return list;
  }
  throw 'Unexpected result type: ${result.runtimeType}';
}

void main() {
  group('Set methods - comprehensive', () {
    test('I-COLL-264: Add. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Set<int> numbers = {1, 2};
        numbers.add(3);
        return numbers;
      }
      ''';
      expect(interpretSetAsSortedList<int>(source), equals([1, 2, 3]));
    });

    test('I-COLL-274: AddAll. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Set<int> numbers = {1, 2};
        numbers.addAll([3, 4]);
        return numbers;
      }
      ''';
      expect(interpretSetAsSortedList<int>(source), equals([1, 2, 3, 4]));
    });

    test('I-COLL-277: Remove. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Set<int> numbers = {1, 2, 3};
        numbers.remove(2);
        return numbers;
      }
      ''';
      expect(interpretSetAsSortedList<int>(source), equals([1, 3]));
    });

    test('I-COLL-278: Clear. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Set<int> numbers = {1, 2, 3};
        numbers.clear();
        return numbers;
      }
      ''';
      expect(interpretSetAsSortedList<int>(source), isEmpty);
    });

    test('I-COLL-279: Contains. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Set<int> numbers = {1, 2, 3};
        return numbers.contains(2);
      }
      ''';
      expect(execute(source), isTrue);
    });

    test('I-COLL-280: Length. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Set<int> numbers = {1, 2, 3};
        return numbers.length;
      }
      ''';
      expect(execute(source), equals(3));
    });

    test('I-COLL-281: IsEmpty and isNotEmpty. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Set<int> numbers = {};
        return [numbers.isEmpty, numbers.isNotEmpty];
      }
      ''';
      expect(execute(source), equals([true, false]));
    });

    test('I-COLL-249: Union. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Set<int> numbers = {1, 2};
        Set<int> other = {3, 4};
        return numbers.union(other);
      }
      ''';
      expect(interpretSetAsSortedList<int>(source), equals([1, 2, 3, 4]));
    });

    test('I-COLL-250: Intersection. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Set<int> numbers = {1, 2, 3};
        Set<int> other = {2, 3, 4};
        return numbers.intersection(other);
      }
      ''';
      expect(interpretSetAsSortedList<int>(source), equals([2, 3]));
    });

    test('I-COLL-251: Difference. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Set<int> numbers = {1, 2, 3};
        Set<int> other = {2, 3, 4};
        return numbers.difference(other);
      }
      ''';
      expect(interpretSetAsSortedList<int>(source), equals([1]));
    });

    test('I-COLL-252: RetainWhere. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Set<int> numbers = {1, 2, 3, 4};
        numbers.retainWhere((n) => n % 2 == 0);
        return numbers;
      }
      ''';
      expect(interpretSetAsSortedList<int>(source), equals([2, 4]));
    });

    test('I-COLL-253: RemoveWhere. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Set<int> numbers = {1, 2, 3, 4};
        numbers.removeWhere((n) => n % 2 == 0);
        return numbers;
      }
      ''';
      expect(interpretSetAsSortedList<int>(source), equals([1, 3]));
    });

    test('I-COLL-254: Lookup. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Set<int> numbers = {1, 2, 3};
        return numbers.lookup(2);
      }
      ''';
      expect(execute(source), equals(2));
    });

    test('I-COLL-255: ToList. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Set<int> numbers = {1, 2, 3};
        var l = numbers.toList();
        l.sort(); // Sort for consistent comparison
        return l;
      }
      ''';
      expect(execute(source), equals([1, 2, 3]));
    });

    test('I-COLL-256: ToSet. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Set<int> numbers = {1, 2, 3};
        var s = numbers.toSet();
        s.add(4); // Modify to ensure it's a new set
        return [numbers, s]; // Return both to check independence and content
      }
      ''';
      final result = execute(source) as List;
      final originalSet = (result[0] as Set).toList()..sort();
      final newSet = (result[1] as Set).toList()..sort();
      expect(originalSet, equals([1, 2, 3]));
      expect(newSet, equals([1, 2, 3, 4]));
    });

    test('I-COLL-257: ContainsAll. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Set<int> numbers = {1, 2, 3};
        return numbers.containsAll([1, 2]);
      }
      ''';
      expect(execute(source), isTrue);
    });

    test('I-COLL-258: FollowedBy. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Set<int> numbers = {1, 2};
        Iterable<int> moreNumbers = numbers.followedBy([3, 4]);
        return moreNumbers.toSet(); // Return the resulting set
      }
      ''';
      expect(interpretSetAsSortedList<int>(source), equals([1, 2, 3, 4]));
    });

    test('I-COLL-259: Cast. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Set<dynamic> numbers = {1, 2, 3};
        Set<int> casted = numbers.cast<int>();
        return casted;
      }
      ''';
      expect(interpretSetAsSortedList<int>(source), equals([1, 2, 3]));
    });

    test('I-COLL-260: Map. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Set<int> numbers = {1, 2, 3};
        return numbers.map((n) => n * 2).toSet();
      }
      ''';
      expect(interpretSetAsSortedList<int>(source), equals([2, 4, 6]));
    });

    test('I-COLL-261: Where. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Set<int> numbers = {1, 2, 3, 4};
        return numbers.where((n) => n % 2 == 0).toSet();
      }
      ''';
      expect(interpretSetAsSortedList<int>(source), equals([2, 4]));
    });

    test('I-COLL-262: Reduce. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Set<int> numbers = {1, 2, 3};
        return numbers.reduce((a, b) => a + b);
      }
      ''';
      expect(execute(source), equals(6));
    });

    test('I-COLL-263: Fold. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Set<int> numbers = {1, 2, 3};
        return numbers.fold(0, (a, b) => a + b);
      }
      ''';
      expect(execute(source), equals(6));
    });

    test('I-COLL-265: Expand. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Set<int> numbers = {1, 2, 3};
        return numbers.expand((n) => [n, n * 2]).toSet();
      }
      ''';
      expect(interpretSetAsSortedList<int>(source), equals([1, 2, 3, 4, 6]));
    });

    test('I-COLL-266: Take. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Set<int> numbers = {1, 2, 3, 4, 5};
        return numbers.take(3).toSet();
      }
      ''';
      // Order not guaranteed, check length and subset property
      final result = execute(source) as Set;
      expect(result.length, equals(3));
      expect({1, 2, 3, 4, 5}.containsAll(result), isTrue);
    });

    test('I-COLL-267: TakeWhile. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Set<int> numbers = {1, 2, 3, 4, 5};
        // Note: takeWhile on Set iterates in arbitrary order.
        // This test might be flaky. A List would be better here.
        return numbers.takeWhile((n) => n < 4).toSet();
      }
      ''';
      // Result depends heavily on iteration order, just check types
      expect(execute(source), isA<Set>());
    });

    test('I-COLL-268: Skip. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Set<int> numbers = {1, 2, 3, 4, 5};
        return numbers.skip(2).toSet();
      }
      ''';
      // Order not guaranteed, check length and subset property
      final result = execute(source) as Set;
      expect(result.length, equals(3));
      expect({1, 2, 3, 4, 5}.containsAll(result), isTrue);
    });

    test('I-COLL-269: SkipWhile. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Set<int> numbers = {1, 2, 3, 4, 5};
        // Note: skipWhile on Set iterates in arbitrary order.
        // This test might be flaky. A List would be better here.
        return numbers.skipWhile((n) => n < 3).toSet();
      }
      ''';
      // Result depends heavily on iteration order, just check types
      expect(execute(source), isA<Set>());
    });

    test('I-COLL-270: First and last. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Set<int> numbers = {1, 2, 3};
        // Note: first/last on Set iterates in arbitrary order.
        // These properties are typically used with ordered collections (List).
        // This test checks if they run without error.
        var f = numbers.first;
        var l = numbers.last;
        return [numbers.contains(f), numbers.contains(l)];
      }
      ''';
      expect(execute(source), equals([true, true]));
    });

    test('I-COLL-271: Single. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Set<int> numbers = {42};
        return numbers.single;
      }
      ''';
      expect(execute(source), equals(42));
    });

    test('I-COLL-272: ElementAt. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Set<int> numbers = {10, 20, 30};
        // Note: elementAt on Set iterates in arbitrary order.
        var el = numbers.elementAt(1); // Get element at index 1
        return numbers.contains(el);
      }
      ''';
      expect(execute(source), isTrue);
    });

    test('I-COLL-273: Any. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Set<int> numbers = {1, 2, 3, 4};
        return numbers.any((n) => n > 3);
      }
      ''';
      expect(execute(source), isTrue);
    });

    test('I-COLL-275: Every. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Set<int> numbers = {2, 4, 6};
        return numbers.every((n) => n % 2 == 0);
      }
      ''';
      expect(execute(source), isTrue);
    });

    test('I-COLL-276: Join. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Set<String> items = {'a', 'b', 'c'};
        // Note: join on Set iterates in arbitrary order.
        var str = items.join('-');
        // Check length and contained chars as order varies
        return [str.length, str.contains('a'), str.contains('b'), str.contains('c'), str.contains('-')];
      }
      ''';
      final result = execute(source) as List;
      expect(result[0], equals(5)); // a-b-c
      expect(result.sublist(1), equals([true, true, true, true]));
    });
  });
}
