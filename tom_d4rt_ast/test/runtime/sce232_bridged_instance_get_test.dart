/// SCE232 — `BridgedInstance.get` resolves a bridged member the way the
/// interpreter's readers do: getter first, then bound method, then an enum
/// wrapper's `name` / `index`.
///
/// It was methods-only, so a getter reached through it threw. Nothing in the
/// interpreter calls it (0 calls across the `tom_d4rt` suite, measured
/// 2026-09-29); it is a primitive for host code. The order is unobservable for
/// method names because no name may sit in two member maps
/// (`scd196_member_map_disjointness_test.dart`).
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

void main() {
  final boxClass = BridgedClass(
    nativeType: _Box,
    name: 'Box',
    getters: {
      'v': (visitor, target) => (target as _Box).v,
      'seen': (visitor, target) => visitor == null ? 'no visitor' : 'visitor',
    },
    methods: {
      'm': (visitor, target, positional, named, _) => (target as _Box).m(),
    },
  );

  test('F-SCE232-1: BridgedInstance.get reads a bridged GETTER, as the '
      'interpreter readers do [2026-09-29] (PASS)', () {
    // Methods-only until SCE232: this threw UndefinedMemberD4rtException.
    expect(BridgedInstance(boxClass, _Box()).get('v'), 41);
  });

  test('F-SCE232-2: without a visitor the getter adapter is handed null, '
      'which its type allows [2026-09-29] (PASS)', () {
    expect(BridgedInstance(boxClass, _Box()).get('seen'), 'no visitor');
  });

  test('F-SCE232-3: a METHOD name still answers the bound callable '
      '[2026-09-29] (PASS)', () {
    final m = BridgedInstance(boxClass, _Box()).get('m');
    expect(m, isA<BridgedMethodCallable>());
  });

  test('F-SCE232-4: an enum wrapper answers name/index, and an absent '
      'member is undefined [2026-09-29] (PASS)', () {
    final enumClass = BridgedClass(nativeType: _Shade, name: 'Shade');
    final dark = BridgedInstance(enumClass, _Shade.dark);
    expect(dark.get('name'), 'dark');
    expect(dark.get('index'), 1);
    expect(BridgedInstance(enumClass, _Shade.light).get('index'), 0);
    expect(
      () => BridgedInstance(boxClass, _Box()).get('nope'),
      throwsA(isA<UndefinedMemberD4rtException>()),
    );
  });
}

class _Box {
  int v = 41;
  int m() => 7;
}

enum _Shade { light, dark }
