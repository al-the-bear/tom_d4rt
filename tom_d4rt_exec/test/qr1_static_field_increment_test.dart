// QR1 — `++` / `--` on a static field updates the static.
//
// Measured 2026-11-07 on tom_d4rt 1.231.1 and tom_d4rt_ast 0.212.1, both trees
// alike:
//
//     class A { static int n = 0; A() { n++; } }             // two A(): 0, Dart 2
//     class C { static int n = 0; void inc() { n++; } }      // two inc(): 0, Dart 2
//     class E { static int n = 0; static void inc() { n++; } } // two inc(): 0, Dart 2
//     class B { static int n = 0; B() { Box2.n++; } }        // threw
//
// while `n = n + 1` and `n += 1` were right. SCE125 had fixed the ASSIGNMENT
// path for a bare static name; the increment / decrement path kept two
// routes of its own, each with SCE125's defect in a different place:
//
// * in an instance member (constructor, method) the bare name resolves
//   through implicit `this`, and the write went to `thisInstance.set`, which
//   creates a per-instance field — the static never changed, and the method
//   could read its own shadow back;
// * in a static member the bare name resolves in the static-field SNAPSHOT
//   the member runs in, and the write only touched that snapshot, discarded
//   when the call returns — the propagation `visitAssignmentExpression` does
//   was never applied.
//
// And `Box.n++` (a PrefixedIdentifier, the parser's form for `Class.member`)
// had no handler for a class target at all.
//
// And while fixing it: prefix `++c` on a bare INSTANCE field threw
// 'Assigning to undefined variable', because the prefix path wrote a bare name
// back with `environment.assign` only (QR1-9).
//
// ABLATION: each group fails on the pre-fix tree (see the commit).

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

Object? run(String source) => D4rt().execute(source: source, name: 'main');

