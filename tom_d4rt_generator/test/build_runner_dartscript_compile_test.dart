// GEN-BRC: build_runner path must produce a compiling dartscript.b.dart.
//
// Regression guard for the bug where the build_runner / orchestrator path
// emitted a `dartscript.b.dart` that could not compile, because:
//   1. the delegating barrel (`<Module>Bridge`) was missing the
//      `subPackageBarrels()` method the shared dartscript template calls, and
//   2. `relaxers.b.dart` (imported by the dartscript template whenever the
//      config has modules) was never generated on the build_runner path.
//
// This test assembles the three artifacts the build_runner path produces —
// the orchestrator delegating barrel, the shared dartscript template, and the
// relaxer stub — plus hand-written per-package bridge stand-ins, into a temp
// directory under the generator project root (so `package:tom_d4rt/...`
// resolves via the project package_config), then runs `dart analyze` and
// asserts the generated code has no compile errors.
//
// It also asserts the delegating barrel exposes the full API surface the
// shared dartscript template invokes (registerBridges / subPackageBarrels /
// getImportBlock) — i.e. the build_runner barrel honours the same contract as
// the standalone/CLI module bridge, so the two paths emit interchangeable
// registration code.

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/src/bridge_config.dart';
import 'package:tom_d4rt_generator/src/file_generators.dart';
import 'package:tom_d4rt_generator/src/file_writer.dart';
import 'package:tom_d4rt_generator/src/per_package_orchestrator.dart';
import 'package:tom_d4rt_generator/src/relaxer_generator.dart';

void main() {
  group('GEN-BRC: build_runner dartscript compiles', () {
    late Directory tempDir;

    setUp(() {
      final projectRoot = _findGeneratorProjectRoot();
      // Keep the fixture under .dart_tool so it is gitignored and never
      // committed, while still resolving the project's package_config.json
      // (which includes tom_d4rt) when `dart analyze` walks up to the root.
      final holder = Directory(p.join(projectRoot, '.dart_tool', 'gen_brc'));
      holder.createSync(recursive: true);
      tempDir = holder.createTempSync('compile_');
    });

    tearDown(() {
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    });

    test('G-BRC-01: orchestrator barrel + dartscript + relaxer stub compile '
        '[2026-06-10] (PASS)', () async {
      // --- Config mirrors a build_runner build with one module, two packages.
      // Flat (non-lib/) output paths keep all imports relative within tempDir.
      const config = BridgeConfig(
        name: 'gen_brc_fixture',
        modules: [
          ModuleConfig(
            name: 'all',
            barrelFiles: ['package:fixture_pkg_a/fixture_pkg_a.dart'],
            outputPath: 'all_bridges.b.dart',
            barrelImport: 'package:fixture_pkg_a/fixture_pkg_a.dart',
          ),
        ],
        dartscriptPath: 'dartscript.b.dart',
        relaxerOutputPath: 'relaxers.b.dart',
      );

      // --- 1) Orchestrator delegating barrel (the build_runner artifact).
      final orchestrator = PerPackageBridgeOrchestrator(
        config: config,
        projectRoot: tempDir.path,
        fileWriter: StandaloneFileWriter(tempDir.path),
        buildPackageName: 'gen_brc_fixture',
      );

      final mapping = BarrelPackageMapping(
        moduleName: 'all',
        barrelImport: 'package:fixture_pkg_a/fixture_pkg_a.dart',
        outputPath: 'all_bridges.b.dart',
        requiredPackages: {'fixture_pkg_a', 'fixture_pkg_b'},
      );
      final packageFiles = <String, String>{
        'fixture_pkg_a': 'package_fixture_pkg_a_bridges.b.dart',
        'fixture_pkg_b': 'package_fixture_pkg_b_bridges.b.dart',
      };

      final barrelContent =
          orchestrator.generateDelegatingBarrelContentForTest(
        mapping,
        packageFiles,
      );

      // --- 2) Shared dartscript template (identical for both code paths).
      final dartscriptContent = generateDartscriptFileContent(
        config,
        dartscriptPath: 'dartscript.b.dart',
        packageName: 'gen_brc_fixture',
      );

      // --- 3) Relaxer stub: empty extraction sites -> no-op stub that still
      //        defines registerRelaxers() / registerGenericConstructors().
      final relaxerResult = await generateRelaxers(
        config: config,
        projectPath: tempDir.path,
        globalClassLookup: const {},
      );
      expect(relaxerResult.isSuccess, isTrue,
          reason: 'relaxer stub generation should succeed');

      // --- 4) Per-package bridge stand-ins (what real per-package files expose).
      _writeFixture(tempDir, 'all_bridges.b.dart', barrelContent);
      _writeFixture(tempDir, 'dartscript.b.dart', dartscriptContent);
      _writeFixture(
        tempDir,
        'package_fixture_pkg_a_bridges.b.dart',
        _perPackageStandIn('PackageFixturePkgABridge'),
      );
      _writeFixture(
        tempDir,
        'package_fixture_pkg_b_bridges.b.dart',
        _perPackageStandIn('PackageFixturePkgBBridge'),
      );
      // relaxers.b.dart was written by generateRelaxers into tempDir.
      expect(
        File(p.join(tempDir.path, 'relaxers.b.dart')).existsSync(),
        isTrue,
        reason: 'relaxer stub must be emitted into the fixture dir',
      );

      // --- Contract assertions: barrel exposes everything the dartscript calls.
      expect(barrelContent, contains('static List<BridgedClass> bridgeClasses()'));
      expect(barrelContent, contains('static void registerBridges('));
      expect(barrelContent, contains('static String getImportBlock()'));
      expect(barrelContent, contains('static List<String> subPackageBarrels()'),
          reason: 'GEN-BRC: barrel MUST expose subPackageBarrels() — the '
              'dartscript template calls it unconditionally');
      // Primary package (fixture_pkg_a) excluded; sub-package included.
      expect(barrelContent,
          contains("'package:fixture_pkg_b/fixture_pkg_b.dart'"),
          reason: 'sub-package barrel URI must be listed');
      expect(barrelContent,
          isNot(contains("'package:fixture_pkg_a/fixture_pkg_a.dart',")),
          reason: 'primary package must not appear in subPackageBarrels()');

      // Dartscript must wire the relaxer + sub-package registration the build
      // would otherwise fail to compile against.
      expect(dartscriptContent, contains('.subPackageBarrels()'));
      expect(dartscriptContent, contains('registerGenericConstructors()'));
      expect(dartscriptContent, contains('registerRelaxers()'));

      // --- Compile check: dart analyze must report no errors.
      final result = Process.runSync(
        'dart',
        [
          'analyze',
          '--no-fatal-warnings',
          tempDir.path,
        ],
        workingDirectory: tempDir.path,
      );

      expect(
        result.exitCode,
        0,
        reason: 'Generated build_runner dartscript.b.dart did not compile.\n'
            'stdout:\n${result.stdout}\nstderr:\n${result.stderr}',
      );
    });
  });
}

