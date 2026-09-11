// scd8_ahcm: `extensionSourceUris()` must identify an extension, not just name
// it.
//
// The emitted map was keyed by the extension NAME alone:
//
//     static Map<String, String> extensionSourceUris() {
//       return {
//         'Helpers': 'package:zom_extkey/alpha.dart',
//         'Helpers': 'package:zom_extkey/beta.dart',   // last one wins
//
// and `registerBridges()` looked the URI up by that same name. Two genuinely
// distinct extensions that share a name — different on-types, different
// libraries — therefore collapsed to one entry, and ONE of them was registered
// against the OTHER's source URI. That is independent of GEN-120, which
// removed a duplicate of a SINGLE extension; this is two extensions sharing one
// key.
//
// The key is a wire format: the same expression is spelled out on both sides,
// in the map and in the `registerBridges()` lookup, so both move together.
//
// WHAT IS STILL NOT DISTINGUISHABLE. The lookup runs against a
// `BridgedExtensionDefinition`, which carries the name and the on-type and
// nothing else — so two extensions sharing BOTH (the same name on the same
// type, from two libraries) cannot be told apart at the lookup site by any key
// built there. The generator now reports that case as a warning at generation
// time and emits one entry rather than a duplicate map key, which would make
// the generated file fail the GEN-121 analyze gate. G-EXTKEY-5 pins it.
//
// NOTE ON TEST DESIGN: like the GEN-119/120/121 suites, this file deliberately
// does NOT chdir. `dart test` runs test files as isolates inside one process
// and `Directory.current` is process-wide.

@Tags(['generation'])
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

/// Writes a package whose two libraries each declare `extension Helpers`.
///
/// [sameOnType] puts both extensions on the SAME type, which is the residual
/// case no lookup key can separate.
Directory writeSameNameExtensionFixture({bool sameOnType = false}) {
  final dir = Directory.systemTemp.createTempSync('extkey_');

  File(p.join(dir.path, 'pubspec.yaml')).writeAsStringSync(
    'name: zom_extkey\n'
    'environment:\n'
    "  sdk: '>=3.0.0 <4.0.0'\n",
  );

  Directory(p.join(dir.path, '.dart_tool')).createSync();
  File(p.join(dir.path, '.dart_tool', 'package_config.json')).writeAsStringSync(
    '{\n'
    '  "configVersion": 2,\n'
    '  "packages": [\n'
    '    {\n'
    '      "name": "zom_extkey",\n'
    '      "rootUri": "../",\n'
    '      "packageUri": "lib/",\n'
    '      "languageVersion": "3.0"\n'
    '    }\n'
    '  ]\n'
    '}\n',
  );

  final libDir = Directory(p.join(dir.path, 'lib'))..createSync();
  File(p.join(libDir.path, 'alpha.dart')).writeAsStringSync(
    'class Alpha {\n'
    '  Alpha(this.value);\n'
    '  final int value;\n'
    '}\n'
    '\n'
    'extension Helpers on Alpha {\n'
    "  String get tag => 'alpha:\$value';\n"
    '}\n',
  );
  File(p.join(libDir.path, 'beta.dart')).writeAsStringSync(
    // Same on-type means beta has to import alpha to name it.
    '${sameOnType ? "import 'alpha.dart';\n\n" : ''}'
    'class Beta {\n'
    '  Beta(this.value);\n'
    '  final int value;\n'
    '}\n'
    '\n'
    'extension Helpers on ${sameOnType ? 'Alpha' : 'Beta'} {\n'
    "  String get label => 'beta:\$value';\n"
    '}\n',
  );

  return dir;
}

