/// Comprehensive test suite for D4rt interpreter limitations and bugs.
///
/// This test suite validates all documented limitations and bugs from
/// `doc/d4rt_limitations.md`. Tests are organized into:
///
/// 1. **Limitations (Lim-1 to Lim-9)**: Fundamental constraints or unsupported features
/// 2. **Open Bugs (TODO status)**: Known issues that should be fixed
/// 3. **Fixed Bugs**: Regression tests for bugs that have been resolved
///
/// ## Strategy for Hanging Tests
///
/// Some tests (like Lim-4: infinite sync* generators) can hang the interpreter.
/// These are handled by:
/// - Using `timeout` on individual tests (default 5 seconds)
/// - Skipping truly blocking tests with a `skip` reason
/// - For async tests, using `Future.timeout()` as backup
///
/// Run with: `dart test test/limitations_and_bugs_test.dart`
library;

import 'dart:async';

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// Execute D4rt code synchronously, returning the result or throwing.
dynamic execute(String source, {Duration timeout = const Duration(seconds: 5)}) {
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

/// Execute D4rt code asynchronously with timeout support.
Future<dynamic> executeAsync(
  String source, {
  Duration timeout = const Duration(seconds: 5),
}) async {
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
    return await result.timeout(timeout);
  }
  return result;
}

/// Matcher for RuntimeError with specific message pattern.
Matcher throwsRuntimeError(dynamic messageMatcher) {
  return throwsA(
    isA<RuntimeError>().having((e) => e.message, 'message', messageMatcher),
  );
}

/// Matcher for any error (RuntimeError, SourceCodeException, etc.)
Matcher throwsD4rtError() {
  return throwsA(anyOf(isA<RuntimeError>(), isA<SourceCodeException>()));
}

