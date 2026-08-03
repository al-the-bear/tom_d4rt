// GEN-120: an extension declared inside a `part of` file must be collected
// exactly once.
//
// Regression guard for the duplicate found in
// `tom_dist_ledger/lib/src/d4rt_bridges/tom_dist_ledger_bridges.b.dart`:
//
//     static Map<String, String> extensionSourceUris() {
//       return {
//         'DLLogLevelExtension': 'package:tom_dist_ledger/src/ledger_api/call_callback.dart',
//         'DLLogLevelExtension': 'package:tom_dist_ledger/src/ledger_api/ledger_api.dart',
//         ...
//
// `DLLogLevelExtension` is declared in `call_callback.dart`, which is
// `part of 'ledger_api.dart'`. The barrel walk hands `_parseGlobals` both the
// part and its parent library as separate source files. Resolving either one
// yields the SAME `LibraryElement`, so the extractor returns the same
// extension twice — once tagged with the part's path, once with the parent's.
//
// The visible symptom is the analyzer's `equal_keys_in_map`, but that is only
// the tip: `bridgedExtensions()` emits the extension twice as two complete
// `BridgedExtensionDefinition` entries, and a duplicate element in a List
// literal is perfectly legal Dart, so nothing complains at all. Deduping the
// map alone would silence the warning and leave the double registration — so
// the fix has to be at collection time, which is what these tests pin.
//
// NOTE ON TEST DESIGN: like the GEN-119 suite, this file deliberately does NOT
// chdir. `dart test` runs test files as isolates inside one process and
// `Directory.current` is process-wide.

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

/// Writes a minimal package whose `part of` file declares an extension.
///
/// This is the shape that produced the tom_dist_ledger duplicate. Three files
/// are needed, and the third one is the non-obvious part:
///
///   * `parent_lib.dart` — declares the on-type and owns the part.
///   * `child_part.dart` — `part of` the parent, declares the extension.
///   * `consumer.dart`   — *imports* the parent library.
///
/// Without the importing file there is no duplicate. The extension is
/// collected twice by two different code paths: the local extractor sees it
/// while extracting `parent_lib.dart` (tagged with the parent's path), and
/// GEN-049 import discovery sees it again while extracting `consumer.dart`,
/// tagged with `extElement.firstFragment.libraryFragment.source.uri` — which
/// for a part-declared extension is the PART's URI, not the library's.
Directory writePartExtensionFixture() {
  final dir = Directory.systemTemp.createTempSync('gen120_');

  File(p.join(dir.path, 'pubspec.yaml')).writeAsStringSync(
    'name: zom_partext\n'
    'environment:\n'
    "  sdk: '>=3.0.0 <4.0.0'\n",
  );

  Directory(p.join(dir.path, '.dart_tool')).createSync();
  File(p.join(dir.path, '.dart_tool', 'package_config.json')).writeAsStringSync(
    '{\n'
    '  "configVersion": 2,\n'
    '  "packages": [\n'
    '    {\n'
    '      "name": "zom_partext",\n'
    '      "rootUri": "../",\n'
    '      "packageUri": "lib/",\n'
    '      "languageVersion": "3.0"\n'
    '    }\n'
    '  ]\n'
    '}\n',
  );

  final libDir = Directory(p.join(dir.path, 'lib'))..createSync();
  File(p.join(libDir.path, 'parent_lib.dart')).writeAsStringSync(
    'library;\n'
    "part 'child_part.dart';\n"
    '\n'
    'enum ZomLevel { debug, info }\n',
  );
  File(p.join(libDir.path, 'child_part.dart')).writeAsStringSync(
    "part of 'parent_lib.dart';\n"
    '\n'
    'extension ZomLevelExtension on ZomLevel {\n'
    "  String get label => name.toUpperCase();\n"
    '  bool isAtLeast(ZomLevel other) => index >= other.index;\n'
    '}\n',
  );
  File(p.join(libDir.path, 'consumer.dart')).writeAsStringSync(
    "import 'parent_lib.dart';\n"
    '\n'
    'class ZomUser {\n'
    '  ZomUser(this.level);\n'
    '  final ZomLevel level;\n'
    '  String describe() => level.label;\n'
    '}\n',
  );

  return dir;
}

