/// Comprehensive tests for bridge generator extension bridging (GEN-047).
///
/// These tests verify that the generator correctly:
/// - Detects extensions from source files
/// - Generates BridgedExtensionDefinition code with getters, setters, methods
/// - Registers extensions via registerBridges()
/// - Skips private extensions
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

/// Helper to extract a section from generated code using regex
String? _extractSection(String code, String sectionName) {
  // Look for patterns like "static List<BridgedExtensionDefinition> bridgedExtensions() {"
  final regex = RegExp(
    r'static\s+\S+\s+' + RegExp.escape(sectionName) + r'\s*\(\s*\)\s*\{',
    multiLine: true,
  );
  final match = regex.firstMatch(code);
  if (match == null) return null;

  // Find matching closing brace
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
        Directory.systemTemp.createTempSync('bridge_extension_test_').path;
  });

  tearDownAll(() {
    try {
      Directory(tempOutputDir).deleteSync(recursive: true);
    } catch (_) {}
  });

  group('Extension Bridge Generation', () {
    late BridgeGenerator generator;
    late String generatedCode;

    setUpAll(() async {
      generator = BridgeGenerator(
        workspacePath: testFixturesDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
        sourceImport: 'extension_test_source.dart',
        packageName: 'test_package',
        verbose: false,
      );

      final sourceFile = p.join(testFixturesDir, 'extension_test_source.dart');
      final outputFile = p.join(tempOutputDir, 'extension_bridges_test.dart');

      final result = await generator.generateBridges(
        sourceFiles: [sourceFile],
        outputPath: outputFile,
        moduleName: 'test',
      );

      expect(result.errors, isEmpty, reason: 'Should generate without errors');
      expect(result.outputFiles, isNotEmpty);

      generatedCode = await File(result.outputFiles.first).readAsString();
    });

    test('generates bridgedExtensions() method [2026-02-10 06:37]', () {
      expect(generatedCode, contains('static List<BridgedExtensionDefinition> bridgedExtensions()'));
    });

    test('generates extensionSourceUris() method [2026-02-10 06:37]', () {
      expect(generatedCode, contains('static Map<String, String> extensionSourceUris()'));
    });
    
    test('generates StringHelpers extension [2026-02-10 06:37]', () {
      expect(generatedCode, contains("name: 'StringHelpers'"));
      expect(generatedCode, contains("onTypeName: 'String'"));
    });

    test('generates isPalindrome getter for StringHelpers [2026-02-10 06:37]', () {
      final section = _extractSection(generatedCode, 'bridgedExtensions');
      expect(section, isNotNull);
      expect(section, contains("'isPalindrome'"));
    });

    test('generates reversed getter for StringHelpers [2026-02-10 06:37]', () {
      final section = _extractSection(generatedCode, 'bridgedExtensions');
      expect(section, isNotNull);
      expect(section, contains("'reversed'"));
    });

    test('generates repeat method for StringHelpers [2026-02-10 06:37]', () {
      final section = _extractSection(generatedCode, 'bridgedExtensions');
      expect(section, isNotNull);
      expect(section, contains("'repeat'"));
    });

    test('generates surround method for StringHelpers [2026-02-10 06:37]', () {
      final section = _extractSection(generatedCode, 'bridgedExtensions');
      expect(section, isNotNull);
      expect(section, contains("'surround'"));
    });

    test('generates DateTimeHelpers extension [2026-02-10 06:37]', () {
      expect(generatedCode, contains("name: 'DateTimeHelpers'"));
      expect(generatedCode, contains("onTypeName: 'DateTime'"));
    });

    test('generates PointExtensions extension [2026-02-10 06:37]', () {
      expect(generatedCode, contains("name: 'PointExtensions'"));
      expect(generatedCode, contains("onTypeName: 'Point'"));
    });

    test('generates magnitude getter for PointExtensions [2026-02-10 06:37]', () {
      final section = _extractSection(generatedCode, 'bridgedExtensions');
      expect(section, isNotNull);
      expect(section, contains("'magnitude'"));
    });

    test('generates add method for PointExtensions [2026-02-10 06:37]', () {
      final section = _extractSection(generatedCode, 'bridgedExtensions');
      expect(section, isNotNull);
      // Check for method with name 'add' - could be in methods map
      expect(section, contains("'add'"));
    });

    test('skips private extensions [2026-02-10 06:37]', () {
      // _PrivateExtension should not be generated
      expect(generatedCode, isNot(contains("'_PrivateExtension'")));
      expect(generatedCode, isNot(contains("'secret'")));
    });

    test('registers extensions in registerBridges() [2026-02-10 06:37]', () {
      expect(generatedCode, contains('final extensions = bridgedExtensions()'));
      expect(generatedCode, contains('interpreter.registerBridgedExtension'));
    });
  });
}
