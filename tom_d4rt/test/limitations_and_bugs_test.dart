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

import 'dart:async';
import 'dart:convert';
import 'dart:io';

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

/// Execute D4rt code in a subprocess with timeout.
/// Returns the result if successful within timeout, throws on timeout or error.
/// This is used for tests that might hang (infinite loops, etc).
Future<dynamic> executeInSubprocess(
  String source, {
  Duration timeout = const Duration(seconds: 5),
}) async {
  // Create a temporary Dart script that runs D4rt
  final tempDir = await Directory.systemTemp.createTemp('d4rt_test_');
  final scriptFile = File('${tempDir.path}/test_script.dart');

  // Get the path to the tom_d4rt package
  final packageRoot = Directory.current.path;

  final scriptContent = '''
import 'dart:convert';
import 'package:tom_d4rt/d4rt.dart';

void main() {
  final source = ${_escapeStringLiteral(source)};
  
  final d4rt = D4rt()..setDebug(false);
  d4rt.grant(FilesystemPermission.any);
  d4rt.grant(NetworkPermission.any);
  d4rt.grant(ProcessRunPermission.any);
  d4rt.grant(IsolatePermission.any);
  
  try {
    final result = d4rt.execute(
      library: 'package:test/main.dart',
      sources: {'package:test/main.dart': source},
    );
    
    if (result is Future) {
      result.then((value) {
        print('RESULT:\${jsonEncode(value)}');
      }).catchError((e) {
        print('ERROR:\$e');
      });
    } else {
      print('RESULT:\${jsonEncode(result)}');
    }
  } catch (e) {
    print('ERROR:\$e');
  }
}
''';

  await scriptFile.writeAsString(scriptContent);

  try {
    final process = await Process.start(
      'dart',
      ['run', '--packages=$packageRoot/.dart_tool/package_config.json', scriptFile.path],
      workingDirectory: packageRoot,
    );

    final stdoutBuffer = StringBuffer();
    final stderrBuffer = StringBuffer();

    process.stdout.transform(utf8.decoder).listen((data) => stdoutBuffer.write(data));
    process.stderr.transform(utf8.decoder).listen((data) => stderrBuffer.write(data));

    final completed = await process.exitCode.timeout(
      timeout,
      onTimeout: () {
        process.kill(ProcessSignal.sigkill);
        throw TimeoutException('Process timed out after \${timeout.inSeconds} seconds');
      },
    );

    final stdout = stdoutBuffer.toString();
    final stderr = stderrBuffer.toString();

    if (stdout.contains('RESULT:')) {
      final resultLine = stdout.split('\n').firstWhere((l) => l.startsWith('RESULT:'));
      final jsonStr = resultLine.substring(7);
      return jsonDecode(jsonStr);
    } else if (stdout.contains('ERROR:') || stderr.isNotEmpty) {
      throw Exception('Subprocess error: \$stdout\$stderr');
    } else if (completed != 0) {
      throw Exception('Process exited with code \$completed: \$stderr');
    }

    return null;
  } finally {
    await tempDir.delete(recursive: true);
  }
}

/// Escape a string for use as a Dart string literal
String _escapeStringLiteral(String s) {
  final escaped = s
      .replaceAll('\\', '\\\\')
      .replaceAll("'", "\\'")
      .replaceAll('\$', '\\\$')
      .replaceAll('\n', '\\n')
      .replaceAll('\r', '\\r');
  return "'''$escaped'''";
}