void main() {
  group('QR1: increment / decrement of a bare static name', () {
    test('QR1-1: n++ in a constructor counts constructions [2026-11-07]', () {
      expect(
        run(
          'class A { static int n = 0; A() { n++; } }\n'
          'main() { A(); A(); return A.n; }',
        ),
        2,
      );
    });

    test('QR1-2: n++ and n-- in an instance method update the static, '
        'seen from outside and from a second instance [2026-11-07]', () {
      expect(
        run(
          'class C { static int n = 0; void inc() { n++; } void dec() { n--; } }\n'
          'main() { final a = C(); final b = C(); a.inc(); b.inc(); a.inc(); b.dec();\n'
          '  return [C.n, a.read(), b.read()]; }\n'
          'extension on C { int read() => C.n; }',
        ),
        [2, 2, 2],
      );
      // The bare read inside the method agrees with the static: no shadow.
      expect(
        run(
          'class C { static int n = 0; List go() { n++; return [n, C.n]; } }\n'
          'main() { C().go(); return C().go(); }',
        ),
        [2, 2],
      );
    });

    test('QR1-3: n++ in a static method updates the static [2026-11-07]', () {
      expect(
        run(
          'class E { static int n = 0; static void inc() { n++; } '
          'static void dec() { n--; } }\n'
          'main() { E.inc(); E.inc(); E.inc(); E.dec(); return E.n; }',
        ),
        2,
      );
    });

    test('QR1-4: prefix ++n / --n update the static and yield the new '
        'value; postfix yields the old one [2026-11-07]', () {
      expect(
        run(
          'class P { static int n = 0;\n'
          '  List inst() => [n++, ++n, --n, n--];\n'
          '  static List stat() => [n++, ++n, --n, n--]; }\n'
          'main() { final a = P().inst(); final aAfter = P.n;\n'
          '  final b = P.stat(); return [a, aAfter, b, P.n]; }',
        ),
        [
          [0, 2, 1, 1],
          0,
          [0, 2, 1, 1],
          0,
        ],
      );
    });

    test('QR1-5: compound n += 1 and n -= 1 stay right in every member kind '
        '[2026-11-07]', () {
      expect(
        run(
          'class K { static int n = 0; K() { n += 1; } void m() { n += 10; }\n'
          '  static void s() { n -= 1; } }\n'
          'main() { K().m(); K.s(); return K.n; }',
        ),
        10,
      );
    });

    test('QR1-6: a local or parameter named like the static is what the '
        'bare name means; the static is untouched [2026-11-07]', () {
      expect(
        run(
          'class L { static int n = 5;\n'
          '  int local() { var n = 0; n++; return n; }\n'
          '  int param(int n) { n++; return n; }\n'
          '  static int staticLocal() { var n = 10; n++; return n; } }\n'
          'main() { return [L().local(), L().param(7), L.staticLocal(), L.n]; }',
        ),
        [1, 8, 11, 5],
      );
    });
  });

  group('QR1: a local or parameter in a static member shadows the static', () {
    // Found while fixing the increment: a static member runs in an
    // environment that holds a snapshot of the class's static fields, and its
    // parameters and locals are defined into that SAME environment. The
    // write-back propagation (OPEN B.9) asked only whether the defining
    // environment was the snapshot scope, so a local or parameter of the
    // static's name wrote through to the static on every ASSIGNMENT. Measured
    // before the fix: [11, 11], [11, 11], [3, 3], [2, 2].
    test('QR1-10: assignment to a shadowing local or parameter leaves the '
        'static alone [2026-11-07]', () {
      String probe(String body, [String params = '', String args = '']) =>
          'class L { static int n = 5; static int f($params) { $body } }\n'
          'main() { return [L.f($args), L.n]; }';
      expect(run(probe('var n = 10; n = n + 1; return n;')), [11, 5]);
      expect(run(probe('var n = 10; n += 1; return n;')), [11, 5]);
      expect(run(probe('var n = 10; { n = 3; } return n;')), [3, 5]);
      expect(run(probe('n = n + 1; return n;', 'int n', '1')), [2, 5]);
      expect(run(probe('n++; return n;', 'int n', '1')), [2, 5]);
      // And the static itself is still written through when not shadowed.
      expect(run(probe('n = n + 1; return n;')), [6, 6]);
    });
  });

  group('QR1: prefix increment of a bare INSTANCE name', () {
    // Found while fixing the static case: the prefix path wrote a bare name
    // back with `environment.assign` only, so a field reached through
    // implicit `this` threw 'Assigning to undefined variable' - even an
    // ordinary instance field. Postfix `c++` worked.
    test('QR1-9: ++c / --c on an instance field and through an instance '
        'setter [2026-11-07]', () {
      expect(
        run(
          'class C { int c = 0; int inc() { ++c; ++c; --c; return c; } }\n'
          'main() => C().inc();',
        ),
        1,
      );
      expect(
        run(
          'class S { int _v = 0; int get v => _v; set v(int x) { _v = x * 10; }\n'
          '  int bump() => ++v; }  // ++v is the value assigned (1), as in Dart\n'
          'main() { final s = S(); return [s.bump(), s.v]; }',
        ),
        [1, 10],
      );
    });
  });

  group('QR1: increment / decrement of a qualified static name', () {
    test(
      'QR1-7: Box.n++ in a constructor counts constructions [2026-11-07]',
      () {
        expect(
          run(
            'class Box2 { static int made = 0; Box2() { Box2.made++; } }\n'
            'main() { Box2(); Box2(); return Box2.made; }',
          ),
          2,
        );
      },
    );

    test('QR1-8: Class.n++, ++Class.n, Class.n-- and --Class.n from outside '
        'the class, with their values [2026-11-07]', () {
      expect(
        run(
          'class Q { static int n = 0; }\n'
          'main() { final r = [Q.n++, ++Q.n, Q.n--, --Q.n]; return [r, Q.n]; }',
        ),
        [
          [0, 2, 2, 0],
          0,
        ],
      );
    });
  });
}
