import 'test_helpers.dart';
/// Test for Bug-98: Extension getter on bridged List not resolved
import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

void main() {
  group('Bug-98: Extension getter on bridged List', () {
    late D4rt interpreter;

    setUp(() {
      interpreter = D4rt(parseSourceCallback: parseSource);
    });

    test('I-COLL-1: Extension getter on List<int> works. [2026-02-10 06:37] (PASS)', () async {
      final result = await interpreter.execute(source: '''
        extension IntListExt on List<int> {
          int get sum => fold(0, (a, b) => a + b);
        }

        int main() {
          var numbers = [1, 2, 3, 4, 5];
          return numbers.sum;
        }
      ''');

      expect(result, equals(15));
    });

    test('I-COLL-2: Extension method on List<String> works. [2026-02-10 06:37] (PASS)', () async {
      final result = await interpreter.execute(source: '''
        extension StringListExt on List<String> {
          String get joined => join(', ');
        }

        String main() {
          var words = ['hello', 'world'];
          return words.joined;
        }
      ''');

      expect(result, equals('hello, world'));
    });

    test('I-COLL-3: Multiple extensions on same base type work. [2026-02-10 06:37] (PASS)', () async {
      final result = await interpreter.execute(source: '''
        extension IntListSum on List<int> {
          int get sum => fold(0, (a, b) => a + b);
        }

        extension IntListProduct on List<int> {
          int get product => fold(1, (a, b) => a * b);
        }

        List<int> main() {
          var numbers = [1, 2, 3, 4];
          return [numbers.sum, numbers.product];
        }
      ''');

      expect(result, equals([10, 24]));
    });

    test('I-COLL-4: Extension on List (unparameterized) works. [2026-02-10 06:37] (PASS)', () async {
      final result = await interpreter.execute(source: '''
        extension ListExt on List {
          int get len => length;
        }

        int main() {
          var items = [1, 2, 3];
          return items.len;
        }
      ''');

      expect(result, equals(3));
    });

    test('I-COLL-5: Extension on Map<String, int> works. [2026-02-10 06:37] (PASS)', () async {
      final result = await interpreter.execute(source: '''
        extension MapExt on Map<String, int> {
          int get sumValues => values.fold(0, (a, b) => a + b);
        }

        int main() {
          var data = {'a': 1, 'b': 2, 'c': 3};
          return data.sumValues;
        }
      ''');

      expect(result, equals(6));
    });

    test('I-COLL-6: Extension method with parameters on List works. [2026-02-10 06:37] (PASS)', () async {
      final result = await interpreter.execute(source: '''
        extension IntListExt on List<int> {
          int sumGreaterThan(int threshold) {
            return where((x) => x > threshold).fold(0, (a, b) => a + b);
          }
        }

        int main() {
          var numbers = [1, 2, 3, 4, 5];
          return numbers.sumGreaterThan(2);
        }
      ''');

      expect(result, equals(12)); // 3 + 4 + 5
    });
  });
}
