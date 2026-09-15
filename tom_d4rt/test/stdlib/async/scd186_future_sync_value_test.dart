// `Future.syncValue` — the one member the SDK-floor rule was hiding.
//
// WHY IT ARRIVES NOW. `scc73_sdk_member_completeness_test.dart` skips any SDK
// member annotated `@Since` a version above the package's own floor, because
// the guard reads whichever SDK the test runs on and would otherwise turn red
// on every SDK upgrade, demanding members the package cannot legally compile
// against. `tom_d4rt` declared `^3.9.0`; `Future.syncValue` is `@Since("3.10")`.
//
// SCD186 raised the floor to `^3.10.4` — the version its mirror twin and every
// other package in the d4rt repo already declared — and this member is what the
// completeness guard then asked for. Measured across all eight bridged `dart:`
// libraries, it was the ONLY one: at a 3.9 floor the rule hid exactly one
// constructor, even against an installed 3.12.2 SDK.
//
// THE MEMBER IS NOT `Future.value` WITH A DIFFERENT NAME, and the difference is
// the whole reason it exists. Both complete with the argument, but `value`
// ADOPTS a future argument — waiting for it and taking its result, error
// included — while `syncValue` completes with the argument as-is. The SDK's own
// phrasing is that `syncValue` "is guaranteed to not have an error", and that
// guarantee is exactly what adoption would break.
//
// EVERY EXPECTATION HERE WAS COMPUTED AGAINST REAL DART, not reasoned out.
// `await` on a `Future<Object?>` holding a `Future` does NOT flatten — the
// static type is `Object?`, so the flattening rule does not apply — and that is
// surprising enough that asserting it from first principles would have been a
// coin flip. The control case pins `Future.value`'s opposite behaviour beside
// it, because a test that only shows what `syncValue` does cannot show that it
// does something different.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

const String _libPath = 'd4rt-mem:/scd186_future_sync_value_test.dart';

Future<Object?> _run(String body) async {
  final source = "import 'dart:async';\nmain() async {\n$body\n}";
  return await D4rt().execute(
    library: _libPath,
    name: 'main',
    sources: {_libPath: source},
  );
}

void main() {
  group('SCD186: Future.syncValue', () {
    test('F-SCD186-1: completes with the value [2026-09-15] (PASS)', () async {
      expect(await _run('return await Future.syncValue(1);'), 1);
    });

    test('F-SCD186-2: the explicit type-argument form resolves too '
        '[2026-09-15] (PASS)', () async {
      // `Future<T>.syncValue(v)` routes through CONSTRUCTOR lookup while
      // `Future.syncValue(v)` routes through the static path — which is why the
      // bridge registers it in both maps, as the comment above the named
      // factories in `stdlib/async/future.dart` explains. A test of one form
      // would leave the other unproven, and they are genuinely different paths.
      expect(await _run('return await Future<int>.syncValue(2);'), 2);
    });

    test('F-SCD186-3: it does NOT adopt a future argument [2026-09-15] '
        '(PASS)', () async {
      // The distinguishing behaviour. Verified against real Dart first:
      // `await Future<Object?>.syncValue(aFuture)` yields the FUTURE, not its
      // result, because the flattening rule does not apply at static type
      // `Object?`.
      expect(
        await _run('''
          var inner = Future.value(7);
          var v = await Future.syncValue(inner);
          return (v is Future).toString() + '/' + (await v).toString();
        '''),
        'true/7',
      );
    });

    test('F-SCD186-4: CONTROL — Future.value DOES adopt one [2026-09-15] '
        '(PASS)', () async {
      // Without this case F-SCD186-3 shows only that `syncValue` behaves some
      // way, not that it behaves DIFFERENTLY — and "differently" is the entire
      // content of the member. Also verified against real Dart.
      expect(
        await _run('''
          var inner = Future.value(7);
          var v = await Future.value(inner);
          return (v is Future).toString() + '/' + v.toString();
        '''),
        'false/7',
      );
    });

    test('F-SCD186-5: a null value completes with null, not with an error '
        '[2026-09-15] (PASS)', () async {
      // `Future.error(null)` is rejected by the bridge beside this one; a
      // reader could reasonably wonder whether a null VALUE is treated the same
      // way. It is not, and the SDK's guarantee that the future has no error
      // is what says so.
      expect(
        await _run('''
          var v = await Future.syncValue(null);
          return (v == null).toString();
        '''),
        'true',
      );
    });
  });
}
