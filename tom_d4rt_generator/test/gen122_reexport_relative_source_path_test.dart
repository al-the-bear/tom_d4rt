// GEN-122: `bridgeReExports()` must be emitted for source files named by a
// relative path, not only for ones named by an absolute path.
//
// Regression guard for the silent data loss found in
// `tom_core_d4rt/lib/src/*/*_bridges.b.dart`: regenerating the bridges deleted
// ~330 re-export edges without a single warning. Every dropped edge belonged
// to a package listed with a `path:` dependency — i.e. one whose `barrelFiles`
// in `buildkit.yaml` are written relative to the project directory
// (`../../distributed/tom_dist_ledger/lib/tom_dist_ledger.dart`). Every edge
// that survived belonged to a hosted package, whose files the barrel walk
// reaches through an absolute `~/.pub-cache/...` path.
//
// The cause is a key mismatch, not a resolution failure: the collector stores
// under the NORMALIZED ABSOLUTE path (`parseFile` normalizes before resolving),
// while the emitter looked the entry up under the path as written. For an
// absolute source file the two strings coincide and everything works; for a
// relative one the lookup misses and the whole file's exports vanish.
//
// The defect is invisible downstream — `bridgeReExports()` is still emitted,
// just empty, so the generated code analyzes clean and every test stays green
// while d4rt scripts silently lose the ability to resolve symbols through the
// affected barrels. Only an assertion on the emitted content catches it.
//
// NOTE ON TEST DESIGN: like the GEN-119/GEN-120 suites, this file deliberately
// does NOT chdir — `dart test` runs test files as isolates inside one process
// and `Directory.current` is process-wide. The relative path is therefore
// derived from the current directory rather than by moving into the fixture.

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

/// Writes a minimal package whose barrel re-exports two `src/` libraries, one
/// of which re-exports the other behind a `show` combinator.
///
/// Three export directives are needed to pin the three shapes that appear in
/// the real bridges: a plain barrel export, a second plain barrel export, and
/// a `show`-filtered export between two `src/` files.
Directory writeReExportFixture() {
  final dir = Directory.systemTemp.createTempSync('gen122_');

  File(p.join(dir.path, 'pubspec.yaml')).writeAsStringSync(
    'name: zom_reexp\n'
    'environment:\n'
    "  sdk: '>=3.0.0 <4.0.0'\n",
  );

  Directory(p.join(dir.path, '.dart_tool')).createSync();
  File(p.join(dir.path, '.dart_tool', 'package_config.json')).writeAsStringSync(
    '{\n'
    '  "configVersion": 2,\n'
    '  "packages": [\n'
    '    {\n'
    '      "name": "zom_reexp",\n'
    '      "rootUri": "../",\n'
    '      "packageUri": "lib/",\n'
    '      "languageVersion": "3.0"\n'
    '    }\n'
    '  ]\n'
    '}\n',
  );

  final srcDir = Directory(p.join(dir.path, 'lib', 'src'))
    ..createSync(recursive: true);

  File(p.join(srcDir.path, 'zom_types.dart')).writeAsStringSync(
    'class ZomTypeA {\n'
    '  ZomTypeA(this.label);\n'
    '  final String label;\n'
    '}\n'
    '\n'
    'class ZomHidden {\n'
    '  ZomHidden();\n'
    '}\n',
  );

  File(p.join(srcDir.path, 'zom_api.dart')).writeAsStringSync(
    "export 'zom_types.dart' show ZomTypeA;\n"
    '\n'
    'class ZomApi {\n'
    '  ZomApi();\n'
    '  String greet(ZomTypeA a) => a.label;\n'
    '}\n',
  );

  File(p.join(dir.path, 'lib', 'zom_reexp.dart')).writeAsStringSync(
    "export 'src/zom_api.dart';\n"
    "export 'src/zom_types.dart';\n",
  );

  return dir;
}

/// Extracts the body of the generated `bridgeReExports()` method.
///
/// Asserting on the whole file would pass on an accidental match elsewhere in
/// the output (the same URIs appear in imports and in `extensionSourceUris`),
/// so the assertions are scoped to the one method under test.
String extractReExportBody(String generatedCode) {
  const marker = 'bridgeReExports() {';
  final start = generatedCode.indexOf(marker);
  if (start == -1) return '';
  final end = generatedCode.indexOf('  }', start);
  return generatedCode.substring(start, end == -1 ? generatedCode.length : end);
}

