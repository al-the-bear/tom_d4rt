// SCF19: an interpreted subclass of a bridged class reaches the members that
// class INHERITS, not only the ones its bridge declares.
//
// A bridge carries the members its class declares, so the `ListQueue` bridge
// has `removeFirst` and no `elementAt` — that comes from `Iterable`. A bare
// `ListQueue()` found it anyway, through the visitor's walk over registered
// supertypes. `class MyQ extends ListQueue {}` did not: every path from an
// interpreted instance to its bridged superclass asked that one bridge's own
// maps, so `elementAt`, `first` and `map` were absent — through `q.`, bare
// inside a method, and `super.` alike, each raising a different exception
// type. `BridgedClass.findReachable*Adapter` is the walk, used at every such
// path; the method-invocation path also now passes the visitor to
// `InterpretedInstance.get`, without which the walk has no environment to
// resolve supertype names in.
//
// The analyzer-free twin is
// `tom_d4rt_ast/test/runtime/scf19_inherited_bridged_member_test.dart`.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

Object? _run(String body) => D4rt().execute(
  source:
      '''
import 'dart:collection';
class MyQ extends ListQueue {
  bare() => elementAt(0);
  viaSuper() => super.elementAt(0);
  declared() => super.removeFirst();
  sum() => fold(0, (a, b) => a + b);
}
main() { var q = MyQ(); q.addLast(7); $body }
''',
);

void main() {
  group('SCF19: an interpreted subclass reaches inherited bridged members', () {
    test('F-SCF19-1: `q.elementAt(0)` on the subclass [2026-09-29] (PASS)', () {
      expect(_run('return q.elementAt(0);'), 7);
    });

    test('F-SCF19-2: bare `elementAt(0)` inside a method '
        '[2026-09-29] (PASS)', () {
      expect(_run('return q.bare();'), 7);
    });

    test('F-SCF19-3: `super.elementAt(0)` [2026-09-29] (PASS)', () {
      expect(_run('return q.viaSuper();'), 7);
    });

    test('F-SCF19-4: an inherited getter, `q.first` [2026-09-29] (PASS)', () {
      expect(_run('return q.first;'), 7);
    });

    test('F-SCF19-5: inherited members taking a callback, `map` and a bare '
        '`fold` [2026-09-29] (PASS)', () {
      expect(_run('return q.map((e) => e + 1).toList();'), [8]);
      expect(_run('q.addLast(3); return q.sum();'), 10);
    });

    test('F-SCF19-6: a DECLARED member still resolves, '
        '`super.removeFirst()` [2026-09-29] (PASS)', () {
      // The control: this worked before, through the bridge's own map.
      expect(_run('return q.declared();'), 7);
    });

    test('F-SCF19-7: a name no bridge in the chain has is still an '
        'undefined member [2026-09-29] (PASS)', () {
      // The walk must end where the chain ends, not invent a member.
      expect(
        () => _run('return q.noSuchThing(0);'),
        throwsA(
          predicate((e) => '$e'.contains("no method named 'noSuchThing'")),
        ),
      );
    });
  });
}
