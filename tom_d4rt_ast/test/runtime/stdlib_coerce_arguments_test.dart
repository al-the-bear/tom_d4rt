import 'package:test/test.dart';
import 'package:tom_d4rt_ast/d4rt.dart';
// The coercion helpers are not re-exported from `runtime.dart`; reaching for
// them by same-package path keeps the published API unchanged, as the other
// stdlib mirrors do.
import 'package:tom_d4rt_ast/src/runtime/stdlib/coerce_elements.dart';

/// SCD26 mirror coverage for `tom_d4rt_ast` — coercion accepts, and refuses.
///
/// The defect: d4rt evaluates a list literal to `List<Object?>` and a map
/// literal to `Map<Object?, Object?>`, so an adapter written
/// `positionalArgs[0] as Iterable<int>` tests the CONTAINER's type argument —
/// which never matches — rather than its CONTENTS, which usually do.
///
/// UNIT LEVEL IS THE HONEST LEVEL HERE, and for once it is also the stronger
/// one. The script-level twin
/// (`tom_d4rt/test/stdlib/coerce_arguments_test.dart`) can only observe that a
/// call succeeds, which conflates "the cast was fixed" with "the argument
/// happened to be typed". These cases exercise the coercion directly, so the
/// must-not-widen half is asserted against the function that decides it rather
/// than through whichever adapter is currently wired to it.
///
/// THAT HALF IS THE ONE THAT NEEDS WATCHING. Accepting an argument the SDK
/// rejects makes a script green here that cannot compile as Dart — the one
/// bridge defect no passing test can catch — which is why the helper re-checks
/// every element instead of blanket-casting to `dynamic`.
void main() {
  group('SCD26: coerceElements accepts an erased literal', () {
    test('F-SCD26-AST-1: a List<Object?> of ints coerces to List<int> '
        '[2026-09-12] (PASS)', () {
      final erased = <Object?>[1, 2, 3];
      expect(coerceElements<int>(erased, 'probe'), equals([1, 2, 3]));
    });

    test('F-SCD26-AST-2: an already-typed Iterable passes through '
        '[2026-09-12] (PASS)', () {
      // The form that always worked, and the reason the defect survived
      // review: a spot-check written this way sees nothing wrong.
      expect(coerceElements<int>(<int>[1, 2], 'probe'), equals([1, 2]));
    });
  });

  group('SCD26: coerceElements refuses to widen', () {
    test('F-SCD26-AST-3: an element of the wrong type throws [2026-09-12] '
        '(PASS)', () {
      expect(
        () => coerceElements<int>(<Object?>[1, 'x'], 'probe'),
        throwsA(isA<RuntimeD4rtException>()),
      );
    });

    test('F-SCD26-AST-4: a non-collection throws [2026-09-12] (PASS)', () {
      expect(
        () => coerceElements<int>(7, 'probe'),
        throwsA(isA<RuntimeD4rtException>()),
      );
    });
  });

  group('SCD26: coerceMapArg', () {
    test(
      'F-SCD26-AST-5: an erased map literal coerces [2026-09-12] (PASS)',
      () {
        final erased = <Object?, Object?>{'a': 'b'};
        expect(
          coerceMapArg<String, dynamic>(erased, 'probe'),
          equals({'a': 'b'}),
        );
      },
    );

    test('F-SCD26-AST-6: null passes through, because the call sites take an '
        'optional named argument [2026-09-12] (PASS)', () {
      expect(coerceMapArg<String, dynamic>(null, 'probe'), isNull);
      expect(coerceElementsOrNull<String>(null, 'probe'), isNull);
    });

    test(
      'F-SCD26-AST-7: a key of the wrong type throws [2026-09-12] (PASS)',
      () {
        expect(
          () => coerceMapArg<String, dynamic>(<Object?, Object?>{
            1: 'b',
          }, 'probe'),
          throwsA(isA<RuntimeD4rtException>()),
        );
      },
    );

    test(
      'F-SCD26-AST-8: a value of the wrong type throws [2026-09-12] (PASS)',
      () {
        expect(
          () =>
              coerceMapArg<String, int>(<Object?, Object?>{'a': 'b'}, 'probe'),
          throwsA(isA<RuntimeD4rtException>()),
        );
      },
    );
  });
}
