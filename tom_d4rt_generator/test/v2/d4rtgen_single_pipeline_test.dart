// One generation pipeline: the `d4rtgen` CLI and the `generateBridges` library
// API must produce the same bridges from the same config.
//
// They used to be two independent orchestrations, each constructing its own
// `BridgeGenerator` and writing the barrel / dartscript / test runner /
// relaxer / proxy output itself. That matters because the freshness gate every
// consumer runs (`checkBridgeFreshness` → `generateBridges`) certifies
// committed bridges against the API pipeline, while `d4rtgen` regenerates them
// through the executor's. When the two disagree, a gate can fail on bridges
// d4rtgen just produced, or pass on bridges it would never produce.
//
// They had already drifted once (DGUB2: buildkit `recursiveBoundTypes:`
// reached the API but not the executor). The divergence D4G-PIPE-3 pins is the
// one that survived: the two computed `sourceImport` / `sourceImports`
// differently, so a module whose `barrelImport` names a different URI than its
// barrel got a different `getImportBlock()` from each.

// The equivalence test runs the real generator twice, so this file needs the
// tag that gives generation-bound tests a proportionate timeout (G-GENTAG-1).
@Tags(['generation'])
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_build_base/tom_build_base_v2.dart';
import 'package:tom_d4rt_generator/src/v2/d4rtgen_executor.dart';
import 'package:tom_d4rt_generator/src/v2/d4rtgen_tool.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

/// A resolvable package whose module declares a `barrelImport` that is a
/// DIFFERENT URI from its barrel. That is the shape the two pipelines
/// disagreed about; every module in the workspace today happens to set the two
/// to the same URI, which is why the drift stayed invisible.
void _writePackage(Directory root) {
  String at(String rel) => p.join(root.path, rel);
  File(at('pubspec.yaml'))
    ..createSync(recursive: true)
    ..writeAsStringSync(
      "name: pipefix\nenvironment:\n  sdk: '>=3.0.0 <4.0.0'\n",
    );
  File(at('.dart_tool/package_config.json'))
    ..createSync(recursive: true)
    ..writeAsStringSync(
      '{"configVersion": 2, "packages": [{"name": "pipefix", '
      '"rootUri": "../", "packageUri": "lib/", "languageVersion": "3.0"}]}',
    );
  File(at('lib/pipefix.dart'))
    ..createSync(recursive: true)
    ..writeAsStringSync("export 'src/greeter.dart';\n");
  File(at('lib/facade.dart'))
    ..createSync(recursive: true)
    ..writeAsStringSync("export 'src/greeter.dart';\n");
  File(at('lib/src/greeter.dart'))
    ..createSync(recursive: true)
    ..writeAsStringSync(
      'class Greeter {\n'
      '  Greeter(this.name);\n'
      '  final String name;\n'
      "  String greet() => 'Hello, \$name';\n"
      '}\n',
    );
  File(at('buildkit.yaml')).writeAsStringSync(
    'd4rtgen:\n'
    '  name: pipefix\n'
    '  modules:\n'
    '    - name: pipefix\n'
    '      barrelFiles:\n'
    '        - package:pipefix/pipefix.dart\n'
    '      barrelImport: package:pipefix/facade.dart\n'
    '      outputPath: lib/src/d4rt_bridges/pipefix_bridges.b.dart\n'
    '  generateBarrel: true\n'
    '  barrelPath: lib/d4rt_bridges.b.dart\n',
  );
}

/// Every generated file's relative path and contents, with the `// Generated:`
/// attribution line dropped.
///
/// That line carries a wall-clock timestamp, so two runs of the SAME pipeline
/// differ in it. `checkBridgeFreshness` ignores it for the same reason; a
/// comparison that kept it would fail for a reason that has nothing to do with
/// which pipeline produced the file.
Map<String, String> _generated(Directory root) {
  final out = <String, String>{};
  for (final e in root.listSync(recursive: true).whereType<File>()) {
    final rel = p.relative(e.path, from: root.path);
    if (p.split(rel).contains('.dart_tool')) continue;
    if (!rel.endsWith('.b.dart')) continue;
    out[rel] = e
        .readAsStringSync()
        .split('\n')
        .where((line) => !line.startsWith('// Generated:'))
        .join('\n');
  }
  return out;
}