/// Generates the fixture's bridge and returns `(code, warnings)`.
Future<(String, List<String>)> generateFixture(Directory fixture) async {
  final outDir = Directory.systemTemp.createTempSync('extkey_out_');
  final generator = BridgeGenerator(
    workspacePath: fixture.path,
    skipPrivate: true,
    helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
    packageName: 'zom_extkey',
  );
  final result = await generator.generateBridges(
    sourceFiles: [
      p.join(fixture.path, 'lib', 'alpha.dart'),
      p.join(fixture.path, 'lib', 'beta.dart'),
    ],
    outputPath: p.join(outDir.path, 'zom_extkey_bridges.dart'),
    moduleName: 'extkey',
  );
  expect(result.errors, isEmpty, reason: 'fixture must generate cleanly');
  final code =
      File(p.join(outDir.path, 'zom_extkey_bridges.dart')).readAsStringSync();
  try {
    outDir.deleteSync(recursive: true);
  } catch (_) {}
  return (code, result.warnings);
}

int countOf(String haystack, String needle) =>
    needle.allMatches(haystack).length;

void main() {
  late Directory fixture;
  late String generatedCode;

  setUpAll(() async {
    fixture = writeSameNameExtensionFixture();
    final (code, _) = await generateFixture(fixture);
    generatedCode = code;
  });

  tearDownAll(() {
    try {
      fixture.deleteSync(recursive: true);
    } catch (_) {}
  });

  group('scd8: same-named extensions from different libraries', () {
    test(
      'G-EXTKEY-1: both extensions reach bridgedExtensions() '
      '[2026-09-12] (PASS)',
      () {
        expect(countOf(generatedCode, "name: 'Helpers'"), equals(2));
      },
    );

    test(
      'G-EXTKEY-2: each survives in extensionSourceUris() under its own key, '
      'mapped to its own library [2026-09-12] (PASS)',
      () {
        expect(
          generatedCode,
          contains("'Helpers@Alpha': 'package:zom_extkey/alpha.dart'"),
        );
        expect(
          generatedCode,
          contains("'Helpers@Beta': 'package:zom_extkey/beta.dart'"),
        );
      },
    );

    test(
      'G-EXTKEY-3: the bare name is no longer a key, so neither entry can '
      'overwrite the other [2026-09-12] (PASS)',
      () {
        expect(
          countOf(generatedCode, "      'Helpers':"),
          equals(0),
          reason:
              'the bare name was the key that made the two collide — Dart '
              'keeps the last entry, so one extension registered against the '
              "other's source URI",
        );
      },
    );

    test(
      'G-EXTKEY-4: registerBridges() looks the URI up under the same key it '
      'was emitted with [2026-09-12] (PASS)',
      () {
        // The key is spelled on both sides; if they ever disagree, every
        // lookup misses and every extension registers with a null source URI
        // — which nothing else in the suite would notice.
        expect(
          generatedCode,
          contains(r"final extKey = '${extDef.name ?? '<unnamed>'}"
              r"@${extDef.onTypeName}';"),
        );
        expect(generatedCode, contains('sourceUri: extSources[extKey]'));
      },
    );

    test(
      'G-EXTKEY-5: two extensions sharing name AND on-type are reported, and '
      'emit one key rather than a duplicate [2026-09-12] (PASS)',
      () async {
        final collide = writeSameNameExtensionFixture(sameOnType: true);
        try {
          final (code, warnings) = await generateFixture(collide);

          expect(
            countOf(code, "'Helpers@Alpha':"),
            equals(1),
            reason:
                'a duplicate key is an equal_keys_in_map warning, which the '
                'GEN-121 gate treats as fatal — the generated file must stay '
                'clean and the generator must be the one to complain',
          );
          expect(
            warnings.where((w) => w.contains('Helpers')),
            isNotEmpty,
            reason:
                'nothing at the lookup site can tell these two apart, so '
                'generation time is the only place this can be reported',
          );
          expect(
            warnings.join('\n'),
            contains('package:zom_extkey/beta.dart'),
            reason: 'the warning must name the extension that loses its URI',
          );
        } finally {
          try {
            collide.deleteSync(recursive: true);
          } catch (_) {}
        }
      },
    );
  });
}
