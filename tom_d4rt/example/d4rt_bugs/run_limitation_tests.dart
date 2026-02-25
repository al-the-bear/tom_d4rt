/// D4rt Limitation and Bug Test Runner
///
/// Tests all documented limitations and bugs from d4rt_limitations.md
/// Each test wraps potentially problematic code with error handling
/// to report issues without crashing.
///
/// Usage:
///   dart run run_limitation_tests.dart         # Run all tests
///   dart run run_limitation_tests.dart Lim-1   # Run specific limitation
///   dart run run_limitation_tests.dart Bug-32  # Run specific bug
library;

import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';

/// Test definition with expected behavior
class LimitationTest {
  final String id;
  final String description;
  final String code;
  final bool expectedToFail;
  final String? expectedError;
  final Duration timeout;
  final bool runsInSubprocess; // For blocking tests

  LimitationTest({
    required this.id,
    required this.description,
    required this.code,
    this.expectedToFail = true,
    this.expectedError,
    this.timeout = const Duration(seconds: 5),
    this.runsInSubprocess = false,
  });
}

/// All limitation tests
final limitationTests = <LimitationTest>[
  // === LIMITATIONS ===

  LimitationTest(
    id: 'Lim-1',
    description: 'Extension types (Dart 3.3+) not supported',
    expectedToFail: true,
    code: '''
extension type UserId(int value) {
  bool get isValid => value > 0;
}
void main() {
  var id = UserId(42);
  print('UserId: \${id.value}');
  print('isValid: \${id.isValid}');
}
''',
  ),

  LimitationTest(
    id: 'Lim-2',
    description: 'Extensions on bridged types fail',
    expectedToFail: false,
    code: '''
extension DateTimeExtension on DateTime {
  bool get isWeekend => weekday == DateTime.saturday || weekday == DateTime.sunday;
}
void main() {
  var now = DateTime.now();
  print('isWeekend: \${now.isWeekend}');
}
''',
  ),

  LimitationTest(
    id: 'Lim-3',
    description: 'Isolate execution with interpreted code',
    expectedToFail: true,
    code: '''
import 'dart:isolate';
void main() async {
  final result = await Isolate.run(() {
    return 42;
  });
  print('Result: \$result');
}
''',
  ),

  LimitationTest(
    id: 'Lim-4',
    description: 'Infinite sync* generators hang',
    expectedToFail: true,
    runsInSubprocess: true, // Must run in subprocess due to blocking
    timeout: const Duration(seconds: 10),
    code: '''
Iterable<int> infiniteNumbers() sync* {
  var n = 0;
  while (true) {
    yield n++;
  }
}
void main() {
  final first5 = infiniteNumbers().take(5).toList();
  print('First 5: \$first5');
}
''',
  ),

  LimitationTest(
    id: 'Lim-5',
    description: 'Comparable interface not fully supported',
    expectedToFail: false,
    code: '''
class Person implements Comparable<Person> {
  final String name;
  Person(this.name);
  
  @override
  int compareTo(Person other) => name.compareTo(other.name);
}
void main() {
  var people = [Person('Charlie'), Person('Alice'), Person('Bob')];
  people.sort();
  print('Sorted: \${people.map((p) => p.name).toList()}');
}
''',
  ),

  LimitationTest(
    id: 'Lim-6',
    description: 'noSuchMethod for getters not supported',
    expectedToFail: false,
    code: '''
class FlexibleObject {
  @override
  dynamic noSuchMethod(Invocation invocation) {
    return 'handled';
  }
}
void main() {
  dynamic obj = FlexibleObject();
  print('Method: \${obj.anyMethod()}');  // Works
  print('Property: \${obj.someProperty}');  // Fails
}
''',
  ),

  LimitationTest(
    id: 'Lim-7',
    description: 'Labeled continue in switch statements',
    expectedToFail: false,
    code: '''
void main() {
  outer: switch (1) {
    case 1:
      print('Case 1');
      continue other;
    other:
    case 2:
      print('Case 2');
      break;
  }
}
''',
  ),

  LimitationTest(
    id: 'Lim-8',
    description: 'Logical OR patterns in switch cases',
    expectedToFail: false,
    code: '''
void main() {
  var day = 'Saturday';
  var result = switch (day) {
    'Saturday' || 'Sunday' => 'Weekend',
    _ => 'Weekday',
  };
  print('Result: \$result');
}
''',
  ),

  LimitationTest(
    id: 'Lim-9',
    description: 'Await in string interpolation',
    expectedToFail: false, // Shows AsyncSuspensionRequest but doesn't fail
    code: '''
Future<String> getValue() async => 'Hello';
void main() async {
  print('Value: \${await getValue()}');
}
''',
  ),

  // === BUGS (Fixed) - Should all pass ===

  LimitationTest(
    id: 'Bug-1',
    description: 'List.empty() constructor',
    expectedToFail: false,
    code: '''
void main() {
  var list = List<int>.empty(growable: true);
  list.add(1);
  print('List: \$list');
}
''',
  ),

  LimitationTest(
    id: 'Bug-2',
    description: 'Queue.addAll() method',
    expectedToFail: false,
    code: '''
import 'dart:collection';
void main() {
  var queue = Queue<int>();
  queue.addAll([1, 2, 3]);
  print('Queue: \$queue');
}
''',
  ),

  LimitationTest(
    id: 'Bug-3',
    description: 'Enum value access (FIXED)',
    expectedToFail: false,
    code: '''
enum Day { monday, tuesday, wednesday }
void main() {
  var today = Day.wednesday;
  print('Today: \$today');
}
''',
  ),

  LimitationTest(
    id: 'Bug-5',
    description: 'Division by zero',
    expectedToFail: false,
    code: '''
void main() {
  var result = 1.0 / 0.0;
  print('Result: \$result');
  print('Is infinite: \${result.isInfinite}');
}
''',
  ),

  LimitationTest(
    id: 'Bug-6',
    description: 'Record hashCode',
    expectedToFail: false,
    code: '''
void main() {
  var r1 = (1, 2, name: 'test');
  var r2 = (1, 2, name: 'test');
  print('r1.hashCode == r2.hashCode: \${r1.hashCode == r2.hashCode}');
}
''',
  ),

  LimitationTest(
    id: 'Bug-7',
    description: 'Digit separators',
    expectedToFail: false,
    code: '''
void main() {
  var million = 1_000_000;
  print('Million: \$million');
}
''',
  ),

  LimitationTest(
    id: 'Bug-8',
    description: 'List.indexWhere()',
    expectedToFail: false,
    code: '''
void main() {
  var list = ['a', 'b', 'c', 'd'];
  print('indexOf b: \${list.indexWhere((e) => e == 'b')}');
}
''',
  ),

  LimitationTest(
    id: 'Bug-9',
    description: 'Never type',
    expectedToFail: false,
    code: '''
Never throwError() {
  throw Exception('Error');
}
void main() {
  try {
    throwError();
  } catch (e) {
    print('Caught: \$e');
  }
}
''',
  ),

  LimitationTest(
    id: 'Bug-10',
    description: 'Comparable interface implements',
    expectedToFail: false,
    code: '''
class Value implements Comparable<Value> {
  final int n;
  Value(this.n);
  @override
  int compareTo(Value other) => n.compareTo(other.n);
}
void main() {
  var a = Value(5);
  var b = Value(10);
  print('a < b: \${a.compareTo(b) < 0}');
}
''',
  ),

  LimitationTest(
    id: 'Bug-11',
    description: 'Sealed class',
    expectedToFail: false,
    code: '''
sealed class Shape {}
class Circle extends Shape { final double radius; Circle(this.radius); }
class Square extends Shape { final double side; Square(this.side); }
void main() {
  Shape s = Circle(5.0);
  print('Shape: \$s');
}
''',
  ),

  LimitationTest(
    id: 'Bug-12',
    description: 'Exception interface',
    expectedToFail: false,
    code: '''
class MyException implements Exception {
  final String message;
  MyException(this.message);
}
void main() {
  try {
    throw MyException('Test');
  } catch (e) {
    print('Caught: \$e');
  }
}
''',
  ),

  LimitationTest(
    id: 'Bug-13',
    description: 'LogicalOrPattern',
    expectedToFail: false,
    code: '''
void main() {
  var day = 'Saturday';
  var type = switch (day) {
    'Saturday' || 'Sunday' => 'Weekend',
    _ => 'Weekday',
  };
  print('Type: \$type');
}
''',
  ),

  LimitationTest(
    id: 'Bug-14',
    description: 'Record type annotation',
    expectedToFail: false,
    code: '''
(int, int) swap((int, int) pair) => (pair.\$2, pair.\$1);
void main() {
  var result = swap((1, 2));
  print('Swapped: \$result');
}
''',
  ),

  LimitationTest(
    id: 'Bug-20',
    description: 'identical() function',
    expectedToFail: false,
    code: '''
void main() {
  var list1 = [1, 2, 3];
  var list2 = list1;
  print('identical: \${identical(list1, list2)}');
}
''',
  ),

  LimitationTest(
    id: 'Bug-21',
    description: 'Set.from() constructor',
    expectedToFail: false,
    code: '''
void main() {
  var set = Set<int>.from([1, 2, 3, 3, 2, 1]);
  print('Set: \$set');
}
''',
  ),

  LimitationTest(
    id: 'Bug-23',
    description: 'Static const sibling reference',
    expectedToFail: false,
    code: '''
class Colors {
  static const red = '#FF0000';
  static const blue = '#0000FF';
  static const defaultColor = blue;
}
void main() {
  print('Default: \${Colors.defaultColor}');
}
''',
  ),

  LimitationTest(
    id: 'Bug-24',
    description: 'mixin class declaration',
    expectedToFail: false,
    code: '''
mixin class Logger {
  void log(String msg) => print('[LOG] \$msg');
}
class Service with Logger {}
void main() {
  var service = Service();
  service.log('Hello');
}
''',
  ),

  LimitationTest(
    id: 'Bug-27',
    description: 'Short-circuit && with null',
    expectedToFail: false,
    code: '''
void main() {
  String? name;
  if (name != null && name.isNotEmpty) {
    print('Has name');
  } else {
    print('No name');
  }
}
''',
  ),

  LimitationTest(
    id: 'Bug-28',
    description: 'GenericFunctionType (FIXED)',
    expectedToFail: false,
    code: '''
typedef BinaryOp = int Function(int, int);
void main() {
  BinaryOp add = (a, b) => a + b;
  print('add(3, 4) = \${add(3, 4)}');
}
''',
  ),

  LimitationTest(
    id: 'Bug-29',
    description: 'Future.value() (FIXED)',
    expectedToFail: false,
    code: '''
void main() async {
  var value = await Future.value(42);
  print('Value: \$value');
}
''',
  ),

  // Active bugs (still failing)
  LimitationTest(
    id: 'Bug-32',
    description: 'continue label in switch (LIMITATION)',
    expectedToFail: false,
    code: '''
void main() {
  outer: switch (1) {
    case 1:
      print('One');
      continue two;
    two:
    case 2:
      print('Two');
      break;
  }
}
''',
  ),

  LimitationTest(
    id: 'Bug-40',
    description: 'Comparable sort (LIMITATION)',
    expectedToFail: false,
    code: '''
class Person implements Comparable<Person> {
  final String name;
  Person(this.name);
  @override
  int compareTo(Person other) => name.compareTo(other.name);
}
void main() {
  var people = [Person('C'), Person('A'), Person('B')];
  people.sort();
  print('Sorted');
}
''',
  ),

  LimitationTest(
    id: 'Bug-42',
    description: 'noSuchMethod getter (LIMITATION)',
    expectedToFail: false,
    code: '''
class Flex {
  @override
  dynamic noSuchMethod(Invocation inv) => 'handled';
}
void main() {
  dynamic obj = Flex();
  print(obj.anyMethod());
  print(obj.someProperty);
}
''',
  ),

  LimitationTest(
    id: 'Bug-43',
    description: 'Infinite sync* generator (LIMITATION)',
    expectedToFail: true,
    runsInSubprocess: true, // Must run in subprocess due to blocking
    timeout: const Duration(seconds: 10),
    code: '''
Iterable<int> infinite() sync* {
  var n = 0;
  while (true) yield n++;
}
void main() {
  print(infinite().take(3).toList());
}
''',
  ),
];

