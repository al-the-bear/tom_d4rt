// SCC64 — a callable on the right-hand side of `is` is not a type test.
//
// THE DEFECT. `_valueHasType` used to answer `x is Foo`, where `Foo` resolved
// to a `NativeFunction`, by CALLING it:
//
//     } else if (targetType is NativeFunction &&
//         targetType.call(this, []) is Type) {
//       final object = targetType.call(this, []);
//
// Twice, because the guard and the body each invoke it. So a type test — an
// expression a reader takes to be a pure question about a value — executed
// arbitrary host code, with whatever side effects that code has, before
// deciding it was not a type after all.
//
// WHERE IT CAME FROM AND WHY IT IS GONE. The branch existed to serve exactly
// one registration in the whole stdlib: `HttpClientCredentials`, defined as a
// zero-arity native returning its own `Type` object. SCC64 bridges that name
// properly, so nothing produces a `Type`-valued native any more — in either
// tree, or in any consumer package (`tom_d4rt_flutter*`, `tom_d4rt_exec`,
// `tom_d4rt_dcli`, `tom_dcli_exec`, `tom_d4rt_generator` register none). The
// branch was therefore not a general mechanism that happened to have one user;
// it was one registration's workaround that every other callable fell into.
//
// WHAT REPLACES IT. A callable is never a type, so the answer is neither `true`
// nor `false` — it is a diagnosis. The interpreter now says so without invoking
// anything, and says it the same way for a host function and for a script one,
// which the old code did not: an `InterpretedFunction` missed the
// `NativeFunction` branch entirely and fell through to "Type 'f' not found or
// is not a int", a message that names the *operand's* type and so reads as
// though the operand were at fault.
import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';
import 'interpreter_test.dart';

void main() {
  group('SCC64: a callable is rejected as an `is` operand', () {
    test('F-SCC64-12: a script function on the right of `is` is diagnosed '
        '[2026-09-06]', () {
      const source = '''
      int helper(int x) => x;
      main() { return 1 is helper; }
      ''';
      expect(
        () => execute(source),
        throwsRuntimeError(
          allOf(
            contains('helper'),
            contains('function'),
            contains('not a type'),
          ),
        ),
      );
    });

    test('F-SCC64-13: a host function on the right of `is` is diagnosed the '
        'same way [2026-09-06]', () {
      // `print` is a `NativeFunction`, so before the fix this took the branch
      // that called it. What the script got back was not a statement about the
      // type test at all but a raw host `RangeError (length): Invalid value:
      // Valid value range is empty: 0` — `print`'s own body indexing the empty
      // argument list the guard had passed it.
      const source = '''
      main() { return 1 is print; }
      ''';
      expect(
        () => execute(source),
        throwsRuntimeError(
          allOf(
            contains('print'),
            contains('function'),
            contains('not a type'),
          ),
        ),
      );
    });

    test('F-SCC64-18: the hazard was never about `dart:io` [2026-09-06]', () {
      // `identical` is a `dart:core` native with an arity check, so before the
      // fix `1 is identical` reported "Type check failed: identical requires
      // two arguments." — the same sentence shape as the credentials defect
      // this todo started from, on a name with no connection to it. Pinned to
      // record that fixing the four registrations alone would have left the
      // mechanism in place for every other native in the library.
      const source = '''
      main() { return 1 is identical; }
      ''';
      expect(
        () => execute(source),
        throwsRuntimeError(
          allOf(contains('identical'), contains('not a type')),
        ),
      );
    });

    test('F-SCC64-14: the callable is not invoked while being rejected '
        '[2026-09-06]', () {
      // The half that matters most, and the half a message assertion cannot
      // reach: the old guard *called* the function to inspect its return value.
      //
      // The spy is an embedder-registered native rather than a script function,
      // because only the host side reached the offending branch — a script
      // function is an `InterpretedFunction`, missed the `NativeFunction`
      // guard, and fell through to the throw without being called. Testing with
      // a script function would therefore have been green before the fix and
      // proved nothing.
      //
      // It returns a `Type` on purpose. That makes the guard succeed, so the
      // body ran too and the old code invoked it TWICE — the count, not merely
      // its non-zero-ness, is the measurement.
      var calls = 0;
      final d4rt = D4rt();
      d4rt.registertopLevelFunction(
        'spy',
        (visitor, args, namedArgs, typeArgs) {
          calls++;
          return int;
        },
        'package:fixture/spy.dart',
        signature: 'Type spy()',
      );

      expect(
        () => d4rt.execute(
          library: 'package:test/main.dart',
          sources: {
            'package:test/main.dart': '''
import 'package:fixture/spy.dart';
main() { return 1 is spy; }
''',
          },
        ),
        throwsRuntimeError(contains('not a type')),
      );
      expect(calls, equals(0), reason: 'a type test must not run the callable');
    });

    test('F-SCC64-15: `is!` against a callable also throws rather than '
        'answering [2026-09-06]', () {
      // Negation must not convert a diagnosis into an answer. A `!` applied to
      // a thrown expression is unreachable, but the guard is cheap and the
      // failure it prevents — `1 is! someFunction` quietly answering `true` —
      // would look like working code.
      const source = '''
      int helper(int x) => x;
      main() { return 1 is! helper; }
      ''';
      expect(() => execute(source), throwsRuntimeError(contains('not a type')));
    });

    test('F-SCC64-16: an unresolvable name still reports as undefined '
        '[2026-09-06]', () {
      // The control that keeps the new message narrow. "Not a type" must mean
      // "this resolved, to something that is not a type" — a name that resolves
      // to nothing at all is a different failure and keeps its own wording.
      const source = '''
      main() { return 1 is NoSuchType; }
      ''';
      expect(() => execute(source), throwsRuntimeError(contains('NoSuchType')));
    });

    test('F-SCC64-17: a real type on the right of `is` is unaffected '
        '[2026-09-06]', () {
      // The other control: the branch removed here sat in the same `else if`
      // chain as the bridged- and interpreted-class cases, so the cheapest way
      // to break them is to edit their neighbour.
      const source = '''
      class Box {}
      main() {
        var b = Box();
        return [b is Box, 1 is int, 'x' is String, b is int];
      }
      ''';
      expect(execute(source), equals([true, true, true, false]));
    });
  });
}
