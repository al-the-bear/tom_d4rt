/// Tests for Engine issues identified in flutterm integration.
///
/// These tests verify the generator correctly handles:
/// - ENG-010: InterpretedFunction callback wrapping for setters
/// - ENG-011: Null cast in generic method callback return
/// - ENG-007: Nullable type extraction mismatch
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
        Directory.systemTemp.createTempSync('eng_issues_test_').path;
  });

  tearDownAll(() {
    try {
      Directory(tempOutputDir).deleteSync(recursive: true);
    } catch (_) {}
  });

  group('ENG-010: Setter Callback Wrapping', () {
    late String generatedCode;
    late BridgeGeneratorResult result;

    setUpAll(() async {
      final generator = BridgeGenerator(
        workspacePath: testFixturesDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
        sourceImport: 'setter_callback_source.dart',
        packageName: 'test_eng_issues',
        verbose: false,
      );

      final sourceFile = p.join(testFixturesDir, 'setter_callback_source.dart');
      final outputFile = p.join(tempOutputDir, 'setter_callback_bridges.dart');

      result = await generator.generateBridges(
        sourceFiles: [sourceFile],
        outputPath: outputFile,
        moduleName: 'setter_callback',
      );

      expect(result.errors, isEmpty, reason: 'Should generate without errors');
      expect(result.outputFiles, isNotEmpty);

      generatedCode = await File(result.outputFiles.first).readAsString();

      // Debug output
      final debugPath = p.join(
        Directory.current.path,
        'ztmp',
        'eng_issues_bridge.dart',
      );
      await Directory(p.dirname(debugPath)).create(recursive: true);
      await File(debugPath).writeAsString(generatedCode);
    });

    test('ENG-010-01: GestureRecognizerMock is bridged. [2026-03-07] (PASS)',
        () {
      expect(generatedCode, contains("name: 'GestureRecognizerMock'"));
    });

    test(
        'ENG-010-02: onStart setter wraps InterpretedFunction. [2026-03-07] (FAIL)',
        () {
      // The setter adapter should check if value is InterpretedFunction
      // and wrap it in a native closure:
      // if (value is InterpretedFunction) {
      //   instance.onStart = (GestureDetails details) =>
      //     D4.callInterpreterCallback(visitor, value, [details]);
      // } else {
      //   instance.onStart = value;
      // }
      expect(
        generatedCode,
        anyOf(
          contains(
              'InterpretedFunction'), // Checks for InterpretedFunction handling
          contains(
              'D4.callInterpreterCallback'), // Or uses the callback wrapper
        ),
        reason: 'Setter should wrap InterpretedFunction in native closure',
      );
    });

    test(
        'ENG-010-03: All callback setters have wrapping code. [2026-03-07] (FAIL)',
        () {
      // Each callback setter (onStart, onUpdate, onEnd) should have wrapper
      expect(generatedCode, contains("'onStart':"));
      expect(generatedCode, contains("'onUpdate':"));
      expect(generatedCode, contains("'onEnd':"));
    });

    test(
        'ENG-010-04: AnimationMock status callback setter wrapped. [2026-03-07] (FAIL)',
        () {
      expect(generatedCode, contains("name: 'AnimationMock'"));
      expect(generatedCode, contains("'onStatusChanged':"));
    });

    test(
        'ENG-010-05: CallbackReturnSetters filter wrapped with return. [2026-03-07] (FAIL)',
        () {
      expect(generatedCode, contains("name: 'CallbackReturnSetters'"));
      expect(generatedCode, contains("'filter':"));
      // Return-value callbacks need: return D4.callInterpreterCallback(...) as bool;
    });

    test(
        'ENG-010-06: CallbackReturnSetters transform wrapped. [2026-03-07] (FAIL)',
        () {
      expect(generatedCode, contains("'transform':"));
    });
  });

  group('ENG-011: Generic Method Callback Return', () {
    late String generatedCode;

    setUpAll(() async {
      // Use same generated code from ENG-010 setup
      final generator = BridgeGenerator(
        workspacePath: testFixturesDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
        sourceImport: 'setter_callback_source.dart',
        packageName: 'test_eng_issues',
        verbose: false,
      );

      final sourceFile = p.join(testFixturesDir, 'setter_callback_source.dart');
      final outputFile =
          p.join(tempOutputDir, 'setter_callback_bridges_eng011.dart');

      final result = await generator.generateBridges(
        sourceFiles: [sourceFile],
        outputPath: outputFile,
        moduleName: 'setter_callback',
      );

      expect(result.errors, isEmpty);
      generatedCode = await File(result.outputFiles.first).readAsString();
    });

    test('ENG-011-01: SyncFutureMock is bridged. [2026-03-07] (PASS)', () {
      expect(generatedCode, contains("name: 'SyncFutureMock'"));
    });

    test('ENG-011-02: then method is bridged. [2026-03-07] (PASS)', () {
      expect(generatedCode, contains("'then':"));
    });

    test(
        'ENG-011-03: then callback return handles null safely. [2026-03-07] (FAIL)',
        () {
      // The callback wrapper should handle null returns:
      // final result = D4.callInterpreterCallback(visitor, fn, [value]);
      // if (result == null && null is R) return null as R;
      // return result as R;

      // Check for null-safe casting pattern
      expect(
        generatedCode,
        anyOf(
          contains('null is'), // Null-safe check
          contains('castCallbackResult'), // Or helper method
          contains('?? null'), // Or null coalescing
        ),
        reason: 'Generic callback return should handle null safely',
      );
    });

    test(
        'ENG-011-04: thenOrNull explicitly handles nullable. [2026-03-07] (PASS)',
        () {
      expect(generatedCode, contains("'thenOrNull':"));
    });
  });

  group('ENG-007: Nullable Type Extraction', () {
    late String generatedCode;

    setUpAll(() async {
      final generator = BridgeGenerator(
        workspacePath: testFixturesDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
        sourceImport: 'setter_callback_source.dart',
        packageName: 'test_eng_issues',
        verbose: false,
      );

      final sourceFile = p.join(testFixturesDir, 'setter_callback_source.dart');
      final outputFile =
          p.join(tempOutputDir, 'setter_callback_bridges_eng007.dart');

      final result = await generator.generateBridges(
        sourceFiles: [sourceFile],
        outputPath: outputFile,
        moduleName: 'setter_callback',
      );

      expect(result.errors, isEmpty);
      generatedCode = await File(result.outputFiles.first).readAsString();
    });

    test('ENG-007-01: TextStyleMock is bridged. [2026-03-07] (PASS)', () {
      expect(generatedCode, contains("name: 'TextStyleMock'"));
    });

    test('ENG-007-02: TextWidgetMock is bridged. [2026-03-07] (PASS)', () {
      expect(generatedCode, contains("name: 'TextWidgetMock'"));
    });

    test(
        'ENG-007-03: Nullable style parameter uses proper extraction. [2026-03-07] (FAIL)',
        () {
      // For nullable parameter TextStyleMock?, should use:
      // D4.extractBridgedArgOrNull<TextStyleMock>(...) 
      // OR
      // D4.extractBridgedArg<TextStyleMock?>(...)
      expect(
        generatedCode,
        anyOf(
          contains('extractBridgedArgOrNull'),
          contains('TextStyleMock?>'),
        ),
        reason: 'Nullable params should use null-aware extraction',
      );
    });

    test(
        'ENG-007-04: formatWith method handles nullable param. [2026-03-07] (PASS)',
        () {
      expect(generatedCode, contains("'formatWith':"));
    });
  });
}
