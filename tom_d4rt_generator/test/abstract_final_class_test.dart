/// Tests for Dart 3 class modifiers (abstract final, final, interface, base).
///
/// These tests verify the generator correctly handles:
/// - abstract final class (like Flutter's Curves) - cannot be instantiated or extended
/// - final class - can be instantiated but not extended
/// - interface class - can only be implemented
/// - base class - can only be extended in same library
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

void main() {
  late String testFixturesDir;
  late String tempOutputDir;

  setUpAll(() {
    testFixturesDir = p.join(Directory.current.path, 'test', 'fixtures');
    tempOutputDir = Directory.systemTemp
        .createTempSync('abstract_final_class_')
        .path;
  });

  tearDownAll(() {
    try {
      Directory(tempOutputDir).deleteSync(recursive: true);
    } catch (_) {}
  });

  group('Dart 3 Class Modifiers', () {
    late BridgeGenerator generator;
    late String generatedCode;
    late BridgeGeneratorResult result;

    setUpAll(() async {
      generator = BridgeGenerator(
        workspacePath: testFixturesDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
        sourceImport: 'abstract_final_class_source.dart',
        packageName: 'test_class_modifiers',
        verbose: false,
      );

      final sourceFile = p.join(
        testFixturesDir,
        'abstract_final_class_source.dart',
      );
      final outputFile = p.join(
        tempOutputDir,
        'abstract_final_class_bridges.dart',
      );

      result = await generator.generateBridges(
        sourceFiles: [sourceFile],
        outputPath: outputFile,
        moduleName: 'class_modifiers',
      );

      expect(result.errors, isEmpty, reason: 'Should generate without errors');
      expect(result.outputFiles, isNotEmpty);

      generatedCode = await File(result.outputFiles.first).readAsString();

      // Debug: Save to workspace for inspection
      final debugPath = p.join(
        Platform.environment['HOME']!,
        'repos/al_the_bear/inhouse/second_wind/'
        'enterprise_flutter/tom_agent_container/ztmp/abstract_final_bridges.dart',
      );
      await File(debugPath).create(recursive: true);
      await File(debugPath).writeAsString(generatedCode);
    });

    // =========================================================================
    // Abstract Final Class Tests (Curves pattern)
    // =========================================================================
    group('Abstract Final Class (Curves pattern)', () {
      test('G-AFC-01: Curve base class is bridged. [2026-03-01] (PASS)', () {
        expect(generatedCode, contains("name: 'Curve'"));
      });

      test(
        'G-AFC-02: abstract final Curves class is bridged. [2026-03-01] (FAIL)',
        () {
          // Abstract final classes with static members should be bridged
          expect(generatedCode, contains("name: 'Curves'"));
        },
      );

      test(
        'G-AFC-03: Curves.linear static const is accessible. [2026-03-01] (FAIL)',
        () {
          // Static const members should be bridged as getters
          expect(
            generatedCode,
            anyOf(contains("'linear'"), contains('Curves.linear')),
          );
        },
      );

      test(
        'G-AFC-04: Curves.byName static method is accessible. [2026-03-01] (FAIL)',
        () {
          expect(
            generatedCode,
            anyOf(contains("'byName'"), contains('Curves.byName')),
          );
        },
      );

      test(
        'G-AFC-05: Curves has no constructors bridged (cannot be instantiated). [2026-03-01] (FAIL)',
        () {
          // Abstract final classes should have no bridged constructors
          // but should still exist as a class
          expect(generatedCode, contains("name: 'Curves'"));
          // The constructors map should be empty
          final curvesMatch = RegExp(
            r"BridgedClass _createCurvesBridge\(\) \{[\s\S]*?return BridgedClass\([\s\S]*?constructors: \{[\s\S]*?\}",
          ).firstMatch(generatedCode);
          if (curvesMatch != null) {
            final ctorSection = curvesMatch.group(0)!;
            // Should only have 'constructors: {' followed by '},' (empty)
            expect(
              ctorSection,
              matches(RegExp(r"constructors: \{\s*\}")),
              reason: 'Curves should have empty constructors map',
            );
          }
        },
      );
    });

    // =========================================================================
    // Final Class Tests
    // =========================================================================
    group('Final Class', () {
      test('G-AFC-10: FinalPoint class is bridged. [2026-03-01] (PASS)', () {
        expect(generatedCode, contains("name: 'FinalPoint'"));
      });

      test(
        'G-AFC-11: FinalPoint constructor is bridged. [2026-03-01] (PASS)',
        () {
          expect(generatedCode, contains("'': (visitor, positional, named)"));
        },
      );

      test(
        'G-AFC-12: FinalPoint.origin static const is accessible. [2026-03-01] (PASS)',
        () {
          expect(
            generatedCode,
            anyOf(contains("'origin'"), contains('FinalPoint.origin')),
          );
        },
      );

      test(
        'G-AFC-13: FinalPoint.distanceTo method is accessible. [2026-03-01] (PASS)',
        () {
          expect(generatedCode, contains("'distanceTo'"));
        },
      );
    });

    // =========================================================================
    // Interface Class Tests
    // =========================================================================
    group('Interface Class', () {
      test('G-AFC-20: Drawable interface is bridged. [2026-03-01] (PASS)', () {
        expect(generatedCode, contains("name: 'Drawable'"));
      });

      test('G-AFC-21: Circle class is bridged. [2026-03-01] (PASS)', () {
        expect(generatedCode, contains("name: 'Circle'"));
      });

      test(
        'G-AFC-22: Circle.draw method is accessible. [2026-03-01] (PASS)',
        () {
          expect(generatedCode, contains("'draw'"));
        },
      );
    });

    // =========================================================================
    // Base Class Tests
    // =========================================================================
    group('Base Class', () {
      test('G-AFC-30: BaseWidget class is bridged. [2026-03-01] (PASS)', () {
        expect(generatedCode, contains("name: 'BaseWidget'"));
      });

      test(
        'G-AFC-31: BaseWidget.build method is accessible. [2026-03-01] (PASS)',
        () {
          expect(generatedCode, contains("'build'"));
        },
      );
    });

    // =========================================================================
    // Mixin Class Tests
    // =========================================================================
    group('Mixin Class', () {
      test('G-AFC-40: Loggable mixin is bridged. [2026-03-01] (PASS)', () {
        expect(generatedCode, contains("name: 'Loggable'"));
      });

      test(
        'G-AFC-41: Loggable.log method is accessible. [2026-03-01] (PASS)',
        () {
          expect(generatedCode, contains("'log'"));
        },
      );
    });
  });
}
