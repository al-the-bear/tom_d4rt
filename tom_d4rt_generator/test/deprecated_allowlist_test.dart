/// A.5 (OPEN A.5): per-symbol `@Deprecated` allowlist.
///
/// The generator already had a boolean `generateDeprecatedElements` toggle
/// (include *all* deprecated symbols, or none). A.5 adds a per-symbol
/// allowlist so a handful of deprecated SDK symbols a script depends on can be
/// bridged without flipping the whole module to include every deprecated
/// member.
///
/// These tests lock down `ElementModeExtractor._isDeprecatedExcluded` through
/// the full `BridgeGenerator` pipeline:
///   - flag off + empty allowlist ⇒ all `@Deprecated` symbols excluded
///   - flag on ⇒ all symbols emitted
///   - allowlist of one symbol ⇒ that symbol emitted, the rest excluded
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

void main() {
  late String fixturesDir;
  late String tempDir;

  setUpAll(() {
    fixturesDir = p.join(Directory.current.path, 'test', 'fixtures');
    tempDir = Directory.systemTemp
        .createTempSync('deprecated_allowlist_')
        .path;
  });

  tearDownAll(() {
    try {
      Directory(tempDir).deleteSync(recursive: true);
    } catch (_) {}
  });

  /// Generates the fixture bridges with the given deprecated policy and
  /// returns the emitted source.
  Future<String> generateWith({
    required bool generateDeprecatedElements,
    Set<String> deprecatedAllowlist = const {},
    required String outName,
  }) async {
    final generator = BridgeGenerator(
      workspacePath: fixturesDir,
      skipPrivate: true,
      helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
      sourceImport: 'deprecated_allowlist_source.dart',
      packageName: 'test_package',
      verbose: false,
    );
    generator.generateDeprecatedElements = generateDeprecatedElements;
    generator.deprecatedAllowlist = deprecatedAllowlist;

    final src = p.join(fixturesDir, 'deprecated_allowlist_source.dart');
    final out = p.join(tempDir, outName);
    final result = await generator.generateBridges(
      sourceFiles: [src],
      outputPath: out,
      moduleName: 'test',
    );
    expect(result.errors, isEmpty,
        reason: 'deprecated-allowlist fixture must generate cleanly');
    expect(result.outputFiles, isNotEmpty);
    return File(result.outputFiles.first).readAsStringSync();
  }

  group('A.5: @Deprecated allowlist', () {
    test('G-DEP-1: flag off + empty allowlist excludes all deprecated symbols',
        () async {
      final code = await generateWith(
        generateDeprecatedElements: false,
        outName: 'dep_off.dart',
      );
      // Live symbols are always present.
      expect(code, contains('LiveWidget'));
      expect(code, contains('LiveMode'));
      expect(code, contains('liveFunction'));
      // Deprecated symbols are skipped.
      expect(code, isNot(contains('LegacyWidget')));
      expect(code, isNot(contains('LegacyGadget')));
      expect(code, isNot(contains('LegacyMode')));
      expect(code, isNot(contains('legacyFunction')));
      expect(code, isNot(contains('legacyGetter')));
      expect(code, isNot(contains('legacyConstant')));
    });

    test('G-DEP-2: flag on includes all deprecated symbols', () async {
      final code = await generateWith(
        generateDeprecatedElements: true,
        outName: 'dep_on.dart',
      );
      expect(code, contains('LegacyWidget'));
      expect(code, contains('LegacyGadget'));
      expect(code, contains('LegacyMode'));
      expect(code, contains('legacyFunction'));
    });

    test('G-DEP-3: allowlisted symbol is emitted, others stay excluded',
        () async {
      final code = await generateWith(
        generateDeprecatedElements: false,
        deprecatedAllowlist: {'LegacyWidget', 'legacyFunction'},
        outName: 'dep_allow.dart',
      );
      // Allowlisted symbols are emitted.
      expect(code, contains('LegacyWidget'));
      expect(code, contains('legacyFunction'));
      // Non-allowlisted deprecated symbols remain excluded.
      expect(code, isNot(contains('LegacyGadget')));
      expect(code, isNot(contains('LegacyMode')));
      expect(code, isNot(contains('legacyGetter')));
      expect(code, isNot(contains('legacyConstant')));
    });

    test(
        'G-DEP-4: the default policy (flag off + empty allowlist) is '
        'content-identical across repeated generations', () async {
      // The "byte-identical regen" guarantee (OPEN A.5 step d) rests on the
      // deprecated-exclusion path being deterministic: adding the
      // `deprecatedAllowlist` field at its empty default must not perturb
      // output. Generating the same fixture twice under the default policy must
      // yield identical source — modulo the `// Generated:` header timestamp,
      // which is wall-clock and not part of the bridge content.
      final first = stripGeneratedTimestamp(await generateWith(
        generateDeprecatedElements: false,
        outName: 'dep_default_a.dart',
      ));
      final second = stripGeneratedTimestamp(await generateWith(
        generateDeprecatedElements: false,
        deprecatedAllowlist: const {},
        outName: 'dep_default_b.dart',
      ));
      expect(second, equals(first));
    });
  });
}

/// Removes the wall-clock `// Generated: <timestamp>` header line so two
/// generation runs can be compared for content identity.
String stripGeneratedTimestamp(String code) => code
    .split('\n')
    .where((line) => !line.startsWith('// Generated:'))
    .join('\n');
