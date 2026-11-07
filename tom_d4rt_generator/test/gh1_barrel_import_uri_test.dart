// GitHub al-the-bear/tom_d4rt#1, bug 3: the import a generated bridge hands a
// D4rt script must be a `package:` URI.
//
// A module names its barrel as a path relative to the package root
// (`barrelFiles: [lib/url_builder.dart]`), and the generator emitted that path
// verbatim wherever it needed the barrel's import: as the import path the
// dartscript and test-runner register the bridges under, and (through
// `BridgeGenerator`'s own fallback) as `package:<pkg>/lib/url_builder.dart` in
// getImportBlock(). No script can import either. Every configuration in the
// tree worked around it with an explicit `barrelImport`; three of those
// (`tom_dist_ledger.dart`, `tom_process_monitor.dart`, `tom_vscode_bridge.dart`)
// are lib-relative themselves, and tom_vscode_bridge's dartscript registered
// its bridges under 'tom_vscode_bridge.dart' and 'lib/tom_vscode_bridge.dart'
// but never under its package URI (measured 2026-11-07).
@Tags(['generation'])
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/src/bridge_config.dart';
import 'package:tom_d4rt_generator/src/file_generators.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart'
    show BridgeGenerator;

void main() {
  group('gh1: a barrel import is a package: URI', () {
    test('GH1-1: barrelImportUri resolves each path form '
        '[2026-11-07]', () {
      expect(
        barrelImportUri('lib/url_builder.dart', 'pkg'),
        'package:pkg/url_builder.dart',
      );
      expect(
        barrelImportUri('lib/src/a.dart', 'pkg'),
        'package:pkg/src/a.dart',
      );
      expect(barrelImportUri('./lib/a.dart', 'pkg'), 'package:pkg/a.dart');
      // A barrelImport without a scheme is lib-relative, as configured today.
      expect(
        barrelImportUri('url_builder.dart', 'pkg'),
        'package:pkg/url_builder.dart',
      );
      // A URI stays as written.
      expect(
        barrelImportUri('package:other/x.dart', 'pkg'),
        'package:other/x.dart',
      );
      expect(barrelImportUri('dart:async', 'pkg'), 'dart:async');
    });

    test('GH1-2: a module with only package-relative barrels imports them as '
        'package: URIs, the first one primary [2026-11-07]', () {
      const module = ModuleConfig(
        name: 'all',
        barrelFiles: ['lib/url_builder.dart', 'lib/extra.dart'],
        outputPath: 'lib/src/bridges.b.dart',
      );
      expect(module.scriptImport('pkg'), 'package:pkg/url_builder.dart');
      expect(module.scriptImports('pkg'), [
        'package:pkg/url_builder.dart',
        'package:pkg/extra.dart',
      ]);
      // An explicit barrelImport is primary; a barrel naming the same file is
      // not listed twice.
      const withImport = ModuleConfig(
        name: 'all',
        barrelFiles: ['lib/url_builder.dart'],
        barrelImport: 'url_builder.dart',
        outputPath: 'lib/src/bridges.b.dart',
      );
      expect(withImport.scriptImports('pkg'), ['package:pkg/url_builder.dart']);
    });

    const config = BridgeConfig(
      name: 'pkg',
      modules: [
        ModuleConfig(
          name: 'all',
          barrelFiles: ['lib/url_builder.dart'],
          outputPath: 'lib/src/d4rt_bridges/all_bridges.b.dart',
        ),
      ],
    );

    test('GH1-3: the dartscript registers and imports the package: URI '
        '[2026-11-07]', () {
      final content = generateDartscriptFileContent(config);
      expect(content, contains("'package:pkg/url_builder.dart',"));
      expect(content, isNot(contains("'lib/url_builder.dart'")));
    });

    test('GH1-4: the test runner imports and registers the package: URI '
        '[2026-11-07]', () {
      final content = generateTestRunnerContent(config);
      expect(content, contains("import 'package:pkg/url_builder.dart';"));
      expect(content, contains("'package:pkg/url_builder.dart',"));
      expect(content, isNot(contains("'lib/url_builder.dart'")));
    });

    test('GH1-5: BridgeGenerator given a package-relative sourceImport emits '
        'getImportBlock() with the package: URI [2026-11-07]', () async {
      final fixtures = p.join(Directory.current.path, 'test', 'fixtures');
      final out = Directory.systemTemp.createTempSync('gh1_import_block_');
      addTearDown(() => out.deleteSync(recursive: true));
      final generator = BridgeGenerator(
        workspacePath: fixtures,
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
        sourceImport: 'lib/abstract_final_class_source.dart',
        packageName: 'pkg',
      );
      final result = await generator.generateBridges(
        sourceFiles: [p.join(fixtures, 'abstract_final_class_source.dart')],
        outputPath: p.join(out.path, 'bridges.dart'),
        moduleName: 'gh1',
      );
      expect(result.errors, isEmpty);
      final code = File(result.outputFiles.first).readAsStringSync();
      expect(
        code,
        contains(
          "return \"import 'package:pkg/abstract_final_class_source.dart';\";",
        ),
      );
      expect(code, isNot(contains('package:pkg/lib/')));
    });
  });
}
