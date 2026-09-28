/// SCE223 — `BridgedInstance.set` assigns through the bridged setter.
///
/// It threw "not implemented" whatever the class declared. It now assigns
/// through the setter adapter, as `get` reads through the getter adapter, and
/// a class with no such setter reports an undefined member. The script-level
/// half of SCE223 (await into a field or index, await on a non-Future, the
/// multi-variable `for` refusal) is in `tom_d4rt`'s
/// `test/sce223_announced_gaps_test.dart`; this package has no parser.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

class _Box {
  int v = 0;
}

void main() {
  test('F-SCE223-6: BridgedInstance.set assigns through the setter, and a '
      'missing setter is an undefined member [2026-09-29] (PASS)', () {
    final boxClass = BridgedClass(
      nativeType: _Box,
      name: 'Box',
      setters: {
        'v': (visitor, target, value) => (target as _Box).v = value as int,
      },
    );
    final box = _Box();
    BridgedInstance(boxClass, box).set('v', 3);
    expect(box.v, 3);
    expect(
      () => BridgedInstance(boxClass, box).set('nope', 1),
      throwsA(isA<UndefinedMemberD4rtException>()),
    );
  });
}
