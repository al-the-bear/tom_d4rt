import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// Tests for positionalArgs and namedArgs in execute()
/// This feature allows passing arguments directly to functions called via execute()
void main() {
  group('positionalArgs and namedArgs', () {
    late D4rt d4rt;

    setUp(() {
      d4rt = D4rt();
    });

    group('Basic positional arguments', () {
      test('I-FUNC-4: Should pass single positional argument. [2026-02-10 06:37] (PASS)', () {
        final result = d4rt.execute(
          source: '''
            String echo(String value) => "Echo: \$value";
          ''',
          name: 'echo',
          positionalArgs: ['Hello'],
        );
        expect(result, equals('Echo: Hello'));
      });

      test('I-FUNC-8: Should pass multiple positional arguments. [2026-02-10 06:37] (PASS)', () {
        final result = d4rt.execute(
          source: '''
            int calculate(int a, int b, int c) => a * b + c;
          ''',
          name: 'calculate',
          positionalArgs: [5, 4, 3],
        );
        expect(result, equals(23)); // 5 * 4 + 3 = 23
      });

      test('I-FUNC-14: Should handle positional arguments with different types. [2026-02-10 06:37] (PASS)', () {
        final result = d4rt.execute(
          source: '''
            String describe(String name, int age, double height, bool active) {
              return "\$name, \$age years, \${height}m, active: \$active";
            }
          ''',
          name: 'describe',
          positionalArgs: ['Alice', 30, 1.75, true],
        );
        expect(result, equals('Alice, 30 years, 1.75m, active: true'));
      });

      test('I-FUNC-24: Should handle null in positional arguments. [2026-02-10 06:37] (PASS)', () {
        final result = d4rt.execute(
          source: '''
            String handleNull(String? value) {
              return value ?? "default";
            }
          ''',
          name: 'handleNull',
          positionalArgs: [null],
        );
        expect(result, equals('default'));
      });
    });

    group('Basic named arguments', () {
      test('I-FUNC-33: Should pass single named argument. [2026-02-10 06:37] (PASS)', () {
        final result = d4rt.execute(
          source: '''
            String greet({required String name}) => "Hello, \$name!";
          ''',
          name: 'greet',
          namedArgs: {'name': 'World'},
        );
        expect(result, equals('Hello, World!'));
      });

      test('I-FUNC-34: Should pass multiple named arguments. [2026-02-10 06:37] (PASS)', () {
        final result = d4rt.execute(
          source: '''
            Map<String, dynamic> createUser({
              required String name,
              required int age,
              String role = "user"
            }) {
              return {'name': name, 'age': age, 'role': role};
            }
          ''',
          name: 'createUser',
          namedArgs: {'name': 'John', 'age': 25, 'role': 'admin'},
        );
        expect(result, equals({'name': 'John', 'age': 25, 'role': 'admin'}));
      });

      test('I-FUNC-35: Should use default values for omitted named arguments. [2026-02-10 06:37] (PASS)', () {
        final result = d4rt.execute(
          source: '''
            String formatDate({
              int day = 1,
              int month = 1,
              int year = 2000
            }) {
              return "\$year-\$month-\$day";
            }
          ''',
          name: 'formatDate',
          namedArgs: {'year': 2024}, // Only provide year
        );
        expect(result, equals('2024-1-1'));
      });

      test('I-FUNC-1: Should handle named arguments with complex default values. [2026-02-10 06:37] (PASS)', () {
        final result = d4rt.execute(
          source: '''
            List<int> generateRange({
              int start = 0,
              int end = 10,
              int step = 1
            }) {
              List<int> result = [];
              for (int i = start; i < end; i += step) {
                result.add(i);
              }
              return result;
            }
          ''',
          name: 'generateRange',
          namedArgs: {'end': 5},
        );
        expect(result, equals([0, 1, 2, 3, 4]));
      });
    });

    group('Mixed positional and named arguments', () {
      test('I-FUNC-2: Should handle positional followed by named arguments. [2026-02-10 06:37] (PASS)', () {
        final result = d4rt.execute(
          source: '''
            String format(String template, {String prefix = "", String suffix = ""}) {
              return "\$prefix\$template\$suffix";
            }
          ''',
          name: 'format',
          positionalArgs: ['content'],
          namedArgs: {'prefix': '[', 'suffix': ']'},
        );
        expect(result, equals('[content]'));
      });

      test('I-FUNC-3: Should handle multiple positional and multiple named arguments. [2026-02-10 06:37] (PASS)',
          () {
        final result = d4rt.execute(
          source: '''
            String buildQuery(
              String table,
              String column,
              {
                String where = "",
                String orderBy = "",
                int limit = 100
              }
            ) {
              String query = "SELECT \$column FROM \$table";
              if (where.isNotEmpty) query += " WHERE \$where";
              if (orderBy.isNotEmpty) query += " ORDER BY \$orderBy";
              query += " LIMIT \$limit";
              return query;
            }
          ''',
          name: 'buildQuery',
          positionalArgs: ['users', 'name'],
          namedArgs: {'where': 'active = true', 'limit': 50},
        );
        expect(
          result,
          equals('SELECT name FROM users WHERE active = true LIMIT 50'),
        );
      });

      test('I-FUNC-5: Should handle complex business logic with mixed args. [2026-02-10 06:37] (PASS)', () {
        final result = d4rt.execute(
          source: '''
            Map<String, dynamic> processOrder(
              String productId,
              int quantity,
              {
                double discount = 0.0,
                String currency = "USD",
                bool express = false,
                String? couponCode
              }
            ) {
              double basePrice = 10.0; // Simplified
              double total = basePrice * quantity * (1 - discount);
              double shipping = express ? 15.0 : 5.0;
              
              return {
                'productId': productId,
                'quantity': quantity,
                'subtotal': total,
                'shipping': shipping,
                'total': total + shipping,
                'currency': currency,
                'express': express,
                'coupon': couponCode
              };
            }
          ''',
          name: 'processOrder',
          positionalArgs: ['PROD-001', 3],
          namedArgs: {
            'discount': 0.1,
            'express': true,
            'couponCode': 'SAVE10',
          },
        );

        expect(result['productId'], equals('PROD-001'));
        expect(result['quantity'], equals(3));
        expect(result['subtotal'], equals(27.0)); // 10 * 3 * 0.9
        expect(result['shipping'], equals(15.0));
        expect(result['total'], equals(42.0));
        expect(result['express'], isTrue);
        expect(result['coupon'], equals('SAVE10'));
      });
    });

    group('Complex data types as arguments', () {
      test('I-FUNC-6: Should handle List argument. [2026-02-10 06:37] (PASS)', () {
        final result = d4rt.execute(
          source: '''
            int sumList(List<int> numbers) {
              int total = 0;
              for (var n in numbers) total += n;
              return total;
            }
          ''',
          name: 'sumList',
          positionalArgs: [
            [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
          ],
        );
        expect(result, equals(55));
      });

      test('I-FUNC-7: Should handle nested List argument. [2026-02-10 06:37] (PASS)', () {
        final result = d4rt.execute(
          source: '''
            List<int> flatten(List<List<int>> matrix) {
              List<int> result = [];
              for (var row in matrix) {
                for (var item in row) {
                  result.add(item);
                }
              }
              return result;
            }
          ''',
          name: 'flatten',
          positionalArgs: [
            [
              [1, 2, 3],
              [4, 5, 6],
              [7, 8, 9]
            ]
          ],
        );
        expect(result, equals([1, 2, 3, 4, 5, 6, 7, 8, 9]));
      });

      test('I-FUNC-9: Should handle Map argument. [2026-02-10 06:37] (PASS)', () {
        final result = d4rt.execute(
          source: '''
            List<String> getKeys(Map<String, dynamic> map) {
              return map.keys.toList();
            }
          ''',
          name: 'getKeys',
          positionalArgs: [
            {'a': 1, 'b': 2, 'c': 3}
          ],
        );
        expect(result, containsAll(['a', 'b', 'c']));
      });

      test('I-FUNC-10: Should handle deeply nested Map argument. [2026-02-10 06:37] (PASS)', () {
        final result = d4rt.execute(
          source: '''
            dynamic getNestedValue(Map<String, dynamic> data, List<String> path) {
              dynamic current = data;
              for (var key in path) {
                if (current is Map) {
                  current = current[key];
                } else {
                  return null;
                }
              }
              return current;
            }
          ''',
          name: 'getNestedValue',
          positionalArgs: [
            {
              'user': {
                'profile': {
                  'settings': {'theme': 'dark'}
                }
              }
            },
            ['user', 'profile', 'settings', 'theme']
          ],
        );
        expect(result, equals('dark'));
      });

      test('I-FUNC-11: Should handle function callback in list (as values). [2026-02-10 06:37] (PASS)', () {
        final result = d4rt.execute(
          source: '''
            List<int> mapNumbers(List<int> numbers, List<int> multipliers) {
              List<int> result = [];
              for (int i = 0; i < numbers.length; i++) {
                result.add(numbers[i] * multipliers[i % multipliers.length]);
              }
              return result;
            }
          ''',
          name: 'mapNumbers',
          positionalArgs: [
            [1, 2, 3, 4],
            [10, 100]
          ],
        );
        expect(result, equals([10, 200, 30, 400]));
      });
    });

    group('Optional positional arguments', () {
      test(
          'should handle optional positional arguments with defaults via named args',
          () {
        // Note: Optional positional parameters [...] are best handled via named args
        // or by using required positional parameters
        final result = d4rt.execute(
          source: '''
            String greet({String name = "Guest", String greeting = "Hello"}) {
              return "\$greeting, \$name!";
            }
          ''',
          name: 'greet',
          namedArgs: {'name': 'Alice'},
        );
        expect(result, equals('Hello, Alice!'));
      });

      test('I-FUNC-12: Should handle all optional parameters via named args. [2026-02-10 06:37] (PASS)', () {
        final result = d4rt.execute(
          source: '''
            int power({int base = 2, int exponent = 2}) {
              int result = 1;
              for (int i = 0; i < exponent; i++) {
                result *= base;
              }
              return result;
            }
          ''',
          name: 'power',
          namedArgs: {'base': 3, 'exponent': 4},
        );
        expect(result, equals(81)); // 3^4
      });

      test('I-FUNC-13: Should handle no optional arguments provided. [2026-02-10 06:37] (PASS)', () {
        final result = d4rt.execute(
          source: '''
            String defaultGreeting({String name = "World"}) {
              return "Hello, \$name!";
            }
          ''',
          name: 'defaultGreeting',
          namedArgs: {},
        );
        expect(result, equals('Hello, World!'));
      });
    });

    group('Error handling', () {
      test('I-FUNC-15: Should throw error when required positional argument is missing. [2026-02-10 06:37] (PASS)',
          () {
        expect(
          () => d4rt.execute(
            source: '''
              int add(int a, int b) => a + b;
            ''',
            name: 'add',
            positionalArgs: [1], // Missing second argument
          ),
          throwsA(isA<RuntimeD4rtException>()),
        );
      });

      test('I-FUNC-16: Should throw error when too many positional arguments provided. [2026-02-10 06:37] (PASS)',
          () {
        expect(
          () => d4rt.execute(
            source: '''
              int add(int a, int b) => a + b;
            ''',
            name: 'add',
            positionalArgs: [1, 2, 3], // Too many arguments
          ),
          throwsA(isA<RuntimeD4rtException>()),
        );
      });

      test('I-FUNC-17: Should throw error when required named argument is missing. [2026-02-10 06:37] (PASS)', () {
        expect(
          () => d4rt.execute(
            source: '''
              String greet({required String firstName, required String lastName}) {
                return "\$firstName \$lastName";
              }
            ''',
            name: 'greet',
            namedArgs: {'firstName': 'John'}, // Missing lastName
          ),
          throwsA(isA<RuntimeD4rtException>()),
        );
      });

      test('I-FUNC-18: Should throw error when unknown named argument is provided. [2026-02-10 06:37] (PASS)', () {
        expect(
          () => d4rt.execute(
            source: '''
              void doSomething({String? name}) {}
            ''',
            name: 'doSomething',
            namedArgs: {'unknownArg': 'value'},
          ),
          throwsA(isA<RuntimeD4rtException>()),
        );
      });

      test('I-FUNC-19: Should throw error when function does not exist. [2026-02-10 06:37] (PASS)', () {
        expect(
          () => d4rt.execute(
            source: '''
              void existingFunction() {}
            ''',
            name: 'nonExistentFunction',
            positionalArgs: [],
          ),
          throwsA(isA<RuntimeD4rtException>()),
        );
      });
    });

    group('Special cases', () {
      test('I-FUNC-20: Should handle empty string argument. [2026-02-10 06:37] (PASS)', () {
        final result = d4rt.execute(
          source: '''
            bool isEmpty(String value) => value.isEmpty;
          ''',
          name: 'isEmpty',
          positionalArgs: [''],
        );
        expect(result, isTrue);
      });

      test('I-FUNC-21: Should handle very long string argument. [2026-02-10 06:37] (PASS)', () {
        final longString = 'a' * 10000;
        final result = d4rt.execute(
          source: '''
            int getLength(String value) => value.length;
          ''',
          name: 'getLength',
          positionalArgs: [longString],
        );
        expect(result, equals(10000));
      });

      test('I-FUNC-22: Should handle negative numbers. [2026-02-10 06:37] (PASS)', () {
        final result = d4rt.execute(
          source: '''
            int absolute(int value) => value < 0 ? -value : value;
          ''',
          name: 'absolute',
          positionalArgs: [-42],
        );
        expect(result, equals(42));
      });

      test('I-FUNC-23: Should handle floating point precision. [2026-02-10 06:37] (PASS)', () {
        final result = d4rt.execute(
          source: '''
            double sum(double a, double b) => a + b;
          ''',
          name: 'sum',
          positionalArgs: [0.1, 0.2],
        );
        expect(result, closeTo(0.3, 0.0001));
      });

      test('I-FUNC-25: Should handle unicode strings. [2026-02-10 06:37] (PASS)', () {
        final result = d4rt.execute(
          source: '''
            String echo(String value) => value;
          ''',
          name: 'echo',
          positionalArgs: ['Hello 世界 🌍 مرحبا'],
        );
        expect(result, equals('Hello 世界 🌍 مرحبا'));
      });

      test('I-FUNC-26: Should handle recursive function with arguments. [2026-02-10 06:37] (PASS)', () {
        final result = d4rt.execute(
          source: '''
            int factorial(int n) {
              if (n <= 1) return 1;
              return n * factorial(n - 1);
            }
          ''',
          name: 'factorial',
          positionalArgs: [10],
        );
        expect(result, equals(3628800));
      });

      test('I-FUNC-27: Should handle async function with arguments. [2026-02-10 06:37] (PASS)', () async {
        final result = await d4rt.execute(
          source: '''
            Future<int> asyncAdd(int a, int b) async {
              return a + b;
            }
          ''',
          name: 'asyncAdd',
          positionalArgs: [10, 20],
        );
        expect(result, equals(30));
      });
    });

    group('Interaction with classes', () {
      test('I-FUNC-28: Should handle class creation and method calls with arguments. [2026-02-10 06:37] (PASS)', () {
        final result = d4rt.execute(
          source: '''
            class Point {
              int x;
              int y;
              Point(this.x, this.y);
              
              int distanceSquared() => x * x + y * y;
            }
            
            int calculateDistance(int x, int y) {
              var p = Point(x, y);
              return p.distanceSquared();
            }
          ''',
          name: 'calculateDistance',
          positionalArgs: [3, 4],
        );
        expect(result, equals(25)); // 3^2 + 4^2 = 9 + 16 = 25
      });

      test('I-FUNC-29: Should handle class with named constructor and arguments. [2026-02-10 06:37] (PASS)', () {
        final result = d4rt.execute(
          source: '''
            class Rectangle {
              int width;
              int height;
              Rectangle(this.width, this.height);
              Rectangle.square(int size) : width = size, height = size;
              
              int area() => width * height;
            }
            
            int computeArea(int w, int h, {bool isSquare = false}) {
              var rect = isSquare ? Rectangle.square(w) : Rectangle(w, h);
              return rect.area();
            }
          ''',
          name: 'computeArea',
          positionalArgs: [5, 10],
          namedArgs: {'isSquare': false},
        );
        expect(result, equals(50)); // 5 * 10
      });

      test('I-FUNC-30: Should handle static method call with arguments. [2026-02-10 06:37] (PASS)', () {
        final result = d4rt.execute(
          source: '''
            class Calculator {
              static int multiply(int a, int b) => a * b;
            }
            
            int useCalculator(int x, int y) {
              return Calculator.multiply(x, y);
            }
          ''',
          name: 'useCalculator',
          positionalArgs: [7, 8],
        );
        expect(result, equals(56));
      });

      test('I-FUNC-31: Should handle class with getters and setters. [2026-02-10 06:37] (PASS)', () {
        final result = d4rt.execute(
          source: '''
            class Counter {
              int _value = 0;
              
              int get value => _value;
              set value(int v) => _value = v;
              
              void increment() => _value++;
            }
            
            int manipulateCounter(int initial, int increments) {
              var counter = Counter();
              counter.value = initial;
              for (int i = 0; i < increments; i++) {
                counter.increment();
              }
              return counter.value;
            }
          ''',
          name: 'manipulateCounter',
          positionalArgs: [10, 5],
        );
        expect(result, equals(15)); // 10 + 5
      });

      test('I-FUNC-32: Should handle inheritance with arguments. [2026-02-10 06:37] (PASS)', () {
        final result = d4rt.execute(
          source: '''
            class Animal {
              String name;
              Animal(this.name);
              String speak() => "...";
            }
            
            class Dog extends Animal {
              Dog(String name) : super(name);
              String speak() => "\$name says: Woof!";
            }
            
            String makeSpeak(String dogName) {
              var dog = Dog(dogName);
              return dog.speak();
            }
          ''',
          name: 'makeSpeak',
          positionalArgs: ['Buddy'],
        );
        expect(result, equals('Buddy says: Woof!'));
      });
    });
  });
}
