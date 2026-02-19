import '../test_helpers.dart';
import 'package:tom_d4rt_exec/d4rt.dart';
import 'package:test/test.dart';

void main() {
  group('Null Safety Features', () {
    late D4rt d4rt;

    setUp(() {
      d4rt = D4rt(parseSourceCallback: parseSource);
    });

    test('I-MISC-382: Nullable types are supported. [2026-02-10 06:37] (PASS)', () {
      final result = d4rt.execute(source: '''
        main() {
          String? nullableString = null;
          if (nullableString == null) {
            return 'null_detected';
          }
          return 'not_null';
        }
      ''');

      expect(result, 'null_detected');
    });

    test('I-MISC-389: Null assertion operator (!) works. [2026-02-10 06:37] (PASS)', () {
      final result = d4rt.execute(source: '''
        main() {
          String? nullableString = 'hello';
          String nonNullable = nullableString!;
          return nonNullable;
        }
      ''');

      expect(result, 'hello');
    });

    test('I-MISC-390: Null assertion operator (!) throws on null values. [2026-02-10 06:37] (PASS)', () {
      expect(() => d4rt.execute(source: '''
        main() {
          String? nullableString = null;
          String nonNullable = nullableString!;
          return nonNullable;
        }
      '''), throwsA(isA<RuntimeD4rtException>()));
    });

    test('I-MISC-391: Null-aware access operator (?.) returns null for null values. [2026-02-10 06:37] (PASS)', () {
      final result = d4rt.execute(source: '''
        class Person {
          String name = 'John';
        }
        
        main() {
          Person? person = null;
          var name = person?.name;
          return name;
        }
      ''');

      expect(result, null);
    });

    test('I-MISC-392: Null-aware access operator (?.) works for non-null values. [2026-02-10 06:37] (PASS)', () {
      final result = d4rt.execute(source: '''
        class Person {
          String name = 'John';
        }
        
        main() {
          Person? person = Person();
          var name = person?.name;
          return name;
        }
      ''');

      expect(result, 'John');
    });

    test('I-MISC-393: Null coalescing operator (??) chooses right side for null left. [2026-02-10 06:37] (PASS)', () {
      final result = d4rt.execute(source: '''
        main() {
          String? maybeValue = null;
          String definiteValue = maybeValue ?? 'default';
          return definiteValue;
        }
      ''');

      expect(result, 'default');
    });

    test('I-MISC-394: Null coalescing operator (??) chooses left side for non-null left. [2026-02-10 06:37] (PASS)',
        () {
      final result = d4rt.execute(source: '''
        main() {
          String? maybeValue = 'actual';
          String definiteValue = maybeValue ?? 'default';
          return definiteValue;
        }
      ''');

      expect(result, 'actual');
    });

    test('I-MISC-380: Null-aware assignment operator (??=) assigns if null. [2026-02-10 06:37] (PASS)', () {
      final result = d4rt.execute(source: '''
        main() {
          String? value = null;
          value ??= 'assigned';
          return value;
        }
      ''');

      expect(result, 'assigned');
    });

    test('I-MISC-381: Null-aware assignment operator (??=) does not assign if not null. [2026-02-10 06:37] (PASS)',
        () {
      final result = d4rt.execute(source: '''
        main() {
          String? value = 'original';
          value ??= 'not assigned';
          return value;
        }
      ''');

      expect(result, 'original');
    });

    test('I-MISC-383: Null-aware method call (?.) returns null for null receiver. [2026-02-10 06:37] (PASS)', () {
      final result = d4rt.execute(source: '''
        class Person {
          String getName() => 'John';
        }
        
        main() {
          Person? person = null;
          var name = person?.getName();
          return name;
        }
      ''');

      expect(result, null);
    });

    test('I-MISC-384: Null-aware method call (?.) works for non-null receiver. [2026-02-10 06:37] (PASS)', () {
      final result = d4rt.execute(source: '''
        class Person {
          String getName() => 'John';
        }
        
        main() {
          Person? person = Person();
          var name = person?.getName();
          return name;
        }
      ''');

      expect(result, 'John');
    });

    test('I-MISC-385: Spread null-aware operator (...?) skips null collections. [2026-02-10 06:37] (PASS)', () {
      final result = d4rt.execute(source: '''
        main() {
          List<int>? nullList = null;
          List<int> finalList = [1, 2, ...?nullList, 3];
          return finalList;
        }
      ''');

      expect(result, [1, 2, 3]);
    });

    test('I-MISC-386: Spread null-aware operator (...?) includes non-null collections. [2026-02-10 06:37] (PASS)', () {
      final result = d4rt.execute(source: '''
        main() {
          List<int>? nonNullList = [10, 20];
          List<int> finalList = [1, 2, ...?nonNullList, 3];
          return finalList;
        }
      ''');

      expect(result, [1, 2, 10, 20, 3]);
    });

    test('I-MISC-387: Chained null-aware access works correctly. [2026-02-10 06:37] (PASS)', () {
      final result = d4rt.execute(source: '''
        class Address {
          String street = 'Main St';
        }
        
        class Person {
          Address? address;
        }
        
        main() {
          Person? person = null;
          var street = person?.address?.street;
          return street;
        }
      ''');

      expect(result, null);
    });

    test('I-MISC-388: Mixed null safety operators work together. [2026-02-10 06:37] (PASS)', () {
      final result = d4rt.execute(source: '''
        class Config {
          String? getValue() => null;
        }
        
        main() {
          Config? config = Config();
          String value = config?.getValue() ?? 'default';
          return value;
        }
      ''');

      expect(result, 'default');
    });
  });
}
