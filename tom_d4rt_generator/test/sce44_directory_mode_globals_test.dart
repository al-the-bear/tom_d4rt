// sce44: directory mode read the enum, function and variable lists raw.
//
// scd11 fixed exactly this for extensions. The three lines beside the one it
// named had the same shape and the same defect: the single-file branch filters
// each kind by `excludeSourcePatterns` and then collapses GEN-045 name
// collisions, and directory mode — one `<source>_bridge.dart` per source file —
// grouped straight off `globals`, applying none of it.
//
// MEASURED before the fix, on the gen120 part fixture: excluding
// `package:zom_partext/parent_lib.dart` correctly dropped the extension (scd11)
// and still bridged `enum ZomLevel`, declared in that very same excluded file.
//
// It was deferred rather than folded into scd11 because each kind carried its
// own inline pipeline, and shipping three untested extractions inside a tested
// one-line fix is what scd11's own deferral note warned against. These tests
// are that exercise: one fixture declaring all three kinds in an excluded
// source and all three in a kept one, so every assertion has its anti-vacuity
// twin — a blanket "emits nothing" would satisfy the exclusion half while
// breaking the generator, and only the kept-file half notices.
@Tags(['generation'])
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/src/bridge_generator.dart';

/// A package declaring an enum, a global function and a global variable in
/// EACH of two libraries, so one can be excluded and the other must survive.
Directory writeGlobalsFixture() {
  final dir = Directory.systemTemp.createTempSync('sce44_');

  File(p.join(dir.path, 'pubspec.yaml')).writeAsStringSync(
    'name: zom_dirglobals\n'
    'environment:\n'
    "  sdk: '>=3.0.0 <4.0.0'\n",
  );
  Directory(p.join(dir.path, '.dart_tool')).createSync();
  File(p.join(dir.path, '.dart_tool', 'package_config.json')).writeAsStringSync(
    '{\n'
    '  "configVersion": 2,\n'
    '  "packages": [\n'
    '    {\n'
    '      "name": "zom_dirglobals",\n'
    '      "rootUri": "../",\n'
    '      "packageUri": "lib/",\n'
    '      "languageVersion": "3.0"\n'
    '    }\n'
    '  ]\n'
    '}\n',
  );

  final libDir = Directory(p.join(dir.path, 'lib'))..createSync();
  File(p.join(libDir.path, 'excluded_lib.dart')).writeAsStringSync(
    'enum ZomExcludedEnum { alpha, beta }\n'
    '\n'
    'int zomExcludedFunction(int a, int b) => a + b;\n'
    '\n'
    "const String zomExcludedVariable = 'excluded';\n",
  );
  File(p.join(libDir.path, 'kept_lib.dart')).writeAsStringSync(
    'enum ZomKeptEnum { gamma, delta }\n'
    '\n'
    'int zomKeptFunction(int a, int b) => a * b;\n'
    '\n'
    "const String zomKeptVariable = 'kept';\n",
  );

  return dir;
}

