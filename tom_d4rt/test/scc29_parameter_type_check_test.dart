import 'package:test/test.dart';
import 'interpreter_test.dart' show execute;

/// SCC29 — a declared parameter type is checked when the caller binds it.
///
/// THE DEFECT SHAPE
///
/// The interpreter checked *return* types and nothing else, so
/// `String f(String s) => s;` invoked as `f(42)` returned `42`. Real Dart raises
/// `TypeError: type 'int' is not a subtype of type 'String' of 's'`. The one
/// direction that catches a *caller's* mistake was the missing one, and it fails
/// silently: the wrong-typed value flows into the body and misbehaves somewhere
/// further in, so the reported symptom points at the callee rather than at the
/// call.
///
/// Measured before the fix, all of `f(42)`, `f(x)` with `dynamic x = 42`,
/// optional, named, method and constructor parameters passed the wrong value
/// through without complaint — the failure was never limited to dynamic
/// dispatch.
///
/// WHERE THE CHECK LIVES, AND WHY THERE
///
/// In `InterpretedFunction._prepareExecutionEnvironment`, on the value the
/// binding loop is about to define. That is the single point every call shape
/// funnels through — direct, dynamic, method, constructor, closure, tear-off —
/// so one site covers all of them, and it is the point at which the argument and
/// its declared parameter are both in hand.
///
/// THE SCOPE IS DELIBERATELY CALLER-PROVIDED ARGUMENTS ONLY
///
/// A value the *declaration* produced — an omitted optional's implicit `null`,
/// or an evaluated default — is not checked (F-SCC29-15). Two reasons, and both
/// matter more than the symmetry that is given up:
///
///   1. Real Dart rejects those at compile time, so a runtime check here is
///      guarding a case that a compiled program cannot reach. It would only ever
///      fire on scripts the analyzer already rejects.
///   2. `void f([String s])` is invalid Dart but common in interpreted scripts,
///      and failing it at *entry* would break working code at a point unrelated
///      to any mistake the caller made.
///
/// WHAT IS NOT CHECKED, AND WHY EACH ONE IS A CHOICE
///
/// The predicate stays permissive wherever it cannot be sure, because a false
/// positive here rejects a correct program:
///
///   - `dynamic` and unannotated parameters (F-SCC29-9, F-SCC29-10) — nothing to
///     check against.
///   - An unbound type parameter `T` (F-SCC29-11, F-SCC29-18). `T` resolves to a
///     placeholder, not to the type the caller actually supplied, so a check
///     would compare against a stand-in. Guessing here would reject correct
///     generic code, which is strictly worse than missing an error.
///   - Function-typed and record-typed annotations (F-SCC29-20) — structural
///     comparison of a callable against a declared shape is a larger question
///     than this fix, and getting it wrong rejects working callbacks.
///   - Any annotation that fails to resolve — same rule the return-type check
///     already follows.
///
/// THE ERROR TYPE AND MESSAGE ARE NOT THE RETURN PATH'S
///
/// The return check raises `RuntimeD4rtException` with the *analyzer's* wording
/// ("A value of type 'X' can't be returned from…"), which is a compile-time
/// diagnostic quoted at runtime. The parameter check raises `D4rtTypeError` with
/// the *SDK's runtime* wording, because that is the shape a real program sees
/// and the shape `on TypeError` must match (F-SCC29-17). The two differ on
/// purpose; F-SCC29-21 pins that this change did not drag the return path along
/// with it. What the two paths genuinely share is the *predicate* —
/// `RuntimeType.isSubtypeOf` — not the presentation.
void main() {
  group('SCC29: declared parameter types are checked at binding', () {
    test('F-SCC29-1: a wrong-typed required positional argument raises '
        'TypeError [2026-09-05]', () {
      expect(
        () => execute('''
          String f(String s) => s;
          main() => f(42);
        '''),
        throwsA(isA<TypeError>()),
      );
    });

    test('F-SCC29-2: the message is the SDK runtime shape, naming the value '
        'type, the declared type and the parameter [2026-09-05]', () {
      expect(
        () => execute('''
          String f(String s) => s;
          main() => f(42);
        '''),
        throwsA(
          isA<TypeError>().having(
            (e) => e.toString(),
            'toString()',
            "type 'int' is not a subtype of type 'String' of 's'",
          ),
        ),
      );
    });

    test('F-SCC29-3: a dynamic receiver does not exempt the call — the check '
        'is at binding, not at the call site [2026-09-05]', () {
      expect(
        () => execute('''
          String f(String s) => s;
          main() {
            dynamic v = 42;
            return f(v);
          }
        '''),
        throwsA(isA<TypeError>()),
      );
    });

    test('F-SCC29-4: an optional positional parameter is checked when the '
        'caller supplies it [2026-09-05]', () {
      expect(
        () => execute('''
          String f([String s = 'a']) => s;
          main() => f(42);
        '''),
        throwsA(
          isA<TypeError>().having(
            (e) => e.toString(),
            'toString()',
            "type 'int' is not a subtype of type 'String' of 's'",
          ),
        ),
      );
    });

    test('F-SCC29-5: a named parameter is checked when the caller supplies '
        'it [2026-09-05]', () {
      expect(
        () => execute('''
          String f({String s = 'a'}) => s;
          main() => f(s: 42);
        '''),
        throwsA(
          isA<TypeError>().having(
            (e) => e.toString(),
            'toString()',
            "type 'int' is not a subtype of type 'String' of 's'",
          ),
        ),
      );
    });

    test('F-SCC29-6: a required named parameter is checked [2026-09-05]', () {
      expect(
        () => execute('''
          String f({required String s}) => s;
          main() => f(s: 42);
        '''),
        throwsA(isA<TypeError>()),
      );
    });

    test('F-SCC29-7: an instance method parameter is checked [2026-09-05]', () {
      expect(
        () => execute('''
          class A {
            String m(String s) => s;
          }
          main() => A().m(42);
        '''),
        throwsA(isA<TypeError>()),
      );
    });

    test('F-SCC29-8: a constructor parameter is checked [2026-09-05]', () {
      expect(
        () => execute('''
          class A {
            final String s;
            A(String v) : s = v;
          }
          main() => A(42).s;
        '''),
        throwsA(isA<TypeError>()),
      );
    });

    test('F-SCC29-9: a closure parameter is checked [2026-09-05]', () {
      expect(
        () => execute('''
          main() {
            final f = (String s) => s;
            return f(42);
          }
        '''),
        throwsA(isA<TypeError>()),
      );
    });

    test('F-SCC29-10: passing null to a non-nullable parameter raises '
        "TypeError naming 'Null' [2026-09-05]", () {
      expect(
        () => execute('''
          String f(String s) => s;
          main() => f(null);
        '''),
        throwsA(
          isA<TypeError>().having(
            (e) => e.toString(),
            'toString()',
            "type 'Null' is not a subtype of type 'String' of 's'",
          ),
        ),
      );
    });

    test('F-SCC29-25: an explicitly bound type parameter is checked against '
        'what it was bound to [2026-09-05]', () {
      // `T` is not always a placeholder. When the caller supplies the type
      // argument it resolves to a real type, and the check then applies to it —
      // which is what real Dart does, and more than the conservative reading of
      // "type parameters are not checked" would have predicted.
      expect(
        () => execute('''
          T f<T>(T v) => v;
          main() => f<String>(42);
        '''),
        throwsA(isA<TypeError>()),
      );
      expect(
        execute('''
          T f<T>(T v) => v;
          main() => f<int>(42);
        '''),
        42,
      );
    });

    test('F-SCC29-26: a class type argument is checked in the methods that '
        'use it [2026-09-05]', () {
      expect(
        () => execute('''
          class Box<T> {
            T? v;
            void put(T value) { v = value; }
          }
          main() {
            final b = Box<String>();
            b.put(42);
          }
        '''),
        throwsA(isA<TypeError>()),
      );
      expect(
        execute('''
          class Box<T> {
            T? v;
            void put(T value) { v = value; }
          }
          main() {
            final b = Box<int>();
            b.put(42);
            return b.v;
          }
        '''),
        42,
      );
    });

    group('values the check must let through', () {
      test('F-SCC29-11: a correctly-typed argument [2026-09-05]', () {
        expect(
          execute('''
            String f(String s) => s;
            main() => f('ok');
          '''),
          'ok',
        );
      });

      test('F-SCC29-12: a subtype of the declared type [2026-09-05]', () {
        expect(
          execute('''
            num f(num n) => n;
            main() => f(1);
          '''),
          1,
        );
      });

      test('F-SCC29-13: a `dynamic` parameter accepts anything '
          '[2026-09-05]', () {
        expect(
          execute('''
            f(dynamic v) => v;
            main() => f(42);
          '''),
          42,
        );
      });

      test('F-SCC29-14: an unannotated parameter accepts anything '
          '[2026-09-05]', () {
        expect(
          execute('''
            f(v) => v;
            main() => f(42);
          '''),
          42,
        );
      });

      test('F-SCC29-15: an `Object` parameter accepts anything '
          '[2026-09-05]', () {
        expect(
          execute('''
            f(Object v) => v;
            main() => f(42);
          '''),
          42,
        );
      });

      test('F-SCC29-16: a nullable parameter accepts null [2026-09-05]', () {
        expect(
          execute('''
            String? f(String? s) => s;
            main() => f(null);
          '''),
          isNull,
        );
      });

      test('F-SCC29-17: an omitted optional is a value the declaration '
          'produced, not one the caller passed [2026-09-05]', () {
        // `[String s]` without a default is not valid Dart, but it is common in
        // interpreted scripts. Checking it would fail a call that made no
        // mistake — the omission is the declaration's problem, not the
        // caller's.
        expect(
          execute('''
            f([String s]) => s;
            main() => f();
          '''),
          isNull,
        );
      });

      test('F-SCC29-18: an inferred type parameter is not checked '
          '[2026-09-05]', () {
        // Without an explicit type argument `T` resolves to a placeholder, not
        // to the type the caller supplied, so any comparison would be against a
        // stand-in. Permissive is the only safe answer — d4rt does not infer
        // `T` from the argument, so a check here would be a guess.
        expect(
          execute('''
            T f<T>(T v) => v;
            main() => f(42);
          '''),
          42,
        );
      });

      test('F-SCC29-19: a raw generic binds its type parameter to `dynamic` '
          'and accepts anything [2026-09-05]', () {
        // `Box()` rather than `Box<int>()`. `T` is spelled `T` but resolves to
        // `dynamic`, so the check has to test the RESOLVED type — testing the
        // spelling alone would make every raw generic reject its own arguments.
        expect(
          execute('''
            class Box<T> {
              T? v;
              void put(T value) { v = value; }
            }
            main() {
              final b = Box();
              b.put(42);
              return b.v;
            }
          '''),
          42,
        );
      });

      test('F-SCC29-20: a function-typed parameter is not checked '
          '[2026-09-05]', () {
        expect(
          execute('''
            int apply(int Function(int) cb) => cb(1);
            main() => apply((int x) => x + 1);
          '''),
          2,
        );
      });

      test('F-SCC29-21: a collection argument is checked on its base type '
          'only [2026-09-05]', () {
        // `List<int>` against `List<String>` is an applied-generic mismatch.
        // The base check passes it; enforcing the arguments element-wise is a
        // separate question from "is this even a List".
        expect(
          execute('''
            int f(List<String> xs) => xs.length;
            main() => f([1]);
          '''),
          1,
        );
      });
    });

    test('F-SCC29-22: an int bound to a `double` parameter is widened, as '
        'Dart widens it [2026-09-05]', () {
      // The return path already does this (`double` declared, `int` returned →
      // `toDouble()`); the binding site is the same conversion at the other
      // end of the call. Without it the body receives an `int` where its own
      // annotation promises a `double`, which is the silent-wrong-value shape
      // this whole fix is about.
      expect(
        execute('''
          bool f(double d) => d is double;
          main() => f(1);
        '''),
        isTrue,
      );
    });

    test('F-SCC29-23: the raised error is catchable by `on TypeError` inside '
        'interpreted code [2026-09-05]', () {
      expect(
        execute('''
          String f(String s) => s;
          main() {
            try {
              f(42);
              return 'no throw';
            } on TypeError {
              return 'caught';
            }
          }
        '''),
        'caught',
      );
    });

    test('F-SCC29-24: the return path keeps its own error type and wording '
        '[2026-09-05]', () {
      // Deliberately different from the parameter path: the return check quotes
      // the analyzer's compile-time diagnostic, the parameter check quotes the
      // SDK's runtime one. Pinned here so a later "make them consistent" edit
      // has to be an argued change rather than a tidy-up.
      expect(
        () => execute('''
          String f() {
            dynamic v = 42;
            return v;
          }
          main() => f();
        '''),
        throwsA(
          isA<Object>().having(
            (e) => e.toString(),
            'toString()',
            contains("can't be returned from the function 'f'"),
          ),
        ),
      );
    });
  });
}
