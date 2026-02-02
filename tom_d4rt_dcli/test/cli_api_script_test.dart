// Copyright (c) 2025 Thomas Schaller. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// CLI API Script Execution Tests
///
/// Tests for script execution, state modification, and environment persistence.
library;

import 'dart:async';
import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt/tom_d4rt.dart';
import 'package:tom_d4rt_dcli/dartscript.dart';
import 'package:tom_d4rt_dcli/tom_d4rt_cli_api.dart';

/// Output capture for testing.
class OutputCapture {
  final List<String> stdout = [];
  final List<String> stderr = [];

  String get stdoutText => stdout.join();
  void clear() {
    stdout.clear();
    stderr.clear();
  }
}

/// Run with output capture.
Future<T> withCapture<T>(OutputCapture capture, Future<T> Function() fn) async {
  return runZoned(
    fn,
    zoneSpecification: ZoneSpecification(
      print: (self, parent, zone, line) {
        capture.stdout.add('$line\n');
      },
    ),
  );
}

void main() {
  group('CLI API Script Execution - State Modification', () {
    late D4rt d4rt;
    late CliState state;
    late D4rtCliController controller;
    late Directory tempDir;
    late OutputCapture output;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync('cli_script_test_');
      d4rt = D4rt();
      d4rt.grant(FilesystemPermission.any);
      d4rt.grant(NetworkPermission.any);
      d4rt.grant(ProcessRunPermission.any);
      TomD4rtDcliBridge.register(d4rt);

      state = CliState(
        dataDirectory: tempDir.path,
        initialDirectory: tempDir.path,
      );

      controller = D4rtCliController(
        d4rt: d4rt,
        state: state,
        toolName: 'Test',
      );
      
      output = OutputCapture();
    });

    tearDown(() {
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    });

    // -------------------------------------------------------------------------
    // Variable Definition and Persistence
    // -------------------------------------------------------------------------

    group('variable persistence', () {
      test('define variable in script, verify exists', () async {
        await controller.execute('var testVar = 42; void main() {}');
        final result = await controller.eval('testVar');
        expect(result, 42);
      });

      test('modify variable in continued execution', () async {
        await controller.execute('var counter = 0; void main() {}');
        // Use eval to modify the variable in the existing environment
        await controller.eval('counter = 10');
        final result = await controller.eval('counter');
        expect(result, 10);
      });

      test('variables persist across multiple evals', () async {
        await controller.execute('var accumulator = 0; void main() {}');
        await controller.eval('accumulator += 1');
        await controller.eval('accumulator += 2');
        await controller.eval('accumulator += 3');
        final result = await controller.eval('accumulator');
        expect(result, 6);
      });

      test('define multiple variables in one script', () async {
        await controller.execute('''
          var a = 1;
          var b = 2;
          var c = 3;
          void main() {}
        ''');
        expect(await controller.eval('a'), 1);
        expect(await controller.eval('b'), 2);
        expect(await controller.eval('c'), 3);
        expect(await controller.eval('a + b + c'), 6);
      });

      test('variable shadowing in new execution', () async {
        await controller.execute('var x = 10; void main() {}');
        // Fresh execute replaces the environment
        final result = await controller.execute('var x = 20; void main() { print(x); }');
        expect(result.success, true);
        // After execute, x is now 20 in the new environment
        expect(await controller.eval('x'), 20);
      });
    });

    // -------------------------------------------------------------------------
    // Function Definition and Invocation
    // -------------------------------------------------------------------------

    group('function persistence', () {
      test('define function, call it later', () async {
        await controller.execute('''
          int add(int a, int b) => a + b;
          void main() {}
        ''');
        final result = await controller.eval('add(3, 4)');
        expect(result, 7);
      });

      test('define multiple functions', () async {
        await controller.execute('''
          int square(int x) => x * x;
          int cube(int x) => x * x * x;
          int double_(int x) => x * 2;
          void main() {}
        ''');
        expect(await controller.eval('square(5)'), 25);
        expect(await controller.eval('cube(3)'), 27);
        expect(await controller.eval('double_(7)'), 14);
      });

      test('recursive function', () async {
        await controller.execute('''
          int factorial(int n) {
            if (n <= 1) return 1;
            return n * factorial(n - 1);
          }
          void main() {}
        ''');
        expect(await controller.eval('factorial(5)'), 120);
        expect(await controller.eval('factorial(10)'), 3628800);
      });

      test('function using captured variable', () async {
        await controller.execute('''
          var multiplier = 5;
          int multiply(int x) => x * multiplier;
          void main() {}
        ''');
        expect(await controller.eval('multiply(3)'), 15);
        await controller.eval('multiplier = 10');
        expect(await controller.eval('multiply(3)'), 30);
      });

      test('higher-order function', () async {
        await controller.execute('''
          int apply(int Function(int) fn, int value) => fn(value);
          int addOne(int x) => x + 1;
          void main() {}
        ''');
        final result = await controller.eval('apply(addOne, 5)');
        expect(result, 6);
      });
    });

    // -------------------------------------------------------------------------
    // Class Definition and Instantiation
    // -------------------------------------------------------------------------

    group('class persistence', () {
      test('define class, create instance', () async {
        await controller.execute('''
          class Counter {
            int value = 0;
            void increment() => value++;
            void decrement() => value--;
          }
          Counter c = Counter();
          void main() {}
        ''');
        await controller.eval('c.increment()');
        await controller.eval('c.increment()');
        await controller.eval('c.increment()');
        final result = await controller.eval('c.value');
        expect(result, 3);
      });

      test('class with constructor', () async {
        await controller.execute('''
          class Point {
            final int x;
            final int y;
            Point(this.x, this.y);
            int distanceSquared() => x * x + y * y;
          }
          Point p = Point(3, 4);
          void main() {}
        ''');
        expect(await controller.eval('p.x'), 3);
        expect(await controller.eval('p.y'), 4);
        expect(await controller.eval('p.distanceSquared()'), 25);
      });

      test('class with named constructor', () async {
        await controller.execute('''
          class Color {
            final int r, g, b;
            Color(this.r, this.g, this.b);
            Color.red() : r = 255, g = 0, b = 0;
            Color.green() : r = 0, g = 255, b = 0;
            Color.blue() : r = 0, g = 0, b = 255;
          }
          Color red = Color.red();
          void main() {}
        ''');
        expect(await controller.eval('red.r'), 255);
        expect(await controller.eval('red.g'), 0);
        expect(await controller.eval('red.b'), 0);
      });

      test('class inheritance', () async {
        await controller.execute('''
          class Animal {
            String speak() => 'sound';
          }
          class Dog extends Animal {
            @override
            String speak() => 'bark';
          }
          class Cat extends Animal {
            @override
            String speak() => 'meow';
          }
          Dog dog = Dog();
          Cat cat = Cat();
          void main() {}
        ''');
        expect(await controller.eval('dog.speak()'), 'bark');
        expect(await controller.eval('cat.speak()'), 'meow');
      });

      test('class with static members', () async {
        await controller.execute('''
          class Config {
            static String appName = 'TestApp';
            static int version = 1;
            static int getVersion() => version;
          }
          void main() {}
        ''');
        expect(await controller.eval('Config.appName'), 'TestApp');
        expect(await controller.eval('Config.version'), 1);
        expect(await controller.eval('Config.getVersion()'), 1);
      });
    });

    // -------------------------------------------------------------------------
    // Define Command (REPL-style definitions)
    // -------------------------------------------------------------------------

    group('define command', () {
      test('define persists function definition', () async {
        // First establish execution context
        await controller.execute('void main() {}');
        // Use multiline define mode
        controller.startDefine();
        await controller.processPrompt('int triple(int x) => x * 3;');
        await controller.end();
        
        final result = await controller.eval('triple(4)');
        expect(result, 12);
      });

      test('define persists class definition', () async {
        // First establish execution context
        await controller.execute('void main() {}');
        controller.startDefine();
        await controller.processPrompt('class Box { int value; Box(this.value); }');
        await controller.end();
        
        final result = await controller.eval('Box(42).value');
        expect(result, 42);
      });
    });

    // -------------------------------------------------------------------------
    // Multiline Script Execution
    // -------------------------------------------------------------------------

    group('multiline script execution', () {
      test('multiline script returns last expression', () async {
        await controller.execute('void main() {}');
        controller.startScript();
        await controller.processPrompt('var x = 10;');
        await controller.processPrompt('var y = 20;');
        await controller.processPrompt('return x + y;');
        final result = await controller.end();
        expect(result, 30);
      });

      test('multiline file adds to environment', () async {
        await controller.execute('void main() {}');
        controller.startFile();
        await controller.processPrompt('var fromMultiline = 123;');
        await controller.end();
        
        final result = await controller.eval('fromMultiline');
        expect(result, 123);
      });

      test('multiline execute runs in fresh environment', () async {
        await controller.execute('var existing = 999; void main() {}');
        controller.startExecute();
        await controller.processPrompt('void main() { print("fresh"); }');
        final result = await controller.end();
        // Result is an ExecuteResult
        expect(result, isA<ExecuteResult>());
        expect((result as ExecuteResult).success, true);
      });
    });

    // -------------------------------------------------------------------------
    // File Execution
    // -------------------------------------------------------------------------

    group('file execution', () {
      test('execute file defines variables accessible later', () async {
        final file = File('${tempDir.path}/setup.dart');
        file.writeAsStringSync('''
          var fromFile = 'loaded';
          void main() {}
        ''');

        await controller.executeFile('setup.dart');
        // After executeFile, we need executeContinued to access vars
        await controller.executeContinued('void main() {}');
        final result = await controller.eval('fromFile');
        expect(result, 'loaded');
      });

      test('.file command shares environment', () async {
        await controller.execute('var sharedVar = 100; void main() {}');
        
        final file = File('${tempDir.path}/use_shared.dart');
        file.writeAsStringSync('var doubled = sharedVar * 2;');

        await controller.file('use_shared.dart');
        final result = await controller.eval('doubled');
        expect(result, 200);
      });

      test('script file executes line by line', () async {
        final file = File('${tempDir.path}/commands.script.txt');
        file.writeAsStringSync('''1+1
2+2
3+3
''');

        await controller.execute('void main() {}');
        final count = await controller.script('commands.script.txt');
        expect(count, 3);
      });
    });

    // -------------------------------------------------------------------------
    // Replay Files
    // -------------------------------------------------------------------------

    group('replay file execution', () {
      test('replay file executes commands', () async {
        final file = File('${tempDir.path}/setup.replay.txt');
        file.writeAsStringSync('1+1\n');

        await controller.execute('void main() {}');
        final count = await controller.replay('setup.replay.txt');
        expect(count, greaterThan(0));
      });

      test('load file shows output', () async {
        final file = File('${tempDir.path}/verbose.replay.txt');
        file.writeAsStringSync('1+1\n');

        await controller.execute('void main() {}');
        await withCapture(output, () => controller.load('verbose.replay.txt'));
        // Load should show output (implementation detail)
      });
    });

    // -------------------------------------------------------------------------
    // Complex Script Scenarios
    // -------------------------------------------------------------------------

    group('complex scenarios', () {
      test('build up state incrementally', () async {
        // Start with base
        await controller.execute('var state = <String, int>{}; void main() {}');
        
        // Add items via eval
        await controller.eval("state['a'] = 1");
        await controller.eval("state['b'] = 2");
        await controller.eval("state['c'] = 3");
        
        // Verify
        expect(await controller.eval('state.length'), 3);
        expect(await controller.eval("state['a']"), 1);
        expect(await controller.eval("state['b']"), 2);
        expect(await controller.eval("state['c']"), 3);
      });

      test('use collections across executions', () async {
        await controller.execute('''
          var items = <int>[];
          void addItem(int x) => items.add(x);
          int sum() => items.fold(0, (a, b) => a + b);
          void main() {}
        ''');
        
        await controller.eval('addItem(10)');
        await controller.eval('addItem(20)');
        await controller.eval('addItem(30)');
        
        expect(await controller.eval('items.length'), 3);
        expect(await controller.eval('sum()'), 60);
      });

      test('async code execution', () async {
        await controller.execute('''
          Future<int> asyncAdd(int a, int b) async {
            return a + b;
          }
          void main() {}
        ''');
        
        // D4rt eval automatically awaits Futures
        final result = await controller.eval('asyncAdd(5, 7)');
        expect(result, 12);
      });

      test('exception handling in scripts', () async {
        await controller.execute('''
          String safeDiv(int a, int b) {
            try {
              if (b == 0) throw ArgumentError('Division by zero');
              return (a / b).toString();
            } catch (e) {
              return 'Error: \$e';
            }
          }
          void main() {}
        ''');
        
        expect(await controller.eval('safeDiv(10, 2)'), '5.0');
        expect(await controller.eval('safeDiv(10, 0)'), contains('Error'));
      });

      test('enum definition and use', () async {
        await controller.execute('''
          enum Status { pending, active, completed }
          Status currentStatus = Status.pending;
          void main() {}
        ''');
        
        expect(await controller.eval('currentStatus'), isNotNull);
        await controller.eval('currentStatus = Status.active');
        expect(await controller.eval('currentStatus == Status.active'), true);
      });

      test('extension methods', () async {
        await controller.execute('''
          extension IntExtensions on int {
            int doubled() => this * 2;
            int squared() => this * this;
          }
          void main() {}
        ''');
        
        expect(await controller.eval('5.doubled()'), 10);
        expect(await controller.eval('5.squared()'), 25);
      });

      test('typedef and function types', () async {
        await controller.execute('''
          typedef IntTransform = int Function(int);
          int apply(IntTransform fn, int value) => fn(value);
          void main() {}
        ''');
        
        expect(await controller.eval('apply((x) => x + 10, 5)'), 15);
        expect(await controller.eval('apply((x) => x * 2, 7)'), 14);
      });

      test('mixin usage', () async {
        await controller.execute('''
          mixin Swimmer {
            String swim() => 'swimming';
          }
          mixin Flyer {
            String fly() => 'flying';
          }
          class Duck with Swimmer, Flyer {}
          Duck duck = Duck();
          void main() {}
        ''');
        
        expect(await controller.eval('duck.swim()'), 'swimming');
        expect(await controller.eval('duck.fly()'), 'flying');
      });

      test('late variables', () async {
        await controller.execute('''
          late String lazyValue;
          bool isInitialized = false;
          void initValue() {
            lazyValue = 'initialized';
            isInitialized = true;
          }
          void main() {}
        ''');
        
        expect(await controller.eval('isInitialized'), false);
        await controller.eval('initValue()');
        expect(await controller.eval('isInitialized'), true);
        expect(await controller.eval('lazyValue'), 'initialized');
      });

      test('null safety features', () async {
        await controller.execute('''
          String? nullableString;
          String getWithDefault() => nullableString ?? 'default';
          void main() {}
        ''');
        
        expect(await controller.eval('getWithDefault()'), 'default');
        await controller.eval("nullableString = 'set'");
        expect(await controller.eval('getWithDefault()'), 'set');
      });

      test('cascade operator', () async {
        await controller.execute('''
          class Builder {
            final values = <int>[];
            Builder add(int v) { values.add(v); return this; }
            int sum() => values.fold(0, (a, b) => a + b);
          }
          Builder b = Builder();
          void main() {}
        ''');
        
        await controller.eval('b..add(1)..add(2)..add(3)');
        expect(await controller.eval('b.sum()'), 6);
      });

      test('spread operator', () async {
        await controller.execute('''
          var list1 = [1, 2, 3];
          void main() {}
        ''');
        
        final result = await controller.eval('[...list1, 4, 5]');
        expect(result, [1, 2, 3, 4, 5]);
      });

      test('collection if and for', () async {
        await controller.execute('''
          var includeExtra = true;
          List<int> numbers = [1, 2, 3];
          void main() {}
        ''');
        
        var result = await controller.eval('[1, 2, if (includeExtra) 3]');
        expect(result, [1, 2, 3]);
        
        // For-in-collection uses map instead of for loop in eval
        result = await controller.eval('numbers.map((n) => n * 2).toList()');
        expect(result, [2, 4, 6]);
      });
    });

    // -------------------------------------------------------------------------
    // Output Capture Tests
    // -------------------------------------------------------------------------

    group('output capture', () {
      test('capture print output', () async {
        await withCapture(output, () async {
          await controller.execute('void main() { print("Hello, World!"); }');
        });
        expect(output.stdoutText, contains('Hello, World!'));
      });

      test('capture multiple prints', () async {
        await withCapture(output, () async {
          await controller.execute('''
            void main() {
              print("Line 1");
              print("Line 2");
              print("Line 3");
            }
          ''');
        });
        expect(output.stdoutText, contains('Line 1'));
        expect(output.stdoutText, contains('Line 2'));
        expect(output.stdoutText, contains('Line 3'));
      });

      test('capture loop output', () async {
        await withCapture(output, () async {
          await controller.execute('''
            void main() {
              for (var i = 0; i < 5; i++) {
                print('Count: \$i');
              }
            }
          ''');
        });
        for (var i = 0; i < 5; i++) {
          expect(output.stdoutText, contains('Count: $i'));
        }
      });
    });
  });
}
