// ghissues55 — the relaxer file's type arguments are what its imports let it
// name: the union of the imported barrels' export namespaces, minus the names
// two of them export from different declarations.
//
// Found by ghissues50 (GitHub #16): the scope rule judged a class by how its
// source file is spelled - a `package:` prefix of a configured barrel, or a
// Flutter / sky_engine path fragment (GEN-094). A class from a pub-cache
// package whose barrel the relaxer file imports (vector_math's Vector3 through
// the twins' vector_math layer) has a filesystem path and was never in scope,
// so `ValueNotifier<Vector3>` and the other RC-2 dispatches never offered it,
// while on a setup with `package:` source files it would be. A wider rule
// ("everything a module bridged") broke the other way: `Colors` is exported by
// both material.dart and vector_math_64.dart (ambiguous), and flutter's
// foundation bridges meta's `Immutable` but exports only `immutable`.
//
// The generator now resolves the relaxer file's imports in its analysis
// context (`BridgeGenerator.importedNamesOf`, `ImportedNames`) and
// `generateRelaxers(importedNames:)` decides by that set; an ambiguous bridged
// name is skipped with a warning naming the libraries. Without the set (a
// caller that cannot resolve) the path rule stays.

@Tags(['generation'])
library;

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

void main() {
  group('ghissues55: ImportedNames', () {
    test('GHI55-1: a name two imports export from different declarations is '
        'ambiguous; a re-export of one declaration is not; a platform '
        'library\'s declaration yields to a package\'s (dart:ui TextStyle); '
        'dart:core sits under the imports [2026-11-14]', () {
      final names = ImportedNames.compute(
        {
          'package:a/a.dart': {
            'Shared': 'package:a/src/shared.dart',
            'Box': 'package:a/src/box.dart',
            'Same': 'package:common/same.dart',
            'Duration': 'package:a/src/duration.dart',
          },
          'package:b/b.dart': {
            'Shared': 'package:b/src/shared.dart',
            'Vec': 'package:b/src/vec.dart',
            'Same': 'package:common/same.dart',
            'TextStyle': 'package:b/src/text_style.dart',
          },
          'dart:ui': {'TextStyle': 'dart:ui', 'Canvas': 'dart:ui'},
        },
        dartCore: {'int': 'dart:core', 'Duration': 'dart:core'},
      );
      expect(names.ambiguous, {
        'Shared': ['package:a/a.dart', 'package:b/b.dart'],
      });
      expect(
        names.nameable,
        containsAll([
          'Box',
          'Vec',
          'Same',
          'int',
          'Duration',
          'TextStyle',
          'Canvas',
        ]),
      );
      expect(names.nameable, isNot(contains('Shared')));
    });
  });

  group('ghissues55: generateRelaxers decides by the imported names', () {
    late Directory tempDir;
    setUp(() => tempDir = Directory.systemTemp.createTempSync('ghissues55_'));
    tearDown(() => tempDir.deleteSync(recursive: true));

    /// `Box<T>` with an extraction site; `Vec` a class whose source file is a
    /// pub-cache PATH (as vector_math's are); `Hidden` bridged but exported
    /// by no import; `Shared` exported by two imports.
    Map<String, ClassInfo> lookup() => {
      'Box': ClassInfo(
        name: 'Box',
        sourceFile: 'package:zom_a/src/box.dart',
        typeParameters: const {'T': null},
        constructors: const [
          ConstructorInfo(
            parameters: [ParameterInfo(name: 'value', type: 'T')],
          ),
        ],
      ),
      'Vec': ClassInfo(
        name: 'Vec',
        sourceFile:
            '/home/u/.pub-cache/hosted/pub.dev/zom_b-1.0.0/lib/src/vec.dart',
      ),
      'Hidden': ClassInfo(
        name: 'Hidden',
        sourceFile: 'package:zom_a/hidden.dart',
      ),
      'Shared': ClassInfo(
        name: 'Shared',
        sourceFile: 'package:zom_a/src/shared.dart',
      ),
    };

    Future<(String, List<String>)> generate(ImportedNames? names) async {
      final warnings = <String>[];
      final result = await generateRelaxers(
        config: BridgeConfig(
          name: 'zom_a',
          modules: const [
            ModuleConfig(
              name: 'a',
              barrelFiles: ['lib/zom_a.dart'],
              outputPath: 'lib/src/a.b.dart',
              barrelImport: 'package:zom_a/zom_a.dart',
            ),
            ModuleConfig(
              name: 'b',
              barrelFiles: ['lib/zom_b.dart'],
              outputPath: 'lib/src/b.b.dart',
              barrelImport: 'package:zom_b/zom_b.dart',
            ),
          ],
          relaxerOutputPath: '${tempDir.path}/relaxers.b.dart',
        ),
        projectPath: tempDir.path,
        globalClassLookup: lookup(),
        genericExtractionSites: const [
          GenericExtractionSite(
            baseTypeName: 'Box',
            typeArg: 'Vec',
            moduleName: 'a',
          ),
        ],
        importedNames: names,
        onWarning: warnings.add,
      );
      return (File(result.outputFile!).readAsStringSync(), warnings);
    }

    final names = ImportedNames(
      nameable: {'Box', 'Vec', 'int', 'String'},
      ambiguous: {
        'Shared': ['package:zom_a/zom_a.dart', 'package:zom_b/zom_b.dart'],
      },
    );

    test('GHI55-2: a class exported by an imported barrel is a relaxer type '
        'whatever its source file looks like (a pub-cache path) '
        '[2026-11-14]', () async {
      final (code, _) = await generate(names);
      expect(code, contains(r'class $RelaxedBox<'));
      expect(code, contains("'Vec' =>"));
    });

    test(
      'GHI55-3: a bridged class no import exports, and an ambiguous one, '
      'are left out; the ambiguous one is named in a warning [2026-11-14]',
      () async {
        final (code, warnings) = await generate(names);
        expect(code, isNot(contains('Hidden')));
        expect(code, isNot(contains('Shared')));
        expect(
          warnings,
          contains(
            contains(
              'Shared is exported by more than one imported library '
              '(package:zom_a/zom_a.dart, package:zom_b/zom_b.dart)',
            ),
          ),
        );
      },
    );

    test('GHI55-4: without the imported names the path rule decides: the '
        'pub-cache-path class is out of scope (the gap this closes) '
        '[2026-11-14]', () async {
      final (code, _) = await generate(null);
      expect(code, isNot(contains("'Vec' =>")));
    });

    test('GHI55-5: relaxerImportUris lists dart:async first, then the '
        'module barrels sorted [2026-11-14]', () {
      expect(
        relaxerImportUris(
          BridgeConfig(
            name: 'x',
            modules: const [
              ModuleConfig(
                name: 'b',
                barrelFiles: ['lib/b.dart'],
                outputPath: 'lib/src/b.b.dart',
                barrelImport: 'package:zom_b/zom_b.dart',
              ),
              ModuleConfig(
                name: 'a',
                barrelFiles: ['lib/a.dart'],
                outputPath: 'lib/src/a.b.dart',
                barrelImport: 'package:zom_a/zom_a.dart',
              ),
              ModuleConfig(
                name: 'ui',
                barrelFiles: [],
                outputPath: 'lib/src/ui.b.dart',
                barrelImport: 'dart:ui',
              ),
            ],
          ),
        ),
        [
          'dart:async',
          'dart:ui',
          'package:zom_a/zom_a.dart',
          'package:zom_b/zom_b.dart',
        ],
      );
    });
  });

  group('ghissues55: BridgeGenerator.importedNamesOf', () {
    late Directory root;
    late ImportedNames names;

    setUpAll(() async {
      root = Directory.systemTemp.createTempSync('ghissues55_ws_');
      void write(String rel, String text) {
        final f = File(p.join(root.path, rel));
        f.parent.createSync(recursive: true);
        f.writeAsStringSync(text);
      }

      // zom_a exports Box and its own Shared; zom_b exports another Shared
      // and Vec from src/; Hidden is declared but exported by nothing.
      write('zom_a/pubspec.yaml', 'name: zom_a\n');
      write(
        'zom_a/lib/zom_a.dart',
        "export 'src/box.dart';\nexport 'src/shared.dart';\n",
      );
      write(
        'zom_a/lib/src/box.dart',
        'class Box<T> { Box(this.value); final T value; }\n',
      );
      write('zom_a/lib/src/shared.dart', 'class Shared {}\n');
      write('zom_a/lib/src/hidden.dart', 'class Hidden {}\n');
      write('zom_b/pubspec.yaml', 'name: zom_b\n');
      write(
        'zom_b/lib/zom_b.dart',
        "export 'src/vec.dart';\nexport 'src/shared.dart';\n",
      );
      write('zom_b/lib/src/vec.dart', 'class Vec {}\n');
      write('zom_b/lib/src/shared.dart', 'class Shared {}\n');
      write('app/pubspec.yaml', 'name: zom_app\n');
      write('app/lib/app.dart', '');
      write(
        'app/.dart_tool/package_config.json',
        jsonEncode({
          'configVersion': 2,
          'packages': [
            for (final (name, dir) in [
              ('zom_app', '../'),
              ('zom_a', '../../zom_a/'),
              ('zom_b', '../../zom_b/'),
            ])
              {
                'name': name,
                'rootUri': dir,
                'packageUri': 'lib/',
                'languageVersion': '3.0',
              },
          ],
        }),
      );
      names =
          await BridgeGenerator(
            workspacePath: p.join(root.path, 'app'),
            packageName: 'zom_app',
          ).importedNamesOf([
            'dart:async',
            'package:zom_a/zom_a.dart',
            'package:zom_b/zom_b.dart',
            'package:zom_none/none.dart',
          ]);
    });

    tearDownAll(() => root.deleteSync(recursive: true));

    test('GHI55-6: the export namespaces resolve: Box and the src/ Vec are '
        'nameable, Hidden is not, Shared is ambiguous, an unresolved import '
        'is reported [2026-11-14]', () {
      expect(names.nameable, containsAll(['Box', 'Vec', 'Future', 'int']));
      expect(names.nameable, isNot(contains('Hidden')));
      expect(names.ambiguous.keys, ['Shared']);
      expect(names.unresolved, ['package:zom_none/none.dart']);
    });
  });
}
