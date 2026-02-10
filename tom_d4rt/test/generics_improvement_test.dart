import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

dynamic execute(String source, {List<Object?>? args}) {
  final d4rt = D4rt()..setDebug(false);
  return d4rt.execute(
      library: 'package:test/main.dart',
      positionalArgs: args,
      sources: {'package:test/main.dart': source});
}

void main() {
  group('Improved Generics Validation', () {
    test('I-TYPE-71: Generic class constraint validation. [2026-02-10 06:37] (PASS)', () {
      final validCode = '''
        class NumericContainer<T extends num> {
          T value;
          NumericContainer(this.value);
          
          T getValue() => value;
        }
        
        main() {
          var intContainer = NumericContainer<int>(42);
          return intContainer.getValue();
        }
      ''';

      expect(execute(validCode), equals(42));

      final invalidCode = '''
        class NumericContainer<T extends num> {
          T value;
          NumericContainer(this.value);
          
          T getValue() => value;
        }
        
        main() {
          var stringContainer = NumericContainer<String>("hello");
          return stringContainer.getValue();
        }
      ''';

      expect(
        () => execute(invalidCode),
        throwsA(isA<RuntimeD4rtException>().having(
          (e) => e.message,
          'message',
          contains('does not satisfy bound'),
        )),
      );
    });

    test('I-TYPE-72: Generic function constraint validation. [2026-02-10 06:37] (PASS)', () {
      final validCode = '''
        T addOne<T extends num>(T value) {
          return value + 1;
        }
        
        main() {
          return addOne<int>(5);
        }
      ''';

      expect(execute(validCode), equals(6));

      final invalidCode = '''
        T addOne<T extends num>(T value) {
          return value + 1;
        }
        
        main() {
          return addOne<String>("hello");
        }
      ''';

      expect(
        () => execute(invalidCode),
        throwsA(isA<RuntimeD4rtException>().having(
          (e) => e.message,
          'message',
          contains('does not satisfy bound'),
        )),
      );
    });

    test('I-TYPE-73: Multiple type parameters with bounds. [2026-02-10 06:37] (PASS)', () {
      final validCode = '''
        class Pair<T extends num, U extends String> {
          T first;
          U second;
          Pair(this.first, this.second);
        }
        
        main() {
          var validPair = Pair<double, String>(42, "test");
          return true;
        }
      ''';

      expect(execute(validCode), isTrue);

      final invalidCode = '''
        class Pair<T extends num, U extends String> {
          T first;
          U second;
          Pair(this.first, this.second);
        }
        
        main() {
          var invalidPair = Pair<bool, String>(true, "test");
          return true;
        }
      ''';

      expect(
        () => execute(invalidCode),
        throwsA(isA<RuntimeD4rtException>().having(
          (e) => e.message,
          'message',
          contains('does not satisfy bound'),
        )),
      );
    });

    test('I-TYPE-70: Nested generics constraint validation. [2026-02-10 06:37] (PASS)', () {
      final validCode = '''
        class Container<T extends num> {
          List<T> items = [];
        }
        
        main() {
          var container = Container<int>();
          return true;
        }
      ''';

      expect(execute(validCode), isTrue);

      final invalidCode = '''
        class Container<T extends num> {
          List<T> items = [];
        }
        
        main() {
          var container = Container<String>();
          return true;
        }
      ''';

      expect(
        () => execute(invalidCode),
        throwsA(isA<RuntimeD4rtException>().having(
          (e) => e.message,
          'message',
          contains('does not satisfy bound'),
        )),
      );
    });
  });
}