void main() {
  // ============================================================
  // LIMITATIONS (Lim-1 to Lim-9)
  // Fundamental constraints - tests FAIL to demonstrate limitations
  // ============================================================

  group('Limitations (SHOULD FAIL)', () {
    test('Lim-1: Extension types should work', () {
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

    test('Lim-2: Extension on DateTime should work', () {
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

    test('Lim-3: Isolate.run with interpreted closure should work', () async {
      const source = '''
import 'dart:isolate';
Future<int> main() async {
  final result = await Isolate.run(() {
    return 42;
  });
  return result;
}
''';
      final result = await executeAsync(source);
      expect(result, equals(42));
    });

    test(
      'Lim-4: Infinite sync* generators with take() should work',
      () async {
        const source = '''
Iterable<int> naturals() sync* {
  int n = 0;
  while (true) { yield n++; }
}
List<int> main() {
  return naturals().take(5).toList();
}
''';
        // Uses subprocess with 5s timeout - will timeout if hanging
        final result = await executeInSubprocess(source);
        expect(result, equals([0, 1, 2, 3, 4]));
      },
    );

    test('Lim-5: List.sort() with Comparable class should work', () {
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

    test('Lim-6: Labeled continue in switch should work', () {
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

    test('Lim-7: noSuchMethod for methods should work', () {
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

    test('Lim-8: Logical OR pattern in switch should work', () {
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

    test('Lim-9: Await in string interpolation should work', () async {
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

  // ============================================================
  // OPEN BUGS (⬜ TODO status)
  // Known issues that should be fixed - tests FAIL until fixed
  // ============================================================

  group('Open Bugs (SHOULD FAIL)', () {
    test('Bug-1: List.empty() should work', () {
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

    test('Bug-2: Queue.addAll() should work', () {
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

    test('Bug-4: Enum in top-level const should work', () {
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

    test('Bug-5: Division by zero should return infinity', () {
      const source = '''
double main() {
  return 1.0 / 0.0;
}
''';
      final result = execute(source);
      expect(result, equals(double.infinity));
    });

    test('Bug-6: record.hashCode should work', () {
      const source = '''
int main() {
  var r = (1, 2, name: 'test');
  return r.hashCode;
}
''';
      final result = execute(source);
      expect(result, isA<int>());
    });

    test('Bug-7: Digit separators should work', () {
      const source = '''
int main() {
  return 1_000_000;
}
''';
      final result = execute(source);
      expect(result, equals(1000000));
    });

    test('Bug-8: List.indexWhere() should work', () {
      const source = '''
int main() {
  var list = ['a', 'b', 'c'];
  return list.indexWhere((e) => e == 'b');
}
''';
      final result = execute(source);
      expect(result, equals(1));
    });

    test('Bug-9: Never return type should work', () {
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

    test('Bug-10: implements Comparable should work', () {
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

    test('Bug-11: Sealed class subclass should work', () {
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

    test('Bug-12: implements Exception should work', () {
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

    test('Bug-13: LogicalOrPattern should work', () {
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

    test('Bug-14: Record type annotation should work (positional-only)', () {
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

    // This test documents the limitation: named records can't be converted to native records
    test('Bug-14: Records with named fields should return native record', () {
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

    // This test documents the limitation: >9 positional fields can't be converted
    test('Bug-14: Records with >9 positional fields should return native record', () {
      const source = '''
(int, int, int, int, int, int, int, int, int, int) main() {
  return (1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
}
''';
      final result = execute(source);
      // Currently returns InterpretedRecord - this test fails until we add more cases
      expect(result, equals((1, 2, 3, 4, 5, 6, 7, 8, 9, 10)));
    });

    test('Bug-15: base64Encode should work', () {
      const source = '''
import 'dart:convert';
String main() {
  return base64Encode([72, 101, 108, 108, 111]);
}
''';
      final result = execute(source);
      expect(result, equals('SGVsbG8='));
    });

    test('Bug-20: identical() should work', () {
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

    test('Bug-21: Set.from() should work', () {
      const source = '''
Set<int> main() {
  return Set<int>.from([1, 2, 3, 2, 1]);
}
''';
      final result = execute(source);
      expect(result, equals({1, 2, 3}));
    });

    test('Bug-23: Static const referencing sibling should work', () {
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

    test('Bug-24: mixin class should work', () {
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

    test('Bug-26: Assert in constructor initializer should work', () {
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

    test('Bug-27: Short-circuit && with null check should work', () {
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

    test('Bug-32: continue with label in switch should work', () {
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

    test('Bug-40: Comparable sort should work', () {
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

    test('Bug-41: Await in string interpolation should return correct value', () async {
      const source = '''
Future<String> getValue() async => 'Hello';
Future<String> main() async {
  return 'Value: \${await getValue()}';
}
''';
      final result = await executeAsync(source);
      expect(result, equals('Value: Hello'));
    });

    test('Bug-42: noSuchMethod should work for getters', () {
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

    test(
      'Bug-43: Infinite sync* generator should work with take()',
      () async {
        const source = '''
Iterable<int> naturals() sync* {
  int n = 0;
  while (true) { yield n++; }
}
List<int> main() {
  return naturals().take(5).toList();
}
''';
        // Uses subprocess with 5s timeout - will timeout if hanging
        final result = await executeInSubprocess(source);
        expect(result, equals([0, 1, 2, 3, 4]));
      },
    );

    test('Bug-45: Labeled continue in sync* should return correct values', () {
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

    test(
      'Bug-47: Future.doWhile should work',
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
        // Uses subprocess to avoid error escaping test framework
        final result = await executeInSubprocess(source);
        expect(result, equals(3));
      },
    );

    test('Bug-52: Implicit super() should work', () {
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

    test('Bug-53: NullAwareElement should work', () {
      const source = '''
List<int> main() {
  int? maybeNull;
  return [1, 2, ?maybeNull, 3];
}
''';
      final result = execute(source);
      expect(result, equals([1, 2, 3]));
    });
  });

  // ============================================================
  // FIXED BUGS (✅ Fixed status)
  // Regression tests for bugs that have been resolved - TESTS PASS
  // ============================================================

  group('Fixed Bugs (SHOULD PASS)', () {
    test('Bug-3: Enum value access should work', () {
      const source = '''
enum Day { monday, tuesday, wednesday }
Day main() {
  return Day.wednesday;
}
''';
      final result = execute(source);
      expect(result.toString(), contains('wednesday'));
    });

    test('Bug-16: Abstract method from mixin should not false-positive', () {
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

    test('Bug-17: Extending interface class in same library should work', () {
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

    test('Bug-18: Mixin with abstract getter should work', () {
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

    test('Bug-22: Error class should be accessible', () {
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

    test('Bug-28: Typedef with generic function should work', () {
      const source = '''
typedef BinaryOp = int Function(int, int);
int main() {
  BinaryOp add = (a, b) => a + b;
  return add(3, 4);
}
''';
      expect(execute(source), equals(7));
    });

    test('Bug-29: Future.value() should return correct type', () async {
      const source = '''
Future<int> main() async {
  return await Future.value(42);
}
''';
      final result = await executeAsync(source);
      expect(result, equals(42));
    });

    test('Bug-44: async* generator should complete correctly', () async {
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

    test('Bug-48: await for should iterate stream correctly', () async {
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

    test('Bug-50: map[key] = value should work', () {
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

    test('Bug-51: Mixing in bridged mixin should work', () {
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

    test('Bug-54: void function returning should work', () {
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
  });
}
