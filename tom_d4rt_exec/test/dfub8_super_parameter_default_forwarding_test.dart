// DFUB8 conformance (DGUB11): super parameters forward the parent
// constructor's default — verified against the ANALYZER-FREE interpreter.
//
// Mirror of tom_d4rt/test/dfub8_super_parameter_default_forwarding_test.dart.
// The fix lives in the interpreter's constructor parameter binding
// (callable.dart) in both trees; this file is the end-to-end guard that the
// tom_d4rt_ast half is actually present in the HOSTED package tom_d4rt_exec
// resolves. It can only be exercised through full source execution (class
// hierarchies), which is why there is no standalone tom_d4rt_ast unit test.

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

dynamic execute(String source) {
  final d4rt = D4rt()..setDebug(false);
  return d4rt.execute(
      library: 'package:test/main.dart',
      sources: {'package:test/main.dart': source});
}

void main() {
  group('DFUB8 (exec): super-parameter default forwarding', () {
    test(
        'F-DFUB8-EXEC-1: optional positional super param uses parent default '
        '[2026-07-27] (PASS)', () {
      const code = '''
        class Parent {
          final String name;
          final int value;
          Parent(this.name, [this.value = 0]);
        }

        class Child extends Parent {
          Child(super.name, [super.value]);
        }

        main() {
          var c1 = Child('test');
          var c2 = Child('test2', 42);
          return [c1.name, c1.value, c2.name, c2.value];
        }
      ''';
      expect(execute(code), equals(['test', 0, 'test2', 42]));
    });

    test(
        'F-DFUB8-EXEC-2: super param with default value in parent '
        '[2026-07-27] (PASS)', () {
      const code = '''
        class Parent {
          final String name;
          final int count;
          Parent(this.name, [this.count = 5]);
        }

        class Child extends Parent {
          Child(super.name, [super.count]);
        }

        main() {
          var c1 = Child('test');
          var c2 = Child('test', 10);
          return [c1.name, c1.count, c2.name, c2.count];
        }
      ''';
      expect(execute(code), equals(['test', 5, 'test', 10]));
    });
  });
}
