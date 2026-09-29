// SCE231: the generator's name dedup must be OBSERVABLE on the path the
// Flutter twins actually use.
//
// SCD195 asked whether the generator should REFUSE a colliding bridged name at
// build time. Decided on the measurement: not until something is red. The
// runtime guard (`scd195_registry_collision_test.dart` in both twins) is green
// over the live registry and covers a strictly larger surface — user bridges
// and the stdlib as well as generated output — and a refusal with nothing to
// refuse is untested by construction. What the decision lacked was evidence
// from the generator's side, so this pins that the generator reports it.
//
// WHERE THE DEDUP ACTUALLY HAPPENS. SCD195 named `PerPackageBridgeOrchestrator`;
// the twins' `tool/regenerate_bridges.dart` calls `generateBridges`
// (`bridge_api.dart`), which never constructs one. On that path:
//
//   * WITHIN a module, GEN-045 keeps the first of two same-name classes and
//     emits `NAME COLLISION` (pinned for the single-module API by DGUB1).
//   * ACROSS modules, GEN-076 skips a class whose name AND source file match
//     one an earlier module generated — a re-export — and keeps a same-name
//     class from a DIFFERENT source in both modules.
//
// THE FINDING: `generateBridges` dropped every per-module warning — GEN-045's
// `NAME COLLISION` included. It was neither returned nor printed, so on the
// path that regenerates the Flutter corpus a within-module collision was
// silent, and the two cross-module cases were counted nowhere.
//
// The orchestrator (build_runner path) reports the same two numbers from
// `buildGlobalClassLookup`; that path has no fixture-level test here because
// it needs a build_runner harness, and its counts are computed by the same
// few lines read above.

@Tags(['generation'])
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';
import 'package:tom_d4rt_generator/src/build_config_loader.dart';

Directory _fixture() {
  final dir = Directory.systemTemp.createTempSync('sce231_');
  File(p.join(dir.path, 'pubspec.yaml')).writeAsStringSync(
    'name: zom_sce231\nenvironment:\n  sdk: ">=3.0.0 <4.0.0"\n',
  );
  File(
    p.join(dir.path, 'pubspec.lock'),
  ).writeAsStringSync('packages: {}\nsdks:\n  dart: ">=3.0.0 <4.0.0"\n');
  Directory(p.join(dir.path, '.dart_tool')).createSync(recursive: true);
  File(
    p.join(dir.path, '.dart_tool', 'package_config.json'),
  ).writeAsStringSync('{"configVersion":2,"packages":[]}');

  void lib(String name, String content) {
    final f = File(p.join(dir.path, 'lib', name));
    f.parent.createSync(recursive: true);
    f.writeAsStringSync(content);
  }

  // Two distinct classes sharing a simple name, a third in module two, and one
  // class both barrels export.
  lib('a.dart', 'class Dup { final int a = 1; }\n');
  lib('b.dart', 'class Dup { final String b = "b"; }\n');
  lib('c.dart', 'class Dup { final bool c = true; }\n');
  lib('shared.dart', 'class Shared {}\n');
  lib(
    'one.dart',
    "export 'a.dart';\nexport 'b.dart';\nexport 'shared.dart';\n",
  );
  lib('two.dart', "export 'c.dart';\nexport 'shared.dart';\n");

  File(p.join(dir.path, 'buildkit.yaml')).writeAsStringSync('''
d4rtgen:
  name: zom_sce231
  generateBarrel: false
  generateDartscript: false
  modules:
    - name: one
      barrelFiles:
        - lib/one.dart
      outputPath: lib/src/d4rt_bridges/one_bridges.b.dart
    - name: two
      barrelFiles:
        - lib/two.dart
      outputPath: lib/src/d4rt_bridges/two_bridges.b.dart
''');
  return dir;
}

void main() {
  late Directory project;
  late GenerationResult result;

  setUpAll(() async {
    project = _fixture();
    final config = BuildConfigLoader.loadFromTomBuildYaml(project.path)!;
    result = await generateBridges(
      config: config,
      projectPath: project.path,
      runPubGet: false,
    );
  });

  tearDownAll(() {
    try {
      project.deleteSync(recursive: true);
    } catch (_) {}
  });

  group('SCE231: generateBridges reports what its name dedup did', () {
    test('F-SCE231-0 (control): the fixture generated [2026-09-29] (PASS)', () {
      expect(result.errors, isEmpty);
      expect(result.totalModules, 2);
    });

    test('F-SCE231-1: a within-module NAME COLLISION reaches the result '
        '[2026-09-29] (PASS)', () {
      final collisions = result.warnings
          .where((w) => w.contains('NAME COLLISION'))
          .toList();
      expect(
        collisions,
        hasLength(1),
        reason:
            'GEN-045 found `Dup` twice in module one and kept the first; '
            'generateBridges must carry that warning out instead of dropping '
            'it with the module result. Warnings: ${result.warnings}',
      );
      expect(collisions.single, contains('Dup'));
    });

    test('F-SCE231-2: the dedup report counts both cross-module cases, and '
        'is not a warning [2026-09-29] (PASS)', () {
      expect(
        result.warnings.where((w) => w.startsWith('Dedup:')),
        isEmpty,
        reason:
            'GenerationResult.warnings is for configuration notes and is empty '
            'for a clean config (D4G-OPT-2); the dedup counts are on '
            'GenerationResult.dedup',
      );
    });

    test('F-SCE231-3: the dedup report counts both cross-module cases '
        '[2026-09-29] (PASS)', () {
      final dedup = result.dedup;
      expect(
        dedup,
        isNotNull,
        reason: 'every run that reached a module has one',
      );
      expect(dedup!.crossModuleReExports, 1);
      expect(dedup.crossModuleSameName.keys, ['Dup']);
      expect(dedup.crossModuleSameName['Dup'], hasLength(2));
      expect(
        dedup.summary,
        allOf(
          contains('1 class(es) skipped as cross-module re-exports'),
          contains('1 class name(s) generated from different source files'),
          contains('Dup'),
        ),
        reason:
            '`Shared` is one class exported by both barrels (a re-export); '
            '`Dup` from c.dart is a DIFFERENT class under a name module one '
            'already generated, kept in both.',
      );
    });
  });
}