/// Run all limitation tests
Future<void> main(List<String> args) async {
  print('');
  print('=' * 70);
  print('D4rt Limitation and Bug Test Runner');
  print('=' * 70);
  print('');

  final filterIds = args.where((a) => !a.startsWith('-')).toSet();
  final showAll = args.contains('--all');

  var passed = 0;
  var failed = 0;
  var skipped = 0;

  for (final test in limitationTests) {
    if (filterIds.isNotEmpty && !filterIds.contains(test.id)) {
      skipped++;
      continue;
    }

    stdout.write('${test.id}: ${test.description}... ');

    try {
      final result = await runTest(test);

      if (result.success) {
        if (test.expectedToFail) {
          print('⚠️ UNEXPECTED PASS');
          if (showAll) print('   Expected to fail but passed!');
          failed++;
        } else {
          print('✅ PASS');
          passed++;
        }
      } else {
        if (test.expectedToFail) {
          print('✅ EXPECTED FAIL');
          if (showAll) print('   Error: ${result.error}');
          passed++;
        } else {
          print('❌ FAIL');
          print('   Error: ${result.error}');
          failed++;
        }
      }
    } catch (e) {
      if (test.expectedToFail) {
        print('✅ EXPECTED FAIL');
        if (showAll) print('   Exception: $e');
        passed++;
      } else {
        print('❌ EXCEPTION');
        print('   $e');
        failed++;
      }
    }
  }

  print('');
  print('=' * 70);
  print('Results: $passed passed, $failed failed, $skipped skipped');
  print('=' * 70);

  exit(failed > 0 ? 1 : 0);
}

