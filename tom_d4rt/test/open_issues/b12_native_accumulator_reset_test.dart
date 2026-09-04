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
/// `D4rt.resetScriptDeclarations`. This is the analyzer-based VM runtime;
/// mirrors the analyzer-free AST twin in
/// `tom_d4rt_ast/test/runtime/native_accumulator_reset_test.dart`.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

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
  group('OPEN B.12 — D4 native accumulator reset (VM)', () {
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
        for (final k in keys) {
          expect(D4.interpretedForNative(k), isNotNull);
        }

        D4.resetNativeAccumulators();

        expect(D4.nativeRegistrationCount, 0);
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
      final pinned = <Object>[];
      const cyclesN = 6;
      const perCycle = 4;
      for (var cycle = 0; cycle < cyclesN; cycle++) {
        pinned.addAll(_simulateBuildRegistrations(perCycle));
      }
      expect(D4.nativeRegistrationCount, cyclesN * perCycle);
      expect(pinned.every((k) => D4.interpretedForNative(k) != null), isTrue);
    });

    test('WITH reset between cycles, the accumulator stays at baseline', () {
      final pinned = <Object>[];
      const cyclesN = 6;
      const perCycle = 4;
      for (var cycle = 0; cycle < cyclesN; cycle++) {
        D4.resetNativeAccumulators();
        expect(D4.nativeRegistrationCount, 0);
        pinned.addAll(_simulateBuildRegistrations(perCycle));
        expect(D4.nativeRegistrationCount, perCycle);
      }
      final live = pinned.where((k) => D4.interpretedForNative(k) != null);
      expect(live.length, perCycle);
    });

    test('D4rt.resetScriptDeclarations also clears the native accumulator', () {
      final interpreter = D4rt();
      // Drive a real execute so the full reset path (env + native) runs.
      expect(interpreter.execute(source: 'int main() => 1;'), 1);

      final keys = _simulateBuildRegistrations(7);
      expect(D4.nativeRegistrationCount, 7);

      interpreter.resetScriptDeclarations();

      expect(
        D4.nativeRegistrationCount,
        0,
        reason: 'the facade reset API must clear D4 native state',
      );
      for (final k in keys) {
        expect(D4.interpretedForNative(k), isNull);
      }
      // The interpreter is still usable afterwards.
      expect(interpreter.execute(source: 'int main() => 2;'), 2);
    });

    test('reset is idempotent and safe with no prior registrations', () {
      expect(D4.resetNativeAccumulators, returnsNormally);
      D4.resetNativeAccumulators();
      expect(D4.nativeRegistrationCount, 0);
    });
  });
}
