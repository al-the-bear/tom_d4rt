// ghissues26 — a static field reads the top-level constants declared before
// its class.
//
// Measured 2026-11-10: tom_d4rt 1.232.0 (the commit before GitHub #10's fix,
// 3c6f27c3c~1) and the published 1.231.1 answered
//
//   const int _a = 7; const int _b = 8;
//   class C { static const List<int> xs = <int>[_a, _b]; }
//   C.xs                                   // [null, null]
//
// and a static list of a top-level const object read null the same way. Every
// static initializer of a class ran when the class was loaded, before the
// top-level variables were initialized. In the Flutter corpus (GEN-131) a
// State's `static const List<Color> _accents = <Color>[_kSmcrowTeal, ...]`
// held nulls, its getter `_accent` passed null to a widget's `accent`, and the
// widget's `createRenderObject` was refused (`type 'Null' is not a subtype of
// type 'Color' of 'accent'`). Fixed by 1.233.0, which initializes a static or
// top-level variable on its first read (GitHub #10, gh10_static_forward_
// reference_test.dart covers reads among statics and among top-level
// variables); these cases pin the read from a static into the top level. The
// same in tom_d4rt_ast (test/runtime/ghissues26_static_reads_top_level_const_
// test.dart).

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

Object? _run(String source) => D4rt().execute(source: source);

void main() {
  group('ghissues26: a static field reads earlier top-level constants', () {
    test('GHI26-1: a static const list of top-level int constants, read '
        'directly and from an instance getter [2026-11-10]', () {
      expect(
        _run(
          'const int _a = 7;\n'
          'const int _b = 8;\n'
          'class C {\n'
          '  static const List<int> xs = <int>[_a, _b];\n'
          '  int get first => xs[0];\n'
          '}\n'
          'main() => [C.xs, C().first];\n',
        ),
        [
          [7, 8],
          7,
        ],
      );
    });

    test('GHI26-2: a static const list of a top-level const object '
        '[2026-11-10]', () {
      expect(
        _run(
          'class P { const P(this.v); final int v; }\n'
          'const P _a = P(7);\n'
          'class C {\n'
          '  static const List<P> xs = <P>[_a];\n'
          '  P get first => xs[0];\n'
          '}\n'
          'main() => C().first.v;\n',
        ),
        7,
      );
    });

    test('GHI26-3: the corpus shape - a getter picks from the static list by '
        'an instance field and passes it to a constructor with a default '
        '[2026-11-10]', () {
      expect(
        _run(
          'class P { const P(this.v); final int v; }\n'
          'const P _teal = P(1);\n'
          'const P _plum = P(2);\n'
          'class Card { const Card({this.accent = _teal}); final P accent; }\n'
          'class Config {\n'
          '  int index = 1;\n'
          '  static const List<P> _accents = <P>[_teal, _plum];\n'
          '  P get _accent => _accents[index % _accents.length];\n'
          '  Card preview() => Card(accent: _accent);\n'
          '}\n'
          'main() => [Config().preview().accent.v, const Card().accent.v];\n',
        ),
        [2, 1],
      );
    });
  });
}
