// DFUB8: super parameters forward the parent constructor's default.
//
// Ports the two failing super-parameter cases from upstream
// kodjodevf/d4rt test/class/class_test.dart. When a Dart 2.17+ super
// parameter (`super.value`) is an *optional positional* whose matching
// parameter in the PARENT constructor has a default, and the child call
// omits it, our interpreter passed `null` instead of applying the parent's
// default. The fix makes the omitted super-parameter fall through to the
// parent constructor's declared default.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

Object? execute(String code) {
  final d4rt = D4rt();
  return d4rt.execute(source: code);
}

void main() {
  group('DFUB8: super-parameter default forwarding', () {
    test('F-DFUB8-1: optional positional super param uses parent default '
        '[2026-07-23] (RED)', () {
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

    test('F-DFUB8-2: super param with default value in parent '
        '[2026-07-23] (RED)', () {
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