/// Counts occurrences of [needle] in [haystack].
int countOf(String haystack, String needle) =>
    needle.allMatches(haystack).length;

void main() {
  late Directory fixture;
  late Directory outDir;
  late String generatedCode;

  setUpAll(() async {
    fixture = writePartExtensionFixture();
    outDir = Directory.systemTemp.createTempSync('gen120_out_');

    final generator = BridgeGenerator(
      workspacePath: fixture.path,
      skipPrivate: true,
      helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
      packageName: 'zom_partext',
    );

    // Both the declaring library and a file that imports it must be in the
    // source list — that is the whole point of the fixture. With only one of
    // them there is a single collection path and no duplicate.
    final result = await generator.generateBridges(
      sourceFiles: [
        p.join(fixture.path, 'lib', 'parent_lib.dart'),
        p.join(fixture.path, 'lib', 'consumer.dart'),
      ],
      outputPath: p.join(outDir.path, 'zom_partext_bridges.dart'),
      moduleName: 'partext',
    );

    expect(result.errors, isEmpty, reason: 'fixture must generate cleanly');
    generatedCode = File(
      p.join(outDir.path, 'zom_partext_bridges.dart'),
    ).readAsStringSync();
  });

  tearDownAll(() {
    for (final dir in [fixture, outDir]) {
      try {
        dir.deleteSync(recursive: true);
      } catch (_) {}
    }
  });

  group('GEN-120: part-declared extensions are collected once', () {
    test(
      'G-GEN120-01: the extension is registered exactly once in '
      'bridgedExtensions() [2026-08-03] (PASS)',
      () {
        expect(
          countOf(generatedCode, "name: 'ZomLevelExtension'"),
          equals(1),
          reason:
              'Resolving the part and resolving its parent both yield the '
              'same LibraryElement, so the extractor returns the extension '
              'twice. A duplicate element in a List literal is legal Dart, so '
              'this defect is invisible to the analyzer — only this assertion '
              'catches it.',
        );
      },
    );

    test(
      'G-GEN120-02: extensionSourceUris() emits no duplicate key '
      '[2026-08-03] (PASS)',
      () {
        expect(
          countOf(generatedCode, "'ZomLevelExtension':"),
          equals(1),
          reason:
              'A duplicate key in a map literal is what the analyzer reports '
              'as equal_keys_in_map. Dart silently keeps the LAST entry, so '
              'the duplicate is not merely noisy — it decides which source '
              'URI survives by source order.',
        );
      },
    );

    test(
      'G-GEN120-03: the surviving source URI is the parent library, not the '
      'part [2026-08-03] (PASS)',
      () {
        expect(
          generatedCode,
          contains(
            "'ZomLevelExtension': 'package:zom_partext/parent_lib.dart'",
          ),
          reason:
              'A part file is not independently importable, so its URI is '
              'useless to any consumer that tries to act on it. The parent '
              'library is the only URI that can be imported.',
        );
        expect(
          generatedCode,
          isNot(contains('package:zom_partext/child_part.dart')),
          reason: 'The part URI must not appear anywhere in the output.',
        );
      },
    );

    test(
      'G-GEN120-04: deduplication keeps the members, it does not drop the '
      'extension [2026-08-03] (PASS)',
      () {
        // Anti-vacuity guard. Asserting "exactly one" passes just as happily
        // when the count is one because the extension was dropped entirely as
        // when it was correctly deduped, so pin the payload too.
        expect(generatedCode, contains("'label'"));
        expect(generatedCode, contains("'isAtLeast'"));
      },
    );
  });
}
