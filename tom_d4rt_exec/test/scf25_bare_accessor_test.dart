// SCF25: a bare name reaches the getter or setter it names.
//
// Inside a static member the owner class's statics are snapshotted into the
// execution environment so they resolve without a prefix. Static fields were
// snapshotted as values; static getters and setters were snapshotted as the
// FUNCTIONS themselves, under the plain name. So a bare read of a static
// getter returned the getter (`<fn dbl>`), a bare write to a static setter
// rebound the name and dropped the write, and a getter and setter of one name
// collided. Top-level accessors had the same shape and the same defects:
// `int get g => 1; main() => g;` answered the function, and `s = 3` never
// called `set s`. From an instance method a bare write to a static setter
// landed on the instance instead.
//
// A setter is now bound under Dart's own setter name, `v=`, so the pair no
// longer collides; a bare read of a getter calls it; and a bare write calls
// the setter unless a closer binding of the plain name shadows it.

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

Object? _run(String source) => D4rt().execute(source: source);

const _box = '''
class Box {
  static int _x = 0;
  static set v(int n) { _x = n + 100; }
  static int get v => _x;
  static int get dbl => _x * 2;
  static void sm() { v = 5; }
  void im() { v = 5; }
  static int sread() => dbl;
  static void compound() { v += 1; }
}
''';

void main() {
  group('SCF25: bare accessors are called, not rebound', () {
    test('F-SCF25-1: the qualified write still reaches the setter '
        '[2026-09-29] (PASS)', () {
      expect(_run('$_box main() { Box.v = 5; return Box.v; }'), 105);
    });

    test('F-SCF25-2: a bare write inside a STATIC method reaches the setter '
        '[2026-09-29] (PASS)', () {
      expect(_run('$_box main() { Box.sm(); return Box.v; }'), 105);
    });

    test('F-SCF25-3: a bare write inside an INSTANCE method reaches the '
        'static setter [2026-09-29] (PASS)', () {
      expect(_run('$_box main() { Box().im(); return Box.v; }'), 105);
    });

    test('F-SCF25-4: a bare read of a static getter inside a static method '
        'calls it [2026-09-29] (PASS)', () {
      expect(_run('$_box main() { Box.v = 5; return Box.sread(); }'), 210);
    });

    test('F-SCF25-5: a bare compound write reads through the getter and '
        'writes through the setter [2026-09-29] (PASS)', () {
      // _x = 0; v += 1 reads v (0) and sets 1, so _x = 101.
      expect(_run('$_box main() { Box.compound(); return Box.v; }'), 101);
    });

    test('F-SCF25-6: top-level getters and setters, including a pair of one '
        'name [2026-09-29] (PASS)', () {
      expect(_run('int get g => 1; main() => g;'), 1);
      expect(
        _run(
          'List<int> log = []; set s(int v) { log.add(v); } '
          'main() { s = 3; return log; }',
        ),
        [3],
      );
      expect(
        _run(
          'int _x = 0; int get v => _x; set v(int n) { _x = n * 10; } '
          'main() { v = 2; return [v, _x]; }',
        ),
        [20, 20],
      );
    });

    test('F-SCF25-8: `++v`, `v--` and `v ??= x` go through the accessor pair '
        '[2026-09-29] (PASS)', () {
      const pair = 'int? _x = 0; int? get v => _x; set v(int? n) { _x = n; } ';
      expect(_run('$pair main() { ++v; v++; v--; return [v, _x]; }'), [1, 1]);
      expect(_run('$pair main() { _x = null; v ??= 4; return [v, _x]; }'), [
        4,
        4,
      ]);
    });

    test('F-SCF25-7 (rail): a closer local still shadows the accessor '
        '[2026-09-29] (PASS)', () {
      expect(
        _run(
          'int _x = 0; set v(int n) { _x = n; } '
          'main() { var v = 1; v = 2; return [v, _x]; }',
        ),
        [2, 0],
      );
    });
  });
}
