/// Dart Overview D4rt Interpreter Failure Tests
///
/// Isolated test cases for each D4rt interpreter failure found in the
/// `dart_overview` example project. Each test reproduces a specific
/// interpreter limitation with a minimal code snippet.
///
/// These failures were identified by running all 20 Dart Overview areas
/// through the D4rt interpreter (run_overview_in_d4rt.dart). 10 of 20 areas
/// fail. The root causes fall into 7 distinct categories:
///
/// | # | Area            | Root Cause                                      |
/// |---|-----------------|------------------------------------------------|
/// | 1 | operators        | AdjacentStrings with StringInterpolation        |
/// | 2 | control_flow     | LogicalAndPattern not implemented               |
/// | 3 | functions        | Constructor tear-offs (Class.new)               |
/// | 4 | classes          | Abstract method check ignores grandparent chain |
/// | 5 | class_modifiers  | Switch case pattern variable scoping            |
/// | 6 | generics         | Type bound check for user Comparable<T>         |
/// | 7 | patterns         | LogicalAndPattern (same as #2)                  |
/// | 8 | mixins           | Abstract method check with mixin chain          |
/// | 9 | extensions       | Extensions on nullable types (on T?)            |
/// |10 | async            | await-for loop variable declaration             |
// ignore_for_file: file_names
// ignore_for_file: unintended_html_in_doc_comment
@TestOn('vm')
@Timeout(Duration(minutes: 2))
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';
import 'package:tom_d4rt_exec/tom_d4rt.dart';

/// Path to the dart_overview example directory.
final _overviewDir = p.join(
  Directory.current.path,
  'example',
  'd4',
  'lib',
  'src',
  'dart_overview',
);

/// Execute a D4rt source string and return the result.
///
/// Throws on interpreter errors so tests can catch them.
dynamic _execute(String source) {
  final d4rt = D4rt()..setDebug(false);
  return d4rt.execute(
    library: 'package:test/main.dart',
    sources: {'package:test/main.dart': source},
  );
}

/// Execute an overview area script file and return the result.
ScriptExecutionResult _executeArea(String area) {
  final d4rt = D4rt()..setDebug(false);
  d4rt.grant(FilesystemPermission.any);
  d4rt.grant(IsolatePermission.any);
  final runnerFile = p.join(_overviewDir, area, 'run_$area.dart');
  return executeFile(d4rt, runnerFile);
}