/// Walks up from the current directory to find the tom_d4rt_generator root
/// (the directory whose pubspec.yaml declares `name: tom_d4rt_generator`).
String _findGeneratorProjectRoot() {
  var dir = Directory.current;
  while (true) {
    final pubspec = File(p.join(dir.path, 'pubspec.yaml'));
    if (pubspec.existsSync() &&
        pubspec.readAsStringSync().contains('name: tom_d4rt_generator')) {
      return dir.path;
    }
    final parent = dir.parent;
    if (parent.path == dir.path) {
      throw StateError(
        'Could not locate tom_d4rt_generator project root from '
        '${Directory.current.path}',
      );
    }
    dir = parent;
  }
}

void _writeFixture(Directory dir, String name, String content) {
  File(p.join(dir.path, name)).writeAsStringSync(content);
}

/// A minimal stand-in for a real per-package bridge file. It defines the exact
/// static API surface the delegating barrel delegates to, so the barrel (and
/// thus the dartscript that imports it) compiles.
String _perPackageStandIn(String className) {
  return '''
// ignore_for_file: unused_import
import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';

class $className {
  static List<BridgedClass> bridgeClasses() => const [];
  // Step #17 — lazy factory + native-type maps the aggregator delegates to.
  static Map<String, BridgedClass Function()> bridgeClassThunks() => const {};
  static Map<String, Type> bridgeClassTypes() => const {};
  static Map<String, String> classSourceUris() => const {};
  static List<BridgedEnumDefinition> bridgedEnums() => const [];
  static Map<String, NativeFunctionImpl> globalFunctions() => const {};
  static void registerBridges(D4rt interpreter, String importPath) {}
}
''';
}
