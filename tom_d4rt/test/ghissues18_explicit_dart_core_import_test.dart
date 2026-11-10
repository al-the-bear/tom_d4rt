// ghissues18 — a library that imports `dart:core` explicitly, imported by a
// script that declares a class of the same name as one of the library's.
//
//   // package:p/types.dart
//   import 'dart:core';
//   abstract class Base { String b() => 'base'; }
//   class W extends Base {}
//   // main
//   import 'package:p/types.dart';
//   class Base {}
//   main() => W().b();
//
// Found by ghissues11 in tom_d4rt_ast, where it threw `FrozenNameMap is frozen
// and cannot be mutated.`; measured 2026-11-10 on this tree (1.243.0) too. A
// library's own class lost to an imported class of the same name: in an
// imported library and a `library:` entry, imports run before pass 1, which
// skipped a name the import had bound, so the library's `Base` WAS the
// imported one - pass 2 wrote into it (`FrozenNameMap is frozen`), or `Base()`
// met the imported abstract class (`Cannot instantiate abstract class`); in a
// `source:` entry pass 1 ran first and the import then replaced the
// placeholder (an import won every name conflict). The enum case read the
// imported enum. A library's own class, mixin or enum now shadows an imported
// one, as in Dart. The explicit `dart:core` import is how it was met; it is
// not needed for the defect.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

const _entry = 'package:p/main.dart';

/// `types.dart` importing `dart:core` [as corePrefix], and an entry importing
/// it [as prefix] that declares its own `Base`.
Object? _run({String? prefix, String? corePrefix}) {
  final core = corePrefix == null ? '' : ' as $corePrefix';
  final string = corePrefix == null ? 'String' : '$corePrefix.String';
  final p = prefix == null ? '' : '$prefix.';
  return D4rt().execute(
    library: _entry,
    sources: {
      'package:p/types.dart':
          "import 'dart:core'$core;\n"
          "abstract class Base { $string b() => 'base'; }\n"
          'class W extends Base {}\n',
      _entry:
          "import 'package:p/types.dart'${prefix == null ? '' : ' as $prefix'};\n"
          'class Base {}\n'
          'main() => [${p}W().b(), Base() is ${p}W];\n',
    },
  );
}

void main() {
  group('ghissues18: a library importing dart:core explicitly', () {
    test('GHI18-1: imported with a prefix by a script declaring the same '
        'class name [2026-11-10]', () {
      expect(_run(prefix: 'l'), ['base', false]);
    });

    test('GHI18-2: imported without a prefix by a script declaring the same '
        'class name - the script\'s own class shadows the import '
        '[2026-11-10]', () {
      expect(_run(), ['base', false]);
    });

    test('GHI18-3: the library imports dart:core with a prefix '
        '[2026-11-10]', () {
      expect(_run(prefix: 'l', corePrefix: 'core'), ['base', false]);
      expect(_run(corePrefix: 'core'), ['base', false]);
    });

    test("GHI18-4: a library's own class, mixin and enum shadow imported ones "
        'of the same name, in an imported library and in the entry, with '
        'and without an explicit dart:core import [2026-11-10]', () {
      // Measured before the fix: the class and mixin cases failed with
      // `FrozenNameMap is frozen` (pass 1 skipped the library's own
      // placeholder because the import had bound the name), and the enum
      // case answered 1 (the imported enum).
      Object? run(Map<String, String> sources) =>
          D4rt().execute(library: _entry, sources: sources);
      const a =
          "class Base { String n() => 'a'; }\n"
          "mixin M { String n() => 'a'; }\n"
          'enum E { a }\n';
      expect(
        run({
          'package:p/a.dart': a,
          'package:p/b.dart':
              "import 'package:p/a.dart';\n"
              "class Base { String n() => 'b'; }\n"
              'String viaB() => Base().n();\n',
          _entry: "import 'package:p/b.dart';\nmain() => viaB();\n",
        }),
        'b',
      );
      for (final core in ['', "import 'dart:core';\n"]) {
        expect(
          run({
            'package:p/a.dart': '$core$a',
            _entry:
                "import 'package:p/a.dart';\n"
                "class Base { String n() => 'main'; }\n"
                "mixin M { String n() => 'main'; }\n"
                'class C with M {}\n'
                'enum E { x, y }\n'
                'main() => [Base().n(), C().n(), E.values.length];\n',
          }),
          ['main', 'main', 2],
          reason: core.isEmpty ? 'no dart:core import' : 'dart:core imported',
        );
      }
      expect(
        D4rt().execute(
          source:
              "import 'package:p/a.dart';\n"
              "class Base { String n() => 'main'; }\n"
              'main() => Base().n();\n',
          sources: {'package:p/a.dart': a},
        ),
        'main',
      );
    });
  });
}
