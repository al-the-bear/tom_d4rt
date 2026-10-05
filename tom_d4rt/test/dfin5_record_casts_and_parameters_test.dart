// DFIN5 (dguc8): record and function casts, the cast message, and record- and
// function-typed parameters.
//
// The `as` branch and the parameter-shape surface had no case in either dfub5
// suite (`dfub5_function_record_runtime_type_test.dart`, which these extend).
//
// Twin: tom_d4rt_exec ports this file verbatim.
import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

Object? execute(String code) => D4rt().execute(source: code);

void main() {
  // The twin's cast message named an AST node class ("SRecordTypeAnnotation")
  // where Dart prints the type.
  group('DFIN5: record and function casts and parameter shapes', () {
    test('F-DFIN5-C1: `as` a matching record type passes [2026-10-03]', () {
      expect(execute("int main() => ((1, 'a') as (int, String)).\$1;"), 1);
    });

    test('F-DFIN5-C2: `as` a mismatched record type throws, naming the type '
        '[2026-10-03]', () {
      expect(
        () => execute("Object main() => (1, 'a') as (String, int);"),
        throwsA(predicate((e) => '$e'.contains('(String, int)'))),
      );
    });

    test('F-DFIN5-C3: `as` a function type: a matching tear-off passes, a '
        'mismatched one throws naming the type [2026-10-03]', () {
      expect(
        execute(
          'int twice(int x) => x * 2;\n'
          'int main() => (twice as int Function(int))(4);',
        ),
        8,
      );
      expect(
        () => execute(
          'int twice(int x) => x * 2;\n'
          'Object main() => twice as String Function(int);',
        ),
        throwsA(predicate((e) => '$e'.contains('String Function(int)'))),
      );
    });

    test('F-DFIN5-C4: a record-typed parameter accepts its shape and refuses '
        'another [2026-10-03]', () {
      const fn = r'int sum((int, int) p) => p.$1 + p.$2;';
      expect(execute('$fn\nint main() => sum((1, 2));'), 3);
      expect(
        () => execute("$fn\nObject main() => sum(('a', 2) as dynamic);"),
        throwsA(
          predicate(
            (e) =>
                '$e'.contains("is not a subtype of type '(int, int)' of 'p'"),
          ),
        ),
      );
    });

    test('F-DFIN5-C5: a function-typed parameter accepts a matching tear-off; '
        'a mismatched one is NOT refused, by design [2026-10-03]', () {
      // Unlike a record, a function annotation is not checked at a parameter
      // (`InterpretedFunction.resolveBinding`): the interpreter infers no
      // context type for a closure literal, so `(x) => x + 1` passed where
      // `int Function(int)` is declared has the runtime type
      // `dynamic Function(dynamic)`, and a structural check would refuse a
      // correct callback. This pins that boundary so a change to it is a
      // decision rather than an accident.
      const fns =
          'int apply(int Function(int) f) => f(3);\n'
          'int inc(int x) => x + 1;\n'
          r"String show(int x) => '$x';"
          '\n';
      expect(execute('${fns}int main() => apply(inc);'), 4);
      expect(execute('${fns}Object main() => apply(show as dynamic);'), '3');
    });
  });
}
