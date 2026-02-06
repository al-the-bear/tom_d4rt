/// Tests for bugs discovered via dart_overview examples
///
/// These bugs were found when running the dart_overview examples
/// through D4rt and comparing with native Dart execution.
///
/// Bug IDs: Bug-79 through Bug-99
///
/// These tests assert the CORRECT behavior. When the bug exists, tests FAIL.
/// When the bug is fixed, tests PASS.
library;

import 'dart:async';

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// Execute D4rt code synchronously, returning the result or throwing.
dynamic execute(String source) {
  final d4rt = D4rt()..setDebug(false);
  d4rt.grant(FilesystemPermission.any);
  d4rt.grant(NetworkPermission.any);
  d4rt.grant(ProcessRunPermission.any);
  d4rt.grant(IsolatePermission.any);
  return d4rt.execute(
    library: 'package:test/main.dart',
    sources: {'package:test/main.dart': source},
  );
}

/// Execute D4rt code with multiple source files.
dynamic executeMulti(Map<String, String> sources, {String library = 'package:test/main.dart', bool debug = false}) {
  final d4rt = D4rt()..setDebug(debug);
  d4rt.grant(FilesystemPermission.any);
  d4rt.grant(NetworkPermission.any);
  d4rt.grant(ProcessRunPermission.any);
  d4rt.grant(IsolatePermission.any);
  return d4rt.execute(
    library: library,
    sources: sources,
  );
}

/// Execute D4rt code asynchronously.
Future<dynamic> executeAsync(String source) async {
  final d4rt = D4rt()..setDebug(false);
  d4rt.grant(FilesystemPermission.any);
  d4rt.grant(NetworkPermission.any);
  d4rt.grant(ProcessRunPermission.any);
  d4rt.grant(IsolatePermission.any);

  final result = d4rt.execute(
    library: 'package:test/main.dart',
    sources: {'package:test/main.dart': source},
  );

  if (result is Future) {
    return await result;
  }
  return result;
}

