// SCF24: a script class that declares no `toString` still has one.
//
// Every Dart object inherits `Object`'s members. A script class that declared
// none of them answered `hashCode`, `runtimeType`, `==` and `'$c'`, but not an
// explicit `c.toString()`, its tear-off, `super.toString()` from a class whose
// superclass is `Object`, or `super.noSuchMethod(i)` inside a `noSuchMethod`
// override — each raised an error naming a member the script correctly did
// not write. The renderer already existed (SCD72's `<instance of C>`, the text
// `'$c'` produces); the lookups did not reach it.
//
// THE ORDERING IS THE RISK, so the rails are asserted beside the fix: a
// script's own `toString` still wins, a subclass of a bridged class still
// answers from its bridge, and an override calling `super.toString()` gets the
// default rendering rather than recursing into itself.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

Object? _run(String source) => D4rt().execute(source: source);

void main() {
  group('SCF24: Object members on a script class that declares none', () {
    test('F-SCF24-1: `c.toString()` renders as `\'\$c\'` does '
        '[2026-09-29] (PASS)', () {
      expect(
        _run(
          'class C {} main() { var c = C(); return [c.toString(), "\$c"]; }',
        ),
        ['<instance of C>', '<instance of C>'],
      );
    });

    test('F-SCF24-2: the tear-off, and calls through `Object` and a closure '
        '[2026-09-29] (PASS)', () {
      expect(
        _run('class C {} main() { var f = C().toString; return f(); }'),
        '<instance of C>',
      );
      expect(
        _run(
          'class C {} String f(Object o) => o.toString(); main() => f(C());',
        ),
        '<instance of C>',
      );
      expect(
        _run('class C {} main() => [C()].map((e) => e.toString()).toList();'),
        ['<instance of C>'],
      );
    });

    test('F-SCF24-3: `super.toString()` from a class whose superclass is '
        '`Object` gives the default, not a recursion [2026-09-29] (PASS)', () {
      expect(
        _run(
          'class C { String toString() => "C:" + super.toString(); } '
          'main() => C().toString();',
        ),
        'C:<instance of C>',
      );
    });

    test('F-SCF24-4: `super.noSuchMethod(i)` raises a NoSuchMethodError a '
        'script can catch [2026-09-29] (PASS)', () {
      expect(
        _run(
          'class C { noSuchMethod(i) => super.noSuchMethod(i); } '
          'main() { dynamic c = C(); '
          'try { c.foo(); return "no throw"; } '
          'on NoSuchMethodError { return "NSME"; } }',
        ),
        'NSME',
      );
    });

    test('F-SCF24-8: `super` through an interpreted superclass that declares '
        'none reaches `Object` too, and `super.hashCode` answers '
        '[2026-09-29] (PASS)', () {
      expect(
        _run(
          'class A {} class B extends A { '
          'String toString() => "B:" + super.toString(); } '
          'main() => B().toString();',
        ),
        'B:<instance of B>',
      );
      expect(
        _run(
          'class C { int h() => super.hashCode; } '
          'main() { var c = C(); return c.h() == c.hashCode; }',
        ),
        isTrue,
      );
    });

    test('F-SCF24-5 (rail): a declared `toString` still wins, in both '
        'spellings [2026-09-29] (PASS)', () {
      expect(
        _run(
          'class M { String toString() => "mine"; } '
          'main() => [M().toString(), "\${M()}"];',
        ),
        ['mine', 'mine'],
      );
    });

    test('F-SCF24-6 (rail): a subclass of a bridged class still answers '
        'from its bridge [2026-09-29] (PASS)', () {
      expect(
        _run(
          'class B extends StringBuffer {} '
          'main() => (B()..write("z")).toString();',
        ),
        'z',
      );
    });

    test('F-SCF24-7 (rail): an inherited script `toString` is still found '
        '[2026-09-29] (PASS)', () {
      expect(
        _run(
          'class A { String toString() => "A"; } class B extends A {} '
          'main() => [B().toString(), "\${B()}"];',
        ),
        ['A', 'A'],
      );
    });
  });
}
