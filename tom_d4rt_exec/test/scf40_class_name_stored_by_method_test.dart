// SCF40: a class name stored in a set or map through a METHOD or an index
// assignment reaches a lookup by `runtimeType`, as a literal already did.
//
// A bare bridged class name evaluates to its `BridgedClass`. SCD198 stored the
// native `Type` when a set or map LITERAL held one, but a key that reached the
// collection any other way was stored as the `BridgedClass`:
//
//   (<Type, int>{}..[String] = 1)['x'.runtimeType]           -> null   (Dart: 1)
//   (<Type>{}..add(String)).contains('x'.runtimeType)        -> false  (Dart: true)
//
// A native hash lookup asks `Type == BridgedClass`, which `Type.==` refuses,
// and an identity collection compares identities natively. Now the argument
// boundary every call crosses converts a class name to its native `Type`, as
// do the index operators and a list literal's elements, so the value has one
// representation in every collection.
//
// The analyzer-free twin is
// `tom_d4rt_ast/test/runtime/scf40_class_name_stored_by_method_test.dart`.

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

Object? _run(String expression) => D4rt().execute(
  source:
      '''
import 'dart:collection';
main() => $expression;
''',
);

void main() {
  group('SCF40: a class name stored by method or index reaches a runtimeType '
      'lookup', () {
    test('F-SCF40-1: map index assignment [2026-09-30] (PASS)', () {
      expect(_run("(<Type, int>{}..[String] = 1)['x'.runtimeType]"), 1);
    });

    test('F-SCF40-2: Set.add and Set.addAll [2026-09-30] (PASS)', () {
      expect(_run("(<Type>{}..add(String)).contains('x'.runtimeType)"), true);
      expect(
        _run("(<Type>{}..addAll([String])).contains('x'.runtimeType)"),
        true,
      );
    });

    test('F-SCF40-3: identity collections [2026-09-30] (PASS)', () {
      expect(
        _run("(Set<Object>.identity()..add(String)).contains('x'.runtimeType)"),
        true,
      );
      expect(
        _run("(Map<Object, int>.identity()..[String] = 1)['x'.runtimeType]"),
        1,
      );
      expect(
        _run("(Map<Object, int>.identity()..['x'.runtimeType] = 1)[String]"),
        1,
      );
    });

    test('F-SCF40-4: putIfAbsent and addAll on a map [2026-09-30] (PASS)', () {
      expect(
        _run("(<Type, int>{}..putIfAbsent(String, () => 1))['x'.runtimeType]"),
        1,
      );
      expect(_run("(<Type, int>{}..addAll({String: 1}))['x'.runtimeType]"), 1);
    });

    test('F-SCF40-5: the two spellings are one key [2026-09-30] (PASS)', () {
      expect(
        _run(
          '() { final m = Map<Object, int>.identity(); m[String] = 1; '
          "m['x'.runtimeType] = 2; return [m.length, m[String]]; }()",
        ),
        [1, 2],
      );
    });

    test('F-SCF40-6: control — an interpreted class name, and the '
        'already-working direction [2026-09-30] (PASS)', () {
      expect(
        D4rt().execute(
          source:
              'class A {} '
              'main() { final m = <Type, int>{}; m[A] = 1; '
              'return m[A().runtimeType]; }',
        ),
        1,
      );
      expect(_run("(<Type>{}..add('x'.runtimeType)).contains(String)"), true);
    });
  });
}
