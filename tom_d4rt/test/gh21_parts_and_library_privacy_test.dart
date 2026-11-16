// GitHub al-the-bear/tom_d4rt#21 — parts and library privacy.
//
// Reported with five library graphs (tom_d4rt_ast 0.244.0); reproduced
// 2026-11-16 in both trees (this one 1.265.0, `execute(sources:)`):
//
//   1. owner.dart imports child.dart and has `part 'piece.dart'`, which
//      declares `class Base`; child.dart imports owner.dart and extends Base.
//      Dart prints 11; the interpreter failed: `Superclass 'Base' not found`.
//   2. owner.dart has `part 'piece.dart'`, but piece.dart says
//      `part of 'other.dart'`. Dart rejects it; the interpreter ran.
//   3. main.dart imports a file with `part of 'owner.dart'`. Dart rejects the
//      import; the interpreter ran the part's function.
//   4. child.dart extends `_PrivateBase` reached through `export 'base.dart'`.
//      Dart: `Type '_PrivateBase' not found`; the interpreter ran.
//   5. child.dart extends a `_PrivateBase` declared in an imported library's
//      part. Both rejected it - the interpreter only because it never read
//      the part.
//
// The cause of 1-3 was one gap: `part` and `part of` were ignored entirely,
// so a part's declarations never reached their library (no part worked, cycle
// or not), and a part file loaded as a library of its own. A library is now
// loaded with its parts merged in - their declarations share its imports and
// its private names - after checking that each part names it in its `part of`
// and has no directive of its own; a part loaded as a library (imported,
// exported or run) is refused. 4 was the exported environment carrying a
// library's `_` names to every importer; it now carries its public names only.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// Runs `package:fixture/main.dart` of [files] (names relative to the
/// package).
Object? run(Map<String, String> files) => D4rt().execute(
  library: 'package:fixture/main.dart',
  sources: {
    for (final MapEntry(:key, :value) in files.entries)
      'package:fixture/$key': value,
  },
);

Matcher refusedWith(String text) =>
    throwsA(predicate((Object e) => e.toString().contains(text), text));