/// Test result
class TestResult {
  final bool success;
  final String? error;
  final dynamic result;

  TestResult.success(this.result) : success = true, error = null;
  TestResult.failure(this.error) : success = false, result = null;
}

/// Run a single test with timeout
Future<TestResult> runTest(LimitationTest test) async {
  // For blocking tests, run in subprocess
  if (test.runsInSubprocess) {
    return runTestInSubprocess(test);
  }

  try {
    final d4rt = D4rt();

    // Create a temporary file for the test
    final tempDir = Directory.systemTemp.createTempSync('d4rt_test_');
    final tempFile = File(p.join(tempDir.path, 'test.dart'));
    tempFile.writeAsStringSync(test.code);

    try {
      final completer = Completer<TestResult>();

      // Run with timeout
      Timer(test.timeout, () {
        if (!completer.isCompleted) {
          completer.complete(TestResult.failure('Timeout after ${test.timeout.inSeconds}s'));
        }
      });

      // Execute the test
      final result = executeFile(d4rt, tempFile.path, log: null);

      var finalResult = result.result;
      if (finalResult is Future) {
        finalResult = await finalResult.timeout(test.timeout, onTimeout: () {
          return null;
        });
      }

      if (!completer.isCompleted) {
        if (result.success) {
          completer.complete(TestResult.success(finalResult));
        } else {
          completer.complete(TestResult.failure(result.error?.toString() ?? 'Unknown error'));
        }
      }

      return await completer.future;
    } finally {
      // Cleanup
      tempDir.deleteSync(recursive: true);
    }
  } catch (e) {
    return TestResult.failure(e.toString());
  }
}

