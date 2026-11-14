// ghissues49 — GitHub #18: an extension's own type parameters are bound.
//
// Measured 2026-11-14 on tom_d4rt 1.260.0 / tom_d4rt_ast 0.240.0:
//
//   extension KeyKind<K, V> on Map<K, V> { String keyKind() => K.toString(); }
//   final Map<String, int> narrow = sameMap();      // a native Map<String, int>
//   final Map<dynamic, dynamic> wide = narrow;
//   [narrow.keyKind(), wide.keyKind()]   // threw: Undefined variable: K
//                                        // (Dart: ['String', 'dynamic'])
//
// Nothing bound K or V when an extension member ran. Dart infers them from the
// receiver's STATIC type, which the interpreter does not have: both front
// ends parse without resolution. Decided (ghissues49, user): bind from the
// receiver's WRITTEN type when it is a typed local, parameter or field - the
// one static type the interpreter keeps - else from the receiver's runtime
// type arguments (a native generic object, an interpreted generic instance),
// else dynamic. So the issue's pair answers as in Dart; an untyped script
// literal (`{'x': 7}.keyKind()`) answers dynamic where Dart infers String
// (limitations doc, Lim-13). The same in tom_d4rt_ast
// (test/runtime/ghissues49_extension_type_parameters_test.dart).
//
// The explicit override `KeyKind<Object, int>(m)` is not tested here: no
// explicit extension override works yet (ghissues53).

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

Object? _run(String body) {
  final d4rt = D4rt()
    ..registertopLevelFunction(
      'sameMap',
      (visitor, positional, named, typeArgs) => <String, int>{'x': 7},
      'package:n/n.dart',
    )
    ..registertopLevelFunction(
      'doubles',
      (visitor, positional, named, typeArgs) => <double>[1.5],
      'package:n/n.dart',
    );
  return d4rt.execute(
    library: 'package:p/main.dart',
    sources: {
      'package:p/main.dart':
          "import 'package:n/n.dart';\n"
          'extension KeyKind<K, V> on Map<K, V> {\n'
          '  String keyKind() => K.toString();\n'
          '  String valueKind() => V.toString();\n'
          '  bool keyIs(Object? key) => key is K;\n'
          '}\n'
          'extension ElementKind<T> on List<T> {\n'
          '  String get elementKind => T.toString();\n'
          '}\n'
          '$body',
    },
  );
}

void main() {
  group('ghissues49: an extension\'s type parameters', () {
    test('GHI49-1: the issue - two declared views of one map (GitHub #18) '
        '[2026-11-14]', () {
      expect(
        _run(
          'Object main() {\n'
          '  final Map<String, int> narrow = sameMap();\n'
          '  final Map<dynamic, dynamic> wide = narrow;\n'
          '  return [narrow.keyKind(), wide.keyKind()];\n'
          '}',
        ),
        ['String', 'dynamic'],
      );
    });

    test('GHI49-2: an untyped receiver binds K and V from the native map\'s '
        'runtime type arguments [2026-11-14]', () {
      expect(
        _run(
          'Object main() {\n'
          '  final m = sameMap();\n'
          '  return [m.keyKind(), m.valueKind(), sameMap().keyKind()];\n'
          '}',
        ),
        ['String', 'int', 'String'],
      );
    });

    test('GHI49-3: a typed parameter and typed fields give their written '
        'type arguments [2026-11-14]', () {
      expect(
        _run(
          'String viaParameter(Map<Object, num> m) => m.keyKind();\n'
          'class Holder {\n'
          '  Holder(this.m);\n'
          '  final Map<int, String> m;\n'
          '  List<String> kinds() => [m.keyKind(), this.m.valueKind()];\n'
          '}\n'
          'Object main() {\n'
          '  final h = Holder(<int, String>{1: "a"});\n'
          '  return [viaParameter(sameMap()), ...h.kinds(), h.m.keyKind()];\n'
          '}',
        ),
        ['Object', 'int', 'String', 'int'],
      );
    });

    test('GHI49-4: an extension on List<T>, a getter [2026-11-14]', () {
      expect(
        _run(
          'Object main() {\n'
          '  final List<num> typed = doubles();\n'
          '  return [typed.elementKind, doubles().elementKind];\n'
          '}',
        ),
        ['num', 'double'],
      );
    });

    test('GHI49-5: K works as a type in the member [2026-11-14]', () {
      expect(
        _run(
          'Object main() {\n'
          '  final Map<String, int> narrow = sameMap();\n'
          '  final Map<dynamic, dynamic> wide = narrow;\n'
          '  return [narrow.keyIs("a"), narrow.keyIs(1), wide.keyIs(1)];\n'
          '}',
        ),
        [true, false, true],
      );
    });

    test('GHI49-6: a receiver with no written or reified type arguments binds '
        'dynamic - an untyped script literal (Dart infers String; Lim-13) '
        '[2026-11-14]', () {
      expect(
        _run("Object main() => {'x': 7}.keyKind();"),
        'dynamic',
      );
    });
  });
}