void main() {
  // ============================================================
  // LIMITATIONS (Lim-1 to Lim-9)
  // Fundamental constraints or intentionally unsupported features
  // ============================================================

  group('Limitations', () {
    group('Lim-1: Extension types (Dart 3.3+) not supported', () {
      test('extension type declaration should fail', () {
        const source = '''
extension type UserId(int value) {
  bool get isValid => value > 0;
}
void main() {
  var id = UserId(42);
  print(id.value);
}
''';
        expect(() => execute(source), throwsD4rtError());
      });
    });

    group('Lim-2: Extensions on bridged types fail', () {
      test('extension on DateTime should fail', () {
        const source = '''
extension DateTimeExtension on DateTime {
  bool get isWeekend => weekday == DateTime.saturday || weekday == DateTime.sunday;
}
void main() {
  var now = DateTime.now();
  print(now.isWeekend);
}
''';
        expect(() => execute(source), throwsD4rtError());
      });

      test('extension on String (bridged) actually works - String is special', () {
        const source = '''
extension StringExtension on String {
  String get doubled => this + this;
}
void main() {
  var s = 'hello';
  print(s.doubled);
}
''';
        // String extensions work because String is handled specially
        expect(() => execute(source), returnsNormally);
      });
    });

    group('Lim-3: Isolate execution with interpreted code', () {
      test('Isolate.run with interpreted closure should fail', () async {
        const source = '''
import 'dart:isolate';
void main() async {
  final result = await Isolate.run(() {
    return 42;
  });
  print(result);
}
''';
        // Throws ArgumentError because interpreted closures can't be serialized
        expect(() async => await executeAsync(source), throwsA(isA<ArgumentError>()));
      });
    });

    group('Lim-4: Infinite sync* generators hang', () {
      // SKIP: This test would hang the test runner.
      // The interpreter evaluates sync* generators eagerly, so infinite
      // generators never complete. Use subprocess execution for actual testing.
      test(
        'infinite generator should hang (SKIPPED - would block test runner)',
        () {
          // Source code for reference - not executed due to hang risk:
          // Iterable<int> naturals() sync* {
          //   int n = 0;
          //   while (true) { yield n++; }
          // }
          // void main() { print(naturals().take(5).toList()); }
          fail('This test is skipped to prevent hanging');
        },
        skip: 'Infinite sync* generators hang the interpreter - tested via subprocess in d4rt_bugs/',
      );
    });

    group('Lim-5: Comparable interface not implemented', () {
      test('List.sort() with Comparable class should fail', () {
        const source = '''
class Person implements Comparable<Person> {
  final String name;
  Person(this.name);
  
  @override
  int compareTo(Person other) => name.compareTo(other.name);
}
void main() {
  var people = [Person('Bob'), Person('Alice')];
  people.sort();
  print(people.map((p) => p.name).toList());
}
''';
        expect(() => execute(source), throwsD4rtError());
      });
    });

    group('Lim-6: Labeled continue in switch statements', () {
      test('continue with label to another case should fail', () {
        const source = '''
void main() {
  switch (1) {
    case 1:
      print('One');
      continue two;
    two:
    case 2:
      print('Two');
      break;
  }
}
''';
        expect(() => execute(source), throwsD4rtError());
      });
    });

    group('Lim-7: noSuchMethod for getters not supported', () {
      test('noSuchMethod fails for BOTH methods and getters (limitation)', () {
        const source = '''
class Dynamic {
  @override
  dynamic noSuchMethod(Invocation invocation) {
    return 'handled';
  }
}
dynamic main() {
  dynamic d = Dynamic();
  return d.anyMethod();
}
''';
        // noSuchMethod doesn't work for methods either in current implementation
        expect(() => execute(source), throwsD4rtError());
      });

      test('noSuchMethod should fail for getters', () {
        const source = '''
class Dynamic {
  @override
  dynamic noSuchMethod(Invocation invocation) {
    return 'handled';
  }
}
dynamic main() {
  dynamic d = Dynamic();
  return d.someGetter;
}
''';
        expect(() => execute(source), throwsD4rtError());
      });
    });

    group('Lim-8: Logical OR patterns in switch cases', () {
      test('logical OR pattern should fail', () {
        const source = '''
String main() {
  var day = 'Saturday';
  return switch (day) {
    'Saturday' || 'Sunday' => 'Weekend',
    _ => 'Weekday',
  };
}
''';
        expect(() => execute(source), throwsD4rtError());
      });
    });

    group('Lim-9: Await in string interpolation', () {
      test('await in interpolation shows raw object (quirk, not crash)', () async {
        const source = '''
Future<String> getValue() async => 'Hello';
Future<String> main() async {
  return 'Value: \${await getValue()}';
}
''';
        // This doesn't crash but shows "Instance of 'AsyncSuspensionRequest'"
        // instead of the resolved value. We just verify it doesn't throw.
        final result = await executeAsync(source);
        expect(result, isA<String>());
      });
    });
  });

  // ============================================================
  // OPEN BUGS (⬜ TODO status)
  // Known issues that should be fixed
  // ============================================================

  group('Open Bugs (TODO)', () {
    group('Bug-1: List.empty() constructor not bridged', () {
      test('List.empty() should fail', () {
        const source = '''
void main() {
  var list = List<int>.empty(growable: true);
  list.add(1);
  print(list);
}
''';
        expect(() => execute(source), throwsD4rtError());
      });
    });

    group('Bug-2: Queue.addAll() method not bridged', () {
      test('Queue.addAll() should fail', () {
        const source = '''
import 'dart:collection';
void main() {
  var queue = Queue<int>();
  queue.addAll([1, 2, 3]);
  print(queue);
}
''';
        expect(() => execute(source), throwsD4rtError());
      });
    });

    group('Bug-5: Division by zero throws instead of infinity', () {
      test('1.0 / 0.0 should fail instead of returning infinity', () {
        const source = '''
double main() {
  return 1.0 / 0.0;
}
''';
        expect(() => execute(source), throwsD4rtError());
      });
    });

    group('Bug-6: Record missing Object methods (hashCode)', () {
      test('record.hashCode should fail', () {
        const source = '''
int main() {
  var r = (1, 2, name: 'test');
  return r.hashCode;
}
''';
        expect(() => execute(source), throwsD4rtError());
      });
    });

    group('Bug-7: Digit separators not parsed', () {
      test('1_000_000 should fail', () {
        const source = '''
int main() {
  return 1_000_000;
}
''';
        expect(() => execute(source), throwsD4rtError());
      });
    });

    group('Bug-8: List.indexWhere() method not bridged', () {
      test('list.indexWhere() should fail', () {
        const source = '''
int main() {
  var list = ['a', 'b', 'c'];
  return list.indexWhere((e) => e == 'b');
}
''';
        expect(() => execute(source), throwsD4rtError());
      });
    });

    group('Bug-9: Type Never not found', () {
      test('Never return type should fail', () {
        const source = '''
Never throwError() {
  throw Exception('Error');
}
void main() {
  try {
    throwError();
  } catch (e) {
    print('Caught');
  }
}
''';
        expect(() => execute(source), throwsD4rtError());
      });
    });

    group('Bug-10: Interface Comparable not found', () {
      test('implements Comparable should fail', () {
        const source = '''
class Value implements Comparable<Value> {
  final int n;
  Value(this.n);
  
  @override
  int compareTo(Value other) => n.compareTo(other.n);
}
void main() {
  var a = Value(5);
  print(a.n);
}
''';
        expect(() => execute(source), throwsD4rtError());
      });
    });

    group('Bug-11: Sealed class subclasses incorrectly rejected', () {
      test('extending sealed class in same library should fail', () {
        const source = '''
sealed class Shape {}
class Circle extends Shape {
  final double radius;
  Circle(this.radius);
}
void main() {
  Shape s = Circle(5.0);
  print(s);
}
''';
        expect(() => execute(source), throwsD4rtError());
      });
    });

    group('Bug-12: Interface Exception not found', () {
      test('implements Exception should fail', () {
        const source = '''
class MyException implements Exception {
  final String message;
  MyException(this.message);
}
void main() {
  try {
    throw MyException('Test');
  } catch (e) {
    print('Caught');
  }
}
''';
        expect(() => execute(source), throwsD4rtError());
      });
    });

    group('Bug-13: LogicalOrPattern not supported', () {
      test('pattern || in switch should fail', () {
        const source = '''
String main() {
  var day = 'Saturday';
  return switch (day) {
    'Saturday' || 'Sunday' => 'Weekend',
    _ => 'Weekday',
  };
}
''';
        expect(() => execute(source), throwsD4rtError());
      });
    });

    group('Bug-14: Record type annotation not resolved', () {
      test('(int, int) parameter type should fail', () {
        const source = '''
(int, int) swap((int, int) pair) {
  return (pair.\$2, pair.\$1);
}
void main() {
  var result = swap((1, 2));
  print(result);
}
''';
        expect(() => execute(source), throwsD4rtError());
      });
    });

    group('Bug-20: identical() function not bridged', () {
      test('identical() should fail', () {
        const source = '''
bool main() {
  var a = [1, 2, 3];
  var b = a;
  return identical(a, b);
}
''';
        expect(() => execute(source), throwsD4rtError());
      });
    });

    group('Bug-21: Set.from() constructor not bridged', () {
      test('Set.from() should fail', () {
        const source = '''
void main() {
  var set = Set<int>.from([1, 2, 3]);
  print(set);
}
''';
        expect(() => execute(source), throwsD4rtError());
      });
    });

    group('Bug-23: Static const referencing sibling const fails', () {
      test('static const = sibling should fail', () {
        const source = '''
class Colors {
  static const red = '#FF0000';
  static const blue = '#0000FF';
  static const defaultColor = blue;
}
String main() {
  return Colors.defaultColor;
}
''';
        expect(() => execute(source), throwsD4rtError());
      });
    });

    group('Bug-24: mixin class declaration not supported', () {
      test('mixin class should fail', () {
        const source = '''
mixin class Logger {
  void log(String msg) => print('[LOG] \$msg');
}
class Service with Logger {}
void main() {
  var s = Service();
  s.log('Hello');
}
''';
        expect(() => execute(source), throwsD4rtError());
      });
    });

    group('Bug-27: Short-circuit && with null check fails', () {
      test('null && property access should fail', () {
        const source = '''
bool main() {
  String? name;
  if (name != null && name.isNotEmpty) {
    return true;
  }
  return false;
}
''';
        expect(() => execute(source), throwsD4rtError());
      });
    });

    group('Bug-32: continue with label in switch (same as Lim-6)', () {
      test('continue label in switch should fail', () {
        const source = '''
void main() {
  switch (1) {
    case 1:
      print('One');
      continue two;
    two:
    case 2:
      print('Two');
  }
}
''';
        expect(() => execute(source), throwsD4rtError());
      });
    });

    group('Bug-40: Comparable sort (same as Lim-5)', () {
      test('sorting Comparable interpreted class should fail', () {
        const source = '''
class Person implements Comparable<Person> {
  final String name;
  Person(this.name);
  @override
  int compareTo(Person other) => name.compareTo(other.name);
}
void main() {
  var people = [Person('Bob'), Person('Alice')];
  people.sort();
}
''';
        expect(() => execute(source), throwsD4rtError());
      });
    });

    group('Bug-42: noSuchMethod getter (same as Lim-7)', () {
      test('noSuchMethod not invoked for getter access', () {
        const source = '''
class Flex {
  @override
  dynamic noSuchMethod(Invocation i) => 'handled';
}
dynamic main() {
  dynamic f = Flex();
  return f.anyProperty;
}
''';
        expect(() => execute(source), throwsD4rtError());
      });
    });

    group('Bug-43: Infinite sync* generator (same as Lim-4)', () {
      test(
        'infinite generator should hang (SKIPPED)',
        () {
          fail('Skipped to prevent hanging');
        },
        skip: 'Same as Lim-4 - tested via subprocess',
      );
    });
  });

  // ============================================================
  // FIXED BUGS (✅ Fixed status)
  // Regression tests for bugs that have been resolved
  // ============================================================

  group('Fixed Bugs (Regression Tests)', () {
    group('Bug-3: Enum value access (FIXED)', () {
      test('enum value access should work', () {
        const source = '''
enum Day { monday, tuesday, wednesday }
Day main() {
  return Day.wednesday;
}
''';
        final result = execute(source);
        expect(result.toString(), contains('wednesday'));
      });
    });

    group('Bug-4: Enum value at top-level const (NOT FIXED)', () {
      test('enum in top-level const should fail', () {
        const source = '''
enum Status { pending, active, done }
const defaultStatus = Status.active;
Status main() {
  return defaultStatus;
}
''';
        expect(() => execute(source), throwsD4rtError());
      });
    });

    group('Bug-15: base64Encode function (NOT FIXED)', () {
      test('base64Encode should fail', () {
        const source = '''
import 'dart:convert';
String main() {
  return base64Encode([72, 101, 108, 108, 111]);
}
''';
        expect(() => execute(source), throwsD4rtError());
      });
    });

    group('Bug-16: Abstract method inheritance (FIXED)', () {
      test('abstract method from mixin should not false-positive', () {
        const source = '''
abstract class Animal {
  void speak();
}
class Dog extends Animal {
  @override
  void speak() => print('Woof');
}
void main() {
  Dog().speak();
}
''';
        expect(() => execute(source), returnsNormally);
      });
    });

    group('Bug-17: Interface class same-library extension (FIXED)', () {
      test('extending interface class in same library should work', () {
        const source = '''
interface class Base {
  void doSomething() {}
}
class Derived implements Base {
  @override
  void doSomething() => print('Done');
}
void main() {
  Derived().doSomething();
}
''';
        expect(() => execute(source), returnsNormally);
      });
    });

    group('Bug-18: Mixin abstract getter inheritance (FIXED)', () {
      test('mixin with abstract getter should work', () {
        const source = '''
mixin Named {
  String get name;
  void greet() => print('Hello, \$name');
}
class Person with Named {
  @override
  final String name;
  Person(this.name);
}
void main() {
  Person('Alice').greet();
}
''';
        expect(() => execute(source), returnsNormally);
      });
    });

    group('Bug-22: Error() class constructor (FIXED)', () {
      test('Error class should be accessible', () {
        const source = '''
void main() {
  try {
    throw Error();
  } catch (e) {
    print('Caught Error');
  }
}
''';
        expect(() => execute(source), returnsNormally);
      });
    });

    group('Bug-26: Assert in constructor initializer (NOT FIXED)', () {
      test('assert in constructor should fail', () {
        const source = '''
class PositiveNumber {
  final int value;
  PositiveNumber(this.value) : assert(value > 0);
}
void main() {
  var n = PositiveNumber(5);
  print(n.value);
}
''';
        expect(() => execute(source), throwsD4rtError());
      });
    });

    group('Bug-28: GenericFunctionType (FIXED)', () {
      test('typedef with generic function should work', () {
        const source = '''
typedef BinaryOp = int Function(int, int);
int main() {
  BinaryOp add = (a, b) => a + b;
  return add(3, 4);
}
''';
        expect(execute(source), equals(7));
      });
    });

    group('Bug-29: Future.value() (FIXED)', () {
      test('Future.value() should return correct type', () async {
        const source = '''
Future<int> main() async {
  return await Future.value(42);
}
''';
        final result = await executeAsync(source);
        expect(result, equals(42));
      });
    });

    group('Bug-44: Async generators completion (FIXED)', () {
      test('async* generator should complete correctly', () async {
        const source = '''
Stream<int> countTo(int n) async* {
  for (int i = 1; i <= n; i++) {
    yield i;
  }
}
Future<List<int>> main() async {
  return await countTo(3).toList();
}
''';
        final result = await executeAsync(source);
        expect(result, equals([1, 2, 3]));
      });
    });

    group('Bug-45: Labeled continue in sync* generators (BROKEN)', () {
      test('continue with label in sync* returns empty list (bug)', () {
        const source = '''
Iterable<int> generateWithSkip() sync* {
  outer:
  for (int i = 0; i < 5; i++) {
    if (i == 2) continue outer;
    yield i;
  }
}
List<int> main() {
  return generateWithSkip().toList();
}
''';
        // Bug: returns empty list instead of [0, 1, 3, 4]
        final result = execute(source);
        expect(result, equals([])); // Wrong but current behavior
      });
    });

    group('Bug-47: Future.doWhile type cast (NOT FIXED)', () {
      test(
        'Future.doWhile throws uncatchable async error',
        () {
          // This test cannot be properly run because the error is thrown
          // in an async callback that escapes the test framework's error catching.
          // The bug is verified via the run_limitation_tests.dart runner.
        },
        skip: 'Error thrown in async callback escapes test framework - verified in d4rt_bugs/',
      );
    });

    group('Bug-48: await for stream iteration (FIXED)', () {
      test('await for should iterate stream correctly', () async {
        const source = '''
Future<int> main() async {
  int sum = 0;
  await for (var n in Stream.fromIterable([1, 2, 3])) {
    sum += n;
  }
  return sum;
}
''';
        final result = await executeAsync(source);
        expect(result, equals(6));
      });
    });

    group('Bug-50: Index assignment operator []= (FIXED)', () {
      test('map[key] = value should work', () {
        const source = '''
int main() {
  var map = <String, int>{};
  map['a'] = 1;
  map['b'] = 2;
  return map['a']! + map['b']!;
}
''';
        expect(execute(source), equals(3));
      });
    });

    group('Bug-51: Bridged mixins type resolution (FIXED)', () {
      test('mixing in bridged mixin should work', () {
        const source = '''
mixin Printable {
  void printMe() => print(this);
}
class Item with Printable {
  final String name;
  Item(this.name);
  @override
  String toString() => 'Item(\$name)';
}
void main() {
  Item('test').printMe();
}
''';
        expect(() => execute(source), returnsNormally);
      });
    });

    group('Bug-52: Implicit super() with constructors (NOT FIXED)', () {
      test('implicit super() should fail when parent has constructors', () {
        const source = '''
class Parent {
  final String name;
  Parent() : name = 'Parent';
}
class Child extends Parent {
  // Implicit super() call
}
String main() {
  return Child().name;
}
''';
        expect(() => execute(source), throwsD4rtError());
      });
    });

    group('Bug-53: NullAwareElement feature (NOT FIXED)', () {
      test('?element in list literal should fail', () {
        const source = '''
List<int> main() {
  int? maybeNull;
  return [1, 2, ?maybeNull, 3];
}
''';
        expect(() => execute(source), throwsD4rtError());
      });
    });

    group('Bug-54: Void return type checking (FIXED)', () {
      test('void function returning value should work', () {
        const source = '''
void doSomething() {
  print('Done');
  return; // explicit void return
}
void main() {
  doSomething();
}
''';
        expect(() => execute(source), returnsNormally);
      });
    });
  });
}
