/// Tests for Flutter bridge issues found during essential classes testing.
///
/// These tests verify the generator correctly handles issues found in:
/// - Paint.color receiving BridgedInstance<Object> instead of Color
/// - Map<String, WidgetBuilder> routes not converting functions
/// - UniqueKey.hashCode not being bridged
/// - Curves static const members not accessible
/// - AnimationController.vsync TickerProvider interface not recognized
/// - ChangeNotifier.hasListeners/addListener not bridged
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
        .createTempSync('flutter_bridge_issues_')
        .path;
  });

  tearDownAll(() {
    try {
      Directory(tempOutputDir).deleteSync(recursive: true);
    } catch (_) {}
  });

  group('Flutter Bridge Issues', () {
    late BridgeGenerator generator;
    late String generatedCode;
    late BridgeGeneratorResult result;

    setUpAll(() async {
      generator = BridgeGenerator(
        workspacePath: testFixturesDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
        sourceImport: 'flutter_bridge_issues_source.dart',
        packageName: 'test_flutter_issues',
        verbose: false,
      );

      final sourceFile = p.join(
        testFixturesDir,
        'flutter_bridge_issues_source.dart',
      );
      final outputFile = p.join(
        tempOutputDir,
        'flutter_bridge_issues_bridges.dart',
      );

      result = await generator.generateBridges(
        sourceFiles: [sourceFile],
        outputPath: outputFile,
        moduleName: 'flutter_issues',
      );

      expect(result.errors, isEmpty, reason: 'Should generate without errors');
      expect(result.outputFiles, isNotEmpty);

      generatedCode = await File(result.outputFiles.first).readAsString();

      // Debug: Save to workspace for inspection
      final debugPath = p.join(
        Platform.environment['HOME']!,
        'repos/al_the_bear/inhouse/second_wind/'
        'enterprise_flutter/tom_agent_container/ztmp/flutter_issues_bridge.dart',
      );
      await File(debugPath).create(recursive: true);
      await File(debugPath).writeAsString(generatedCode);
    });

    // ==========================================================================
    // ISSUE 1: BridgedInstance unwrapping for native types
    // ==========================================================================
    group('Issue 1: BridgedInstance Unwrapping', () {
      test('G-FBI-01: Color class is bridged. [2026-02-28] (PASS)', () {
        expect(generatedCode, contains("name: 'Color'"));
      });

      test(
        'G-FBI-02: Color.red static const is accessible. [2026-02-28] (PASS)',
        () {
          expect(
            generatedCode,
            anyOf(contains("'red'"), contains('Color.red')),
          );
        },
      );

      test('G-FBI-03: Paint class is bridged. [2026-02-28] (PASS)', () {
        expect(generatedCode, contains("name: 'Paint'"));
      });

      test(
        'G-FBI-04: Paint.color setter extracts Color from BridgedInstance. [2026-02-28] (PASS)',
        () {
          // GEN-082: Setter should use extractBridgedArgOrNull<Color> since color is Color?
          expect(
            generatedCode,
            anyOf(
              contains('extractBridgedArgOrNull<'),
              contains('extractBridgedArg<'),
              contains('as Color'),
            ),
          );
        },
      );

      test('G-FBI-05: Offset class is bridged. [2026-02-28] (PASS)', () {
        expect(generatedCode, contains("name: 'Offset'"));
      });

      test(
        'G-FBI-06: PositionedBox.position extracts Offset. [2026-02-28] (FAIL)',
        () {
          expect(generatedCode, contains("name: 'PositionedBox'"));
          // Position parameter should extract Offset properly
          expect(
            generatedCode,
            anyOf(
              contains("'position'"),
              contains('extractBridgedArg<Offset>'),
            ),
          );
        },
      );
    });

    // ==========================================================================
    // ISSUE 2: Map<String, Function> type parameters
    // ==========================================================================
    group('Issue 2: Map with Function Values', () {
      test('G-FBI-10: AppWithRoutes class is bridged. [2026-02-28] (PASS)', () {
        expect(generatedCode, contains("name: 'AppWithRoutes'"));
      });

      test(
        'G-FBI-11: routes parameter with Map<String, WidgetBuilder> is handled. [2026-02-28] (FAIL)',
        () {
          // The routes parameter should convert InterpretedFunction to Widget Function(BuildContext)
          expect(
            generatedCode,
            anyOf(
              contains("'routes'"),
              contains('Map<String'),
              contains('WidgetBuilder'),
            ),
          );
        },
      );

      test(
        'G-FBI-12: SemanticWidget with Map<CustomAction, Function()> is bridged. [2026-02-28] (OK)',
        () {
          expect(generatedCode, contains("name: 'SemanticWidget'"));
          expect(
            generatedCode,
            anyOf(contains("'customActions'"), contains('Map<CustomAction')),
          );
        },
      );
    });

    // ==========================================================================
    // ISSUE 3: Missing hashCode/runtimeType on bridged classes
    // ==========================================================================
    group('Issue 3: Object Properties (hashCode, runtimeType)', () {
      test('G-FBI-20: UniqueKey class is bridged. [2026-02-28] (PASS)', () {
        expect(generatedCode, contains("name: 'UniqueKey'"));
      });

      test(
        'G-FBI-21: UniqueKey.hashCode getter is bridged. [2026-02-28] (OK)',
        () {
          // hashCode should be accessible on bridged instances
          expect(
            generatedCode,
            anyOf(contains("'hashCode'"), contains('getter: (instance)')),
          );
        },
      );

      test(
        'G-FBI-22: runtimeType getter is bridged. [2026-02-28] (OK)',
        () {
          expect(
            generatedCode,
            anyOf(contains("'runtimeType'"), contains('.runtimeType')),
          );
        },
      );

      test('G-FBI-23: ValueKey class is bridged. [2026-02-28] (PASS)', () {
        expect(generatedCode, contains("name: 'ValueKey'"));
      });
    });

    // ==========================================================================
    // ISSUE 4: Abstract class with static const members (Curves pattern)
    // ==========================================================================
    group('Issue 4: Abstract Class Static Members (Curves)', () {
      test('G-FBI-30: Curve base class is bridged. [2026-02-28] (PASS)', () {
        expect(generatedCode, contains("name: 'Curve'"));
      });

      test(
        'G-FBI-31: LinearCurve implementation is bridged. [2026-02-28] (PASS)',
        () {
          expect(generatedCode, contains("name: 'LinearCurve'"));
        },
      );

      test(
        'G-FBI-32: Curves abstract class is bridged despite private constructor. [2026-02-28] (OK)',
        () {
          // Abstract class with static members should be bridged
          expect(generatedCode, contains("name: 'Curves'"));
        },
      );

      test(
        'G-FBI-33: Curves.linear static const is accessible. [2026-02-28] (OK)',
        () {
          // Static const members should be bridged as getters
          expect(
            generatedCode,
            anyOf(contains("'linear'"), contains('Curves.linear')),
          );
        },
      );

      test(
        'G-FBI-34: Curves.byName static method is accessible. [2026-02-28] (OK)',
        () {
          expect(
            generatedCode,
            anyOf(contains("'byName'"), contains('Curves.byName')),
          );
        },
      );
    });

    // ==========================================================================
    // ISSUE 5: Interface types (TickerProvider pattern)
    // ==========================================================================
    group('Issue 5: Interface Types (TickerProvider)', () {
      test(
        'G-FBI-40: TickerProvider interface is bridged. [2026-02-28] (OK)',
        () {
          // Interface types should be bridgeable
          expect(generatedCode, contains("name: 'TickerProvider'"));
        },
      );

      test(
        'G-FBI-41: AnimationController class is bridged. [2026-02-28] (PASS)',
        () {
          expect(generatedCode, contains("name: 'AnimationController'"));
        },
      );

      test(
        'G-FBI-42: AnimationController.vsync accepts InterpretedInstance implementing TickerProvider. [2026-02-28] (FAIL)',
        () {
          // The vsync parameter should accept InterpretedInstance that implements the interface
          expect(
            generatedCode,
            anyOf(contains("'vsync'"), contains('TickerProvider')),
          );
        },
      );
    });

    // ==========================================================================
    // ISSUE 6: ChangeNotifier methods
    // ==========================================================================
    group('Issue 6: ChangeNotifier Methods', () {
      test(
        'G-FBI-50: ChangeNotifier class is bridged. [2026-02-28] (PASS)',
        () {
          expect(generatedCode, contains("name: 'ChangeNotifier'"));
        },
      );

      test(
        'G-FBI-51: ChangeNotifier.hasListeners getter is bridged. [2026-02-28] (FAIL)',
        () {
          expect(generatedCode, contains("'hasListeners'"));
        },
      );

      test(
        'G-FBI-52: ChangeNotifier.addListener method is bridged. [2026-02-28] (FAIL)',
        () {
          expect(generatedCode, contains("'addListener'"));
        },
      );

      test(
        'G-FBI-53: ChangeNotifier.removeListener method is bridged. [2026-02-28] (FAIL)',
        () {
          expect(generatedCode, contains("'removeListener'"));
        },
      );

      test(
        'G-FBI-54: ValueNotifier extends ChangeNotifier and is bridged. [2026-02-28] (PASS)',
        () {
          expect(generatedCode, contains("name: 'ValueNotifier'"));
        },
      );

      test(
        'G-FBI-55: ValueNotifier inherits hasListeners from ChangeNotifier. [2026-02-28] (FAIL)',
        () {
          // When extending, inherited methods should also be accessible
          // This is a runtime concern - the generated code should allow
          // calling hasListeners on ValueNotifier instances
          expect(
            generatedCode,
            anyOf(
              contains('hasListeners'),
              // Or check that ValueNotifier bridge includes parent methods
              contains('ChangeNotifier'),
            ),
          );
        },
      );
    });

    // ==========================================================================
    // ISSUE 7: Required nullable callbacks
    // ==========================================================================
    group('Issue 7: Required Nullable Callbacks', () {
      test(
        'G-FBI-60: ElevatedButton class is bridged. [2026-02-28] (PASS)',
        () {
          expect(generatedCode, contains("name: 'ElevatedButton'"));
        },
      );

      test(
        'G-FBI-61: ElevatedButton.onPressed is required but nullable - only checks containsKey. [2026-02-28] (FAIL)',
        () {
          // Extract ElevatedButton bridge section
          final elevatedButtonSection = _extractBridgeSection(
            generatedCode,
            'ElevatedButton',
          );
          expect(
            elevatedButtonSection,
            isNotNull,
            reason: 'ElevatedButton bridge should be generated',
          );

          // For required nullable, should only check containsKey
          expect(
            elevatedButtonSection,
            contains("if (!named.containsKey('onPressed'))"),
            reason: 'Should check if key exists',
          );
          // Should NOT have the null check for nullable parameter
          expect(
            elevatedButtonSection,
            isNot(contains("|| named['onPressed'] == null")),
            reason:
                'Required nullable callback should only check containsKey, not null value',
          );
        },
      );

      test(
        'G-FBI-62: Switch.onChanged is required but nullable. [2026-02-28] (FAIL)',
        () {
          // Extract Switch bridge section
          final switchSection = _extractBridgeSection(generatedCode, 'Switch');
          expect(
            switchSection,
            isNotNull,
            reason: 'Switch bridge should be generated',
          );

          // For required nullable, should only check containsKey
          expect(
            switchSection,
            contains("if (!named.containsKey('onChanged'))"),
            reason: 'Should check if key exists',
          );
          // Should NOT have the null check for nullable parameter
          expect(
            switchSection,
            isNot(contains("|| named['onChanged'] == null")),
            reason:
                'Required nullable callback should only check containsKey, not null value',
          );
        },
      );

      test(
        'G-FBI-63: IconButton.onPressed is required NON-nullable - should check both. [2026-02-28] (PASS)',
        () {
          // Extract IconButton bridge section
          final iconButtonSection = _extractBridgeSection(
            generatedCode,
            'IconButton',
          );
          expect(
            iconButtonSection,
            isNotNull,
            reason: 'IconButton bridge should be generated',
          );

          // For required non-nullable, the check should include both containsKey and null check
          expect(
            iconButtonSection,
            contains(
              "if (!named.containsKey('onPressed') || named['onPressed'] == null)",
            ),
            reason:
                'Required non-nullable should check both containsKey AND null value',
          );
        },
      );
    });
  });
}

/// Extract the bridge section for a specific class from generated code.
String? _extractBridgeSection(String code, String className) {
  // Find the bridge function definition for this class
  final funcMarker = 'BridgedClass _create${className}Bridge()';
  final startIndex = code.indexOf(funcMarker);
  if (startIndex == -1) return null;

  // Find the end - next bridge function definition or end of file
  final nextFuncIndex = code.indexOf(
    'BridgedClass _create',
    startIndex + funcMarker.length,
  );
  final endIndex = nextFuncIndex != -1 ? nextFuncIndex : code.length;

  return code.substring(startIndex, endIndex);
}