/// Run a blocking test in a subprocess with timeout
Future<TestResult> runTestInSubprocess(LimitationTest test) async {
  // Create a temporary script that runs D4rt
  final tempDir = Directory.systemTemp.createTempSync('d4rt_subprocess_');
  final testFile = File(p.join(tempDir.path, 'test.dart'));
  final runnerFile = File(p.join(tempDir.path, 'runner.dart'));

  testFile.writeAsStringSync(test.code);

  // Create a runner script that uses D4rt
  runnerFile.writeAsStringSync('''
import 'dart:io';
import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';

void main() async {
  try {
    final d4rt = D4rt();
    final result = executeFile(d4rt, '${testFile.path.replaceAll('\\', '\\\\')}', log: null);
    var finalResult = result.result;
    if (finalResult is Future) {
      finalResult = await finalResult;
    }
    if (result.success) {
      print('SUCCESS');
      exit(0);
    } else {
      print('FAIL: \${result.error}');
      exit(1);
    }
  } catch (e) {
    print('ERROR: \$e');
    exit(1);
  }
}
''');

  try {
    // Run the subprocess with timeout
    final process = await Process.start(
      'dart',
      ['run', runnerFile.path],
      workingDirectory: '/Users/alexiskyaw/Desktop/Code/tom2/xternal/tom_module_d4rt/tom_d4rt_generator/example',
    );

    final stdout = StringBuffer();
    final stderr = StringBuffer();

    process.stdout.transform(const SystemEncoding().decoder).listen((data) {
      stdout.write(data);
    });
    process.stderr.transform(const SystemEncoding().decoder).listen((data) {
      stderr.write(data);
    });

    // Wait with timeout
    final exitCode = await process.exitCode.timeout(
      test.timeout,
      onTimeout: () {
        process.kill(ProcessSignal.sigkill);
        return -1; // Timeout
      },
    );

    if (exitCode == -1) {
      return TestResult.failure('Timeout after ${test.timeout.inSeconds}s (killed)');
    } else if (exitCode == 0) {
      return TestResult.success(stdout.toString());
    } else {
      return TestResult.failure(stdout.toString() + stderr.toString());
    }
  } finally {
    // Cleanup
    tempDir.deleteSync(recursive: true);
  }
}
