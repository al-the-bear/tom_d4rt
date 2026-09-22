// SCE125 — a bare write to a static field from an instance method updates the
// static, not a per-instance shadow.
//
//     class Box { static int v = 1; void go() { v += 1; } }
//     main() { Box().go(); return Box.v; }   // real Dart 2, d4rt 1
//
// THE READ PATH WAS ALWAYS RIGHT, and that is what made the two halves
// disagree rather than both being wrong. `InterpretedInstance.get` walks the
// class chain and finds the static when no instance field shadows it. The
// WRITE path reached `thisInstance.set(name, …)`, which CREATES a field when
// none exists — so the write minted an instance field, and the next bare read
// found that field instead of the static.
//
// THE DISCRIMINATOR IS F-SCE125-2, and it is what the todo's notes asked for:
// write by bare name, then read back BOTH ways inside the same method. Before
// the fix that answered `[2, 1, 1]` — bare read 2, qualified read 1, static 1
// — which distinguishes "the write created a shadow" from "the write reached
// the static and something reverted it". Only the first explains all three.
//
// WHY IT WAS SILENT, and why `high` rather than `medium`: the method can read
// its OWN write back, so `v += 1; return v;` answers 2 and any test that
// checks the value inside the method passes. A script counting something in a
// static field from an instance method counts nothing, and the obvious test
// for it agrees that it works. F-SCE125-3 pins the two-instance form, which is
// the sharpest statement of the old behaviour: instance `a` saw 2 and instance
// `b` saw 1, of a field the class declares `static`.
//
// IN DART A CLASS CANNOT DECLARE A STATIC AND AN INSTANCE MEMBER OF THE SAME
// NAME, so finding a static means there is no instance member to prefer and
// the check can come first. F-SCE125-5 holds the three things that legitimately
// come before it anyway — a local, a parameter, and an instance setter.
//
// ABLATED 2026-09-22 by removing the `_staticFieldOwner` short-circuit:
// F-SCE125-1, -2, -3, -4 and -6 fail; -5 passes, which is what makes it the
// rail rather than a restatement.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

Object? run(String source) => D4rt().execute(source: source, name: 'main');

void main() {
  group('SCE125: a bare static write from an instance method', () {
    test('F-SCE125-1: the static is updated, seen from outside [2026-09-22] '
        '(PASS)', () {
      // Compound and plain, both of which were wrong.
      expect(
        run(
          'class Box { static int v = 1; void go() { v += 1; } }\n'
          'main() { Box().go(); return Box.v; }',
        ),
        2,
      );
      expect(
        run(
          'class Box { static int v = 1; void go() { v = 5; } }\n'
          'main() { Box().go(); return Box.v; }',
        ),
        5,
      );
    });

    test('F-SCE125-2: the bare read, the qualified read and the outside read '
        'agree [2026-09-22] (PASS)', () {
      // The discriminator. `[2, 1, 1]` before the fix: the bare read found a
      // freshly minted instance field, the qualified read found the untouched
      // static. Nothing but a shadow explains that triple.
      expect(
        run(
          'class Box {\n'
          '  static int v = 1;\n'
          '  List go() { v += 1; return [v, Box.v]; }\n'
          '}\n'
          'main() { var r = Box().go(); return [r[0], r[1], Box.v]; }',
        ),
        [2, 2, 2],
      );
      expect(
        run(
          'class Box {\n'
          '  static int v = 1;\n'
          '  List go() { v = 9; return [v, Box.v]; }\n'
          '}\n'
          'main() { var r = Box().go(); return [r[0], r[1], Box.v]; }',
        ),
        [9, 9, 9],
      );
    });

    test('F-SCE125-3: two instances see one value [2026-09-22] (PASS)', () {
      // The sharpest statement of the old behaviour: `a` saw 2 and `b` saw 1,
      // of a field the class declares `static`.
      expect(
        run(
          'class Box {\n'
          '  static int v = 1;\n'
          '  void go() { v += 1; }\n'
          '  int peek() => v;\n'
          '}\n'
          'main() { var a = Box(); var b = Box(); a.go(); '
          'return [a.peek(), b.peek(), Box.v]; }',
        ),
        [2, 2, 2],
      );
    });

    test('F-SCE125-4: the write survives the call [2026-09-22] (PASS)', () {
      // The counter idiom, which is what a script actually writes, from a
      // constructor body and from a method.
      expect(
        run(
          'class Box { static int made = 0; Box() { made += 1; } }\n'
          'main() { Box(); Box(); Box(); return Box.made; }',
        ),
        3,
      );
      expect(
        run(
          'class Box { static List log = []; void go(String s) { log.add(s); } }\n'
          'main() { Box().go("a"); Box().go("b"); return Box.log; }',
        ),
        ['a', 'b'],
        reason:
            'mutating through a bare read always worked; the write is the '
            'half that did not, and both have to land on one object',
      );
    });

    test('F-SCE125-5 (rails): what legitimately comes first still does '
        '[2026-09-22] (PASS)', () {
      // An instance field of the same shape stays per-instance.
      expect(
        run(
          'class Box { int v = 1; void go() { v += 1; } int peek() => v; }\n'
          'main() { var a = Box(); var b = Box(); a.go(); '
          'return [a.peek(), b.peek()]; }',
        ),
        [2, 1],
      );
      // A local and a parameter shadow the static, and the static is untouched.
      expect(
        run(
          'class Box { static int v = 1; '
          'int go() { var v = 10; v += 1; return v; } }\n'
          'main() { var r = Box().go(); return [r, Box.v]; }',
        ),
        [11, 1],
      );
      expect(
        run(
          'class Box { static int v = 1; int go(int v) { v += 1; return v; } }\n'
          'main() { var r = Box().go(7); return [r, Box.v]; }',
        ),
        [8, 1],
      );
      // An instance setter is still what a bare write reaches when there is no
      // static of that name.
      expect(
        run(
          'class Box {\n'
          '  int _x = 0;\n'
          '  set v(int n) { _x = n + 100; }\n'
          '  int get peek => _x;\n'
          '  void go() { v = 5; }\n'
          '}\n'
          'main() { var b = Box(); b.go(); return b.peek; }',
        ),
        105,
      );
    });

    test('F-SCE125-6: the write resolves where the read resolves '
        '[2026-09-22] (PASS)', () {
      // The fix mirrors `InterpretedInstance.get`'s walk, superclasses
      // included, so the two halves cannot disagree about which class owns the
      // name. (Dart does not inherit statics; this tree does on the read side,
      // and the point here is that one rule now governs both.)
      expect(
        run(
          'class A { static int v = 1; }\n'
          'class B extends A { void go() { v += 1; } }\n'
          'main() { B().go(); return A.v; }',
        ),
        2,
      );
      // Reached from a static method and from `main` — the two forms that
      // already worked, so a fix that moved them fails here.
      expect(
        run(
          'class Box { static int v = 1; static void go() { v += 1; } }\n'
          'main() { Box.go(); return Box.v; }',
        ),
        2,
      );
      expect(
        run(
          'class Box { static int v = 1; }\n'
          'main() { Box.v += 1; return Box.v; }',
        ),
        2,
      );
    });
  });
}
