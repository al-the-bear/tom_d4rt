// SCF27: a bounded generic class accepts its own constructor.
//
// `class Box<T extends num> { final T v; Box(this.v); } Box(3)` failed with
// "Type argument 'dynamic' for type parameter 'T' does not satisfy bound
// 'num'". A class type argument that is not WRITTEN is not inferred here; it
// is filled with `dynamic`, the interpreter's "unknown", and that unknown was
// then measured against the bound and refused — so every bounded class had
// to spell its argument out at every construction.
//
// The bound is now checked for WRITTEN arguments only. That is the behaviour
// a bounded generic FUNCTION already had (`T id<T extends num>(T x)`, called
// as `id(3)`, is not checked either) — the asymmetry was the class path, and
// it is the class path that changed. It does not make the bound mean anything
// for an unwritten argument; nothing is enforced there, as for functions.
//
// Measured 2026-09-29 before the fix: a bounded MIXIN (`with M`) and a
// bounded EXTENSION TYPE (`E(3)`) already ran without a written argument, so
// only a class construction was affected.

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

Object? _run(String source) => D4rt().execute(source: source);

const _box = 'class Box<T extends num> { final T v; Box(this.v); } ';

void main() {
  group('SCF27: a bounded generic class without a written argument', () {
    test('F-SCF27-1: `Box(3)` constructs [2026-09-29] (PASS)', () {
      expect(_run('$_box main() => Box(3).v;'), 3);
    });

    test('F-SCF27-2: a no-argument constructor of a bounded class '
        '[2026-09-29] (PASS)', () {
      expect(
        _run('class Box<T extends num> { Box(); } main() => Box() is Box;'),
        isTrue,
      );
    });

    test('F-SCF27-3 (control): a WRITTEN argument outside the bound is still '
        'refused, `dynamic` included [2026-09-29] (PASS)', () {
      // The anti-vacuity half. A fix that dropped the bound check outright
      // would pass F-SCF27-1/-2 and fail here.
      for (final arg in ['String', 'dynamic']) {
        expect(
          () => _run("$_box main() => Box<$arg>('a').v;"),
          throwsA(
            predicate(
              (e) => '$e'.contains(
                "Type argument '$arg' for type parameter 'T' does not "
                "satisfy bound 'num' in class 'Box'",
              ),
            ),
          ),
          reason: 'Box<$arg>',
        );
      }
    });

    test('F-SCF27-4 (control): a written argument inside the bound '
        '[2026-09-29] (PASS)', () {
      expect(_run('$_box main() => Box<int>(3).v;'), 3);
    });

    test('F-SCF27-5: the class and function paths now agree — an unwritten '
        'argument is not checked, a written one is [2026-09-29] (PASS)', () {
      expect(_run('T id<T extends num>(T x) => x; main() => id(3);'), 3);
      expect(
        () => _run("T id<T extends num>(T x) => x; main() => id<String>('a');"),
        throwsA(
          predicate((e) => '$e'.contains("does not satisfy bound 'num'")),
        ),
      );
    });
  });
}
