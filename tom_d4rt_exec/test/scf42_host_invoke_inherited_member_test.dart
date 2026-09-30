// SCF42: the HOST `invoke` path reaches the members a bridged superclass
// inherits, as every script path does since SCF19.
//
// `D4rt.invoke(name, args)` calls a member on the interpreted instance a
// script returned. Its bridged-superclass branch asked only the immediate
// bridge's own maps, so for `class MyQ extends ListQueue`, the `ListQueue`
// bridge's `removeFirst` was reachable and `Iterable`'s `elementAt` and
// `first` were not ("Method or getter not found"), although `q.elementAt(0)`
// inside the script worked. It now uses `BridgedClass.findReachable*Adapter`,
// the walk SCF19 put under every other path.
//
// Exec's mirrored `d4rt_base.dart` makes the same change; its port of this
// file is `tom_d4rt_exec/test/scf42_host_invoke_inherited_member_test.dart`.

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

D4rt _prepared() {
  final d4rt = D4rt();
  d4rt.execute(
    source: '''
import 'dart:collection';
class MyQ extends ListQueue {}
main() { var q = MyQ(); q.addLast(7); q.addLast(8); return q; }
''',
  );
  return d4rt;
}

void main() {
  group('SCF42: host invoke reaches inherited bridged members', () {
    test('F-SCF42-1: an inherited method, `elementAt` [2026-09-30] (PASS)', () {
      expect(_prepared().invoke('elementAt', [1]), 8);
    });

    test('F-SCF42-2: an inherited getter, `first` [2026-09-30] (PASS)', () {
      expect(_prepared().invoke('first', []), 7);
    });

    test('F-SCF42-3: control — a member the bridge declares, `removeFirst` '
        '[2026-09-30] (PASS)', () {
      expect(_prepared().invoke('removeFirst', []), 7);
    });

    test('F-SCF42-4: a name no bridge in the chain has is still refused '
        '[2026-09-30] (PASS)', () {
      expect(
        () => _prepared().invoke('noSuchThing', []),
        throwsA(predicate((e) => '$e'.contains('noSuchThing'))),
      );
    });
  });
}