/// Generates the fixture's bridges with every source file named by [pathStyle].
Future<String> generateWith(
  Directory fixture,
  String Function(String absolutePath) pathStyle,
) async {
  final outDir = Directory.systemTemp.createTempSync('gen122_out_');
  final generator = BridgeGenerator(
    workspacePath: fixture.path,
    skipPrivate: true,
    helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
    packageName: 'zom_reexp',
  );

  final absoluteSources = [
    p.join(fixture.path, 'lib', 'zom_reexp.dart'),
    p.join(fixture.path, 'lib', 'src', 'zom_api.dart'),
    p.join(fixture.path, 'lib', 'src', 'zom_types.dart'),
  ];

  final result = await generator.generateBridges(
    sourceFiles: absoluteSources.map(pathStyle).toList(),
    outputPath: p.join(outDir.path, 'zom_reexp_bridges.dart'),
    moduleName: 'reexp',
  );
  expect(result.errors, isEmpty, reason: 'fixture must generate cleanly');

  final code =
      File(p.join(outDir.path, 'zom_reexp_bridges.dart')).readAsStringSync();
  try {
    outDir.deleteSync(recursive: true);
  } catch (_) {}
  return code;
}

void main() {
  late Directory fixture;
  late String absoluteBody;
  late String relativeBody;

  setUpAll(() async {
    fixture = writeReExportFixture();

    absoluteBody = extractReExportBody(
      await generateWith(fixture, (path) => path),
    );
    relativeBody = extractReExportBody(
      await generateWith(
        fixture,
        (path) => p.relative(path, from: Directory.current.path),
      ),
    );
  });

  tearDownAll(() {
    try {
      fixture.deleteSync(recursive: true);
    } catch (_) {}
  });

  group('GEN-122: re-export collection is independent of path style', () {
    test(
      'G-GEN122-01: absolute source paths emit every export directive '
      '[2026-08-10] (PASS)',
      () {
        // Anti-vacuity guard for G-GEN122-03: if the absolute run were also
        // empty, comparing the two runs would prove nothing.
        expect(
          absoluteBody,
          contains(
            "(source: 'package:zom_reexp/zom_reexp.dart', "
            "target: 'package:zom_reexp/src/zom_api.dart'",
          ),
        );
        expect(
          absoluteBody,
          contains(
            "(source: 'package:zom_reexp/zom_reexp.dart', "
            "target: 'package:zom_reexp/src/zom_types.dart'",
          ),
        );
        expect(
          absoluteBody,
          contains(
            "(source: 'package:zom_reexp/src/zom_api.dart', "
            "target: 'package:zom_reexp/src/zom_types.dart', "
            "show: {'ZomTypeA'}",
          ),
        );
      },
    );

    test(
      'G-GEN122-02: relative source paths emit the same export directives '
      '[2026-08-10] (PASS)',
      () {
        expect(
          relativeBody,
          contains(
            "(source: 'package:zom_reexp/zom_reexp.dart', "
            "target: 'package:zom_reexp/src/zom_api.dart'",
          ),
          reason:
              'A barrel named by a relative path — the shape every `path:` '
              'dependency takes in buildkit.yaml — must contribute its '
              'exports exactly as an absolute one does.',
        );
        expect(
          relativeBody,
          contains(
            "(source: 'package:zom_reexp/src/zom_api.dart', "
            "target: 'package:zom_reexp/src/zom_types.dart', "
            "show: {'ZomTypeA'}",
          ),
          reason:
              'The show combinator has to survive too — dropping it would '
              'widen the re-export instead of losing it, which is the more '
              'dangerous failure of the two.',
        );
      },
    );

    test(
      'G-GEN122-03: the two path styles produce identical re-export bodies '
      '[2026-08-10] (PASS)',
      () {
        expect(
          relativeBody,
          equals(absoluteBody),
          reason:
              'How a source file is spelled on the command line is not a '
              'semantic property of the library it names. Any divergence here '
              'means the generator is keying state on the spelling.',
        );
      },
    );
  });
}