void main() {
  // ============================================================
  // OPEN BUGS - PENDING
  // Known issues that should be fixed - tests FAIL until fixed
  // ============================================================

  group('Open Bugs - Pending (SHOULD FAIL)', () {
    // Bug-79: Switch expression not exhaustive for sealed subclass with object pattern
    test('Bug-79: Switch expression should match sealed subclass with object pattern', () {
      final result = execute('''
sealed class Shape {}
class Circle extends Shape {
  final double radius;
  Circle(this.radius);
}
class Square extends Shape {
  final double side;
  Square(this.side);
}

double calculateArea(Shape shape) {
  return switch (shape) {
    Circle(:var radius) => 3.14159 * radius * radius,
    Square(:var side) => side * side,
  };
}

double main() {
  var circle = Circle(5.0);
  return calculateArea(circle);
}
''');
      // Should return the calculated area (78.53975)
      expect(result, closeTo(78.54, 0.01));
    });

    // Bug-80: Cascade on property access fails (..members.add)
    test('Bug-80: Cascade should work on property access (..members.add)', () {
      final result = execute('''
class Team {
  String name = '';
  List<String> members = [];
}

List<String> main() {
  var team = Team()
    ..name = 'Engineering'
    ..members.add('Alice')
    ..members.add('Bob');
  return team.members;
}
''');
      expect(result, equals(['Alice', 'Bob']));
    });

    // Bug-81: LogicalAndPatternImpl - when guards with object patterns
    // The AST represents "pattern when condition" as LogicalAndPatternImpl
    test('Bug-81: Pattern with when guard should work (LogicalAndPatternImpl)', () {
      final result = execute('''
class Person {
  final String name;
  final int age;
  Person(this.name, this.age);
}

String main() {
  var person = Person('Charlie', 25);
  if (person case Person(name: var n, age: var a) when a >= 18) {
    return 'Adult: \$n';
  }
  return 'Minor';
}
''');
      expect(result, equals('Adult: Charlie'));
    });

    // Bug-82: Function.call method not found on InterpretedFunction
    test('Bug-82: Function.call() should work on interpreted functions', () {
      final result = execute('''
int main() {
  var fn = (int x) => x * 2;
  return fn.call(5);
}
''');
      expect(result, equals(10));
    });

    // Bug-83: Nullable function?.call() fails
    test('Bug-83: Nullable function?.call() should work', () {
      final result = execute('''
String main() {
  void Function()? onClick;
  String result = 'not called';
  onClick = () => result = 'called';
  onClick?.call();
  return result;
}
''');
      expect(result, equals('called'));
    });

    // Bug-84: Mixin abstract method satisfaction false positive
    test('Bug-84: Mixin should satisfy abstract method from superclass', () {
      final result = execute('''
abstract class Movable {
  void move();
}

mixin CanWalk on Movable {
  @override
  void move() => print('Walking');
}

class Robot extends Movable with CanWalk {}

String main() {
  var robot = Robot();
  robot.move();
  return 'success';
}
''');
      expect(result, equals('success'));
    });

    // Bug-85: Cannot extend abstract final class in same library
    test('Bug-85: Should extend abstract final class in same library', () {
      final result = execute('''
abstract final class AbstractFinalClass {
  void doSomething();
}

class ConcreteImpl extends AbstractFinalClass {
  @override
  void doSomething() => print('Done');
}

String main() {
  var impl = ConcreteImpl();
  impl.doSomething();
  return 'success';
}
''');
      expect(result, equals('success'));
    });

    // Bug-86: runtimeType not accessible via PrefixedIdentifier
    test('Bug-86: runtimeType should be accessible in string interpolation', () {
      final result = execute('''
class Wrapper<T> {
  final T value;
  Wrapper(this.value);
}

String main() {
  var w = Wrapper<int>(42);
  return 'Type: \${w.runtimeType}';
}
''');
      expect(result, contains('Wrapper'));
    });

    // Bug-87: Map for-in comprehension fails with MapLiteralEntry error
    test('Bug-87: Map for-in comprehension should work', () {
      final result = execute('''
Map<int, String> main() {
  var items = ['a', 'b', 'c'];
  return {for (var i = 0; i < items.length; i++) i: items[i]};
}
''');
      expect(result, equals({0: 'a', 1: 'b', 2: 'c'}));
    });

    // Bug-88: Record pattern with :name shorthand - name lexeme is null
    test('Bug-88: Record pattern with :name shorthand should work', () {
      final result = execute('''
String main() {
  var (:name, :age) = (name: 'Charlie', age: 35);
  return 'name=\$name, age=\$age';
}
''');
      expect(result, equals('name=Charlie, age=35'));
    });

    // Bug-89: Enum.values.byName (List.byName) not bridged
    test('Bug-89: Enum.values.byName should find enum value', () {
      final result = execute('''
enum Color { red, green, blue }

String main() {
  var color = Color.values.byName('green');
  return color.name;
}
''');
      expect(result, equals('green'));
    });

    // Bug-90: Mixin on constraint abstract getter false positive
    test('Bug-90: Mixin on constraint with getter should not require impl', () {
      final result = execute('''
abstract class Named {
  String get name;
}

mixin Greetable on Named {
  String greet() => 'Hello, \$name';
}

class Person extends Named with Greetable {
  @override
  final String name;
  Person(this.name);
}

String main() {
  var p = Person('Alice');
  return p.greet();
}
''');
      expect(result, equals('Hello, Alice'));
    });

    // Bug-91: Extensions on bridged types from imported file fails
    // Extension defined in same file works, but imported extension fails
    test('Bug-91: Imported extensions on bridged types should work', () {
      final result = executeMulti({
        'package:test/main.dart': '''
import 'package:test/extensions.dart';

String main() {
  var name = 'hello world';
  return name.capitalize();
}
''',
        'package:test/extensions.dart': '''
extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return '\${this[0].toUpperCase()}\${substring(1)}';
  }
}
''',
      });
      expect(result, equals('Hello world'));
    });

    // Bug-92: await on Future factory constructor with callback
    // Future(() => ...) returns BridgedInstance<Object> instead of Future
    test('Bug-92: await on Future factory constructor should work', () async {
      final result = await executeAsync('''
Future<String> main() async {
  var computed = Future(() {
    return 'Computed value';
  });
  return await computed;
}
''');
      expect(result, equals('Computed value'));
    });

    // Bug-93: int not auto-promoted to double in return type
    // In Dart, int values are implicitly promoted to double when the return type is double
    test('Bug-93: Int should be implicitly promoted to double return type', () {
      final result = execute('''
double foo(int x) {
  return x;
}
double main() {
  return foo(5);
}
''');
      expect(result, equals(5.0));
    });

    // Bug-94: Cascade index assignment on property fails
    // ..headers['Content-Type'] = 'application/json' should work
    test('Bug-94: Cascade index assignment on property should work', () {
      final result = execute('''
class Request {
  String url = '';
  Map<String, String> headers = {};
}

Map<String, String> main() {
  var req = Request()
    ..url = 'https://example.com'
    ..headers['Content-Type'] = 'application/json'
    ..headers['Accept'] = 'text/html';
  return req.headers;
}
''');
      expect(result, equals({'Content-Type': 'application/json', 'Accept': 'text/html'}));
    });

    // Bug-95: List.forEach with native function tear-off fails
    // list.forEach(print) passes a native function reference that isn't InterpretedFunction
    test('Bug-95: List.forEach with native function tear-off should work', () {
      expect(
        () => execute('''
void main() {
  var numbers = [1, 2, 3];
  numbers.forEach(print);
}
'''),
        returnsNormally,
      );
    });

    // Bug-96: super.name constructor parameter forwarding fails
    // Child(super.name) should forward the argument to Parent(this.name)
    test('Bug-96: super.name constructor parameter forwarding should work', () {
      final result = execute('''
class Parent {
  final String name;
  Parent(this.name);
}

class Child extends Parent {
  Child(super.name);
}

String main() {
  return Child('test').name;
}
''');
      expect(result, equals('test'));
    });

    // Bug-97: num not recognized as satisfying Comparable bound
    // num implements Comparable<num> in Dart, but D4rt rejects it
    test('Bug-97: num should satisfy Comparable type bound', () {
      final result = execute('''
class Box<T extends Comparable<dynamic>> {
  T value;
  Box(this.value);
}

int main() {
  var b = Box<num>(42);
  return b.value.toInt();
}
''');
      expect(result, equals(42));
    });

    // Bug-98: Extension getter on bridged List<int> not resolved
    // Extension methods defined on List<int> should work on native List instances
    test('Bug-98: Extension getter on bridged List should work', () {
      final result = execute('''
extension IntListExt on List<int> {
  int get sum => fold(0, (a, b) => a + b);
  double get average => isEmpty ? 0.0 : sum / length;
}

double main() {
  var numbers = [1, 2, 3, 4, 5];
  return numbers.average;
}
''');
      expect(result, equals(3.0));
    });

    // Bug-99: Stream.handleError callback receives wrong number of arguments
    // handleError passes too many args to the error handler function
    test('Bug-99: Stream handleError callback should receive correct args', () async {
      final result = await executeAsync('''
import 'dart:async';

Future<List<String>> main() async {
  var results = <String>[];
  var stream = Stream.fromIterable([1, 2, 3]).map((n) {
    if (n == 2) throw 'Error at \$n';
    return n;
  });
  var handled = stream.handleError((e) {
    results.add('Handled: \$e');
  });
  await for (var n in handled) {
    results.add('Value: \$n');
  }
  return results;
}
''');
      expect(result, equals(['Value: 1', 'Handled: Error at 2', 'Value: 3']));
    });
  });
}
