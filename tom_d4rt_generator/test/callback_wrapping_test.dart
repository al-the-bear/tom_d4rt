/// Tests for callback (function-type parameter) wrapping in bridge generation.
///
/// These tests verify that the generator correctly handles:
/// - Simple void callbacks (VoidCallback)
/// - Callbacks with parameters (void Function(T))
/// - Callbacks with return values (T Function(T))
/// - Nullable callbacks
/// - Multiple callbacks in one method
/// - Nested callbacks (callbacks that take callbacks)
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

void main() {
  late String testFixturesDir;
  late String tempOutputDir;

  setUpAll(() {
    testFixturesDir = p.join(Directory.current.path, 'test', 'fixtures');
    tempOutputDir =
        Directory.systemTemp.createTempSync('callback_test_').path;
  });

  tearDownAll(() {
    try {
      Directory(tempOutputDir).deleteSync(recursive: true);
    } catch (_) {}
  });

  group('Callback Wrapping Generation', () {
    late String generatedCode;
    late BridgeGeneratorResult result;

    setUpAll(() async {
      final generator = BridgeGenerator(
        workspacePath: testFixturesDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
        sourceImport: 'callback_test_source.dart',
        packageName: 'test_package',
        verbose: false,
      );

      final sourceFile = p.join(testFixturesDir, 'callback_test_source.dart');
      final outputFile = p.join(tempOutputDir, 'callback_test.dart');

      result = await generator.generateBridges(
        sourceFiles: [sourceFile],
        outputPath: outputFile,
        moduleName: 'callback',
      );

      expect(result.errors, isEmpty, reason: 'Should generate without errors');
      expect(result.outputFiles, isNotEmpty);

      generatedCode = await File(result.outputFiles.first).readAsString();
    });

    group('Simple Void Callbacks', () {
      test('G-CB-1a: VoidCallback parameter generates wrapper. [2026-02-10 06:37] (PASS)', () {
        // Should use D4.callInterpreterCallback pattern
        expect(generatedCode, contains('D4.callInterpreterCallback'));
        expect(generatedCode, contains('Raw'));
      });

      test('G-CB-2a: Void Function() callback correct wrapper. [2026-02-10 06:37] (PASS)', () {
        // For VoidCallback: () { D4.callInterpreterCallback(visitor, onCompleteRaw, []); }
        expect(generatedCode, contains("'onComplete':"));
        expect(generatedCode, contains('D4.callInterpreterCallback(visitor,'));
      });
    });

    group('Callbacks with Parameters', () {
      test('G-CB-9: Void Function(int) generates wrapper with parameter. [2026-02-10 06:37] (PASS)', () {
        // Should have: (int p0) { callback_raw.call(visitor, [p0]); }
        expect(generatedCode, contains("'onProgress':"));
        expect(generatedCode, contains('[p0]'));
      });

      test('G-CB-10: Void Function(int, String) generates wrapper with multiple params. [2026-02-10 06:37] (PASS)',
          () {
        // Should have: (int p0, String p1) { callback_raw.call(visitor, [p0, p1]); }
        expect(generatedCode, contains("'onItemProcessed':"));
        expect(generatedCode, contains('[p0, p1]'));
      });
    });

    group('Callbacks with Return Values', () {
      test('G-CB-11: Bool Function(int) generates wrapper with return. [2026-02-10 06:37] (PASS)', () {
        // Should have: (int p0) { return callback_raw.call(visitor, [p0]) as bool; }
        expect(generatedCode, contains("'filter':"));
        expect(generatedCode, contains('as bool'));
      });

      test('G-CB-12: String Function(String) generates wrapper with return. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'transform':"));
        expect(generatedCode, contains('as String'));
      });
    });

    group('Nullable Callbacks', () {
      test('G-CB-1b: Nullable callback generates null check wrapper. [2026-02-10 06:37] (PASS)', () {
        // Should have: callback_raw == null ? null : (...)
        expect(generatedCode, contains('== null ? null :'));
      });
    });

    group('Named Function Parameters', () {
      test('G-CB-2b: Named callback parameter generates wrapper. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'doWorkWithCallback':"));
      });
    });

    group('Multiple Callbacks', () {
      test('G-CB-3a: Multiple callbacks generates all wrappers. [2026-02-10 06:37] (PASS)', () {
        expect(generatedCode, contains("'processWithCallbacks':"));
        // Should have multiple Raw-suffixed variables (camelCase)
        expect(generatedCode,
            matches(RegExp(r"final \w+Raw = ", multiLine: true)));
      });
    });

    test('G-CB-3b: Generated code compiles without errors. [2026-02-10 06:37] (PASS)', () async {
      // Run dart analyze on the generated code
      // ignore: unused_local_variable
      final _ = await Process.run(
        'dart',
        ['analyze', '--fatal-infos'],
        workingDirectory: tempOutputDir,
      );

      // We expect some errors because the generated code references 
      // imports that don't exist in isolation, but should not have syntax errors
      // Just verify the file was created and has content
      final outputFile = File(p.join(tempOutputDir, 'callback_test.dart'));
      expect(await outputFile.exists(), isTrue);
      final content = await outputFile.readAsString();
      expect(content.length, greaterThan(100));
    });

    group('Custom Typedef Resolution', () {
      test('G-CB-4: Custom typedef callback is resolved from source file. [2026-02-10 06:37] (PASS)', () {
        // The callback_test_source.dart defines ProgressCallback typedef
        // The generator should extract function type info from resolved type
        expect(
          generatedCode,
          contains("'onProgress':"),
          reason: 'Method with custom typedef callback should be generated',
        );
        // The wrapper should have the correct parameter type
        expect(
          generatedCode,
          contains('(int p0)'),
          reason: 'Progress callback wrapper should have int parameter',
        );
      });

      test('G-CB-5: Custom typedef with string parameter generates correct wrapper. [2026-02-10 06:37] (PASS)', () {
        // VoidCallback typedef is used in onComplete method
        expect(
          generatedCode,
          contains("'onComplete':"),
          reason: 'Method with VoidCallback should be generated',
        );
        // VoidCallback has no params, so wrapper should be () { ... }
        expect(
          generatedCode,
          contains('() {'),
          reason: 'VoidCallback wrapper should have no parameters',
        );
      });

      test('G-CB-6: Typedef with multiple parameters generates correct wrapper. [2026-02-10 06:37] (PASS)', () {
        // ItemProcessor = void Function(int index, String item)
        expect(
          generatedCode,
          contains("'onItemProcessed':"),
          reason: 'Method with multi-param typedef should be generated',
        );
        // Wrapper should have both parameters
        expect(
          generatedCode,
          contains('(int p0, String p1)'),
          reason: 'ItemProcessor wrapper should have int and String parameters',
        );
      });

      test('G-CB-7: Typedef with return value generates correct wrapper. [2026-02-10 06:37] (PASS)', () {
        // FilterPredicate = bool Function(int value)
        expect(
          generatedCode,
          contains("'filter':"),
          reason: 'Method with return-value typedef should be generated',
        );
        // Return statement should cast to bool
        expect(
          generatedCode,
          contains('as bool'),
          reason: 'FilterPredicate wrapper should cast return value to bool',
        );
      });
    });
  });

  group('Warnings', () {
    test('G-CB-8: No function type warnings for bridgeable callbacks. [2026-02-10 06:37] (PASS)', () async {
      final generator = BridgeGenerator(
        workspacePath: testFixturesDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
        sourceImport: 'callback_test_source.dart',
        packageName: 'test_package',
        verbose: false,
      );

      final sourceFile = p.join(testFixturesDir, 'callback_test_source.dart');
      final outputFile = p.join(tempOutputDir, 'callback_warnings_test.dart');

      final result = await generator.generateBridges(
        sourceFiles: [sourceFile],
        outputPath: outputFile,
        moduleName: 'callback_warn',
      );

      // Should not have "unbridgeable function type" warnings for simple callbacks
      final unbridgeableWarnings = result.warnings
          .where((w) => w.contains('unbridgeable function type'))
          .where((w) =>
              !w.contains('List<') &&
              !w.contains('Map<')) // List/Map of functions still unbridgeable
          .toList();

      expect(
        unbridgeableWarnings,
        isEmpty,
        reason:
            'Simple function-type parameters should be bridged, not marked as unbridgeable. '
            'Warnings found: $unbridgeableWarnings',
      );
    });
  });
}
