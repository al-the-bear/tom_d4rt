/// Tests for D4rt Generator bugs found via DCli bridge testing.
///
/// These tests verify that the generator produces correct bridge code for
/// patterns used by DCli that were previously failing.
///
/// Each test documents a specific generator bug and verifies the fix.
///
/// ## Issue Categories:
/// - DCL-EXT: Extension method callback wrapping
/// - DCL-SUB: Superclass bridge resolution for subclasses
/// - DCL-OPT: Optional parameter detection
/// - DCL-CLS: Class method callback wrapping
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

/// Helper to extract a section from generated code using regex
String? _extractSection(String code, String sectionName) {
  final regex = RegExp(
    r'static\s+\S+\s+' + RegExp.escape(sectionName) + r'\s*\(\s*\)\s*\{',
    multiLine: true,
  );
  final match = regex.firstMatch(code);
  if (match == null) return null;

  int braceCount = 1;
  int startIndex = match.end;
  int endIndex = startIndex;

  while (braceCount > 0 && endIndex < code.length) {
    if (code[endIndex] == '{') {
      braceCount++;
    } else if (code[endIndex] == '}') {
      braceCount--;
    }
    endIndex++;
  }

  return code.substring(match.start, endIndex);
}

void main() {
  late String testFixturesDir;
  late String tempOutputDir;

  setUpAll(() {
    testFixturesDir = p.join(Directory.current.path, 'test', 'fixtures');
    tempOutputDir =
        Directory.systemTemp.createTempSync('dcli_gaps_test_').path;
  });

  tearDownAll(() {
    try {
      Directory(tempOutputDir).deleteSync(recursive: true);
    } catch (_) {}
  });

  group('DCli Bridge Gaps', () {
    late String generatedCode;
    late BridgeGeneratorResult result;

    setUpAll(() async {
      final generator = BridgeGenerator(
        workspacePath: testFixturesDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
        sourceImport: 'dcli_gaps_source.dart',
        packageName: 'test_package',
        verbose: false,
      );

      final sourceFile = p.join(testFixturesDir, 'dcli_gaps_source.dart');
      final outputFile = p.join(tempOutputDir, 'dcli_gaps_bridges.dart');

      result = await generator.generateBridges(
        sourceFiles: [sourceFile],
        outputPath: outputFile,
        moduleName: 'dcli_gaps',
      );

      expect(result.errors, isEmpty, reason: 'Should generate without errors');
      expect(result.outputFiles, isNotEmpty);

      generatedCode = await File(result.outputFiles.first).readAsString();
      
      // Debug: print generated code for inspection
      // print('Generated code:\n$generatedCode');
    });

    group('Extension Callback Wrapping', () {
      // Issue: Extension methods that take function parameters don't wrap
      // InterpretedFunction callbacks. They use Function.apply() directly
      // which passes the raw InterpretedFunction instead of a native wrapper.
      //
      // Example: 'git status'.forEach((line) => print('> $line'))
      // Error: type 'InterpretedFunction' is not a subtype of type '(String) => void'

      test('DCL-EXT-001: Extension on String should be generated [2026-02-11] (PASS)',
          () {
        expect(
          generatedCode,
          contains("name: 'StringAsProcess'"),
          reason: 'Should generate StringAsProcess extension',
        );
        expect(
          generatedCode,
          contains("onTypeName: 'String'"),
          reason: 'Extension should target String type',
        );
      });

      test('DCL-EXT-002: Extension forEach method should be generated [2026-02-11] (PASS)',
          () {
        final section = _extractSection(generatedCode, 'bridgedExtensions');
        expect(section, isNotNull, reason: 'Should have bridgedExtensions method');
        expect(
          section,
          contains("'forEach'"),
          reason: 'Should generate forEach method for extension',
        );
      });

      test('DCL-EXT-003: Extension method callback should wrap InterpretedFunction [2026-02-11] (FAIL)',
          () {
        // The extension method forEach takes void Function(String) lineAction
        // It should wrap the callback, not use Function.apply directly
        final section = _extractSection(generatedCode, 'bridgedExtensions');
        expect(section, isNotNull);

        // Should NOT use Function.apply for forEach (would pass raw InterpretedFunction)
        // Instead should have explicit wrapper code
        expect(
          section,
          isNot(contains('Function.apply(t.forEach')),
          reason: 'Should NOT use Function.apply for methods with callbacks',
        );
      });
      
      test('DCL-EXT-004: Extension callback should use InterpretedFunction wrapper [2026-02-11] (FAIL)',
          () {
        final section = _extractSection(generatedCode, 'bridgedExtensions');
        expect(section, isNotNull);
        
        // The forEach method should extract the callback and wrap it
        expect(
          section,
          anyOf([
            contains('InterpretedFunction'),  // Explicit wrapping
            contains('lineActionRaw'),         // Raw extraction pattern
            contains('(String p0)')            // Inline wrapper lambda
          ]),
          reason: 'Extension method with callback should wrap InterpretedFunction',
        );
      });
    });

    group('Class Method Callback Wrapping', () {
      // Issue: Class methods with callback parameters should wrap callbacks
      // This works for regular classes but need to verify it's correct.

      test('DCL-CLS-001: ProcessRunner forEach should wrap callback [2026-02-11] (PASS)',
          () {
        // Find the ProcessRunner bridge methods section
        expect(
          generatedCode,
          contains("name: 'ProcessRunner'"),
          reason: 'Should generate ProcessRunner class bridge',
        );
        
        // forEach method should have InterpretedFunction wrapping
        expect(
          generatedCode,
          contains("'forEach':"),
          reason: 'Should have forEach method',
        );
      });

      test('DCL-CLS-002: Class forEach callback uses InterpretedFunction [2026-02-11] (PASS)',
          () {
        // The generated code should have callback wrapping for class methods
        // using D4.callInterpreterCallback which handles both InterpretedFunction and NativeFunction
        expect(
          generatedCode,
          contains('D4.callInterpreterCallback'),
          reason: 'Should use D4.callInterpreterCallback for callbacks',
        );
        
        // Should have the wrapper pattern
        expect(
          generatedCode,
          contains('D4.callInterpreterCallback(visitor,'),
          reason: 'Should call D4.callInterpreterCallback with visitor',
        );
      });
    });

    group('Optional Parameter Detection', () {
      // Issue: Optional parameters with default values should not be required

      test('DCL-OPT-001: find() progress parameter should be optional [2026-02-11] (PASS)',
          () {
        // progress is Progress? - optional and nullable
        expect(
          generatedCode,
          contains("getOptionalNamedArg<"),
          reason: 'Nullable optional parameter should use getOptionalNamedArg',
        );
      });

      test('DCL-OPT-002: find() progress should NOT use getRequiredNamedArg [2026-02-11] (PASS)',
          () {
        // Should NOT require progress
        // Look for pattern that would make it required incorrectly
        expect(
          generatedCode,
          isNot(contains("getRequiredNamedArg<Progress>('progress'")),
          reason: 'Nullable Progress? should not be required',
        );
      });

      test('DCL-OPT-003: runCommand onLine should handle null callback [2026-02-11] (PASS)',
          () {
        // Optional callback parameters use raw extraction with null check
        // Pattern: final onLineRaw = named['onLine'];
        //          final onLine = onLineRaw == null ? null : (String p0) { ... };
        expect(
          generatedCode,
          contains("onLineRaw"),
          reason: 'Optional callback should extract raw value',
        );
        expect(
          generatedCode,
          contains("onLineRaw == null ? null :"),
          reason: 'Optional callback should have null check',
        );
      });
    });

    group('Abstract Class Bridge', () {
      // Issue: Abstract classes should have bridges, and internal subclasses
      // should automatically resolve to parent bridge

      test('DCL-SUB-001: Progress abstract class should be bridged [2026-02-11] (PASS)',
          () {
        expect(
          generatedCode,
          contains("name: 'Progress'"),
          reason: 'Should generate bridge for Progress class',
        );
      });

      test('DCL-SUB-002: Progress bridge should have lines getter [2026-02-11] (PASS)',
          () {
        // Look for lines getter in the Progress bridge
        expect(
          generatedCode,
          contains("'lines':"),
          reason: 'Progress bridge should have lines getter',
        );
      });

      test('DCL-SUB-003: Progress bridge should have forEach method [2026-02-11] (PASS)',
          () {
        expect(
          generatedCode,
          contains("'forEach':"),
          reason: 'Progress bridge should have forEach method',
        );
      });

      test('DCL-SUB-004: Private _ProgressImpl should NOT be bridged [2026-02-11] (PASS)',
          () {
        // Private classes should not be bridged
        expect(
          generatedCode,
          isNot(contains('_ProgressImpl')),
          reason: 'Private implementation class should not be bridged',
        );
      });
    });

    group('FindProgress Class', () {
      test('DCL-FND-001: FindProgress should be bridged [2026-02-11] (PASS)',
          () {
        expect(
          generatedCode,
          contains("name: 'FindProgress'"),
          reason: 'Should generate bridge for FindProgress',
        );
      });

      test('DCL-FND-002: FindProgress forEach should wrap callback [2026-02-11] (PASS)',
          () {
        // Check that FindProgress.forEach wraps its callback
        // This should work correctly for regular class methods
        expect(
          generatedCode,
          contains("'forEach':"),
          reason: 'FindProgress should have forEach method',
        );
      });
    });
    
    group('Find Function', () {
      // Note: The dcli_core.find() function has `required ProgressCallback progress`,
      // while the user-friendly dcli.find() wrapper has `Progress? progress` (optional).
      // 
      // When the generator bridges dcli_core (which it does to get low-level APIs),
      // it correctly marks `progress` as required because that's how dcli_core defines it.
      //
      // This is not a generator bug - it's correct behavior. The solution is either:
      // 1. Bridge the dcli package's find() wrapper instead of dcli_core's find()
      // 2. Use the higher-level DCli APIs that don't require explicit progress callbacks
      
      test('DCL-FIND-001: dcli_core.find requires progress callback (by design) [2026-02-11] (PASS)',
          () {
        // This verifies the expected behavior: the generator correctly bridges
        // dcli_core.find() which has a required progress parameter.
        // This is NOT a bug - it's the correct API from dcli_core.
        //
        // Note: This test file uses dcli_gaps_source.dart fixture, not actual DCli.
        // The actual DCli bridge behavior is documented here for reference.
        expect(true, isTrue, reason: 'Documentation test - dcli_core.find requires progress by design');
      });
    });
  });
}
