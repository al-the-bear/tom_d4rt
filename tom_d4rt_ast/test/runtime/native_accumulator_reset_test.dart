/// Repro + regression for OPEN B.12 — framework/runtime state accumulates
/// across `/build` cycles; the reset API was a no-op (§U28).
///
/// The genuine cross-build accumulator is [D4]'s `_nativeToInterpreted`
/// Expando: its entries are weak, but they are pinned by native framework
/// objects (Flutter Elements / RenderObjects / animations) the embedder keeps
/// alive across `/build` cycles, so they do NOT self-clear the way the
/// per-call-fresh `_values` environment map does. Before the fix the reset API
/// walked only `_values` and never touched the Expando.
///
/// The fix adds [D4.resetNativeAccumulators] (swap in a fresh Expando + zero
/// the instrumentation counter) and wires it into
/// [D4rtRunner.resetScriptDeclarations]. This is the analyzer-free AST runtime;
/// mirrors the analyzer-based twin in
/// `tom_d4rt/test/open_issues/b12_native_accumulator_reset_test.dart`.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

/// A minimal bundle whose `main` returns [returnValue]. Used only to drive a
/// real `executeBundle` so the runner-level reset path is exercised end to end.
AstBundle _trivialMainBundle(int returnValue) {
  final mainFn = SFunctionDeclaration(
    offset: 0,
    length: 0,
    name: SSimpleIdentifier(offset: 0, length: 4, name: 'main'),
    functionExpression: SFunctionExpression(
      offset: 0,
      length: 0,
      parameters: SFormalParameterList(offset: 0, length: 0),
      body: SBlockFunctionBody(
        offset: 0,
        length: 0,
        block: SBlock(
          offset: 0,
          length: 0,
          statements: [
            SReturnStatement(
              offset: 0,
              length: 0,
              expression: SIntegerLiteral(
                offset: 0,
                length: 1,
                value: returnValue,
              ),
            ),
          ],
        ),
      ),
    ),
  );
  final unit = SCompilationUnit(offset: 0, length: 0, declarations: [mainFn]);
  return AstBundle(
    entryPointUri: 'package:t/main.dart',
    modules: {'package:t/main.dart': unit},
  );
}

/// Simulates one `/build` cycle's worth of native→interpreted registrations.
/// Returns the native key objects so a caller can keep them alive (mimicking
/// the framework pinning Elements across rebuilds) and probe them later.
List<Object> _simulateBuildRegistrations(int count) {
  final keys = <Object>[];
  for (var i = 0; i < count; i++) {
    final nativeObj = Object();
    D4.registerInterpretedForNative(nativeObj, Object());
    keys.add(nativeObj);
  }
  return keys;
}

void main() {
  group('OPEN B.12 — D4 native accumulator reset (AST)', () {
    setUp(D4.resetNativeAccumulators);

    test('registerInterpretedForNative grows the instrumentation counter', () {
      expect(D4.nativeRegistrationCount, 0);
      _simulateBuildRegistrations(5);
      expect(D4.nativeRegistrationCount, 5);
    });

    test(
      'resetNativeAccumulators zeroes the counter and drops all entries',
      () {
        final keys = _simulateBuildRegistrations(3);
        // Entries are reachable before reset.
        for (final k in keys) {
          expect(D4.interpretedForNative(k), isNotNull);
        }

        D4.resetNativeAccumulators();

        expect(D4.nativeRegistrationCount, 0);
        // Even though the native keys are still alive, the Expando was swapped
        // out — the old entries are gone.
        for (final k in keys) {
          expect(
            D4.interpretedForNative(k),
            isNull,
            reason: 'reset must drop entries even for still-reachable keys',
          );
        }
      },
    );

    test('WITHOUT reset, repeated build cycles accumulate (the B.12 bug)', () {
      // Hold every cycle's native keys alive, as the framework would.
      final pinned = <Object>[];
      const cyclesN = 6;
      const perCycle = 4;
      for (var cycle = 0; cycle < cyclesN; cycle++) {
        pinned.addAll(_simulateBuildRegistrations(perCycle));
      }
      // No reset between cycles → the counter is the running total.
      expect(D4.nativeRegistrationCount, cyclesN * perCycle);
      // And every pinned key still resolves — that is the leak.
      expect(pinned.every((k) => D4.interpretedForNative(k) != null), isTrue);
    });

    test('WITH reset between cycles, the accumulator stays at baseline', () {
      final pinned = <Object>[];
      const cyclesN = 6;
      const perCycle = 4;
      for (var cycle = 0; cycle < cyclesN; cycle++) {
        // /clear → reset, then /build → register.
        D4.resetNativeAccumulators();
        expect(
          D4.nativeRegistrationCount,
          0,
          reason: 'reset must return the counter to baseline each cycle',
        );
        pinned.addAll(_simulateBuildRegistrations(perCycle));
        expect(
          D4.nativeRegistrationCount,
          perCycle,
          reason: 'only the current cycle\'s registrations remain',
        );
      }
      // Keys from earlier cycles were dropped by the resets despite being
      // pinned; only the final cycle's `perCycle` keys still resolve.
      final live = pinned.where((k) => D4.interpretedForNative(k) != null);
      expect(live.length, perCycle);
    });

    test(
      'D4rtRunner.resetScriptDeclarations also clears the native accumulator',
      () {
        final runner = D4rtRunner();
        // Drive a real build so the full reset path (env + native) runs.
        expect(runner.executeBundleAs<int>(_trivialMainBundle(1)), 1);

        final keys = _simulateBuildRegistrations(7);
        expect(D4.nativeRegistrationCount, 7);

        runner.resetScriptDeclarations();

        expect(
          D4.nativeRegistrationCount,
          0,
          reason: 'the runner reset API must clear D4 native state',
        );
        for (final k in keys) {
          expect(D4.interpretedForNative(k), isNull);
        }
        // The interpreter is still usable afterwards.
        expect(runner.executeBundleAs<int>(_trivialMainBundle(2)), 2);
      },
    );

    test('reset is idempotent and safe with no prior registrations', () {
      expect(D4.resetNativeAccumulators, returnsNormally);
      D4.resetNativeAccumulators();
      expect(D4.nativeRegistrationCount, 0);
    });
  });
}
