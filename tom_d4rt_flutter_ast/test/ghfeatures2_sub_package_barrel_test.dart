// RUNNER BUCKET: guard — run_guard_tests.sh
// ghfeatures2 — a bridged name a script did not import does not resolve, as in
// Dart.
//
// Measured 2026-11-15 in both twins (bridges from tom_d4rt_generator 1.65.0):
// a script importing only `package:flutter/material.dart` could use
// `CupertinoPageTransitionsBuilder`, which material.dart does not export.
// Every module whose bridges include a declaration from another package was
// also registered, whole, under that package's barrel; the cupertino,
// material and widgets modules each bridge `StringCharacters`, so every
// cupertino class sat under `package:characters/characters.dart`, which
// widgets.dart (and so material.dart) re-exports. tom_d4rt_generator 1.66.0
// registers a sub-package barrel with only its own package's declarations.
// The same in tom_d4rt_flutter (test/ghfeatures2_sub_package_barrel_test.dart).

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tom_ast_generator/tom_ast_generator.dart' show AstBundler;
import 'package:tom_d4rt_flutter_ast/tom_d4rt_flutter_ast.dart';

String _script(String imports) =>
    '$imports\nObject main() => CupertinoPageTransitionsBuilder();';

Future<Object?> _run(String imports) async {
  final d4rt = FlutterD4rt();
  final bundle = await AstBundler(
    bridgedLibraries: d4rt.interpreter.bridgedLibraryUris,
  ).createFromSource(_script(imports));
  return d4rt.executeAsync<Object?>(bundle);
}

void main() {
  test('GHF2-T1: with cupertino.dart imported the class resolves '
      '[2026-11-15]', () async {
    expect(
      await _run(
        "import 'package:flutter/material.dart';\n"
        "import 'package:flutter/cupertino.dart';",
      ),
      isA<CupertinoPageTransitionsBuilder>(),
    );
  });

  test('GHF2-T2: with only material.dart imported it is undefined, as Dart '
      'rejects it [2026-11-15]', () async {
    await expectLater(
      _run("import 'package:flutter/material.dart';"),
      throwsA(
        predicate((e) => '$e'.contains('CupertinoPageTransitionsBuilder')),
      ),
    );
  });

  test('GHF2-T3: package:characters offers its own declarations only '
      '[2026-11-15]', () async {
    await expectLater(
      _run("import 'package:characters/characters.dart';"),
      throwsA(
        predicate((e) => '$e'.contains('CupertinoPageTransitionsBuilder')),
      ),
    );
  });
}
