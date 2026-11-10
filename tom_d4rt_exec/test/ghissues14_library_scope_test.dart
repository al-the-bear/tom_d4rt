// ghissues14 — an imported library's code cannot reach the importing
// script's top-level declarations.
//
// Measured 2026-11-10 on this tree (1.241.0): a library that named something
// it neither declares nor imports found a same-named declaration of the
// script that imported it.
//
//   // package:rel/types.dart
//   int useScript() => scriptOnly;   // Dart: compile error
//   // main
//   import 'package:rel/types.dart';
//   int scriptOnly = 5;
//   main() => useScript();           // 5, with `source:` and `library:` alike
//
// A loaded module's environment encloses the loader's global environment, and
// the entry script was executed IN that environment, so its declarations were
// in every library's scope chain. The entry now runs in a script scope of its
// own, enclosing the global one: the script still sees everything the loader
// registered there (stdlib, bridges, its imports), and a library no longer
// sees the script.

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

const _entry = 'package:rel/main.dart';

/// Runs [main] as the entry, through `library:` or as a bare `source:`, with
/// `package:rel/types.dart` holding [types].
Object? _run(String types, String main, {required bool asLibrary}) {
  final sources = {'package:rel/types.dart': types};
  return asLibrary
      ? D4rt().execute(library: _entry, sources: {...sources, _entry: main})
      : D4rt().execute(source: main, sources: sources);
}

/// Throws whose message contains every one of [parts].
Matcher _refusedWith(List<String> parts) => throwsA(
  predicate(
    (Object e) => parts.every(e.toString().contains),
    'an error naming ${parts.join(' and ')}',
  ),
);

void main() {
  for (final asLibrary in const [true, false]) {
    final entry = asLibrary ? 'library:' : 'source:';

    group('ghissues14 ($entry): a library does not see the script', () {
      test('GHI14-1: a library function reading a script global is refused '
          '[2026-11-10]', () {
        expect(
          () => _run(
            'int useScript() => scriptOnly;',
            "import 'package:rel/types.dart';\n"
                'int scriptOnly = 5;\n'
                'main() => useScript();',
            asLibrary: asLibrary,
          ),
          _refusedWith(['scriptOnly']),
        );
      });

      test('GHI14-2: a library class extending a script class is refused '
          '[2026-11-10]', () {
        expect(
          () => _run(
            'class Child extends ScriptBase {}',
            "import 'package:rel/types.dart';\n"
                'class ScriptBase { int b() => 1; }\n'
                'main() => Child().b();',
            asLibrary: asLibrary,
          ),
          _refusedWith(['ScriptBase']),
        );
      });

      test(
        'GHI14-3: a library naming a script class, and a script function '
        'shadowing nothing in the library, are both refused [2026-11-10]',
        () {
          expect(
            () => _run(
              'Object make() => ScriptOnly();',
              "import 'package:rel/types.dart';\n"
                  'class ScriptOnly {}\n'
                  'main() => make();',
              asLibrary: asLibrary,
            ),
            _refusedWith(['ScriptOnly']),
          );
          expect(
            () => _run(
              'int callBack() => scriptHelper();',
              "import 'package:rel/types.dart';\n"
                  'int scriptHelper() => 1;\n'
                  'main() => callBack();',
              asLibrary: asLibrary,
            ),
            _refusedWith(['scriptHelper']),
          );
        },
      );

      test('GHI14-4: the library keeps its own declarations, its imports and '
          'the core library, and the script keeps everything [2026-11-10]', () {
        expect(
          _run(
            "import 'dart:math';\n"
                'int own = 2;\n'
                'class Base { int b() => own; }\n'
                'int libMax(int a, int b) => max(a, b);\n'
                "extension Twice on String { String twice() => this + this; }",
            "import 'package:rel/types.dart';\n"
                'int scriptOnly = 5;\n'
                'class Child extends Base {}\n'
                "main() => [Child().b(), libMax(3, 4), 'ab'.twice(), "
                "scriptOnly, int.parse('7')];",
            asLibrary: asLibrary,
          ),
          [2, 4, 'abab', 5, 7],
        );
      });

      test('GHI14-5: a library calling back into the script through a '
          'parameter still works [2026-11-10]', () {
        expect(
          _run(
            'int apply(int Function(int) f) => f(20);',
            "import 'package:rel/types.dart';\n"
                'int scriptOnly = 1;\n'
                'main() => apply((x) => x + scriptOnly);',
            asLibrary: asLibrary,
          ),
          21,
        );
      });
    });
  }
}
