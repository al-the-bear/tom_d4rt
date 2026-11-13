// ghissues23 — a record type annotation keeps its fields' `?`, so a nullable
// field accepts null.
//
// Measured 2026-11-10 on this tree (1.246.0):
//
//   final ({String name, int? n}) r = (name: 'a', n: null);
//   // type '({String name, Null n})' is not a subtype of type
//   //   '({String name, int n})' of 'r'
//
// The same for a positional field, a loop variable, a parameter, a nested
// record and `is` / `as` (GEN-128; in the Flutter corpus
// `cupertino_linear_activity_indicator_test.dart` declared
// `({String name, Color? color})`). Both type resolvers built a record's field
// types without the field's `?`; a nullable field is now a
// `NullableRuntimeType`, which `Null` and the inner type's subtypes satisfy.
// The same in tom_d4rt_ast
// (test/runtime/ghissues23_record_field_nullability_test.dart).
//
// Function types are unchanged: a parameter's `?` is dropped both in the
// annotation (`void Function(int?)`) and in a closure's own type, so neither
// side is refused, and a closure's parameter types are its own annotations, so
// carrying `?` on one side only would refuse `(int? x) {}` for
// `void Function(int?)`. GHI23-6 pins that.

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

Object? _run(String source) => D4rt().execute(source: source);

void main() {
  group('ghissues23: a record type keeps its fields\' `?`', () {
    test('GHI23-1: a variable with a nullable named and positional field, '
        'given null and a value [2026-11-10]', () {
      expect(
        _run(
          "main() { final ({String name, int? n}) a = (name: 'a', n: null); "
          "final ({String name, int? n}) b = (name: 'b', n: 2); "
          "final (String, int?) c = ('c', null); "
          "final (String, int?) d = ('d', 4); "
          r'return [a.n, b.n, c.$2, d.$2]; }',
        ),
        [null, 2, null, 4],
      );
    });

    test('GHI23-2: a loop variable and a parameter [2026-11-10]', () {
      expect(
        _run(
          r'int? f((String, {int? n}) r) => r.n; '
          'main() { var c = 0; '
          'for (final ({String name, int? n}) s in '
          "<({String name, int? n})>[(name: 'a', n: null), (name: 'b', n: 1)]) "
          '{ c++; } '
          "return [c, f(('x', n: null)), f(('y', n: 5))]; }",
        ),
        [2, null, 5],
      );
    });

    test('GHI23-3: a return type [2026-11-10]', () {
      expect(
        _run(
          r"(String, {int? n}) f(bool z) => z ? ('a', n: null) : ('b', n: 1); "
          'main() => [f(true).n, f(false).n];',
        ),
        [null, 1],
      );
    });

    test('GHI23-4: `is` and `as` [2026-11-10]', () {
      expect(
        _run(
          "main() { Object o = ('a', null); Object p = (n: null); "
          "return [o is (String, int?), o is (String, int), "
          "('a', 1) is (String, int?), (p as ({int? n})).n]; }",
        ),
        [true, false, true, null],
      );
    });

    test('GHI23-5: nested records, and a non-null field still refuses null '
        '[2026-11-10]', () {
      expect(
        _run(
          'main() { '
          "final ((int?, String), {(int?,)? x}) a = ((null, 'a'), x: null); "
          "final ((int?, String), {(int?,)? x}) b = ((1, 'b'), x: (null,)); "
          r'return [a.$1.$1, a.x, b.x!.$1]; }',
        ),
        [null, null, null],
      );
      expect(
        () => _run("main() { final (String, int) r = ('a', null); return r; }"),
        throwsA(
          isA<D4rtTypeError>().having(
            (e) => e.toString(),
            'text',
            contains("'(String, int)'"),
          ),
        ),
      );
    });

    test('GHI23-6: a function type with nullable parameters, alone and as a '
        'record field [2026-11-10]', () {
      expect(
        _run(
          'main() { void Function(int?) f = (int? x) {}; '
          'final (void Function(int?), int?) r = (f, null); '
          r'return [f is void Function(int?), r.$1 is void Function(int?), '
          r'r.$2]; }',
        ),
        [true, true, null],
      );
    });
  });
}
