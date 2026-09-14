import 'package:test/test.dart';
import 'interpreter_test.dart' show execute;

/// SCD92: a binding check compares declared TYPE ARGUMENTS, not just base types
///
/// SCC29 made a declared parameter type a real check, and SCD63 extended the
/// same machinery to a typed for-each variable. Both compared BASE types only:
/// `f(List<String> xs)` accepted `f([1])` because the value's runtime type was
/// `List` and the annotation resolved to `List` — both sides erased their
/// arguments before the comparison ever happened. F-SCC29-21 pinned that as the
/// documented limit.
///
/// WHY THE ARGUMENTS WERE ERASED ON BOTH SIDES
///
/// `InterpretedFunction._resolveTypeAnnotationDynamic` reads a `NamedType`'s
/// name and ignores its `typeArguments`, so `List<String>` resolved to the bare
/// `List` bridge. And `Environment.getRuntimeType` answers `List` for every
/// list, because a native `List` carries no element type d4rt can read back —
/// `<int>[1]`, `[1]` and `<dynamic>[1]` are the same object at runtime and all
/// report `List<Object?>` for their script-visible `runtimeType`.
///
/// So the machinery was present — `AppliedRuntimeType.isSubtypeOf` has compared
/// arguments element-wise since DFUB6 — but nothing ever handed it two applied
/// types at a binding site.
///
/// WHAT MAKES THE CHECK POSSIBLE
///
/// DFUB6 solved the identical problem for the RETURN path by deriving a
/// collection's element type from its CONTENTS rather than from a static type,
/// and staying permissive whenever the contents cannot answer. SCD92 lifts that
/// derivation out of the visitor onto [Environment.appliedRuntimeTypeOf] and
/// feeds it to the binding check, so a parameter, a for-each variable and a
/// return all decide the same question the same way.
///
/// PERMISSIVE WHEREVER IT CANNOT BE SURE
///
/// The check adds a rejection only where both sides carry arguments it can
/// read. Everything below stays as permissive as before:
///
///   - an empty collection (F-SCD92-5) — no element to read a type from;
///   - a heterogeneous one (F-SCD92-6, F-SCD92-9) — no single element type;
///   - a top-type argument (F-SCD92-7) — `List<dynamic>` admits anything, so
///     the applied check could only repeat the base one;
///   - a type-parameter argument (F-SCD92-13) — `List<T>` stands for a type not
///     bound at this point, the same reason a bare `T` annotation is skipped;
///   - a raw generic instance (F-SCD92-11) — `Box()` carries no arguments;
///   - a bridged instance (a Flutter widget, a `DateTime`) — its applied type
///     is not derivable, so it is waved through.
///
/// That matters more here than on the return path, because a binding check runs
/// on every argument of every call. A false positive rejects a correct program,
/// which is worse than the silent pass it replaces.
void main() {
  group('SCD92: declared type arguments are checked at binding', () {
    test('F-SCD92-1: a `List<int>` argument bound to a `List<String>` '
        'parameter raises TypeError [2026-09-14]', () {
      expect(
        () => execute('''
          int f(List<String> xs) => xs.length;
          main() => f([1]);
        '''),
        throwsA(isA<TypeError>()),
      );
    });

    test('F-SCD92-2: the message names both applied types and the parameter '
        '[2026-09-14]', () {
      expect(
        () => execute('''
          int f(List<String> xs) => xs.length;
          main() => f([1]);
        '''),
        throwsA(
          isA<TypeError>().having(
            (e) => e.toString(),
            'toString()',
            "type 'List<int>' is not a subtype of type 'List<String>' of 'xs'",
          ),
        ),
      );
    });

    test('F-SCD92-3: a matching applied type binds [2026-09-14]', () {
      expect(
        execute('''
          int f(List<String> xs) => xs.length;
          main() => f(['a', 'b']);
        '''),
        2,
      );
    });

    test('F-SCD92-4: type arguments are covariant, as Dart has them '
        '[2026-09-14]', () {
      // `List<int>` IS a `List<num>` in Dart. A check that compared arguments
      // by name would reject this correct program.
      expect(
        execute('''
          int f(List<num> xs) => xs.length;
          main() => f(<int>[1, 2]);
        '''),
        2,
      );
    });

    test('F-SCD92-5: an empty collection stays permissive [2026-09-14]', () {
      expect(
        execute('''
          int f(List<String> xs) => xs.length;
          main() => f([]);
        '''),
        0,
      );
    });

    test('F-SCD92-6: a heterogeneous collection stays permissive '
        '[2026-09-14]', () {
      expect(
        execute('''
          int f(List<String> xs) => xs.length;
          main() => f([1, 'a']);
        '''),
        2,
      );
    });

    test('F-SCD92-7: a top-type argument admits anything [2026-09-14]', () {
      expect(
        execute('''
          int f(List<dynamic> xs) => xs.length;
          main() => f([1]);
        '''),
        1,
      );
    });

    test(
      'F-SCD92-8: a `Map` is checked on both key and value [2026-09-14]',
      () {
        expect(
          () => execute('''
          int f(Map<String, int> m) => m.length;
          main() => f({1: 1});
        '''),
          throwsA(
            isA<TypeError>().having(
              (e) => e.toString(),
              'toString()',
              contains(
                "'Map<int, int>' is not a subtype of type "
                "'Map<String, int>'",
              ),
            ),
          ),
        );
      },
    );

    test('F-SCD92-9: a heterogeneously-valued Map stays permissive '
        '[2026-09-14]', () {
      expect(
        execute('''
          int f(Map<String, int> m) => m.length;
          main() => f({'a': 1, 'b': 'x'});
        '''),
        2,
      );
    });

    test('F-SCD92-10: a `Set` is checked on its element type [2026-09-14]', () {
      expect(
        () => execute('''
          int f(Set<String> xs) => xs.length;
          main() => f(<int>{1});
        '''),
        throwsA(isA<TypeError>()),
      );
    });

    test('F-SCD92-11: an applied interpreted instance is checked '
        '[2026-09-14]', () {
      expect(
        () => execute('''
          class Box<T> { T? v; }
          int f(Box<int> b) => 1;
          main() => f(Box<String>());
        '''),
        throwsA(isA<TypeError>()),
      );
    });

    test(
      'F-SCD92-12: a raw generic instance stays permissive [2026-09-14]',
      () {
        // `Box()` carries no type arguments, so there is nothing to compare
        // against — the same rule an unbound `T` annotation follows.
        expect(
          execute('''
          class Box<T> { T? v; }
          int f(Box<int> b) => 1;
          main() => f(Box());
        '''),
          1,
        );
      },
    );

    test('F-SCD92-13: an UNBOUND type-parameter argument stays permissive '
        '[2026-09-14]', () {
      // `List<T>` with nothing binding `T` at the call: it resolves to a
      // placeholder rather than to the type the caller supplied, so comparing
      // against it would reject correct generic code.
      expect(
        execute('''
          int f<T>(List<T> xs) => xs.length;
          main() => f([1]);
        '''),
        1,
      );
    });

    test('F-SCD92-16: an unbound type parameter on a raw generic instance '
        'stays permissive [2026-09-14]', () {
      // The same rule reached through a class rather than a function: `Box()`
      // leaves `T` unbound, so `List<T>` says nothing about the argument.
      expect(
        execute('''
          class Box<T> { int f(List<T> xs) => xs.length; }
          main() => Box().f([1]);
        '''),
        1,
      );
    });

    test('F-SCD92-17: a type parameter the caller BOUND is checked '
        '[2026-09-14]', () {
      // `f<String>([1])` is an error real Dart reports too. Once `T` is bound,
      // `List<T>` is `List<String>` and there is no placeholder to guess at —
      // which is the whole reason the unbound case is skipped rather than the
      // generic case as a class.
      expect(
        () => execute('''
          int f<T>(List<T> xs) => xs.length;
          main() => f<String>([1]);
        '''),
        throwsA(isA<TypeError>()),
      );
    });

    test('F-SCD92-18: a type parameter bound by the receiver is checked '
        '[2026-09-14]', () {
      expect(
        () => execute('''
          class Box<T> { int f(List<T> xs) => xs.length; }
          main() => Box<String>().f([1]);
        '''),
        throwsA(isA<TypeError>()),
      );
    });

    test('F-SCD92-19: a nullable applied annotation keeps its `?` in the '
        'message [2026-09-14]', () {
      expect(
        () => execute('''
          int f(List<String>? xs) => xs!.length;
          main() => f([1]);
        '''),
        throwsA(
          isA<TypeError>().having(
            (e) => e.toString(),
            'toString()',
            "type 'List<int>' is not a subtype of type 'List<String>?' of 'xs'",
          ),
        ),
      );
    });

    test('F-SCD92-20: the check is one level deep [2026-09-14]', () {
      // A nested collection's own element type is not derived: the outer list's
      // element type is the bare `List`, which stays compatible with the
      // declared `List<String>` argument. Going deeper means deriving an
      // element type per nested collection, and each level multiplies both the
      // cost and the chance of a false positive on a correct program. Pinned so
      // the limit is a decision rather than an oversight.
      expect(
        execute('''
          int f(List<List<String>> xs) => xs.length;
          main() => f([[1]]);
        '''),
        1,
      );
    });

    test('F-SCD92-14: an element subtype satisfies a supertype argument '
        '[2026-09-14]', () {
      // The corpus shape: a homogeneous list of a subclass passed where the
      // superclass is declared. Rejecting this would break every
      // `List<Widget> children: [Text(..), Text(..)]` in the Flutter corpus.
      expect(
        execute('''
          class A {}
          class B extends A {}
          int f(List<A> xs) => xs.length;
          main() => f([B(), B()]);
        '''),
        2,
      );
    });

    test('F-SCD92-21: int type arguments widen to `double`, as Dart widens '
        'the literals [2026-09-14]', () {
      // Real Dart widens these literals from context, so the argument really
      // is a `Map<String, double>` — d4rt's map just holds the ints it was
      // written with. Two class tests that had passed since February found
      // this: rejecting it is exactly the false positive the permissive
      // fallbacks exist to avoid.
      expect(
        execute('''
          int f(Map<String, double> json) => json.length;
          main() => f({'x': 3, 'y': 4});
        '''),
        2,
      );
      expect(
        execute('''
          int f(List<double> xs) => xs.length;
          main() => f([1, 2]);
        '''),
        2,
      );
    });

    test('F-SCD92-22: the widening is one-way [2026-09-14]', () {
      // `List<double>` is not a `List<int>`; only the direction Dart's literal
      // widening actually goes is allowed.
      expect(
        () => execute('''
          int f(List<int> xs) => xs.length;
          main() => f([1.5, 2.5]);
        '''),
        throwsA(isA<TypeError>()),
      );
    });

    test('F-SCD92-15: a typed for-each variable is checked the same way '
        '[2026-09-14]', () {
      // SCD63 routes the loop variable through the same [ResolvedBinding], so
      // the applied check lands there too rather than on parameters alone.
      expect(
        () => execute('''
          int main() {
            for (final List<String> row in [[1]]) {
              return row.length;
            }
            return 0;
          }
        '''),
        throwsA(isA<TypeError>()),
      );
    });
  });
}