void main() {
  // =========================================================================
  // 1. OPERATORS: AdjacentStrings with StringInterpolation
  // =========================================================================

  group('DOV: Dart Overview Interpreter Failures', () {
    group('String Interpolation in Adjacent Strings', () {
      test(
          'G-DOV-1: Adjacent strings with interpolation. '
          '[2026-02-10 12:00] (FAIL)', () {
        // D4rt throws: "Type de StringLiteral non géré: StringInterpolationImpl"
        // when AdjacentStrings contain StringInterpolation children.
        final result = _execute(r'''
          main() {
            var name = 'World';
            var greeting = 'Hello $name '
                'how are you?';
            return greeting;
          }
        ''');
        expect(result, equals('Hello World how are you?'));
      });

      test(
          'G-DOV-2: Multi-line adjacent string with multiple interpolations. '
          '[2026-02-10 12:00] (FAIL)', () {
        final result = _execute(r'''
          main() {
            var table = 'users';
            var col = 'name';
            var query = 'SELECT $col '
                'FROM $table '
                'WHERE id = 1';
            return query;
          }
        ''');
        expect(result, equals('SELECT name FROM users WHERE id = 1'));
      });
    });

    // =========================================================================
    // 2. CONTROL_FLOW / 7. PATTERNS: LogicalAndPattern
    // =========================================================================

    group('LogicalAndPattern in switch/case', () {
      test(
          'G-DOV-3: Relational AND pattern in switch expression. '
          '[2026-02-10 12:00] (FAIL)', () {
        // D4rt throws: "Pattern type not yet supported: LogicalAndPatternImpl"
        final result = _execute(r'''
          main() {
            int n = 3;
            var result = switch (n) {
              >= 1 && <= 5 => 'in range',
              _ => 'out of range',
            };
            return result;
          }
        ''');
        expect(result, equals('in range'));
      });

      test(
          'G-DOV-4: LogicalAnd pattern in if-case statement. '
          '[2026-02-10 12:00] (FAIL)', () {
        final result = _execute(r'''
          main() {
            var number = 15;
            if (number case > 10 && < 20) {
              return 'in range';
            }
            return 'out of range';
          }
        ''');
        expect(result, equals('in range'));
      });
    });

    // =========================================================================
    // 3. FUNCTIONS: Constructor tear-offs
    // =========================================================================

    group('Constructor Tear-offs', () {
      test(
          'G-DOV-5: Constructor tear-off with Class.new. '
          '[2026-02-10 12:00] (FAIL)', () {
        // D4rt throws: "Undefined static member 'new' on class 'Person'"
        final result = _execute(r'''
          class Person {
            final String name;
            Person(this.name);
            @override
            String toString() => 'Person($name)';
          }

          main() {
            var names = ['Alice', 'Bob'];
            var people = names.map(Person.new).toList();
            return people.length;
          }
        ''');
        expect(result, equals(2));
      });
    });

    // =========================================================================
    // 4. CLASSES / 8. MIXINS: Abstract method inheritance chain validation
    // =========================================================================

    group('Abstract Method Inheritance Chain', () {
      test(
          'G-DOV-6: Grandchild class inherits abstract method override. '
          '[2026-02-10 12:00] (FAIL)', () {
        // D4rt throws: "Missing concrete implementation for inherited
        // abstract method 'move' in class 'AdvancedRobot'"
        // because it only checks the direct parent, not the full chain.
        final result = _execute(r'''
          abstract class Machine {
            void move();
          }

          class Robot extends Machine {
            @override
            String move() => 'Robot moving';
          }

          class AdvancedRobot extends Robot {
            String doExtra() => 'extra';
          }

          main() {
            var robot = AdvancedRobot();
            return robot.move();
          }
        ''');
        expect(result, equals('Robot moving'));
      });

      test(
          'G-DOV-7: Mixin chain with abstract method inherited from parent. '
          '[2026-02-10 12:00] (FAIL)', () {
        // D4rt throws: "Missing concrete implementation for inherited
        // abstract method 'move' in class 'Eagle'"
        final result = _execute(r'''
          abstract class Animal {
            void move();
          }

          class Bird extends Animal {
            @override
            String move() => 'Bird moves';
          }

          mixin Flying on Animal {
            String fly() => 'flying';
          }

          class Eagle extends Bird with Flying {
            Eagle();
          }

          main() {
            var eagle = Eagle();
            return [eagle.move(), eagle.fly()];
          }
        ''');
        expect(result, equals(['Bird moves', 'flying']));
      });
    });

    // =========================================================================
    // 5. CLASS_MODIFIERS: Switch case pattern variable scoping
    // =========================================================================

    group('Switch Case Pattern Variable Scoping', () {
      test(
          'G-DOV-8: Sealed class switch statement pattern variable scoping. '
          '[2026-02-10 12:00] (FAIL)', () async {
        // D4rt throws: "Undefined variable: m" when the second switch case
        // in a statement binds a new variable not present in the first case.
        // Only manifests when running the full area file through executeFile.
        final result = _executeArea('class_modifiers');
        expect(result.success, isTrue,
            reason: 'class_modifiers area should execute without errors: '
                '${result.error}');
      });
    });

    // =========================================================================
    // 6. GENERICS: Type bound check for user-defined Comparable<T>
    // =========================================================================

    group('Generic Type Bound Checking', () {
      test(
          'G-DOV-9: User class implementing Comparable satisfies bound. '
          '[2026-02-10 12:00] (FAIL)', () {
        // D4rt throws: "Type argument 'Person' for type parameter 'T'
        // does not satisfy bound 'Comparable' in class 'SortedList'"
        // Core types like num/String pass, but user-defined classes fail.
        final result = _execute(r'''
          class SortedList<T extends Comparable<dynamic>> {
            final List<T> items = [];
            void add(T item) {
              items.add(item);
              items.sort();
            }
          }

          class Person implements Comparable<Person> {
            final String name;
            Person(this.name);

            @override
            int compareTo(Person other) => name.compareTo(other.name);

            @override
            String toString() => name;
          }

          main() {
            var list = SortedList<Person>();
            list.add(Person('Charlie'));
            list.add(Person('Alice'));
            list.add(Person('Bob'));
            return list.items.map((p) => p.toString()).toList();
          }
        ''');
        expect(result, equals(['Alice', 'Bob', 'Charlie']));
      });
    });

    // =========================================================================
    // 9. EXTENSIONS: Extensions on nullable types
    // =========================================================================

    group('Extensions on Nullable Types', () {
      test(
          'G-DOV-10: Extension method on nullable List type (on List<T>?). '
          '[2026-02-10 12:00] (FAIL)', () {
        // D4rt throws: "Cannot access property 'orEmpty' on target of type null"
        // because it doesn't resolve extensions declared with nullable receiver.
        final result = _execute(r'''
          extension NullableListExt<T> on List<T>? {
            List<T> get orEmpty => this ?? [];
            bool get isNullOrEmpty => this == null || this!.isEmpty;
          }

          main() {
            List<String>? items;
            return items.orEmpty;
          }
        ''');
        expect(result, equals([]));
      });

      test(
          'G-DOV-11: Extension on nullable String. '
          '[2026-02-10 12:00] (FAIL)', () {
        final result = _execute(r'''
          extension NullableStringExt on String? {
            String get orEmpty => this ?? '';
            bool get isNullOrBlank => this == null || this!.trim().isEmpty;
          }

          main() {
            String? name;
            return name.isNullOrBlank;
          }
        ''');
        expect(result, equals(true));
      });
    });

    // =========================================================================
    // 10. ASYNC: await-for loop variable declaration
    // =========================================================================

    group('Await-for Loop Variable Declaration', () {
      test(
          'G-DOV-12: await for with var declaration in stream loop. '
          '[2026-02-10 12:00] (FAIL)', () async {
        // D4rt throws: "Assigning to undefined variable 'number'"
        // because the loop variable declaration in await-for is not
        // properly scoped in the state machine.
        final result = _execute(r'''
          import 'dart:async';

          Future<List<int>> collectStream() async {
            var results = <int>[];
            var numberStream = Stream.fromIterable([1, 2, 3, 4, 5]);
            await for (var number in numberStream) {
              results.add(number);
            }
            return results;
          }

          main() async {
            return await collectStream();
          }
        ''');
        if (result is Future) {
          final resolved = await result;
          expect(resolved, equals([1, 2, 3, 4, 5]));
        } else {
          expect(result, equals([1, 2, 3, 4, 5]));
        }
      });
    });
  });
}
