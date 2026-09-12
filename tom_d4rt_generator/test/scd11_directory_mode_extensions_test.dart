// scd11_ahcm: directory mode read the extension list raw.
//
// GEN-120 (scc71) deduplicated extensions in SINGLE-FILE mode. Directory mode —
// one `<source>_bridge.dart` per source file — grouped them straight off
// `globals.extensions`, before the `excludeSourcePatterns` filter and before
// the GEN-064/GEN-120 dedupe, keyed on the unnormalised `sourceFile`.
//
// Two independent defects at one call site:
//
//   * a part-declared extension is emitted into TWO output files — one named
//     after the part, one after the parent library — each carrying a complete
//     `BridgedExtensionDefinition`, and both get registered. Single-file mode
//     collapses those two arrivals (the local extractor tags the extension with
//     the parent library, GEN-049 import discovery tags it with the declaring
//     fragment, which for a part is the part's own URI); directory mode kept
//     both and then split them across files.
//   * `excludeSourcePatterns` did not apply to extensions at all, so an
//     excluded source still produced one.
//
// It was deferred rather than fixed with GEN-120 because no consumer in this
// workspace uses directory mode, and shipping an untested second code path
// beside a tested fix is how an unexercised path stays unexercised. These tests
// are that exercise.
@Tags(['generation'])
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/src/bridge_generator.dart';

// The fixture is the one GEN-120 already builds: a parent library owning a
// `part of` file that declares the extension, plus a third file importing the
// parent — without that importer there is only one collection path and no
// duplicate to speak of.
import 'gen120_part_declared_extension_test.dart' show writePartExtensionFixture;

/// Generates [fixture] in DIRECTORY mode and returns `outputFile -> contents`.
Future<Map<String, String>> generatePerFile(
  Directory fixture, {
  List<String>? excludeSourcePatterns,
}) async {
  final outDir = Directory.systemTemp.createTempSync('scd11_out_');
  final generator = BridgeGenerator(
    workspacePath: fixture.path,
    skipPrivate: true,
    helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
    packageName: 'zom_partext',
  );

  // A trailing separator is what selects directory mode.
  final result = await generator.generateBridges(
    sourceFiles: [
      p.join(fixture.path, 'lib', 'parent_lib.dart'),
      p.join(fixture.path, 'lib', 'consumer.dart'),
    ],
    outputPath: '${outDir.path}${p.separator}',
    moduleName: 'partext',
    excludeSourcePatterns: excludeSourcePatterns,
  );
  expect(result.errors, isEmpty, reason: 'fixture must generate cleanly');

  final emitted = <String, String>{
    for (final file in outDir.listSync().whereType<File>())
      p.basename(file.path): file.readAsStringSync(),
  };
  try {
    outDir.deleteSync(recursive: true);
  } catch (_) {}
  return emitted;
}