void main() {
  group('gh21: parts', () {
    test('GH21-1: the issue - a public part type across an import cycle '
        '[2026-11-16]', () {
      expect(
        run({
          'main.dart': "import 'owner.dart'; main() => value();",
          'owner.dart':
              "import 'child.dart'; part 'piece.dart'; "
              'int value() => Child().value();',
          'piece.dart':
              "part of 'owner.dart'; class Base { int value() => 11; }",
          'child.dart': "import 'owner.dart'; class Child extends Base {}",
        }),
        11,
      );
    });

    test('GH21-2: a part shares its library\'s imports and private names, '
        'and its library may be named [2026-11-16]', () {
      expect(
        run({
          'main.dart':
              "import 'owner.dart'; main() => [Base().value(), value(), "
              'twice(3), limit];',
          'owner.dart':
              "library owner;\nimport 'dart:math' as math;\n"
              "part 'src/piece.dart';\npart 'src/more.dart';\n"
              'int value() => _hidden() + _counter;\n'
              'int _counter = 1;',
          'src/piece.dart':
              "part of '../owner.dart';\n"
              'class Base { int value() => math.max(11, 2); }\n'
              'int _hidden() => _counter + 10;',
          'src/more.dart':
              'part of owner;\n'
              'int twice(int x) => x * 2;\n'
              'const limit = _limit;\n'
              'const _limit = 5;',
        }),
        [11, 12, 6, 5],
      );
    });

    test(
      'GH21-3: a part that names another library is refused [2026-11-16]',
      () {
        expect(
          () => run({
            'main.dart': "import 'owner.dart'; main() => value();",
            'owner.dart': "part 'piece.dart'; int value() => 1;",
            'piece.dart': "part of 'other.dart'; class Marker {}",
            'other.dart': "part 'piece.dart';",
          }),
          refusedWith(
            "Expected 'package:fixture/piece.dart' to be part of "
            "'package:fixture/owner.dart', not 'package:fixture/other.dart'",
          ),
        );
        expect(
          () => run({
            'main.dart': "import 'owner.dart'; main() => 1;",
            'owner.dart': "library owner; part 'piece.dart';",
            'piece.dart': 'part of other;',
          }),
          refusedWith("not of 'other'"),
        );
        expect(
          () => run({
            'main.dart': "import 'owner.dart'; main() => 1;",
            'owner.dart': "part 'piece.dart';",
            'piece.dart': 'part of owner;',
          }),
          refusedWith('which has no library name'),
        );
      },
    );

    test('GH21-4: a part without part-of, or with a directive of its own, is '
        'refused [2026-11-16]', () {
      expect(
        () => run({
          'main.dart': "import 'owner.dart'; main() => 1;",
          'owner.dart': "part 'piece.dart';",
          'piece.dart': 'int x = 1;',
        }),
        refusedWith('must have a part-of directive'),
      );
      expect(
        () => run({
          'main.dart': "import 'owner.dart'; main() => 1;",
          'owner.dart': "part 'piece.dart';",
          'piece.dart': "part of 'owner.dart'; import 'dart:math';",
        }),
        // The parser refuses it first, with Dart's own message.
        refusedWith(
          'The part-of directive must be the only directive in a part',
        ),
      );
    });

    test('GH21-5: a part is not a library - importing, exporting or running '
        'it is refused [2026-11-16]', () {
      const notALibrary =
          "'package:fixture/piece.dart' is a part of another library";
      final graph = {
        'owner.dart': "part 'piece.dart';",
        'piece.dart': "part of 'owner.dart'; int fromPart() => 19;",
      };
      expect(
        () => run({
          ...graph,
          'main.dart': "import 'piece.dart'; main() => fromPart();",
        }),
        refusedWith(notALibrary),
      );
      expect(
        () => run({
          ...graph,
          'barrel.dart': "export 'piece.dart';",
          'main.dart': "import 'barrel.dart'; main() => fromPart();",
        }),
        refusedWith(notALibrary),
      );
      expect(
        () => D4rt().execute(
          library: 'package:fixture/piece.dart',
          sources: {
            for (final MapEntry(:key, :value) in graph.entries)
              'package:fixture/$key': value,
          },
        ),
        refusedWith(notALibrary),
      );
    });

    test('GH21-6: a direct source with a part directive has nothing to find '
        'its parts from [2026-11-16]', () {
      expect(
        () => D4rt().execute(source: "part 'piece.dart'; main() => 1;"),
        refusedWith("a part directive has no URI to find its parts from"),
      );
      expect(
        () => D4rt().execute(source: "part of 'owner.dart'; main() => 1;"),
        refusedWith('is a part of another library'),
      );
    });
  });

  group('gh21: library privacy', () {
    test('GH21-7: the issue - a private class through an export barrel is not '
        'found [2026-11-16]', () {
      expect(
        () => run({
          'main.dart': "import 'child.dart'; main() => Child().value();",
          'barrel.dart': "export 'base.dart';",
          'base.dart': 'class _PrivateBase { int value() => 13; }',
          'child.dart':
              "import 'barrel.dart'; class Child extends _PrivateBase {}",
        }),
        refusedWith("Superclass '_PrivateBase' not found"),
      );
    });

    test('GH21-8: an import does not carry private names; the library\'s own '
        'code still uses them [2026-11-16]', () {
      final graph = {
        'lib.dart':
            'int _secret() => 42;\nint _count = 2;\nclass _Hidden {}\n'
            'int reveal() => _secret() + _count;\n'
            'Object make() => _Hidden();',
      };
      expect(
        run({
          ...graph,
          'main.dart':
              "import 'lib.dart'; main() => [reveal(), make().runtimeType];",
        }),
        [44, isA<Object>()],
      );
      for (final use in ['_secret()', '_count', '_Hidden()']) {
        expect(
          () => run({
            ...graph,
            'main.dart': "import 'lib.dart'; main() => $use;",
          }),
          throwsA(anything),
          reason: '$use must not be visible outside lib.dart',
        );
      }
    });

    test('GH21-9: the control - a private class of an imported library\'s '
        'part is refused [2026-11-16]', () {
      expect(
        () => run({
          'main.dart': "import 'child.dart'; main() => 1;",
          'owner.dart': "part 'piece.dart';",
          'piece.dart': "part of 'owner.dart'; class _PrivateBase {}",
          'child.dart':
              "import 'owner.dart'; class Child extends _PrivateBase {}",
        }),
        refusedWith("Superclass '_PrivateBase' not found"),
      );
    });
  });
}
