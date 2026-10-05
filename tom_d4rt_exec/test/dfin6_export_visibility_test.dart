// DFIN6 (dgub15): a module exports only its own declarations and what its
// `export` directives name.
//
// All three loaders merged a module's whole environment into its export —
// imports included — so with main -> a -> b, main could call a name only b
// declares (a probe returned 42 on 2026-10-03). Dart says "Undefined name".
//
// Twin: tom_d4rt_exec ports this file verbatim.
import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

Object? _run(Map<String, String> modules, String main) => D4rt().execute(
  library: 'package:app/main.dart',
  sources: {...modules, 'package:app/main.dart': main},
);

const _b = {'package:app/b.dart': 'int bOnly() => 42;\n'};

void main() {
  group('DFIN6: export visibility', () {
    test('DFIN6-1: a name only an import of an import declares is undefined '
        '[2026-10-03]', () {
      expect(
        () => _run({
          ..._b,
          'package:app/a.dart': "import 'b.dart';\nint aOwn() => bOnly();\n",
        }, "import 'package:app/a.dart';\nint main() => bOnly();\n"),
        throwsA(predicate((e) => '$e'.contains('bOnly'))),
      );
    });

    test('DFIN6-2: the module\'s own declarations are still exported, and may '
        'use what it imports [2026-10-03]', () {
      expect(
        _run({
          ..._b,
          'package:app/a.dart':
              "import 'b.dart';\nint aOwn() => bOnly() + 1;\n",
        }, "import 'package:app/a.dart';\nint main() => aOwn();\n"),
        43,
      );
    });

    test('DFIN6-3: an `export` re-publishes what it names [2026-10-03]', () {
      expect(
        _run({
          ..._b,
          'package:app/a.dart': "export 'b.dart';\n",
        }, "import 'package:app/a.dart';\nint main() => bOnly();\n"),
        42,
      );
    });

    test('DFIN6-4: `export ... show` re-publishes only the shown name '
        '[2026-10-03]', () {
      final modules = {
        'package:app/b.dart': 'int one() => 1;\nint two() => 2;\n',
        'package:app/a.dart': "export 'b.dart' show one;\n",
      };
      expect(
        _run(modules, "import 'package:app/a.dart';\nint main() => one();\n"),
        1,
      );
      expect(
        () => _run(
          modules,
          "import 'package:app/a.dart';\nint main() => two();\n",
        ),
        throwsA(predicate((e) => '$e'.contains('two'))),
      );
    });

    test('DFIN6-5: a cyclic import still loads [2026-10-03]', () {
      expect(
        _run({
          'package:app/a.dart':
              "import 'b.dart';\nint fromA() => 1;\nint viaB() => fromB();\n",
          'package:app/b.dart':
              "import 'a.dart';\nint fromB() => fromA() + 1;\n",
        }, "import 'package:app/a.dart';\nint main() => viaB();\n"),
        2,
      );
    });
  });
}