void main() {
  late Directory fixture;

  setUpAll(() => fixture = writePartExtensionFixture());

  tearDownAll(() {
    try {
      fixture.deleteSync(recursive: true);
    } catch (_) {}
  });

  /// Generates [fixture] in SINGLE-FILE mode and returns the emitted source.
  Future<String> generateSingleFile(
    Directory fixture, {
    List<String>? excludeSourcePatterns,
  }) async {
    final outDir = Directory.systemTemp.createTempSync('scd11_single_');
    final generator = BridgeGenerator(
      workspacePath: fixture.path,
      skipPrivate: true,
      helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
      packageName: 'zom_partext',
    );
    final result = await generator.generateBridges(
      sourceFiles: [
        p.join(fixture.path, 'lib', 'parent_lib.dart'),
        p.join(fixture.path, 'lib', 'consumer.dart'),
      ],
      outputPath: p.join(outDir.path, 'single.dart'),
      moduleName: 'partext',
      excludeSourcePatterns: excludeSourcePatterns,
    );
    expect(result.errors, isEmpty);
    final source = File(p.join(outDir.path, 'single.dart')).readAsStringSync();
    try {
      outDir.deleteSync(recursive: true);
    } catch (_) {}
    return source;
  }

  group('scd11: directory mode filters and dedupes extensions', () {
    test(
      'G-SCD11-1: a part-declared extension is emitted into exactly one file '
      '[2026-09-12] (PASS)',
      () async {
        final emitted = await generatePerFile(fixture);
        final carriers = emitted.entries
            .where((e) => e.value.contains("name: 'ZomLevelExtension'"))
            .map((e) => e.key)
            .toList()
          ..sort();

        expect(
          carriers,
          hasLength(1),
          reason: 'Emitted into two files, each with a complete definition, '
              'both registered. Single-file mode has collapsed this since '
              'GEN-120; directory mode read the list before the dedupe.',
        );
        expect(
          carriers.single,
          'parent_lib_bridge.dart',
          reason: 'the surviving copy must be the parent library: a part file '
              'is not independently importable, so its URI is useless to any '
              'consumer that acts on it',
        );
      },
    );

    test(
      'G-SCD11-2: the extension is registered once within that file '
      '[2026-09-12] (PASS)',
      () async {
        final emitted = await generatePerFile(fixture);
        final source = emitted['parent_lib_bridge.dart'] ?? '';

        expect(
          "name: 'ZomLevelExtension'".allMatches(source).length,
          1,
          reason: 'a duplicate element in a List literal is legal Dart, so '
              'nothing but this assertion catches a double registration',
        );
        expect(
          "'ZomLevelExtension@ZomLevel':".allMatches(source).length,
          1,
          reason: 'a duplicate map key is equal_keys_in_map, and Dart keeps '
              'the last entry — deciding the source URI by source order',
        );
      },
    );

    test(
      'G-SCD11-3: excludeSourcePatterns applies to extensions in directory '
      'mode [2026-09-12] (PASS)',
      () async {
        final emitted = await generatePerFile(
          fixture,
          // The pattern globs against the whole source URI, as the doc
          // comment on _matchesSourceExclusion shows.
          excludeSourcePatterns: ['package:zom_partext/parent_lib.dart'],
        );

        final carriers = emitted.entries
            .where((e) => e.value.contains("name: 'ZomLevelExtension'"))
            .map((e) => e.key)
            .toList();

        expect(
          carriers,
          isEmpty,
          reason: 'the exclusion filter sat in the single-file branch only, so '
              'directory mode bridged a source the caller had excluded',
        );
      },
    );

    test(
      'G-SCD11-5: the parent library\'s other declarations survive alongside '
      'it [2026-09-12] (PASS)',
      () async {
        // The dedupe rewrites a part-declared extension's sourceFile to the
        // parent library's `package:` URI. Grouped on that string directly it
        // forms a SECOND group for a file that already has one, and both write
        // to `parent_lib_bridge.dart` — so one silently overwrites the other
        // and the enum disappears. The extension has to group with the file it
        // belongs to.
        final emitted = await generatePerFile(fixture);
        final source = emitted['parent_lib_bridge.dart'] ?? '';

        expect(source, contains("name: 'ZomLevelExtension'"));
        expect(
          source,
          contains("'ZomLevel'"),
          reason: 'parent_lib.dart declares enum ZomLevel; emitting the '
              'extension into a separate group would drop it',
        );
      },
    );

    test(
      'G-SCD11-6: single-file mode honours the exclusion for the same '
      'part-declared extension [2026-09-12] (PASS)',
      () async {
        // The hole was not directory-mode-only: measured before the fix,
        // single-file mode also emitted the extension under this exclusion,
        // because the part's copy survived the filter and the dedupe then
        // renamed it to the excluded parent. One helper now serves both modes,
        // so both are pinned.
        expect(
          await generateSingleFile(
            fixture,
            excludeSourcePatterns: ['package:zom_partext/parent_lib.dart'],
          ),
          isNot(contains("name: 'ZomLevelExtension'")),
        );
        expect(
          await generateSingleFile(fixture),
          contains("name: 'ZomLevelExtension'"),
          reason: 'anti-vacuity: without the exclusion it is emitted',
        );
      },
    );

    test(
      'G-SCD11-4: an unexcluded run still emits it — the exclusion test is not '
      'passing by accident [2026-09-12] (PASS)',
      () async {
        // Anti-vacuity for G-SCD11-3: if generation stopped emitting the
        // extension for any other reason, that test would pass while proving
        // nothing.
        final emitted = await generatePerFile(fixture);
        expect(
          emitted.values.any((s) => s.contains("name: 'ZomLevelExtension'")),
          isTrue,
        );
      },
    );
  });
}
