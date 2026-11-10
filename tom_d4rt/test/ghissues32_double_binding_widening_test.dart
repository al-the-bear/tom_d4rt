// ghissues32 — an int bound to a declared `double` holds a double, wherever
// it is bound.
//
// Measured 2026-11-10 on this tree (1.253.0), `D4rt().execute`:
//
//   main() { double x = 0; return x; }            // 0.0 - correct
//   double g(double v) => v; g(1)                 // 1.0 - correct
//   class C { double f = 0; } C().f               // 0   (Dart: 0.0)
//   class W { W({this.radius = 14}); final double radius; } W().radius // 14
//
// Dart widens an int literal bound to a `double`. A local declaration and a
// typed parameter went through `ResolvedBinding.bind`, which widens; a field
// initializer, a static or top-level variable, a field formal (it has no type
// annotation of its own) and an initializer-list assignment stored the int as
// is. A script that prints the value, compares its runtimeType or hands it to
// an API that checks `is double` saw the difference (the Flutter corpus's
// `double _accentIndex = 0`, `this.radius = 14`). The same in tom_d4rt_ast
// (test/runtime/ghissues32_double_binding_widening_test.dart).

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

Object? _run(String declarations, String body) => D4rt().execute(
  library: 'package:p/main.dart',
  sources: {
    'package:p/main.dart':
        '$declarations\n'
        'Object? _show(Object? v) => [v.runtimeType.toString(), "\$v"];\n'
        'main() => $body;\n',
  },
);

const _double0 = ['double', '0.0'];

void main() {
  group('GHI32: an int bound to a declared double holds a double', () {
    test('GHI32-1: an instance field initializer [2026-11-10]', () {
      expect(_run('class C { double f = 0; }', '_show(C().f)'), _double0);
    });

    test('GHI32-2: a static field and a top-level variable '
        '[2026-11-10]', () {
      expect(_run('class C { static double s = 0; }', '_show(C.s)'), _double0);
      expect(_run('double t = 0;', '_show(t)'), _double0);
      expect(_run('final double t = 0;', '_show(t)'), _double0);
    });

    test('GHI32-3: a field formal with a default and with a passed int '
        '[2026-11-10]', () {
      const w =
          'class W { W({this.radius = 14}); final double radius; }\n'
          'class P { P(this.radius); final double radius; }';
      expect(_run(w, '_show(W().radius)'), ['double', '14.0']);
      expect(_run(w, '_show(W(radius: 3).radius)'), ['double', '3.0']);
      expect(_run(w, '_show(P(7).radius)'), ['double', '7.0']);
    });

    test('GHI32-4: an initializer-list assignment [2026-11-10]', () {
      expect(
        _run(
          'class C { C() : _x = 0; final double _x; get x => _x; }',
          '_show(C().x)',
        ),
        _double0,
      );
    });

    test('GHI32-5: a nullable double field and field formal '
        '[2026-11-10]', () {
      expect(_run('class C { double? f = 0; }', '_show(C().f)'), _double0);
      expect(_run('class C { C([this.f = 2]); double? f; }', '_show(C().f)'), [
        'double',
        '2.0',
      ]);
      // `null.runtimeType` throws in the interpreter (todo nullobj1), so the
      // unset field is checked by value.
      expect(
        _run('class C { C([this.f]); double? f; }', 'C().f == null'),
        isTrue,
      );
    });

    test('GHI32-6: an assignment to a double field after construction '
        '[2026-11-10]', () {
      expect(_run('class C { double f = 1.5; }', '_show((C()..f = 4).f)'), [
        'double',
        '4.0',
      ]);
    });

    test('GHI32-7: num and int fields keep an int [2026-11-10]', () {
      expect(
        _run(
          'class C { num n = 1; int i = 2; }',
          '[_show(C().n), _show(C().i)]',
        ),
        [
          ['int', '1'],
          ['int', '2'],
        ],
      );
    });
  });
}
