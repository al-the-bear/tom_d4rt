import 'package:test/test.dart';
import 'package:tom_d4rt_exec/src/exceptions.dart';

import '../../interpreter_test.dart';

void main() {
  group('List stdlib tests', () {
    test('I-COLL-175: List literal and basic properties. [2026-02-10 06:37] (PASS)', () {
      final result = execute(r'''
        main() {
          List<int> l1 = [1, 2, 3];
          List<dynamic> l2 = [];
          return [
            l1.length, l1.isEmpty, l1.isNotEmpty,
            l2.length, l2.isEmpty, l2.isNotEmpty
          ];
        }
      ''');
      expect(result, equals([3, false, true, 0, true, false]));
    });

    test('I-COLL-118: List index access [] and assignment []=. [2026-02-10 06:37] (PASS)', () {
      final result = execute(r'''
        main() {
          List<String> l = ['a', 'b', 'c'];
          var first = l[0];
          l[1] = 'B';
          return [first, l[1], l];
        }
      ''');
      expect(
          result,
          equals([
            'a',
            'B',
            ['a', 'B', 'c']
          ]));
    });

    test('I-COLL-136: List add and addAll. [2026-02-10 06:37] (PASS)', () {
      final result = execute(r'''
        main() {
          List<int> l = [1];
          l.add(2);
          l.addAll([3, 4]);
          return l;
        }
      ''');
      expect(result, equals([1, 2, 3, 4]));
    });

    test('I-COLL-148: List remove, removeAt, clear. [2026-02-10 06:37] (PASS)', () {
      final result = execute(r'''
        main() {
          List<String> l = ['x', 'y', 'z', 'y'];
          bool removedY = l.remove('y'); // Removes first 'y'
          var removedAt1 = l.removeAt(1); // Removes 'z'
          l.clear();
          return [removedY, removedAt1, l.length, l];
        }
      ''');
      expect(result, equals([true, 'z', 0, []]));
    });

    test('I-COLL-160: List contains, indexOf, lastIndexOf. [2026-02-10 06:37] (PASS)', () {
      final result = execute(r'''
        main() {
          List<int> l = [10, 20, 30, 20, 40];
          return [
            l.contains(20),
            l.contains(50),
            l.indexOf(20),       // First occurrence
            l.lastIndexOf(20),   // Last occurrence
            l.indexOf(50)        // Not found
          ];
        }
      ''');
      expect(result, equals([true, false, 1, 3, -1]));
    });

    test('I-COLL-177: List join. [2026-02-10 06:37] (PASS)', () {
      final result = execute(r'''
        main() {
          List<String> l = ['h', 'e', 'l', 'l', 'o'];
          return l.join('-');
        }
      ''');
      expect(result, equals('h-e-l-l-o'));
    });

    test('I-COLL-187: List sublist. [2026-02-10 06:37] (PASS)', () {
      final result = execute(r'''
        main() {
          List<int> l = [0, 1, 2, 3, 4, 5];
          return [l.sublist(1, 4), l.sublist(3)];
        }
      ''');
      expect(
          result,
          equals([
            [1, 2, 3],
            [3, 4, 5]
          ]));
    });

    group('List methods', () {
      test('I-COLL-108: Insert. [2026-02-10 06:37] (PASS)', () {
        const source = '''
       main() {
        List<int> numbers = [1, 2, 4];
        numbers.insert(2, 3);
        return numbers;
      }
      ''';
        expect(execute(source), equals([1, 2, 3, 4]));
      });

      test('I-COLL-109: InsertAll. [2026-02-10 06:37] (PASS)', () {
        const source = '''
       main() {
        List<int> numbers = [1, 4];
        numbers.insertAll(1, [2, 3]);
        return numbers;
      }
      ''';
        expect(execute(source), equals([1, 2, 3, 4]));
      });

      test('I-COLL-110: SetAll. [2026-02-10 06:37] (PASS)', () {
        const source = '''
       main() {
        List<int> numbers = [1, 2, 3, 4];
        numbers.setAll(1, [5, 6]);
        return numbers;
      }
      ''';
        expect(execute(source), equals([1, 5, 6, 4]));
      });

      test('I-COLL-111: FillRange. [2026-02-10 06:37] (PASS)', () {
        const source = '''
       main() {
        List<int> numbers = [1, 2, 3, 4];
        numbers.fillRange(1, 3, 0);
        return numbers;
      }
      ''';
        expect(execute(source), equals([1, 0, 0, 4]));
      });

      test('I-COLL-112: ReplaceRange. [2026-02-10 06:37] (PASS)', () {
        const source = '''
       main() {
        List<int> numbers = [1, 2, 3, 4];
        numbers.replaceRange(1, 3, [5, 6]);
        return numbers;
      }
      ''';
        expect(execute(source), equals([1, 5, 6, 4]));
      });

      test('I-COLL-113: RemoveRange. [2026-02-10 06:37] (PASS)', () {
        const source = '''
       main() {
        List<int> numbers = [1, 2, 3, 4];
        numbers.removeRange(1, 3);
        return numbers;
      }
      ''';
        expect(execute(source), equals([1, 4]));
      });

      test('I-COLL-114: RetainWhere. [2026-02-10 06:37] (PASS)', () {
        const source = '''
       main() {
        List<int> numbers = [1, 2, 3, 4];
        numbers.retainWhere((n) => n % 2 == 0);
        return numbers;
      }
      ''';
        expect(execute(source), equals([2, 4]));
      });

      test('I-COLL-115: RemoveWhere. [2026-02-10 06:37] (PASS)', () {
        const source = '''
       main() {
        List<int> numbers = [1, 2, 3, 4];
        numbers.removeWhere((n) => n % 2 == 0);
        return numbers;
      }
      ''';
        expect(execute(source), equals([1, 3]));
      });

      test('I-COLL-116: Sort. [2026-02-10 06:37] (PASS)', () {
        const source = '''
       main() {
        List<int> numbers = [4, 2, 3, 1];
        numbers.sort();
        return numbers;
      }
      ''';
        expect(execute(source), equals([1, 2, 3, 4]));
      });

      test('I-COLL-117: Shuffle. [2026-02-10 06:37] (PASS)', () {
        const source = '''
       main() {
        List<int> numbers = [1, 2, 3, 4];
        numbers.shuffle();
        return numbers; // Cannot check order, but check length and elements
      }
      ''';
        final result = execute(source) as List;
        expect(result, isA<List>());
        expect(result.length, equals(4));
        expect(result, containsAll([1, 2, 3, 4]));
      });

      test('I-COLL-119: Reversed. [2026-02-10 06:37] (PASS)', () {
        const source = '''
       main() {
        List<int> numbers = [1, 2, 3, 4];
        return numbers.reversed.toList();
      }
      ''';
        expect(execute(source), equals([4, 3, 2, 1]));
      });

      test('I-COLL-120: AsMap. [2026-02-10 06:37] (PASS)', () {
        const source = '''
       main() {
        List<int> numbers = [1, 2, 3];
        return numbers.asMap();
      }
      ''';
        expect(execute(source), equals({0: 1, 1: 2, 2: 3}));
      });
    });

    group('List methods - comprehensive', () {
      test('I-COLL-121: Add. [2026-02-10 06:37] (PASS)', () {
        const source = '''
       main() {
        List<int> numbers = [1, 2];
        numbers.add(3);
        return numbers;
      }
      ''';
        expect(execute(source), equals([1, 2, 3]));
      });

      test('I-COLL-122: AddAll. [2026-02-10 06:37] (PASS)', () {
        const source = '''
       main() {
        List<int> numbers = [1, 2];
        numbers.addAll([3, 4]);
        return numbers;
      }
      ''';
        expect(execute(source), equals([1, 2, 3, 4]));
      });

      test('I-COLL-123: Remove. [2026-02-10 06:37] (PASS)', () {
        const source = '''
       main() {
        List<int> numbers = [1, 2, 3];
        numbers.remove(2);
        return numbers;
      }
      ''';
        expect(execute(source), equals([1, 3]));
      });

      test('I-COLL-124: RemoveAt. [2026-02-10 06:37] (PASS)', () {
        const source = '''
       main() {
        List<int> numbers = [1, 2, 3];
        numbers.removeAt(1);
        return numbers;
      }
      ''';
        expect(execute(source), equals([1, 3]));
      });

      test('I-COLL-125: RemoveLast. [2026-02-10 06:37] (PASS)', () {
        const source = '''
       main() {
        List<int> numbers = [1, 2, 3];
        numbers.removeLast();
        return numbers;
      }
      ''';
        expect(execute(source), equals([1, 2]));
      });

      test('I-COLL-126: RemoveRange. [2026-02-10 06:37] (PASS)', () {
        const source = '''
       main() {
        List<int> numbers = [1, 2, 3, 4];
        numbers.removeRange(1, 3);
        return numbers;
      }
      ''';
        expect(execute(source), equals([1, 4]));
      });

      test('I-COLL-127: RetainWhere. [2026-02-10 06:37] (PASS)', () {
        const source = '''
       main() {
        List<int> numbers = [1, 2, 3, 4];
        numbers.retainWhere((n) => n % 2 == 0);
        return numbers;
      }
      ''';
        expect(execute(source), equals([2, 4]));
      });

      test('I-COLL-128: IndexOf. [2026-02-10 06:37] (PASS)', () {
        const source = '''
       main() {
        List<int> numbers = [1, 2, 3, 2];
        return numbers.indexOf(2);
      }
      ''';
        expect(execute(source), equals(1));
      });

      test('I-COLL-129: LastIndexOf. [2026-02-10 06:37] (PASS)', () {
        const source = '''
       main() {
        List<int> numbers = [1, 2, 3, 2];
        return numbers.lastIndexOf(2);
      }
      ''';
        expect(execute(source), equals(3));
      });

      test('I-COLL-130: Sublist. [2026-02-10 06:37] (PASS)', () {
        const source = '''
       main() {
        List<int> numbers = [1, 2, 3, 4];
        return numbers.sublist(1, 3);
      }
      ''';
        expect(execute(source), equals([2, 3]));
      });

      test('I-COLL-131: Contains. [2026-02-10 06:37] (PASS)', () {
        const source = '''
       main() {
        List<int> numbers = [1, 2, 3];
        return numbers.contains(2);
      }
      ''';
        expect(execute(source), equals(true));
      });

      test('I-COLL-132: Length. [2026-02-10 06:37] (PASS)', () {
        const source = '''
       main() {
        List<int> numbers = [1, 2, 3];
        return numbers.length;
      }
      ''';
        expect(execute(source), equals(3));
      });

      test('I-COLL-133: IsEmpty and isNotEmpty. [2026-02-10 06:37] (PASS)', () {
        const source = '''
       main() {
        List<int> numbers = [];
        return [numbers.isEmpty, numbers.isNotEmpty];
      }
      ''';
        expect(execute(source), equals([true, false]));
      });

      test('I-COLL-134: Reverse. [2026-02-10 06:37] (PASS)', () {
        const source = '''
       main() {
        List<int> numbers = [1, 2, 3];
        return numbers.reversed.toList();
      }
      ''';
        expect(execute(source), equals([3, 2, 1]));
      });

      test('I-COLL-135: Sort. [2026-02-10 06:37] (PASS)', () {
        const source = '''
       main() {
        List<int> numbers = [3, 1, 2];
        numbers.sort();
        return numbers;
      }
      ''';
        expect(execute(source), equals([1, 2, 3]));
      });

      test('I-COLL-137: Shuffle. [2026-02-10 06:37] (PASS)', () {
        const source = '''
       main() {
        List<int> numbers = [1, 2, 3];
        numbers.shuffle();
        return numbers; // Cannot check order, but check length and elements
      }
      ''';
        final result = execute(source) as List;
        expect(result, isA<List>());
        expect(result.length, equals(3));
        expect(result, containsAll([1, 2, 3]));
      });

      test('I-COLL-138: Expand. [2026-02-10 06:37] (PASS)', () {
        const source = '''
       main() {
        List<int> numbers = [1, 2, 3];
        return numbers.expand((n) => [n, n * 2]).toList();
      }
      ''';
        expect(execute(source), equals([1, 2, 2, 4, 3, 6]));
      });

      test('I-COLL-139: ForEach. [2026-02-10 06:37] (PASS)', () {
        const source = '''
       main() {
        List<int> numbers = [1, 2, 3];
        var sum = 0;
        numbers.forEach((n) => sum += n);
        return sum;
      }
      ''';
        expect(execute(source), equals(6));
      });

      test('I-COLL-140: Map. [2026-02-10 06:37] (PASS)', () {
        const source = '''
       main() {
        List<int> numbers = [1, 2, 3];
        return numbers.map((n) => n * 2).toList();
      }
      ''';
        expect(execute(source), equals([2, 4, 6]));
      });

      test('I-COLL-141: Where. [2026-02-10 06:37] (PASS)', () {
        const source = '''
       main() {
        List<int> numbers = [1, 2, 3, 4];
        return numbers.where((n) => n % 2 == 0).toList();
      }
      ''';
        expect(execute(source), equals([2, 4]));
      });

      test('I-COLL-142: Reduce. [2026-02-10 06:37] (PASS)', () {
        const source = '''
       main() {
        List<int> numbers = [1, 2, 3];
        return numbers.reduce((a, b) => a + b);
      }
      ''';
        expect(execute(source), equals(6));
      });

      test('I-COLL-143: Fold. [2026-02-10 06:37] (PASS)', () {
        const source = '''
       main() {
        List<int> numbers = [1, 2, 3];
        return numbers.fold(0, (a, b) => a + b);
      }
      ''';
        expect(execute(source), equals(6));
      });

      test('I-COLL-144: Join. [2026-02-10 06:37] (PASS)', () {
        const source = '''
       main() {
        List<int> numbers = [1, 2, 3];
        return numbers.join(", ");
      }
      ''';
        expect(execute(source), equals('1, 2, 3'));
      });

      test('I-COLL-145: ToSet. [2026-02-10 06:37] (PASS)', () {
        const source = '''
       main() {
        List<int> numbers = [1, 2, 2, 3];
        return numbers.toSet().toList();
      }
      ''';
        final result = execute(source) as List;
        result.sort();
        expect(result, equals([1, 2, 3]));
      });

      test('I-COLL-146: ToList. [2026-02-10 06:37] (PASS)', () {
        const source = '''
       main() {
        List<int> numbers = [1, 2, 3];
        var l = numbers.toList();
        l.add(4); // Modify to ensure it's a new list
        return [numbers, l]; // Return both to check independence
      }
      ''';
        expect(
            execute(source),
            equals([
              [1, 2, 3],
              [1, 2, 3, 4]
            ]));
      });
    });

    group('Iterable methods', () {
      test('I-COLL-147: Cast. [2026-02-10 06:37] (PASS)', () {
        const source = '''
       main() {
        Iterable<dynamic> numbers = [1, 2, 3];
        Iterable<int> casted = numbers.cast<int>();
        return casted.toList();
      }
      ''';
        expect(execute(source), equals([1, 2, 3]));
      });

      test('I-COLL-149: FollowedBy. [2026-02-10 06:37] (PASS)', () {
        const source = '''
       main() {
        Iterable<int> numbers = [1, 2];
        Iterable<int> moreNumbers = numbers.followedBy([3, 4]);
        return moreNumbers.toList();
      }
      ''';
        expect(execute(source), equals([1, 2, 3, 4]));
      });

      test('I-COLL-150: ElementAt. [2026-02-10 06:37] (PASS)', () {
        const source = '''
       main() {
        Iterable<int> numbers = [1, 2, 3];
        return numbers.elementAt(1);
      }
      ''';
        expect(execute(source), equals(2));
      });
    });

    group('Set methods', () {
      test('I-COLL-151: RetainWhere. [2026-02-10 06:37] (PASS)', () {
        const source = '''
       main() {
        Set<int> numbers = {1, 2, 3, 4};
        numbers.retainWhere((n) => n % 2 == 0);
        return numbers.toList(); // Convert to list for stable comparison
      }
      ''';
        final result = execute(source) as List;
        result.sort();
        expect(result, equals([2, 4]));
      });

      test('I-COLL-152: RemoveWhere. [2026-02-10 06:37] (PASS)', () {
        const source = '''
       main() {
        Set<int> numbers = {1, 2, 3, 4};
        numbers.removeWhere((n) => n % 2 == 0);
        return numbers.toList(); // Convert to list for stable comparison
      }
      ''';
        final result = execute(source) as List;
        result.sort();
        expect(result, equals([1, 3]));
      });
    });

    group('Typed List operations with various element types', () {
      test('I-COLL-153: AddAll on List<String>. [2026-02-10 06:37] (PASS)', () {
        const source = '''
        main() {
          List<String> lines = ['line1', 'line2'];
          lines.addAll(['line3', 'line4']);
          return lines;
        }
        ''';
        expect(execute(source), equals(['line1', 'line2', 'line3', 'line4']));
      });

      test('I-COLL-154: AddAll on List<int>. [2026-02-10 06:37] (PASS)', () {
        const source = '''
        main() {
          List<int> nums = [1, 2];
          nums.addAll([3, 4, 5]);
          return nums;
        }
        ''';
        expect(execute(source), equals([1, 2, 3, 4, 5]));
      });

      test('I-COLL-155: InsertAll on List<String>. [2026-02-10 06:37] (PASS)', () {
        const source = '''
        main() {
          List<String> items = ['a', 'd'];
          items.insertAll(1, ['b', 'c']);
          return items;
        }
        ''';
        expect(execute(source), equals(['a', 'b', 'c', 'd']));
      });

      test('I-COLL-156: InsertAll on List<int>. [2026-02-10 06:37] (PASS)', () {
        const source = '''
        main() {
          List<int> nums = [1, 5];
          nums.insertAll(1, [2, 3, 4]);
          return nums;
        }
        ''';
        expect(execute(source), equals([1, 2, 3, 4, 5]));
      });

      test('I-COLL-157: SetAll on List<String>. [2026-02-10 06:37] (PASS)', () {
        const source = '''
        main() {
          List<String> items = ['a', 'b', 'c', 'd'];
          items.setAll(1, ['X', 'Y']);
          return items;
        }
        ''';
        expect(execute(source), equals(['a', 'X', 'Y', 'd']));
      });

      test('I-COLL-158: SetAll on List<int>. [2026-02-10 06:37] (PASS)', () {
        const source = '''
        main() {
          List<int> nums = [0, 0, 0, 0, 0];
          nums.setAll(2, [7, 8, 9]);
          return nums;
        }
        ''';
        expect(execute(source), equals([0, 0, 7, 8, 9]));
      });

      test('I-COLL-159: ReplaceRange on List<String>. [2026-02-10 06:37] (PASS)', () {
        const source = '''
        main() {
          List<String> items = ['a', 'b', 'c', 'd', 'e'];
          items.replaceRange(1, 4, ['X', 'Y']);
          return items;
        }
        ''';
        expect(execute(source), equals(['a', 'X', 'Y', 'e']));
      });

      test('I-COLL-161: ReplaceRange on List<int>. [2026-02-10 06:37] (PASS)', () {
        const source = '''
        main() {
          List<int> nums = [1, 2, 3, 4, 5];
          nums.replaceRange(1, 3, [20, 30, 40]);
          return nums;
        }
        ''';
        expect(execute(source), equals([1, 20, 30, 40, 4, 5]));
      });

      test('I-COLL-162: ReplaceRange with empty replacement. [2026-02-10 06:37] (PASS)', () {
        const source = '''
        main() {
          List<String> items = ['a', 'b', 'c', 'd'];
          items.replaceRange(1, 3, []);
          return items;
        }
        ''';
        expect(execute(source), equals(['a', 'd']));
      });

      test('I-COLL-163: ReplaceRange with single element. [2026-02-10 06:37] (PASS)', () {
        const source = '''
        main() {
          List<String> items = ['a', 'b', 'c'];
          items.replaceRange(1, 2, ['X']);
          return items;
        }
        ''';
        expect(execute(source), equals(['a', 'X', 'c']));
      });
    });

    group('Dart 3 extension getters', () {
      test('I-COLL-164: FirstOrNull on non-empty List<String>. [2026-02-10 06:37] (PASS)', () {
        const source = '''
        main() {
          List<String> items = ['a', 'b', 'c'];
          return items.firstOrNull;
        }
        ''';
        expect(execute(source), equals('a'));
      });

      test('I-COLL-165: FirstOrNull on empty List<String>. [2026-02-10 06:37] (PASS)', () {
        const source = '''
        main() {
          List<String> items = [];
          return items.firstOrNull;
        }
        ''';
        expect(execute(source), isNull);
      });

      test('I-COLL-166: FirstOrNull on List<int>. [2026-02-10 06:37] (PASS)', () {
        const source = '''
        main() {
          List<int> nums = [10, 20, 30];
          return nums.firstOrNull;
        }
        ''';
        expect(execute(source), equals(10));
      });

      test('I-COLL-167: LastOrNull on non-empty List<String>. [2026-02-10 06:37] (PASS)', () {
        const source = '''
        main() {
          List<String> items = ['a', 'b', 'c'];
          return items.lastOrNull;
        }
        ''';
        expect(execute(source), equals('c'));
      });

      test('I-COLL-168: LastOrNull on empty List<int>. [2026-02-10 06:37] (PASS)', () {
        const source = '''
        main() {
          List<int> nums = [];
          return nums.lastOrNull;
        }
        ''';
        expect(execute(source), isNull);
      });

      test('I-COLL-169: SingleOrNull on single-element list. [2026-02-10 06:37] (PASS)', () {
        const source = '''
        main() {
          List<String> items = ['only'];
          return items.singleOrNull;
        }
        ''';
        expect(execute(source), equals('only'));
      });

      test('I-COLL-170: SingleOrNull on empty list. [2026-02-10 06:37] (PASS)', () {
        const source = '''
        main() {
          List<int> nums = [];
          return nums.singleOrNull;
        }
        ''';
        expect(execute(source), isNull);
      });

      test('I-COLL-171: SingleOrNull on multi-element list. [2026-02-10 06:37] (PASS)', () {
        const source = '''
        main() {
          List<int> nums = [1, 2];
          return nums.singleOrNull;
        }
        ''';
        expect(execute(source), isNull);
      });

      test('I-COLL-172: ElementAtOrNull within bounds. [2026-02-10 06:37] (PASS)', () {
        const source = '''
        main() {
          List<String> items = ['a', 'b', 'c'];
          return items.elementAtOrNull(1);
        }
        ''';
        expect(execute(source), equals('b'));
      });

      test('I-COLL-173: ElementAtOrNull out of bounds. [2026-02-10 06:37] (PASS)', () {
        const source = '''
        main() {
          List<int> nums = [1, 2, 3];
          return nums.elementAtOrNull(10);
        }
        ''';
        expect(execute(source), isNull);
      });

      test('I-COLL-174: ElementAtOrNull negative index throws RangeError. [2026-02-10 06:37] (PASS)', () {
        const source = '''
        main() {
          List<String> items = ['a', 'b'];
          return items.elementAtOrNull(-1);
        }
        ''';
        // Dart's elementAtOrNull throws RangeError for negative indices
        expect(() => execute(source), throwsA(isA<RuntimeD4rtException>()));
      });
    });

    group('Iterable extension getters on derived iterables', () {
      test('I-COLL-176: FirstOrNull on filtered iterable. [2026-02-10 06:37] (PASS)', () {
        const source = '''
        main() {
          List<int> nums = [1, 2, 3, 4, 5];
          var evens = nums.where((n) => n % 2 == 0);
          return evens.firstOrNull;
        }
        ''';
        expect(execute(source), equals(2));
      });

      test('I-COLL-178: FirstOrNull on empty filtered iterable. [2026-02-10 06:37] (PASS)', () {
        const source = '''
        main() {
          List<int> nums = [1, 3, 5];
          var evens = nums.where((n) => n % 2 == 0);
          return evens.firstOrNull;
        }
        ''';
        expect(execute(source), isNull);
      });

      test('I-COLL-179: LastOrNull on mapped iterable. [2026-02-10 06:37] (PASS)', () {
        const source = '''
        main() {
          List<int> nums = [1, 2, 3];
          var doubled = nums.map((n) => n * 2);
          return doubled.lastOrNull;
        }
        ''';
        expect(execute(source), equals(6));
      });

      test('I-COLL-180: SingleOrNull on take(1). [2026-02-10 06:37] (PASS)', () {
        const source = '''
        main() {
          List<String> items = ['a', 'b', 'c'];
          var first = items.take(1);
          return first.singleOrNull;
        }
        ''';
        expect(execute(source), equals('a'));
      });
    });

    group('Static constructors and methods', () {
      test('I-COLL-181: List.filled. [2026-02-10 06:37] (PASS)', () {
        const source = '''
        main() {
          var nums = List.filled(5, 0);
          return nums;
        }
        ''';
        expect(execute(source), equals([0, 0, 0, 0, 0]));
      });

      test('I-COLL-182: List.generate. [2026-02-10 06:37] (PASS)', () {
        const source = '''
        main() {
          var nums = List.generate(5, (i) => i * 2);
          return nums;
        }
        ''';
        expect(execute(source), equals([0, 2, 4, 6, 8]));
      });

      test('I-COLL-183: List.from. [2026-02-10 06:37] (PASS)', () {
        const source = '''
        main() {
          var original = [1, 2, 3];
          var copy = List.from(original);
          copy.add(4);
          return [original, copy];
        }
        ''';
        expect(execute(source), equals([[1, 2, 3], [1, 2, 3, 4]]));
      });

      test('I-COLL-184: List.of. [2026-02-10 06:37] (PASS)', () {
        const source = '''
        main() {
          var original = [1, 2, 3];
          var copy = List.of(original);
          return copy;
        }
        ''';
        expect(execute(source), equals([1, 2, 3]));
      });

      test('I-COLL-185: List.empty growable. [2026-02-10 06:37] (PASS)', () {
        const source = '''
        main() {
          var empty = List.empty(growable: true);
          empty.add(1);
          return empty;
        }
        ''';
        expect(execute(source), equals([1]));
      });

      test('I-COLL-186: List.empty non-growable. [2026-02-10 06:37] (PASS)', () {
        const source = '''
        main() {
          var empty = List.empty();
          return empty.isEmpty;
        }
        ''';
        expect(execute(source), isTrue);
      });
    });

    group('Range operations', () {
      test('I-COLL-188: GetRange. [2026-02-10 06:37] (PASS)', () {
        const source = '''
        main() {
          List<int> nums = [0, 1, 2, 3, 4, 5];
          return nums.getRange(2, 5).toList();
        }
        ''';
        expect(execute(source), equals([2, 3, 4]));
      });

      test('I-COLL-189: RemoveRange. [2026-02-10 06:37] (PASS)', () {
        const source = '''
        main() {
          List<int> nums = [0, 1, 2, 3, 4, 5];
          nums.removeRange(2, 4);
          return nums;
        }
        ''';
        expect(execute(source), equals([0, 1, 4, 5]));
      });

      test('I-COLL-190: FillRange. [2026-02-10 06:37] (PASS)', () {
        const source = '''
        main() {
          List<int> nums = [0, 0, 0, 0, 0];
          nums.fillRange(1, 4, 9);
          return nums;
        }
        ''';
        expect(execute(source), equals([0, 9, 9, 9, 0]));
      });

      test('I-COLL-191: SetRange. [2026-02-10 06:37] (PASS)', () {
        const source = '''
        main() {
          List<int> target = [0, 0, 0, 0, 0];
          List<int> source = [1, 2, 3];
          target.setRange(1, 4, source);
          return target;
        }
        ''';
        expect(execute(source), equals([0, 1, 2, 3, 0]));
      });
    });

    group('Mixed type operations', () {
      test('I-COLL-192: List<dynamic> with mixed types. [2026-02-10 06:37] (PASS)', () {
        const source = '''
        main() {
          List<dynamic> mixed = [1, 'two', 3.0, true];
          mixed.addAll([null, 'five']);
          return mixed;
        }
        ''';
        expect(execute(source), equals([1, 'two', 3.0, true, null, 'five']));
      });

      test('I-COLL-193: List operations returning correct types. [2026-02-10 06:37] (PASS)', () {
        const source = '''
        main() {
          List<int> nums = [1, 2, 3, 4, 5];
          var sum = nums.fold(0, (acc, n) => acc + n);
          var product = nums.reduce((a, b) => a * b);
          return [sum, product];
        }
        ''';
        expect(execute(source), equals([15, 120]));
      });
    });
  });
}

