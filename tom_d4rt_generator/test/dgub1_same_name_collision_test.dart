// DGUB1: within-package same-name class collisions must be surfaced, never
// silently dropped.
//
// The per-module bridge maps (bridgeClassThunks / bridgeClassTypes /
// classSourceUris) and the generated `_create<Name>Bridge` helper are all
// keyed by SIMPLE class name, so two public classes with the same simple name
// from different source libraries cannot both be emitted into one package
// bridge file. DGUB1 asked to harden against a *silent* last-wins drop.
//
// Investigation (dgub1) found this is ALREADY handled upstream of the
// per-module map emission by the GEN-045 name-collision guard
// (bridge_generator.dart ~2768): while building `bridgeableClasses` it detects
// a repeated simple class name, emits a `NAME COLLISION` warning naming both
// source URIs (first kept / second skipped) and skips the duplicate — a
// deterministic primary-import-wins + shadow policy. `_generateBridgeFile`
// therefore only ever receives the already-deduped list, so the map literals
// never carry duplicate keys. No new production code was needed for DGUB1.
//
// This test is a regression guard that pins the GEN-045 class-collision
// behaviour through the public `generateBridges` API: (1) the collision is
// reported as a warning naming the class, and (2) the winner is deterministic
// (the FIRST source file is kept).

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

void main() {
  late String tempSrcDir;
  late String tempOutputDir;
  late BridgeGeneratorResult result;
  late String fileA;
  late String fileB;

  setUpAll(() async {
    tempSrcDir = Directory.systemTemp
        .createTempSync('dgub1_same_name_collision_src_')
        .path;
    tempOutputDir = Directory.systemTemp
        .createTempSync('dgub1_same_name_collision_out_')
        .path;

    // Two source files, each declaring a public class with the SAME simple
    // name (`CollisionWidget`) but a different member — a legal within-package
    // same-name surface from two libraries.
    fileA = p.join(tempSrcDir, 'a.dart');
    fileB = p.join(tempSrcDir, 'b.dart');
    File(fileA).writeAsStringSync('''
/// First CollisionWidget (from a.dart).
class CollisionWidget {
  final String labelA;
  CollisionWidget(this.labelA);
}
''');
    File(fileB).writeAsStringSync('''
/// Second CollisionWidget (from b.dart).
class CollisionWidget {
  final int valueB;
  CollisionWidget(this.valueB);
}
''');

    final generator = BridgeGenerator(
      workspacePath: tempSrcDir,
      skipPrivate: true,
      helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
      sourceImport: null,
      packageName: null,
      verbose: false,
    );

    final outputFile = p.join(tempOutputDir, 'collision_test.dart');
    result = await generator.generateBridges(
      sourceFiles: [fileA, fileB],
      outputPath: outputFile,
      moduleName: 'dgub1_collision',
    );

    expect(result.errors, isEmpty, reason: 'Should generate without errors');
  });

  tearDownAll(() {
    try {
      Directory(tempSrcDir).deleteSync(recursive: true);
    } catch (_) {}
    try {
      Directory(tempOutputDir).deleteSync(recursive: true);
    } catch (_) {}
  });

  group('DGUB1 / GEN-045: within-package same-name class collision', () {
    test(
      'G-DGUB1-1: collision is surfaced as a NAME COLLISION warning (never '
      'silent) [2026-07-23] (PASS)',
      () {
        final collisionWarnings = result.warnings
            .where((w) => w.contains('NAME COLLISION'))
            .toList();
        expect(
          collisionWarnings,
          isNotEmpty,
          reason:
              'The generator must warn when two same-name classes from '
              'different source libraries collide, instead of silently '
              'dropping one. Warnings: ${result.warnings}',
        );
        expect(
          collisionWarnings.single,
          contains('CollisionWidget'),
          reason: 'The warning must name the colliding class.',
        );
      },
    );

    test(
      'G-DGUB1-2: the winner is deterministic — the FIRST source file is kept '
      '[2026-07-23] (PASS)',
      () {
        // generatedClassSources maps className -> kept sourceFile. GEN-045
        // keeps the first occurrence, so exactly one CollisionWidget survives
        // and it comes from a.dart (never the b.dart last-wins that a raw
        // map-literal duplicate would give).
        expect(
          result.generatedClassSources.containsKey('CollisionWidget'),
          isTrue,
          reason: 'The kept class must be recorded exactly once.',
        );
        expect(
          result.generatedClassSources['CollisionWidget'],
          equals(fileA),
          reason:
              'GEN-045 keeps the FIRST occurrence (a.dart); a silent '
              'last-wins would have recorded b.dart.',
        );
      },
    );
  });
}
