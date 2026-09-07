import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

/// SCC85 mirror coverage — `D4.checkArity`, the helper the too-many sweep
/// inserts into 526 stdlib adapters in this tree.
///
/// Registration-level for the DGUC6 reason: `tom_d4rt_exec` is the only runner
/// that could drive a script against THIS tree, and it resolves `tom_d4rt_ast`
/// from pub.dev rather than by path, so it cannot see unpublished local edits.
/// The script-level twin — which checks that a guarded bridge rejects a
/// surplus argument end to end — lives in
/// `tom_d4rt/test/stdlib/bridge_arity_test.dart` as F-SCC85-1..6.
///
/// The helper is pure, so calling it directly measures exactly what the
/// adapters get.
void main() {
  group('SCC85: checkArity bounds', () {
    test('F-SCC85-AST-1: atMost rejects a surplus and names the counts '
        '[2026-09-07]', () {
      expect(
        () => D4.checkArity(const [1, 2], 'BigInt.pow', atMost: 1),
        throwsA(
          isA<RuntimeD4rtException>().having(
            (e) => e.toString(),
            'toString',
            allOf(
              contains('BigInt.pow'),
              contains('at most 1'),
              contains('called with 2'),
              contains('not used by this member'),
            ),
          ),
        ),
      );
    });

    test('F-SCC85-AST-2: atMost admits exactly the bound and fewer — so the '
        'too-few half stays with the generic diagnostic [2026-09-07]', () {
      // The safety property of the whole sweep. Every inserted guard is
      // `atMost`, so a too-FEW call passes straight through to the index read
      // and `describeArityError` restates it as before. If `exactly` had been
      // inserted instead, every guarded bridge would have taken over the
      // too-few message too, and the SCB28 layering would have had to be
      // repointed bridge by bridge.
      expect(() => D4.checkArity(const [1], 'X.y', atMost: 1), returnsNormally);
      expect(() => D4.checkArity(const [], 'X.y', atMost: 1), returnsNormally);
    });

    test('F-SCC85-AST-3: exactly and atLeast report their own shapes '
        '[2026-09-07]', () {
      expect(
        () => D4.checkArity(const [1, 2], 'X.y', exactly: 1),
        throwsA(
          isA<RuntimeD4rtException>().having(
            (e) => e.toString(),
            'toString',
            allOf(
              contains('exactly 1 positional argument'),
              contains('with 2'),
            ),
          ),
        ),
      );
      expect(
        () => D4.checkArity(const [], 'X.y', atLeast: 2),
        throwsA(
          isA<RuntimeD4rtException>().having(
            (e) => e.toString(),
            'toString',
            contains('at least 2 positional arguments'),
          ),
        ),
      );
    });

    test('F-SCC85-AST-4: singular and plural read as English [2026-09-07]', () {
      expect(
        () => D4.checkArity(const [1, 2], 'X.y', atMost: 1),
        throwsA(
          isA<RuntimeD4rtException>().having(
            (e) => e.toString(),
            'toString',
            allOf(
              contains('at most 1 positional argument,'),
              contains('extra argument is not used'),
            ),
          ),
        ),
      );
      expect(
        () => D4.checkArity(const [1, 2, 3], 'X.y', atMost: 1),
        throwsA(
          isA<RuntimeD4rtException>().having(
            (e) => e.toString(),
            'toString',
            contains('extra arguments are not used'),
          ),
        ),
      );
    });

    test('F-SCC85-AST-5: a bound-less call is refused rather than accepting '
        'everything [2026-09-07]', () {
      // A typo'd keyword — `atMax:` — would otherwise make the guard a no-op,
      // which is the exact failure mode the sweep exists to remove.
      expect(
        () => D4.checkArity(const [1, 2, 3], 'X.y'),
        throwsA(isA<AssertionError>()),
      );
    });
  });
}
