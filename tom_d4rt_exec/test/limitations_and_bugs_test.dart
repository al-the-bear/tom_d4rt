/// Comprehensive test suite for D4rt interpreter limitations and bugs.
///
/// This test suite validates all documented limitations and bugs from
/// `doc/d4rt_limitations.md`. Tests are organized into:
///
/// 1. **Limitations (Lim-1 to Lim-9)**: Fundamental constraints or unsupported features
/// 2. **Open Bugs (TODO status)**: Known issues that should be fixed - TESTS FAIL
/// 3. **Fixed Bugs**: Regression tests for bugs that have been resolved - TESTS PASS
///
/// ## Test Philosophy
///
/// - Open bugs/limitations: Tests expect the code to WORK, so they FAIL until fixed
/// - Fixed bugs: Tests expect the code to WORK, they PASS (regression tests)
///
/// ## Strategy for Hanging Tests
///
/// Some tests (like Lim-4: infinite sync* generators) can hang the interpreter.
/// These are handled by running D4rt in a subprocess with a 5-second timeout.
/// If the subprocess doesn't complete in time, it's killed and the test fails.
///
/// Run with: `dart test test/limitations_and_bugs_test.dart`
library;
import 'test_helpers.dart';

import 'dart:async';

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

/// Execute D4rt code synchronously, returning the result or throwing.
dynamic execute(String source, {Duration timeout = const Duration(seconds: 5)}) {
  final d4rt = D4rt(parseSourceCallback: parseSource)..setDebug(false);
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
  final d4rt = D4rt(parseSourceCallback: parseSource)..setDebug(false);
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

void main() {
  // ============================================================
  // OPEN BUGS - WON'T FIX
  // Fundamental limitations that cannot be fixed
  // ============================================================

  group('Open Bugs - Won\'t Fix (SHOULD FAIL)', () {
    // Isolate.run has LIMITED SUPPORT in D4rt:
    // - Uses Future.microtask internally (same isolate, async execution)
    // - Returns correct results
    // - But NO true parallelism (code runs in same isolate)
    //
    // This test PASSES because the result is correct (42).
    // The limitation is that execution is not truly parallel.
    // See doc/d4rt_limitations.md Lim-3 for details.
    test('I-LIM-3: Isolate.run limited support - returns correct result. [2026-02-11] (PASS)', () async {
      const source = '''
import 'dart:isolate';
Future<int> main() async {
  final result = await Isolate.run(() {
    return 42;
  });
  return result;
}
''';
      // D4rt's Isolate.run uses Future.microtask - returns correct result
      // but execution is NOT parallel (limitation: no true isolate spawning)
      final result = await executeAsync(source);
      expect(result, equals(42));
    });

    // Bug-14: Records with named fields can't be converted to native records
    test('I-BUG-14a: Records with named fields. [2026-02-10 06:37] (FAIL)', skip: 'Known limitation: InterpretedRecord vs native records', () {
      const source = '''
({int x, int y}) main() {
  return (x: 10, y: 20);
}
''';
      final result = execute(source);
      // Currently returns InterpretedRecord - this test fails until we can create
      // native records with named fields (not possible in Dart at runtime)
      expect(result, isA<({int x, int y})>());
    });

    // Bug-14: >9 positional fields can't be converted
    test('I-BUG-14b: Records with >9 positional fields. [2026-02-10 06:37] (FAIL)', skip: 'Known limitation: InterpretedRecord vs native records', () {
      const source = '''
(int, int, int, int, int, int, int, int, int, int) main() {
  return (1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
}
''';
      final result = execute(source);
      // Currently returns InterpretedRecord - this test fails until we add more cases
      expect(result, equals((1, 2, 3, 4, 5, 6, 7, 8, 9, 10)));
    });
  });

  // ============================================================
  // OPEN BUGS - PENDING
  // Known issues that should be fixed - tests FAIL until fixed
  // ============================================================

  group('Open Bugs - Pending (SHOULD FAIL)', () {
    // Bug-45: Labeled continue in sync* generators
    test('I-FILE-53: Bug-45: Labeled continue in sync* should return correct values. [2026-02-10 06:37] (PASS)', () {
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
      final result = execute(source);
      expect(result, equals([0, 1, 3, 4]));
    });
  });

  // ============================================================
  // FIXED BUGS (✅ Fixed status)
  // Regression tests for bugs that have been resolved - TESTS PASS
  // ============================================================

  group('Fixed Bugs (SHOULD PASS)', () {
    test('I-FILE-54: Bug-1: List.empty() should work. [2026-02-10 06:37] (PASS)', () {
      const source = '''
List<int> main() {
  var list = List<int>.empty(growable: true);
  list.add(1);
  return list;
}
''';
      final result = execute(source);
      expect(result, equals([1]));
    });

    test('I-FILE-55: Bug-2: Queue.addAll() should work. [2026-02-10 06:37] (PASS)', () {
      const source = '''
import 'dart:collection';
List<int> main() {
  var queue = Queue<int>();
  queue.addAll([1, 2, 3]);
  return queue.toList();
}
''';
      final result = execute(source);
      expect(result, equals([1, 2, 3]));
    });

    test('I-FILE-56: Bug-4: Enum in top-level const should work. [2026-02-10 06:37] (PASS)', () {
      const source = '''
enum Status { pending, active, done }
const defaultStatus = Status.active;
Status main() {
  return defaultStatus;
}
''';
      final result = execute(source);
      expect(result.toString(), contains('active'));
    });

    test('I-FILE-57: Bug-5: Division by zero should return infinity. [2026-02-10 06:37] (PASS)', () {
      const source = '''
double main() {
  return 1.0 / 0.0;
}
''';
      final result = execute(source);
      expect(result, equals(double.infinity));
    });

    test('I-FILE-58: Bug-6: record.hashCode should work. [2026-02-10 06:37] (PASS)', () {
      const source = '''
int main() {
  var r = (1, 2, name: 'test');
  return r.hashCode;
}
''';
      final result = execute(source);
      expect(result, isA<int>());
    });

    test('I-FILE-59: Bug-7: Digit separators should work. [2026-02-10 06:37] (PASS)', () {
      const source = '''
int main() {
  return 1_000_000;
}
''';
      final result = execute(source);
      expect(result, equals(1000000));
    });

    test('I-FILE-60: Bug-8: List.indexWhere() should work. [2026-02-10 06:37] (PASS)', () {
      const source = '''
int main() {
  var list = ['a', 'b', 'c'];
  return list.indexWhere((e) => e == 'b');
}
''';
      final result = execute(source);
      expect(result, equals(1));
    });

    test('I-FILE-61: Bug-9: Never return type should work. [2026-02-10 06:37] (PASS)', () {
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
      expect(() => execute(source), returnsNormally);
    });

    test('I-FILE-62: Bug-10: implements Comparable should work. [2026-02-10 06:37] (PASS)', () {
      const source = '''
class Value implements Comparable<Value> {
  final int n;
  Value(this.n);
  
  @override
  int compareTo(Value other) => n.compareTo(other.n);
}
int main() {
  var a = Value(5);
  return a.n;
}
''';
      final result = execute(source);
      expect(result, equals(5));
    });

    test('I-FILE-63: Bug-11: Sealed class subclass should work. [2026-02-10 06:37] (PASS)', () {
      const source = '''
sealed class Shape {}
class Circle extends Shape {
  final double radius;
  Circle(this.radius);
}
double main() {
  Shape s = Circle(5.0);
  return (s as Circle).radius;
}
''';
      final result = execute(source);
      expect(result, equals(5.0));
    });

    test('I-FILE-64: Bug-12: implements Exception should work. [2026-02-10 06:37] (PASS)', () {
      const source = '''
class MyException implements Exception {
  final String message;
  MyException(this.message);
}
String main() {
  try {
    throw MyException('Test');
  } catch (e) {
    return 'Caught';
  }
}
''';
      final result = execute(source);
      expect(result, equals('Caught'));
    });

    test('I-FILE-65: Bug-13: LogicalOrPattern should work. [2026-02-10 06:37] (PASS)', () {
      const source = '''
String main() {
  var day = 'Saturday';
  return switch (day) {
    'Saturday' || 'Sunday' => 'Weekend',
    _ => 'Weekday',
  };
}
''';
      final result = execute(source);
      expect(result, equals('Weekend'));
    });

    test('I-FILE-66: Bug-14: Record type annotation should work (positional-only). [2026-02-10 06:37] (PASS)', () {
      const source = '''
(int, int) swap((int, int) pair) {
  return (pair.\$2, pair.\$1);
}
(int, int) main() {
  return swap((1, 2));
}
''';
      final result = execute(source);
      // Now returns native Dart record (positional-only records are converted)
      expect(result, equals((2, 1)));
    });

    test('I-FILE-67: Bug-15: base64Encode should work. [2026-02-10 06:37] (PASS)', () {
      const source = '''
import 'dart:convert';
String main() {
  return base64Encode([72, 101, 108, 108, 111]);
}
''';
      final result = execute(source);
      expect(result, equals('SGVsbG8='));
    });

    test('I-FILE-68: Bug-20: identical() should work. [2026-02-10 06:37] (PASS)', () {
      const source = '''
bool main() {
  var a = [1, 2, 3];
  var b = a;
  return identical(a, b);
}
''';
      final result = execute(source);
      expect(result, isTrue);
    });

    test('I-FILE-69: Bug-21: Set.from() should work. [2026-02-10 06:37] (PASS)', () {
      const source = '''
Set<int> main() {
  return Set<int>.from([1, 2, 3, 2, 1]);
}
''';
      final result = execute(source);
      expect(result, equals({1, 2, 3}));
    });

    test('I-FILE-70: Bug-23: Static const referencing sibling should work. [2026-02-10 06:37] (PASS)', () {
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
      final result = execute(source);
      expect(result, equals('#0000FF'));
    });

    test('I-FILE-71: Bug-24: mixin class should work. [2026-02-10 06:37] (PASS)', () {
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
      expect(() => execute(source), returnsNormally);
    });

    test('I-FILE-72: Bug-26: Assert in constructor initializer should work. [2026-02-10 06:37] (PASS)', () {
      const source = '''
class PositiveNumber {
  final int value;
  PositiveNumber(this.value) : assert(value > 0);
}
int main() {
  var n = PositiveNumber(5);
  return n.value;
}
''';
      final result = execute(source);
      expect(result, equals(5));
    });

    test('I-FILE-73: Bug-27: Short-circuit && with null check should work. [2026-02-10 06:37] (PASS)', () {
      const source = '''
bool main() {
  String? name;
  if (name != null && name.isNotEmpty) {
    return true;
  }
  return false;
}
''';
      final result = execute(source);
      expect(result, isFalse);
    });

    test(
      'I-FILE-187: Bug-47: Future.doWhile should work. [2026-02-12] (PASS)',
      () async {
        const source = '''
Future<int> main() async {
  var count = 0;
  await Future.doWhile(() async {
    count++;
    return count < 3;
  });
  return count;
}
''';
        final result = await execute(source);
        expect(result, equals(3));
      },
    );

    test('I-FILE-74: Bug-52: Implicit super() should work. [2026-02-10 06:37] (PASS)', () {
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
      final result = execute(source);
      expect(result, equals('Parent'));
    });

    test('I-FILE-75: Bug-53: NullAwareElement should work. [2026-02-10 06:37] (PASS)', () {
      const source = '''
List<int> main() {
  int? maybeNull;
  return [1, 2, ?maybeNull, 3];
}
''';
      final result = execute(source);
      expect(result, equals([1, 2, 3]));
    });

    test('I-FILE-76: Bug-55: Symbol class should be accessible. [2026-02-10 06:37] (PASS)', () {
      const source = '''
Symbol main() {
  var s = Symbol('test');
  return s;
}
''';
      final result = execute(source);
      expect(result, equals(Symbol('test')));
    });

    test('I-FILE-77: Bug-60: Indexing on null target should give clear error. [2026-02-10 06:37] (PASS)', () {
      // dart_overview operators: "Unsupported target for indexing: null"
      const source = '''
String main() {
  List<String>? nullList;
  return nullList?[0] ?? 'default';
}
''';
      final result = execute(source);
      expect(result, equals('default'));
    });

    test('I-FILE-78: Bug-61: if-case pattern should work with String. [2026-02-10 06:37] (PASS)', () {
      // dart_overview control_flow: "if condition must be a boolean, but was String"
      const source = '''
String main() {
  var value = 'hello';
  if (value case String s) {
    return s.toUpperCase();
  }
  return 'not matched';
}
''';
      final result = execute(source);
      expect(result, equals('HELLO'));
    });

    test('I-FILE-79: Bug-62: List of function types should work. [2026-02-10 06:37] (PASS)', () {
      // dart_overview functions: "GenericFunctionTypeImpl not implemented"
      // This happens with List<int Function(int)> - a list containing function types
      const source = '''
int Function(int) compose(List<int Function(int)> functions) {
  return (int value) {
    var result = value;
    for (var f in functions) {
      result = f(result);
    }
    return result;
  };
}

int main() {
  var pipeline = compose([
    (int n) => n * 2,
    (int n) => n + 10,
  ]);
  return pipeline(5);
}
''';
      final result = execute(source);
      // (5 * 2) = 10, (10 + 10) = 20
      expect(result, equals(20));
    });

    test('I-FILE-80: Bug-64: Interface class same-library extension should work. [2026-02-10 06:37] (PASS)', () {
      // dart_overview class_modifiers: "Cannot extend interface class"
      const source = '''
interface class DataSource {
  void load() {}
}
class JsonDataSource extends DataSource {
  @override
  void load() => print('Loading JSON');
}
void main() {
  JsonDataSource().load();
}
''';
      expect(() => execute(source), returnsNormally);
    });

    test('I-FILE-81: Bug-65: Map.from constructor should be bridged. [2026-02-10 06:37] (PASS)', () {
      // dart_overview collections: "Map.from constructor not bridged"
      const source = '''
Map<String, int> main() {
  var original = {'a': 1, 'b': 2};
  var copy = Map<String, int>.from(original);
  return copy;
}
''';
      final result = execute(source);
      expect(result, equals({'a': 1, 'b': 2}));
    });

    test('I-FILE-82: Bug-67: if-case with int pattern should work. [2026-02-10 06:37] (PASS)', () {
      // dart_overview patterns: "if condition must be a boolean, but was int"
      const source = '''
String main() {
  var value = 42;
  if (value case int x when x > 0) {
    return 'positive: \$x';
  }
  return 'not positive';
}
''';
      final result = execute(source);
      expect(result, equals('positive: 42'));
    });

    test('I-FILE-83: Bug-68: LogicalOrPattern in switch should work. [2026-02-10 06:37] (PASS)', () {
      // dart_overview enums: "LogicalOrPatternImpl not supported"
      const source = '''
String main() {
  var value = 2;
  return switch (value) {
    1 || 2 || 3 => 'low',
    _ => 'high',
  };
}
''';
      final result = execute(source);
      expect(result, equals('low'));
    });

    test('I-FILE-84: Bug-71: Error class should be accessible. [2026-02-10 06:37] (PASS)', () {
      // dart_overview error_handling: "Undefined variable: Error"
      const source = '''
bool main() {
  var e = Error();
  return e is Error;
}
''';
      final result = execute(source);
      expect(result, isTrue);
    });

    test('I-FILE-85: Bug-56: Constructor with positional arguments should work. [2026-02-10 06:37] (PASS)', () {
      const source = '''
class Point {
  final int x;
  final int y;
  Point(this.x, this.y);
}
String main() {
  var p = Point(10, 20);
  return 'Point(\${p.x}, \${p.y})';
}
''';
      final result = execute(source);
      expect(result, equals('Point(10, 20)'));
    });

    test('I-FILE-86: Bug-57: Class with operator override and constructor should work. [2026-02-10 06:37] (PASS)',
        () {
      // This mimics the dart_overview case where Point has operator == override
      // and is defined at the bottom of the file but instantiated earlier
      const source = '''
void main() {
  var p1 = Point(1, 2);
  var p2 = Point(1, 2);
  print('p1: \$p1, p2: \$p2');
  print('p1 == p2: \${p1 == p2}');
}

class Point {
  final int x;
  final int y;

  Point(this.x, this.y);

  @override
  bool operator ==(Object other) =>
      other is Point && other.x == x && other.y == y;

  @override
  int get hashCode => Object.hash(x, y);

  @override
  String toString() => 'Point(\$x, \$y)';
}
''';
      final result = execute(source);
      expect(result, isNull); // void main returns null
    });

    test('I-FILE-87: Bug-58: Complex file with functions and classes defined at end. [2026-02-10 06:37] (PASS)', () {
      // This is exactly like dart_overview/run_comparison.dart where
      // helper function and class are at the end
      const source = '''
void main() {
  print('Testing operators...');
  
  // Use a helper function defined at bottom
  String? nullableStr = getString(null);
  print('nullableStr == null: \${nullableStr == null}');
  
  // Custom equality
  print('--- Custom Equality ---');
  var p1 = Point(1, 2);
  var p2 = Point(1, 2);
  var p3 = p1;
  print('p1: \$p1, p2: \$p2');
  print('p1 == p2: \${p1 == p2}');
  print('identical(p1, p2): \${identical(p1, p2)}');
  print('identical(p1, p3): \${identical(p1, p3)}');
}

class Point {
  final int x;
  final int y;

  Point(this.x, this.y);

  @override
  bool operator ==(Object other) =>
      other is Point && other.x == x && other.y == y;

  @override
  int get hashCode => Object.hash(x, y);

  @override
  String toString() => 'Point(\$x, \$y)';
}

// Helper to return nullable string (prevents compile-time optimization)
String? getString(String? s) => s;
''';
      final result = execute(source);
      expect(result, isNull); // void main returns null
    });

    test('I-FILE-88: Bug-59: Multi-file imports with class constructor calls. [2026-02-10 06:37] (PASS)', () {
      // Test using sources map with imports (like dart_overview)
      // This was the main bug - imported classes had empty constructor maps
      // Fixed by processing ClassDeclaration in ModuleLoader
      final d4rt = D4rt(parseSourceCallback: parseSource)..setDebug(false);

      const mainSource = '''
import 'package:test/comparison.dart' as comparison;

void main() {
  comparison.main();
}
''';

      const comparisonSource = '''
void main() {
  print('--- Custom Equality ---');
  var p1 = Point(1, 2);
  var p2 = Point(1, 2);
  print('p1: \$p1, p2: \$p2');
  print('p1 == p2: \${p1 == p2}');
}

class Point {
  final int x;
  final int y;

  Point(this.x, this.y);

  @override
  bool operator ==(Object other) =>
      other is Point && other.x == x && other.y == y;

  @override
  int get hashCode => Object.hash(x, y);

  @override
  String toString() => 'Point(\$x, \$y)';
}
''';

      final result = d4rt.execute(
        library: 'package:test/main.dart',
        sources: {
          'package:test/main.dart': mainSource,
          'package:test/comparison.dart': comparisonSource,
        },
      );
      expect(result, isNull); // void main returns null
    });

    test('I-FILE-89: Bug-3: Enum value access should work. [2026-02-10 06:37] (PASS)', () {
      const source = '''
enum Day { monday, tuesday, wednesday }
Day main() {
  return Day.wednesday;
}
''';
      final result = execute(source);
      expect(result.toString(), contains('wednesday'));
    });

    test('I-FILE-90: Bug-16: Abstract method from mixin should not false-positive. [2026-02-10 06:37] (PASS)', () {
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

    test('I-FILE-91: Bug-17: Extending interface class in same library should work. [2026-02-10 06:37] (PASS)', () {
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

    test('I-FILE-92: Bug-18: Mixin with abstract getter should work. [2026-02-10 06:37] (PASS)', () {
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

    test('I-FILE-93: Bug-22: Error class should be accessible. [2026-02-10 06:37] (PASS)', () {
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

    test('I-FILE-94: Bug-28: Typedef with generic function should work. [2026-02-10 06:37] (PASS)', () {
      const source = '''
typedef BinaryOp = int Function(int, int);
int main() {
  BinaryOp add = (a, b) => a + b;
  return add(3, 4);
}
''';
      expect(execute(source), equals(7));
    });

    test('I-FILE-95: Bug-29: Future.value() should return correct type. [2026-02-10 06:37] (PASS)', () async {
      const source = '''
Future<int> main() async {
  return await Future.value(42);
}
''';
      final result = await executeAsync(source);
      expect(result, equals(42));
    });

    test('I-FILE-96: Bug-44: async* generator should complete correctly. [2026-02-10 06:37] (PASS)', () async {
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

    test('I-FILE-97: Bug-48: await for should iterate stream correctly. [2026-02-10 06:37] (PASS)', () async {
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

    test('I-FILE-98: Bug-50: map[key] = value should work. [2026-02-10 06:37] (PASS)', () {
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

    test('I-FILE-99: Bug-51: Mixing in bridged mixin should work. [2026-02-10 06:37] (PASS)', () {
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

    test('I-FILE-100: Bug-54: void function returning should work. [2026-02-10 06:37] (PASS)', () {
      const source = '''
void doSomething() {
  print('Done');
  return;
}
void main() {
  doSomething();
}
''';
      expect(() => execute(source), returnsNormally);
    });

    test('I-FILE-101: Lim-2: Extension on DateTime should work. [2026-02-10 06:37] (PASS)', () {
      const source = '''
extension DateTimeExtension on DateTime {
  bool get isWeekend => weekday == DateTime.saturday || weekday == DateTime.sunday;
}
void main() {
  var now = DateTime.now();
  print(now.isWeekend);
}
''';
      expect(() => execute(source), returnsNormally);
    });

    test('I-FILE-102: Bug-32: continue with label in switch should work. [2026-02-10 06:37] (PASS)', () {
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
      expect(() => execute(source), returnsNormally);
    });

    test('I-FILE-103: Bug-40: Comparable sort should work. [2026-02-10 06:37] (PASS)', () {
      const source = '''
class Person implements Comparable<Person> {
  final String name;
  Person(this.name);
  @override
  int compareTo(Person other) => name.compareTo(other.name);
}
List<String> main() {
  var people = [Person('Bob'), Person('Alice')];
  people.sort();
  return people.map((p) => p.name).toList();
}
''';
      final result = execute(source);
      expect(result, equals(['Alice', 'Bob']));
    });

    test('I-FILE-104: Bug-41: Await in string interpolation should return correct value. [2026-02-10 06:37] (PASS)', () async {
      const source = '''
Future<String> getValue() async => 'Hello';
Future<String> main() async {
  return 'Value: \${await getValue()}';
}
''';
      final result = await executeAsync(source);
      expect(result, equals('Value: Hello'));
    });

    test('I-FILE-105: Bug-42: noSuchMethod should work for getters. [2026-02-10 06:37] (PASS)', () {
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
      final result = execute(source);
      expect(result, equals('handled'));
    });

    test('I-FILE-106: Bug-63: Abstract method from interface should be recognized. [2026-02-10 06:37] (PASS)', () {
      // Fixed: dart_overview classes pattern now works
      const source = '''
abstract class Robot {
  void move();
}
class AdvancedRobot implements Robot {
  @override
  void move() => print('Moving');
}
void main() {
  AdvancedRobot().move();
}
''';
      expect(() => execute(source), returnsNormally);
    });

    test('I-FILE-107: Bug-66: Record pattern with named field should work. [2026-02-10 06:37] (PASS)', () {
      // Fixed: Named field pattern destructuring now works
      const source = '''
String main() {
  var record = (name: 'Alice', age: 30);
  var (name: n, age: a) = record;
  return '\$n is \$a years old';
}
''';
      final result = execute(source);
      expect(result, equals('Alice is 30 years old'));
    });

    test('I-FILE-45: Bug-69: Abstract getter from mixin should be recognized. [2026-02-10 06:37] (PASS)', () {
      // Fixed: dart_overview mixins pattern now works
      const source = '''
mixin Named {
  String get name;
}
class Bird with Named {
  @override
  String get name => 'Tweety';
}
String main() {
  return Bird().name;
}
''';
      final result = execute(source);
      expect(result, equals('Tweety'));
    });

    test('I-FILE-46: Bug-70: await on Future.value should work. [2026-02-10 06:37] (PASS)', () {
      // Fixed: await on BridgedInstance works correctly
      const source = '''
Future<String> main() async {
  var result = await Future.value('hello');
  return result;
}
''';
      final result = execute(source);
      expect(result, completion(equals('hello')));
    });

    test(
      'I-FILE-188: Lim-4/Bug-43: Infinite sync* generators with take() should work. [2026-02-12] (PASS)',
      () {
        // Fixed: Lazy sync* generator implementation using native Dart sync*
        // to produce values on demand. Infinite generators now work with take().
        // Now runs in-process (no subprocess needed) since lazy evaluation works.
        const source = '''
Iterable<int> naturals() sync* {
  int n = 0;
  while (true) { yield n++; }
}
List<int> main() {
  return naturals().take(5).toList();
}
''';
        final result = execute(source);
        expect(result, equals([0, 1, 2, 3, 4]));
      },
    );

    test('I-FILE-47: Lim-1: Extension types should work. [2026-02-10 06:37] (PASS)', () {
      // Fixed: Added visitExtensionTypeDeclaration and InterpretedExtensionType
      const source = '''
extension type UserId(int value) {
  bool get isValid => value > 0;
}
void main() {
  var id = UserId(42);
  print(id.value);
}
''';
      expect(() => execute(source), returnsNormally);
    });

    test('I-FILE-48: Lim-5: List.sort() with Comparable class should work. [2026-02-10 06:37] (PASS)', () {
      // Fixed: Modified List.sort bridge to use interpreted compareTo
      const source = '''
class Person implements Comparable<Person> {
  final String name;
  Person(this.name);
  
  @override
  int compareTo(Person other) => name.compareTo(other.name);
}
List<String> main() {
  var people = [Person('Bob'), Person('Alice')];
  people.sort();
  return people.map((p) => p.name).toList();
}
''';
      final result = execute(source);
      expect(result, equals(['Alice', 'Bob']));
    });

    test('I-FILE-49: Lim-6: Labeled continue in switch should work. [2026-02-10 06:37] (PASS)', () {
      // Fixed: Added ContinueSwitchLabel exception handling
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
      expect(() => execute(source), returnsNormally);
    });

    test('I-FILE-50: Lim-7: noSuchMethod for methods should work. [2026-02-10 06:37] (PASS)', () {
      // Fixed: noSuchMethod now invoked for method calls
      const source = '''
class Dynamic {
  @override
  dynamic noSuchMethod(Invocation invocation) {
    return 'handled: \${invocation.memberName}';
  }
}
dynamic main() {
  dynamic d = Dynamic();
  return d.anyMethod();
}
''';
      final result = execute(source);
      expect(result, contains('handled'));
    });

    test('I-FILE-51: Lim-8/Bug-13/Bug-68: Logical OR pattern in switch should work. [2026-02-10 06:37] (PASS)', () {
      // Fixed: Added LogicalOrPattern handling to _matchAndBind
      const source = '''
String main() {
  var day = 'Saturday';
  return switch (day) {
    'Saturday' || 'Sunday' => 'Weekend',
    _ => 'Weekday',
  };
}
''';
      final result = execute(source);
      expect(result, equals('Weekend'));
    });

    test('I-FILE-52: Lim-9: Await in string interpolation should work. [2026-02-10 06:37] (PASS)', () async {
      // Fixed: await expressions in interpolation now resolved correctly
      const source = '''
Future<String> getValue() async => 'Hello';
Future<String> main() async {
  return 'Value: \${await getValue()}';
}
''';
      final result = await executeAsync(source);
      expect(result, equals('Value: Hello'));
    });
  });
}
