import 'dart:async';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';
// The stdlib registrars are deliberately not re-exported from `runtime.dart`
// — see the note in `stdlib_bytes_builder_test.dart`. Reaching for them by
// same-package path keeps the published API unchanged.
import 'package:tom_d4rt_ast/src/runtime/stdlib/async.dart';

/// SCD186 coverage for `tom_d4rt_ast` — `Future.syncValue` is registered and
/// behaves as the SDK specifies.
///
/// WHY THIS MEMBER ARRIVES NOW. `scc73_sdk_member_completeness_test.dart` skips
/// SDK members annotated `@Since` a version above the package's own floor, so
/// that an SDK upgrade cannot turn it red demanding members the package may not
/// legally compile against. `tom_d4rt` declared `^3.9.0` and
/// `Future.syncValue` is `@Since("3.10")`. SCD186 raised that floor to
/// `^3.10.4` — which THIS package and every other in the repo already declared
/// — and the completeness guard then asked for exactly this one constructor.
///
/// So the twin was held back by the reference's floor rather than by its own:
/// `tom_d4rt_ast` could have compiled this member for as long as it has been on
/// 3.10.4. The mirror rule is what kept the two in step, and it is also why the
/// straddle mattered — SCC26 asks that the mirrored packages' floors not
/// diverge, and they had.
///
/// The level is registration-level for the DGUC6 reason: `tom_d4rt_exec` is the
/// only runner that could execute a script against *this* tree, and it resolves
/// `tom_d4rt_ast` from pub.dev rather than by path, so it cannot see unpublished
/// local edits. The script-level twin lives in
/// `tom_d4rt/test/stdlib/async/scd186_future_sync_value_test.dart`.
void main() {
  late Environment env;
  late InterpreterVisitor visitor;

  setUp(() {
    env = Environment();
    AsyncStdlib.register(env);
    visitor = InterpreterVisitor(
      globalEnvironment: env,
      moduleContext: AstModuleLoader(
        modules: const {},
        globalEnvironment: env,
        runner: D4rtRunner(),
      ),
    );
  });

  BridgedClass future() {
    final b = env.findBridgedClassByName('Future');
    expect(b, isNotNull, reason: 'Future must be a registered bridge');
    return b!;
  }

  group('SCD186: Future.syncValue is registered on both paths', () {
    test('F-SCD186-AST-1: it is registered as a constructor AND as a static '
        '[2026-09-15] (PASS)', () {
      // Anti-vacuity, and not merely formal: `Future<T>.syncValue(v)` routes
      // through constructor lookup while `Future.syncValue(v)` routes through
      // the static path, so a registration in one map alone leaves one of the
      // two spellings broken. Every other named Future factory is registered
      // twice for the same reason.
      expect(future().constructors.keys, contains('syncValue'));
      expect(future().staticMethods.keys, contains('syncValue'));
    });

    test('F-SCD186-AST-2: the constructor adapter completes with the value '
        '[2026-09-15] (PASS)', () async {
      final result = future().constructors['syncValue']!(visitor, [1], {});
      expect(result, isA<Future<Object?>>());
      expect(await (result as Future), 1);
    });

    test('F-SCD186-AST-3: the static adapter completes with the value '
        '[2026-09-15] (PASS)', () async {
      final result = future().staticMethods['syncValue']!(visitor, [2], {}, []);
      expect(await (result as Future), 2);
    });

    test('F-SCD186-AST-4: it does NOT adopt a future argument [2026-09-15] '
        '(PASS)', () async {
      // The distinguishing behaviour, and the reason the member exists: `value`
      // waits for a future argument and takes its result — error included —
      // while `syncValue` completes with the argument as-is, which is what the
      // SDK's "guaranteed to not have an error" rests on.
      final inner = Future<int>.value(7);
      final result =
          future().constructors['syncValue']!(visitor, [inner], {}) as Future;
      final value = await result;
      expect(value, isA<Future>());
      expect(await (value as Future), 7);
    });

    test('F-SCD186-AST-5: CONTROL — the `value` adapter DOES adopt one '
        '[2026-09-15] (PASS)', () async {
      // Without this, the case above shows only that `syncValue` behaves some
      // way, not that it behaves differently from the member it sits beside.
      final inner = Future<int>.value(7);
      final result =
          future().constructors['value']!(visitor, [inner], {}) as Future;
      expect(await result, 7);
    });
  });
}
