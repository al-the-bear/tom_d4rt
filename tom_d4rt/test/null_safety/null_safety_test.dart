import 'package:tom_d4rt/d4rt.dart';
import 'package:test/test.dart';

void main() {
  group('Null Safety Features', () {
    late D4rt d4rt;

    setUp(() {
      d4rt = D4rt();
    });

    test('nullable types are supported [2026-02-10 06:37]', () {
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

    test('null assertion operator (!) works [2026-02-10 06:37]', () {
      final result = d4rt.execute(source: '''
        main() {
          String? nullableString = 'hello';
          String nonNullable = nullableString!;
          return nonNullable;
        }
      ''');

      expect(result, 'hello');
    });

    test('null assertion operator (!) throws on null values [2026-02-10 06:37]', () {
      expect(() => d4rt.execute(source: '''
        main() {
          String? nullableString = null;
          String nonNullable = nullableString!;
          return nonNullable;
        }
      '''), throwsA(isA<RuntimeD4rtException>()));
    });

    test('null-aware access operator (?.) returns null for null values [2026-02-10 06:37]', () {
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

    test('null-aware access operator (?.) works for non-null values [2026-02-10 06:37]', () {
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

    test('null coalescing operator (??) chooses right side for null left [2026-02-10 06:37]', () {
      final result = d4rt.execute(source: '''
        main() {
          String? maybeValue = null;
          String definiteValue = maybeValue ?? 'default';
          return definiteValue;
        }
      ''');

      expect(result, 'default');
    });

    test('null coalescing operator (??) chooses left side for non-null left [2026-02-10 06:37]',
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

    test('null-aware assignment operator (??=) assigns if null [2026-02-10 06:37]', () {
      final result = d4rt.execute(source: '''
        main() {
          String? value = null;
          value ??= 'assigned';
          return value;
        }
      ''');

      expect(result, 'assigned');
    });

    test('null-aware assignment operator (??=) does not assign if not null [2026-02-10 06:37]',
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

    test('null-aware method call (?.) returns null for null receiver [2026-02-10 06:37]', () {
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

    test('null-aware method call (?.) works for non-null receiver [2026-02-10 06:37]', () {
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

    test('spread null-aware operator (...?) skips null collections [2026-02-10 06:37]', () {
      final result = d4rt.execute(source: '''
        main() {
          List<int>? nullList = null;
          List<int> finalList = [1, 2, ...?nullList, 3];
          return finalList;
        }
      ''');

      expect(result, [1, 2, 3]);
    });

    test('spread null-aware operator (...?) includes non-null collections [2026-02-10 06:37]', () {
      final result = d4rt.execute(source: '''
        main() {
          List<int>? nonNullList = [10, 20];
          List<int> finalList = [1, 2, ...?nonNullList, 3];
          return finalList;
        }
      ''');

      expect(result, [1, 2, 10, 20, 3]);
    });

    test('chained null-aware access works correctly [2026-02-10 06:37]', () {
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

    test('mixed null safety operators work together [2026-02-10 06:37]', () {
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
