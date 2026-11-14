// ghissues53 — an explicit extension override `E(x).member` (found by
// ghissues47, GitHub #14).
//
// Measured 2026-11-14 on tom_d4rt 1.258.0 (tree):
//
//   extension L on List<int> { List<int> toJson() => this; }
//   L(<int>[3]).toJson()                  // threw: 'L' (type:
//   ListEncoding(<int>[3]).toJson()       //   InterpretedExtension) is not
//   api.ListEncoding(<int>[3]).toJson()   //   callable ...
//
// In Dart `E(x)` applies extension E's members to x explicitly: the way to
// resolve a conflict between two extensions, and to name the extension of a
// prefixed import. Both front ends parse `E(x)` unresolved as an ordinary call
// of `E`, so the interpreter decides it: calling an extension by its name -
// bare or through an import prefix - evaluates to an extension override
// (`ExtensionOverrideValue`), and the access that follows calls the
// extension's member with x as `this`. A member the extension does not
// declare is an error naming the extension: no fallback to x's own members or
// to another extension. `E<T>(x)` binds the extension's type parameters as
// written. The same in tom_d4rt_ast
// (test/runtime/ghissues53_explicit_extension_override_test.dart).
//
// Name resolution: a name now resolves as an extension override.
//
// Compound assignment and increment of a PROPERTY (`E(x).p += 1`) need a
// getter and a setter of one name, which an extension cannot hold yet
// (ghissues56); they are tested on the index operators here.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

const _box = r'''
class Box {
  int v = 1;
  List<int> items = [1, 2, 3];
  int twice(int a) => 0;
}
extension E on Box {
  int get tens => v * 10;
  set value(int x) { v = x; }
  int twice(int a) => a * 2 + v;
  int operator +(int other) => v + other;
  int operator -() => -v;
  int operator ~() => v ^ 7;
  int operator [](int i) => items[i];
  void operator []=(int i, int x) { items[i] = x; }
  int Function(int) get adder => (int a) => a + v;
}
extension F on Box {
  int twice(int a) => -a;
}
extension Kind<T> on List<T> {
  String kind() => T.toString();
}
''';

Object? _run(String main) {
  final d4rt = D4rt()
    ..registerBridgedExtension(
      BridgedExtensionDefinition(
        name: 'Gh53Shout',
        onTypeName: 'String',
        methods: {
          'shout': (visitor, target, positional, named, typeArgs) =>
              '${(target as String).toUpperCase()}!',
        },
        getters: {'doubled': (visitor, target) => (target as String) * 2},
      ),
      'package:b/b.dart',
    );
  final split = main.indexOf('Object main');
  return d4rt.execute(
    library: 'package:p/main.dart',
    sources: {
      'package:r/public.dart': "export 'src/encoding.dart';",
      'package:r/src/encoding.dart':
          'extension ListEncoding on List<int> { List<int> toJson() => this; }',
      'package:p/main.dart':
          '${main.substring(0, split)}$_box${main.substring(split)}',
    },
  );
}

void main() {
  group('ghissues53: explicit extension overrides', () {
    test('GHI53-1: the issue - a local, an imported and a prefixed '
        'extension (GitHub #14) [2026-11-14]', () {
      expect(
        _run(
          "import 'package:r/public.dart' as api;\n"
          'extension L on List<int> { List<int> toJson() => this; }\n'
          'Object main() => [L(<int>[3]).toJson(), '
          'api.ListEncoding(<int>[4]).toJson()];',
        ),
        [
          [3],
          [4],
        ],
      );
      expect(
        _run(
          "import 'package:r/public.dart';\n"
          'Object main() => ListEncoding(<int>[5]).toJson();',
        ),
        [5],
      );
    });

    test('GHI53-2: method, getter, a getter returning a function, a tear-off '
        'and a setter [2026-11-14]', () {
      expect(
        _run(
          'Object main() {\n'
          '  final b = Box();\n'
          '  final torn = E(b).twice;\n'
          '  final results = [E(b).twice(3), E(b).tens, E(b).adder(5), '
          'torn(4)];\n'
          '  E(b).value = 9;\n'
          '  return [...results, b.v, E(b).tens];\n'
          '}',
        ),
        [7, 10, 6, 9, 9, 90],
      );
    });

    test('GHI53-3: operators - binary, unary and index read / write / '
        'compound / increment [2026-11-14]', () {
      expect(
        _run(
          'Object main() {\n'
          '  final b = Box();\n'
          '  final ops = [E(b) + 4, -E(b), ~E(b), E(b)[1]];\n'
          '  E(b)[1] = 9;\n'
          '  E(b)[0] += 5;\n'
          '  final post = E(b)[2]++;\n'
          '  final pre = ++E(b)[2];\n'
          '  return [...ops, post, pre, b.items];\n'
          '}',
        ),
        [
          5,
          -1,
          6,
          2,
          3,
          5,
          [6, 9, 5],
        ],
      );
    });

    test('GHI53-4: the override resolves a conflict between two extensions '
        'and wins over the receiver\'s own member [2026-11-14]', () {
      expect(
        _run('Object main() => [E(Box()).twice(3), F(Box()).twice(3)];'),
        [7, -3],
      );
    });

    test('GHI53-5: a bridged named extension [2026-11-14]', () {
      expect(
        _run(
          "import 'package:b/b.dart';\n"
          "Object main() => [Gh53Shout('hi').shout(), Gh53Shout('ab').doubled];",
        ),
        ['HI!', 'abab'],
      );
    });

    test('GHI53-6: E<T>(x) binds the type parameters as written; without '
        'them they come from the receiver [2026-11-14]', () {
      expect(
        _run(
          'Object main() {\n'
          '  final List<int> ints = [1];\n'
          '  return [Kind<num>(ints).kind(), Kind(ints).kind(), '
          'ints.kind()];\n'
          '}',
        ),
        ['num', 'int', 'int'],
      );
    });

    test('GHI53-7: E(x)?.m() on null short-circuits [2026-11-14]', () {
      expect(
        _run(
          'Object main() {\n'
          '  Box? none;\n'
          '  return [E(none)?.twice(1), E(none)?.tens];\n'
          '}',
        ),
        [null, null],
      );
    });

    test('GHI53-8: a member the extension does not declare is an error naming '
        'the extension, not a fallback [2026-11-14]', () {
      expect(
        () => _run('Object main() => F(Box()).tens;'),
        throwsA(
          isA<RuntimeD4rtException>().having(
            (e) => e.message,
            'message',
            contains("The extension 'F' does not declare a member 'tens'"),
          ),
        ),
      );
    });

    test('GHI53-9: an override takes exactly one positional argument '
        '[2026-11-14]', () {
      expect(
        () => _run('Object main() => E(Box(), Box()).tens;'),
        throwsA(
          isA<RuntimeD4rtException>().having(
            (e) => e.message,
            'message',
            contains('An extension override takes exactly one positional'),
          ),
        ),
      );
    });
  });
}