void main() {
  late Directory work;

  setUp(() {
    work = Directory(
      p.join(
        Directory.current.path,
        '.dart_tool',
        'sce28_pipeline',
        '${pid}_${DateTime.now().microsecondsSinceEpoch}',
      ),
    )..createSync(recursive: true);
  });

  tearDown(() {
    if (work.existsSync()) work.deleteSync(recursive: true);
  });

  group('one pipeline', () {
    test('D4G-PIPE-1: the executor builds no BridgeGenerator of its own '
        '[2026-09-18]', () {
      final executor = File('lib/src/v2/d4rtgen_executor.dart');
      expect(
        executor.existsSync(),
        isTrue,
        reason: 'the guard is pointless if the file moved',
      );
      final source = executor.readAsStringSync();

      // Anti-vacuity: the same pattern must match the pipeline that IS
      // allowed to construct one, or the assertion below proves nothing.
      expect(
        File('lib/src/bridge_api.dart').readAsStringSync(),
        contains('BridgeGenerator('),
        reason: 'the pattern must be able to match at all',
      );

      expect(
        source,
        isNot(contains('BridgeGenerator(')),
        reason:
            'the CLI must route through generateBridges, not orchestrate a '
            'second pipeline that can drift from the one the freshness gate '
            'certifies against',
      );
    });

    test('D4G-PIPE-2: the executor keeps no private copy of the file-writing '
        'stages [2026-09-18]', () {
      final source = File(
        'lib/src/v2/d4rtgen_executor.dart',
      ).readAsStringSync();
      for (final helper in [
        '_generateBarrelFile',
        '_generateDartscriptFile',
        '_generateTestRunnerFile',
      ]) {
        expect(
          source,
          isNot(contains('Future<void> $helper(')),
          reason: '$helper is generateBridges\' job',
        );
      }
    });

    test(
      'D4G-PIPE-3: the CLI and the API generate identical bridges when '
      'barrelImport names a different URI than the barrel [2026-09-18]',
      () async {
        Future<Map<String, String>> generatedBy(
          Future<void> Function(Directory) run,
        ) async {
          final dir = Directory(p.join(work.path, 'pkg'));
          if (dir.existsSync()) dir.deleteSync(recursive: true);
          dir.createSync(recursive: true);
          _writePackage(dir);
          await run(dir);
          return _generated(dir);
        }

        final viaApi = await generatedBy(
          (d) async => generateBridges(
            configPath: p.join(d.path, 'buildkit.yaml'),
            projectPath: d.path,
          ),
        );
        final viaCli = await generatedBy(
          (d) async => ToolRunner(
            tool: d4rtgenTool,
            executors: createD4rtgenExecutors(),
          ).run(['--scan', d.path, '--not-recursive']),
        );

        expect(
          viaApi,
          isNotEmpty,
          reason: 'a comparison of two empty runs proves nothing',
        );
        expect(viaCli.keys.toList()..sort(), viaApi.keys.toList()..sort());
        for (final path in viaApi.keys) {
          expect(
            viaCli[path],
            viaApi[path],
            reason: 'the two pipelines disagree about $path',
          );
        }
      },
      timeout: const Timeout(Duration(minutes: 4)),
    );

    test('D4G-PIPE-4: generateBridges only runs `dart pub get` when asked '
        '[2026-09-18]', () async {
      // An unresolved package: no .dart_tool/package_config.json.
      final dir = Directory(p.join(work.path, 'unresolved'))
        ..createSync(recursive: true);
      _writePackage(dir);
      Directory(p.join(dir.path, '.dart_tool')).deleteSync(recursive: true);

      final result = await generateBridges(
        configPath: p.join(dir.path, 'buildkit.yaml'),
        projectPath: dir.path,
        runPubGet: false,
      );

      // `dart pub get` would have created the package config. It must not
      // have run: a dry run that resolves the package has written to it.
      expect(
        File(
          p.join(dir.path, '.dart_tool', 'package_config.json'),
        ).existsSync(),
        isFalse,
        reason: 'runPubGet: false must not spawn pub get',
      );
      expect(result, isNotNull);
    }, timeout: const Timeout(Duration(minutes: 4)));
  });
}
