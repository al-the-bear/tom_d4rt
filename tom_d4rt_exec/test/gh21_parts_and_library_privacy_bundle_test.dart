/// GitHub al-the-bear/tom_d4rt#21 on the BUNDLE PATH: the issue's five library graphs (parts and library privacy), with the bundler following part directives, bundled by `AstBundler`, sent
/// through `toBytes` / `fromBytes` as an app receives a bundle, and run by
/// `D4rtRunner`.
///
/// `gh21_parts_and_library_privacy_test.dart` next door is the verbatim port of the analyzer-based suite and
/// runs the same cases through `execute(sources:)`. This file is its bundle
/// half, which has no counterpart in `tom_d4rt` and so can only be pinned
/// here; splitting them keeps the shared-name file a verbatim port (see
/// `_plan_e2_static_in_closure_bundle_test.dart`). Expected values are native
/// Dart's, as in the port.
library;

import 'package:test/test.dart';
import 'package:tom_ast_generator/tom_ast_generator.dart' show AstResolver;
import 'package:tom_d4rt_exec/d4rt.dart';

final _resolver = AstResolver();

/// [sources] bundled from [entry] by the [AstBundler] - parse-only, or with
/// [resolve] the resolving check and its static facts - sent through
/// `toBytes` / `fromBytes` as an app receives a bundle.
Future<AstBundle> _bundle(
  Map<String, String> sources,
  String entry, {
  bool resolve = false,
  Set<String> bridged = const {},
  Map<String, String> stubs = const {},
}) async {
  final bundle = await AstBundler(
    explicitSources: sources,
    bridgedLibraries: bridged,
    declarationStubs: stubs,
    fileAccessValidator: (_) => false,
    config: AstBundlerConfig(resolve: resolve),
    resolver: _resolver,
  ).createFromSource(sources[entry]!, sourcePath: entry);
  return AstBundle.fromBytes(bundle.toBytes());
}

Matcher refusedWith(String text) =>
    throwsA(predicate((Object e) => e.toString().contains(text), text));

/// Runs `package:fixture/main.dart` of [files] (names relative to the
/// package) from a bundle.
Future<Object?> run(Map<String, String> files) async =>
    D4rtRunner().executeBundle(
      await _bundle({
        for (final MapEntry(:key, :value) in files.entries)
          'package:fixture/$key': value,
      }, 'package:fixture/main.dart'),
    );

void main() {
  tearDownAll(_resolver.dispose);

  group('gh21 on the bundle path: the issue\'s five graphs', () {
    test(
      'GH21-B1: a public part type across an import cycle [2026-11-19]',
      () async {
        expect(
          await run({
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
      },
    );

    test(
      'GH21-B2: a part naming another library is refused [2026-11-19]',
      () async {
        await expectLater(
          run({
            'main.dart': "import 'owner.dart'; main() => value();",
            'owner.dart': "part 'piece.dart'; int value() => 1;",
            'piece.dart': "part of 'other.dart'; class Marker {}",
            'other.dart': "part 'piece.dart';",
          }),
          refusedWith(
            "Expected 'package:fixture/piece.dart' to be part of "
            "'package:fixture/owner.dart'",
          ),
        );
      },
    );

    test(
      'GH21-B3: a part imported as a library is refused [2026-11-19]',
      () async {
        await expectLater(
          run({
            'owner.dart': "part 'piece.dart';",
            'piece.dart': "part of 'owner.dart'; int fromPart() => 19;",
            'main.dart': "import 'piece.dart'; main() => fromPart();",
          }),
          refusedWith(
            "'package:fixture/piece.dart' is a part of another library",
          ),
        );
      },
    );

    test('GH21-B4: a private class through an export barrel is not found '
        '[2026-11-19]', () async {
      await expectLater(
        run({
          'main.dart': "import 'child.dart'; main() => Child().value();",
          'barrel.dart': "export 'base.dart';",
          'base.dart': 'class _PrivateBase { int value() => 13; }',
          'child.dart':
              "import 'barrel.dart'; class Child extends _PrivateBase {}",
        }),
        refusedWith("Superclass '_PrivateBase' not found"),
      );
    });

    test('GH21-B5: a private class of an imported library\'s part is refused '
        '[2026-11-19]', () async {
      await expectLater(
        run({
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
