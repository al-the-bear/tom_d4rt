import 'test_helpers.dart';
import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

Object? execute(String source) {
  final interpreter = D4rt(parseSourceCallback: parseSource);
  return interpreter.execute(source: source);
}

void main() {
  group('Late keyword tests', () {
    test('I-LATE-2: Late variable declaration without initialization. [2026-02-10 06:37] (PASS)', () {
      final code = '''
        main() {
          late String name;
          name = "Hello";
          return name;
        }
      ''';
      expect(execute(code), equals("Hello"));
    });

    test('I-LATE-9: Late variable with lazy initialization. [2026-02-10 06:37] (PASS)', () {
      final code = '''
        String expensiveComputation() {
          print("Computing...");
          return "Expensive result";
        }
        
        main() {
          late String result = expensiveComputation();
          // Should not compute until accessed
          return result; // This should trigger computation
        }
      ''';
      expect(execute(code), equals("Expensive result"));
    });

    test('I-LATE-20: Late final variable. [2026-02-10 06:37] (PASS)', () {
      final code = '''
        main() {
          late final String name;
          name = "Hello";
          return name;
        }
      ''';
      expect(execute(code), equals("Hello"));
    });

    test('I-LATE-26: Late instance field. [2026-02-10 06:37] (PASS)', () {
      final code = '''
        class Person {
          late String name;
          
          void setName(String n) {
            name = n;
          }
          
          String getName() {
            return name;
          }
        }
        
        main() {
          var person = Person();
          person.setName("Alice");
          return person.getName();
        }
      ''';
      expect(execute(code), equals("Alice"));
    });

    test('I-LATE-32: Late static field. [2026-02-10 06:37] (PASS)', () {
      final code = '''
        class Config {
          static late String appName;
          
          static void init() {
            appName = "MyApp";
          }
        }
        
        main() {
          Config.init();
          return Config.appName;
        }
      ''';
      expect(execute(code), equals("MyApp"));
    });

    test('I-LATE-33: Accessing uninitialized late variable should throw. [2026-02-10 06:37] (PASS)', () {
      final code = '''
        main() {
          late String name;
          return name;
        }
      ''';
      expect(() => execute(code), throwsA(isA<RuntimeD4rtException>()));
    });

    test('I-LATE-1: Late variable with lazy initialization only called once. [2026-02-10 06:37] (PASS)', () {
      final code = '''
        int callCount = 0;
        
        String expensiveComputation() {
          callCount++;
          return "Result \$callCount";
        }
        
        main() {
          late String result = expensiveComputation();
          
          // Access multiple times
          String first = result;
          String second = result;
          
          return [first, second, callCount];
        }
      ''';
      final result = execute(code) as List;
      expect(result[0], equals("Result 1"));
      expect(result[1], equals("Result 1")); // Same result
      expect(result[2], equals(1)); // Only called once
    });

    test('I-LATE-3: Late final variable reassignment should throw. [2026-02-10 06:37] (PASS)', () {
      final code = '''
        main() {
          late final String name;
          name = "First";
          name = "Second"; // Should throw LateInitializationError
          return name;
        }
      ''';
      expect(() => execute(code), throwsA(isA<LateInitializationError>()));
    });

    test('I-LATE-4: Late final variable with initializer reassignment should throw. [2026-02-10 06:37] (PASS)', () {
      final code = '''
        main() {
          late final String name = "Initial";
          var first = name; // Triggers initialization
          name = "Second"; // Should throw LateInitializationError
          return name;
        }
      ''';
      expect(() => execute(code), throwsA(isA<LateInitializationError>()));
    });

    test('I-LATE-5: Late variable in constructor parameter. [2026-02-10 06:37] (PASS)', () {
      final code = '''
        class User {
          late String email;
          
          User(String e) {
            email = e;
          }
          
          String getEmail() {
            return email;
          }
        }
        
        main() {
          var user = User("test@example.com");
          return user.getEmail();
        }
      ''';
      expect(execute(code), equals("test@example.com"));
    });

    test('I-LATE-6: Late instance field with lazy initialization. [2026-02-10 06:37] (PASS)', () {
      final code = '''
        class DataProcessor {
          late String processedData = computeData();
          
          String computeData() {
            return "Processed: \${DateTime.now().millisecondsSinceEpoch}";
          }
          
          String getData() {
            return processedData;
          }
        }
        
        main() {
          var processor = DataProcessor();
          var data = processor.getData();
          return data.startsWith("Processed: ");
        }
      ''';
      expect(execute(code), equals(true));
    });

    test('I-LATE-7: Late static field with lazy initialization. [2026-02-10 06:37] (PASS)', () {
      final code = '''
        class Settings {
          static late String config = loadConfig();
          
          static String loadConfig() {
            return "default-config";
          }
          
          static String getConfig() {
            return config;
          }
        }
        
        main() {
          return Settings.getConfig();
        }
      ''';
      expect(execute(code), equals("default-config"));
    });

    test('I-LATE-8: Late variable with complex expression initializer. [2026-02-10 06:37] (PASS)', () {
      final code = '''
        List<String> createList() {
          return ["a", "b", "c"];
        }
        
        main() {
          late List<String> items = createList();
          return items.length;
        }
      ''';
      expect(execute(code), equals(3));
    });

    test('I-LATE-10: Late variable with null value. [2026-02-10 06:37] (PASS)', () {
      final code = '''
        main() {
          late String? nullableString;
          nullableString = null;
          return nullableString;
        }
      ''';
      expect(execute(code), equals(null));
    });

    test('I-LATE-11: Late variable in function scope. [2026-02-10 06:37] (PASS)', () {
      final code = '''
        String processInFunction() {
          late String result;
          result = "function-scope";
          return result;
        }
        
        main() {
          return processInFunction();
        }
      ''';
      expect(execute(code), equals("function-scope"));
    });

    test('I-LATE-12: Late variable with conditional assignment. [2026-02-10 06:37] (PASS)', () {
      final code = '''
        main() {
          bool condition = true;
          late String message;
          
          if (condition) {
            message = "condition-true";
          } else {
            message = "condition-false";
          }
          
          return message;
        }
      ''';
      expect(execute(code), equals("condition-true"));
    });

    test('I-LATE-13: Multiple late variables in same declaration. [2026-02-10 06:37] (PASS)', () {
      final code = '''
        main() {
          late String first, second;
          first = "one";
          second = "two";
          return [first, second];
        }
      ''';
      final result = execute(code) as List;
      expect(result[0], equals("one"));
      expect(result[1], equals("two"));
    });

    test('I-LATE-14: Late variable with compound assignment. [2026-02-10 06:37] (PASS)', () {
      final code = '''
        main() {
          late int counter = 5;
          counter += 10;
          return counter;
        }
      ''';
      expect(execute(code), equals(15));
    });

    test('I-LATE-15: Late variable accessing other late variable. [2026-02-10 06:37] (PASS)', () {
      final code = '''
        main() {
          late String base = "hello";
          late String derived = base + " world";
          return derived;
        }
      ''';
      expect(execute(code), equals("hello world"));
    });

    test('I-LATE-16: Late variable in loop. [2026-02-10 06:37] (PASS)', () {
      final code = '''
        main() {
          var results = <String>[];
          for (int i = 0; i < 3; i++) {
            late String item = "item-\$i";
            results.add(item);
          }
          return results;
        }
      ''';
      final result = execute(code) as List;
      expect(result, equals(["item-0", "item-1", "item-2"]));
    });

    test('I-LATE-17: Late variable with recursive initialization. [2026-02-10 06:37] (PASS)', () {
      final code = '''
        int fibonacci(int n) {
          if (n <= 1) return n;
          return fibonacci(n - 1) + fibonacci(n - 2);
        }
        
        main() {
          late int fib10 = fibonacci(10);
          return fib10;
        }
      ''';
      expect(execute(code), equals(55));
    });

    test('I-LATE-18: Late static final field. [2026-02-10 06:37] (PASS)', () {
      final code = '''
        class Constants {
          static late final String appVersion = computeVersion();
          
          static String computeVersion() {
            return "1.0.0";
          }
          
          static String getVersion() {
            return appVersion;
          }
        }
        
        main() {
          return Constants.getVersion();
        }
      ''';
      expect(execute(code), equals("1.0.0"));
    });

    test('I-LATE-19: Late static final field reassignment should throw. [2026-02-10 06:37] (PASS)', () {
      final code = '''
        class Constants {
          static late final String appVersion;
          
          static void setVersion(String version) {
            appVersion = version;
          }
          
          static void resetVersion() {
            appVersion = "reset"; // Should throw on second assignment
          }
        }
        
        main() {
          Constants.setVersion("1.0.0");
          Constants.resetVersion(); // This should throw
          return Constants.appVersion;
        }
      ''';
      expect(() => execute(code), throwsA(isA<RuntimeD4rtException>()));
    });

    test('I-LATE-21: Late instance final field. [2026-02-10 06:37] (PASS)', () {
      final code = '''
        class ImmutableData {
          late final String id;
          
          ImmutableData(String identifier) {
            id = identifier;
          }
          
          String getId() {
            return id;
          }
        }
        
        main() {
          var data = ImmutableData("abc123");
          return data.getId();
        }
      ''';
      expect(execute(code), equals("abc123"));
    });

    test('I-LATE-22: Late instance final field reassignment should throw. [2026-02-10 06:37] (PASS)', () {
      final code = '''
        class ImmutableData {
          late final String id;
          
          void setId(String identifier) {
            id = identifier;
          }
          
          void resetId() {
            id = "reset"; // Should throw if already set
          }
          
          String getId() {
            return id;
          }
        }
        
        main() {
          var data = ImmutableData();
          data.setId("first");
          try {
            data.resetId(); // This should throw
            return "no-error";
          } catch (e) {
            return "error-caught";
          }
        }
      ''';
      expect(execute(code), equals("error-caught"));
    });

    test('I-LATE-23: Late variable with exception in initializer. [2026-02-10 06:37] (PASS)', () {
      final code = '''
        String throwingFunction() {
          throw "Initializer failed";
        }
        
        main() {
          late String result = throwingFunction();
          try {
            return result; // Should propagate the exception
          } catch (e) {
            return "caught-error";
          }
        }
      ''';
      expect(execute(code), equals("caught-error"));
    });

    test('I-LATE-24: Late variable assignment in try-catch. [2026-02-10 06:37] (PASS)', () {
      final code = '''
        main() {
          late String result;
          
          try {
            result = "success";
          } catch (e) {
            result = "error";
          }
          
          return result;
        }
      ''';
      expect(execute(code), equals("success"));
    });

    test('I-LATE-25: Late variable with getter/setter pattern. [2026-02-10 06:37] (PASS)', () {
      final code = '''
        class DataContainer {
          late String _data;
          
          String get data => _data;
          
          set data(String value) {
            _data = value.toUpperCase();
          }
        }
        
        main() {
          var container = DataContainer();
          container.data = "hello";
          return container.data;
        }
      ''';
      expect(execute(code), equals("HELLO"));
    });

    test('I-LATE-27: Late top-level variable. [2026-02-10 06:37] (PASS)', () {
      final code = '''
        late String globalConfig;
        
        void initializeGlobal() {
          globalConfig = "global-value";
        }
        
        main() {
          initializeGlobal();
          return globalConfig;
        }
      ''';
      expect(execute(code), equals("global-value"));
    });

    test('I-LATE-28: Late top-level variable with initializer. [2026-02-10 06:37] (PASS)', () {
      final code = '''
        String computeGlobal() {
          return "computed-global";
        }
        
        late String globalData = computeGlobal();
        
        main() {
          return globalData;
        }
      ''';
      expect(execute(code), equals("computed-global"));
    });

    test('I-LATE-29: Late variable circular dependency should work. [2026-02-10 06:37] (PASS)', () {
      final code = '''
        class CircularTest {
          static late String first = "First: " + getSecond();
          static late String second = "Second";
          
          static String getFirst() {
            return first;
          }
          
          static String getSecond() {
            return second;
          }
        }
        
        main() {
          return CircularTest.getFirst();
        }
      ''';
      expect(execute(code), equals("First: Second"));
    });

    test('I-LATE-30: Late variable with separate class access. [2026-02-10 06:37] (PASS)', () {
      final code = '''
        class Outer {
          static late String outerData = "outer";
          
          static String getOuterData() {
            return outerData;
          }
        }
        
        class Inner {
          static late String innerData = Outer.getOuterData() + "-inner";
          
          static String getInnerData() {
            return innerData;
          }
        }
        
        main() {
          return Inner.getInnerData();
        }
      ''';
      expect(execute(code), equals("outer-inner"));
    });

    test('I-LATE-31: Late variable with async-like pattern. [2026-02-10 06:37] (PASS)', () {
      final code = '''
        String simulateAsync() {
          // Simulate some computation
          return "async-result";
        }
        
        main() {
          late String result = simulateAsync();
          
          // Do other work first
          var other = "other-work";
          
          // Now access the late variable
          return result + "-" + other;
        }
      ''';
      expect(execute(code), equals("async-result-other-work"));
    });
  });
}
