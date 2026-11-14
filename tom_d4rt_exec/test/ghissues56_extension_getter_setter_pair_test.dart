// ghissues56 — an extension holds a getter and a setter of one name.
//
// Measured 2026-11-14 on tom_d4rt 1.261.0 (tree):
//
//   class Box { int v = 1; }
//   extension E on Box { int get w => v * 10; set w(int x) { v = x; } }
//   main() { final b = Box(); b.w = 3; return [b.v, b.w]; }
//   // threw: Undefined property 'w' on Box (Dart: [3, 30])
//
// An InterpretedExtension kept every instance member in one map keyed by
// name, so the setter `w` replaced the getter `w`; a bridged extension's
// `getters` and `setters` were merged the same way. Setters now sit apart
// (`InterpretedExtension.setters`, `findSetter`), the setter sites look them
// up with `findExtensionMember(..., setter: true)`, and the explicit override
// (ghissues53) takes the setter for `E(x).p = v`.
//
// The pair made more paths reachable, and they now go through the extension
// too: an extension setter on a native receiver (`list.p = v` threw "No
// setter adapter found"), and a compound update or `++` / `--` of an
// extension property (`b.w += 1`, `b.w++` read the class's own members only).
// A property the receiver's class declares itself still wins over an
// extension of the same name, as in Dart. The same in tom_d4rt_ast
// (test/runtime/ghissues56_extension_getter_setter_pair_test.dart).
//
// Name resolution: an extension setter now resolves where the getter of the
// same name hid it.

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

const _box = '''
class Box { int v = 1; }
extension E on Box {
  int get w => v * 10;
  set w(int x) { v = x; }
}
''';

Object? _run(String main) {
  final d4rt = D4rt()
    ..registerBridgedExtension(
      BridgedExtensionDefinition(
        name: 'Gh56Size',
        onTypeName: 'List',
        getters: {'size': (visitor, target) => (target as List).length},
        setters: {
          'size': (visitor, target, value) {
            (target as List).length = value as int;
          },
        },
      ),
      'package:b/b.dart',
    );
  return d4rt.execute(
    library: 'package:p/main.dart',
    sources: {'package:r/r.dart': _box, 'package:p/main.dart': main},
  );
}

void main() {
  group('ghissues56: a getter and a setter of one name in an extension', () {
    test('GHI56-1: the measured script answers [3, 30] [2026-11-14]', () {
      expect(
        _run(
          "import 'package:r/r.dart';\n"
          'Object main() { final b = Box(); b.w = 3; return [b.v, b.w]; }',
        ),
        [3, 30],
      );
    });

    test('GHI56-2: compound assignment and ++ / -- on the extension property '
        '[2026-11-14]', () {
      expect(
        _run(
          "import 'package:r/r.dart';\n"
          'Object main() {\n'
          '  final b = Box();\n'
          '  b.w += 2;\n'
          '  final post = b.w++;\n'
          '  final pre = ++b.w;\n'
          '  b.w--;\n'
          '  return [b.v, post, pre];\n'
          '}',
        ),
        // b.w += 2: 10 + 2 -> v 12; b.w++: 120 -> v 121 (yields 120);
        // ++b.w: 1210 + 1 -> v 1211 (yields 1211); b.w--: 12110 - 1 -> 12109.
        [12109, 120, 1211],
      );
    });

    test('GHI56-3: through a prefixed import, and on a field of another '
        'object [2026-11-14]', () {
      expect(
        _run(
          "import 'package:r/r.dart' as r;\n"
          'class Holder { r.Box b = r.Box(); }\n'
          'Object main() {\n'
          '  final h = Holder();\n'
          '  h.b.w = 4;\n'
          '  h.b.w += 1;\n'
          '  return [h.b.v, h.b.w];\n'
          '}',
        ),
        [41, 410],
      );
    });

    test('GHI56-4: an interpreted extension on a native receiver '
        '[2026-11-14]', () {
      expect(
        _run(
          'extension Half on List<int> {\n'
          '  int get head2 => this[0] * 2;\n'
          '  set head2(int x) { this[0] = x ~/ 2; }\n'
          '}\n'
          'Object main() {\n'
          '  final l = [1];\n'
          '  l.head2 = 10;\n'
          '  final set = l[0];\n'
          '  l.head2 += 4;\n'
          '  l.head2++;\n'
          '  return [set, l, l.head2];\n'
          '}',
        ),
        // head2 = 10 -> [5]; += 4: 10 + 4 -> [7]; ++: 14 + 1 -> [7].
        [
          5,
          [7],
          14,
        ],
      );
    });

    test('GHI56-5: a bridged extension with a getter and a setter of one '
        'name [2026-11-14]', () {
      expect(
        _run(
          "import 'package:b/b.dart';\n"
          'Object main() {\n'
          '  final l = <int?>[1, 2, 3];\n'
          '  l.size = 1;\n'
          '  final after = l.size;\n'
          '  l.size += 1;\n'
          '  return [after, l];\n'
          '}',
        ),
        [
          1,
          [1, null],
        ],
      );
    });

    test('GHI56-6: the explicit override - E(x).p = v, += v, p++ and ++p '
        '(ghissues53) [2026-11-14]', () {
      expect(
        _run(
          "import 'package:r/r.dart';\n"
          'Object main() {\n'
          '  final b = Box();\n'
          '  E(b).w = 3;\n'
          '  E(b).w += 2;\n'
          '  final post = E(b).w++;\n'
          '  final pre = ++E(b).w;\n'
          '  return [b.v, post, pre];\n'
          '}',
        ),
        // = 3 -> v 3; += 2: 30 + 2 -> v 32; ++: 320 -> v 321 (yields 320);
        // ++: 3210 + 1 -> v 3211 (yields 3211).
        [3211, 320, 3211],
      );
    });

    test('GHI56-7: a property the class declares wins over an extension of '
        'the same name [2026-11-14]', () {
      expect(
        _run(
          'class Own { int w = 1; }\n'
          'extension X on Own {\n'
          '  int get w => -1;\n'
          '  set w(int x) {}\n'
          '}\n'
          'Object main() { final o = Own(); o.w += 5; o.w++; return o.w; }',
        ),
        7,
      );
    });

    test('GHI56-8: reading a setter-only member through an override names '
        'it [2026-11-14]', () {
      expect(
        () => _run(
          'class Box2 { int v = 1; }\n'
          'extension S on Box2 { set only(int x) { v = x; } }\n'
          'Object main() => S(Box2()).only;',
        ),
        throwsA(
          isA<RuntimeD4rtException>().having(
            (e) => e.message,
            'message',
            contains("declares no getter or method 'only' (only a setter"),
          ),
        ),
      );
    });
  });
}
