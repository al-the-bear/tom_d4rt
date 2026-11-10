// ghissues11 (a GitHub al-the-bear/tom_d4rt#9 follow-up) — an extension whose
// `on` type is declared in a library that is still loading.
//
// #9 made a class or mixin whose supertype is declared in a library still
// loading (an import cycle, or a barrel that has not reached the export yet)
// resolve it once the outermost module load returns. An extension in the same
// position failed at its declaration, measured 2026-11-09 on this tree
// (1.238.0):
//
//   Could not resolve 'on' type 'Base' for extension 'X': Type not found or not
//   a recognized core type.
//
// The extension is now created and registered as before, so importers copy it
// with the module's exports, and its `on` type is filled in once the load
// returns; an undefined `on` type is still reported then. Found on the way: the
// `on` clause dropped an import prefix (`on l.Base` bound a local `Base`), as
// the class clauses did before pull request #8 — GHI11-4.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

Object? _run(Map<String, String> sources) =>
    D4rt().execute(library: 'package:p/main.dart', sources: sources);

/// `main.dart` imports a barrel exporting `user.dart` and `base.dart`; both
/// import the barrel back, and `user.dart` comes first, so its extension is
/// declared before anything in `base.dart` exists.
Map<String, String> _viaBarrel(String user, String main) => {
  'package:p/main.dart': "import 'package:p/barrel.dart';\n$main",
  'package:p/barrel.dart':
      "export 'package:p/user.dart';\nexport 'package:p/base.dart';",
  'package:p/user.dart': "import 'package:p/barrel.dart';\n$user",
  'package:p/base.dart':
      "import 'package:p/barrel.dart';\n"
      "abstract class Base { String b() => 'base'; }",
};

/// Throws whose message contains [part].
Matcher _refusedWith(String part) => throwsA(
  predicate((Object e) => e.toString().contains(part), 'an error naming $part'),
);

void main() {
  group('ghissues11: an extension on a type declared in a library still '
      'loading', () {
    test('GHI11-1: through a barrel that exports the type later '
        '[2026-11-09]', () {
      expect(
        _run(
          _viaBarrel(
            "extension X on Base { String x() => 'x:' + b(); }",
            'class W extends Base {}\nmain() => W().x();',
          ),
        ),
        'x:base',
      );
    });

    test('GHI11-2: across a two-library import cycle [2026-11-09]', () {
      // main imports a.dart, whose import of b.dart loads first; b.dart imports
      // a.dart back, which is still loading, so the extension is declared
      // before `Base` exists.
      expect(
        _run({
          'package:p/main.dart':
              "import 'package:p/a.dart';\n"
              "import 'package:p/b.dart';\n"
              'class W extends Base {}\n'
              'main() => [W().x(), W().y];',
          'package:p/a.dart':
              "import 'package:p/b.dart';\n"
              "abstract class Base { String b() => 'base'; }",
          'package:p/b.dart':
              "import 'package:p/a.dart';\n"
              'extension X on Base {\n'
              "  String x() => 'x:' + b();\n"
              "  String get y => 'y';\n"
              '}',
        }),
        ['x:base', 'y'],
      );
    });

    test('GHI11-3: an unnamed extension, used inside the library and by the '
        'importer [2026-11-09]', () {
      expect(
        _run(
          _viaBarrel(
            "extension on Base { String u() => 'u:' + b(); }\n"
                'String viaUser(Base base) => base.u();',
            'class W extends Base {}\nmain() => [W().u(), viaUser(W())];',
          ),
        ),
        ['u:base', 'u:base'],
      );
    });

    test('GHI11-4: a prefixed `on` type binds the imported class, not a '
        'same-named local one [2026-11-09]', () {
      final sources = {
        'package:p/types.dart': "abstract class Base { String b() => 'base'; }",
        'package:p/main.dart':
            "import 'package:p/types.dart' as l;\n"
            'class Base {}\n'
            "extension X on l.Base { String x() => 'x:' + b(); }\n"
            'class W extends l.Base {}\n'
            'main() => W().x();',
      };
      // The extension binds `l.Base` (a local `Base` bound before, so `W`, a
      // `l.Base`, had no `x`). That it is not applied to the local `Base` is
      // not asserted: extension matching also accepts a type of the same NAME
      // (Bug-98's raw-generic fallback), tracked as ghissues17_akiw.
      expect(_run(sources), 'x:base');
    });

    test('GHI11-5: an undefined `on` type is still reported, with and without '
        'a module load in progress [2026-11-09]', () {
      expect(
        () => _run(
          _viaBarrel(
            "extension X on Missing { String x() => 'x'; }",
            'main() => 1;',
          ),
        ),
        _refusedWith("Could not resolve 'on' type 'Missing' for extension 'X'"),
      );
      expect(
        () => D4rt().execute(
          source: "extension X on Missing { String x() => 'x'; }\nmain() => 1;",
        ),
        _refusedWith("Could not resolve 'on' type 'Missing' for extension 'X'"),
      );
    });
  });
}