/// Generates [fixture] in DIRECTORY mode and returns `outputFile -> contents`.
Future<Map<String, String>> generatePerFile(
  Directory fixture, {
  List<String>? excludeSourcePatterns,
}) async {
  final outDir = Directory.systemTemp.createTempSync('sce44_out_');
  final generator = BridgeGenerator(
    workspacePath: fixture.path,
    skipPrivate: true,
    helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
    packageName: 'zom_dirglobals',
  );

  // A trailing separator is what selects directory mode.
  final result = await generator.generateBridges(
    sourceFiles: [
      p.join(fixture.path, 'lib', 'excluded_lib.dart'),
      p.join(fixture.path, 'lib', 'kept_lib.dart'),
    ],
    outputPath: '${outDir.path}${p.separator}',
    moduleName: 'dirglobals',
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

/// Generates [fixture] in SINGLE-FILE mode and returns the emitted source.
Future<String> generateSingleFile(
  Directory fixture, {
  List<String>? excludeSourcePatterns,
}) async {
  final outDir = Directory.systemTemp.createTempSync('sce44_single_');
  final generator = BridgeGenerator(
    workspacePath: fixture.path,
    skipPrivate: true,
    helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
    packageName: 'zom_dirglobals',
  );
  final result = await generator.generateBridges(
    sourceFiles: [
      p.join(fixture.path, 'lib', 'excluded_lib.dart'),
      p.join(fixture.path, 'lib', 'kept_lib.dart'),
    ],
    outputPath: p.join(outDir.path, 'single.dart'),
    moduleName: 'dirglobals',
    excludeSourcePatterns: excludeSourcePatterns,
  );
  expect(result.errors, isEmpty);
  final source = File(p.join(outDir.path, 'single.dart')).readAsStringSync();
  try {
    outDir.deleteSync(recursive: true);
  } catch (_) {}
  return source;
}

const _excluded = ['package:zom_dirglobals/excluded_lib.dart'];

/// Every emitted file concatenated — the question is whether a name appears
/// ANYWHERE, and directory mode spreads output across files.
String _all(Map<String, String> emitted) => emitted.values.join('\n');

void main() {
  late Directory fixture;

  setUpAll(() => fixture = writeGlobalsFixture());

  tearDownAll(() {
    try {
      fixture.deleteSync(recursive: true);
    } catch (_) {}
  });

  group('sce44: directory mode honours excludeSourcePatterns for globals', () {
    test(
      'G-SCE44-1: the fixture declares all six, so the exclusions below mean '
      'something [2026-09-18] (PASS)',
      () async {
        // Anti-vacuity, and the reason it is first: every assertion that
        // follows is an absence. Without this, a generator that emitted
        // nothing at all would pass the entire rest of this file.
        final all = _all(await generatePerFile(fixture));

        for (final name in [
          'ZomExcludedEnum',
          'zomExcludedFunction',
          'zomExcludedVariable',
          'ZomKeptEnum',
          'zomKeptFunction',
          'zomKeptVariable',
        ]) {
          expect(
            all,
            contains(name),
            reason:
                'unexcluded, directory mode must bridge $name — otherwise '
                'its absence under exclusion proves nothing',
          );
        }
      },
      timeout: const Timeout(Duration(minutes: 2)),
    );

    test(
      'G-SCE44-2: an excluded source contributes no ENUM [2026-09-18] (PASS)',
      () async {
        final all = _all(
          await generatePerFile(fixture, excludeSourcePatterns: _excluded),
        );

        expect(
          all,
          isNot(contains('ZomExcludedEnum')),
          reason:
              'this is the case measured on the gen120 fixture: the '
              'extension was dropped and the enum beside it was not',
        );
        expect(
          all,
          contains('ZomKeptEnum'),
          reason: 'the exclusion must be a filter, not a blanket drop',
        );
      },
      timeout: const Timeout(Duration(minutes: 2)),
    );

    test('G-SCE44-3: an excluded source contributes no FUNCTION '
        '[2026-09-18] (PASS)', () async {
      final all = _all(
        await generatePerFile(fixture, excludeSourcePatterns: _excluded),
      );

      expect(all, isNot(contains('zomExcludedFunction')));
      expect(all, contains('zomKeptFunction'));
    }, timeout: const Timeout(Duration(minutes: 2)));

    test('G-SCE44-4: an excluded source contributes no VARIABLE '
        '[2026-09-18] (PASS)', () async {
      final all = _all(
        await generatePerFile(fixture, excludeSourcePatterns: _excluded),
      );

      expect(all, isNot(contains('zomExcludedVariable')));
      expect(all, contains('zomKeptVariable'));
    }, timeout: const Timeout(Duration(minutes: 2)));

    test('G-SCE44-5: single-file mode is unchanged by the lift '
        '[2026-09-18] (PASS)', () async {
      // The three pipelines were LIFTED out of this branch, so the risk is
      // not only that directory mode gains the filter but that single-file
      // mode loses it. Both halves are asserted against the same fixture.
      final unfiltered = await generateSingleFile(fixture);
      for (final name in [
        'ZomExcludedEnum',
        'zomExcludedFunction',
        'zomExcludedVariable',
      ]) {
        expect(unfiltered, contains(name));
      }

      final filtered = await generateSingleFile(
        fixture,
        excludeSourcePatterns: _excluded,
      );
      expect(filtered, isNot(contains('ZomExcludedEnum')));
      expect(filtered, isNot(contains('zomExcludedFunction')));
      expect(filtered, isNot(contains('zomExcludedVariable')));
      expect(filtered, contains('ZomKeptEnum'));
      expect(filtered, contains('zomKeptFunction'));
      expect(filtered, contains('zomKeptVariable'));
    }, timeout: const Timeout(Duration(minutes: 2)));
  });
}
