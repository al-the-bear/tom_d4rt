import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

void main() {
  final testFixturesDir =
      p.join(Directory.current.path, 'test', 'fixtures');
  final tempOutputDir = p.join(Directory.current.path, 'test', 'temp_output');

  setUpAll(() {
    final tempDir = Directory(tempOutputDir);
    if (!tempDir.existsSync()) {
      tempDir.createSync(recursive: true);
    }
  });

  tearDownAll(() {
    final tempDir = Directory(tempOutputDir);
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  });

  group('Operator Generation', () {
    late BridgeGenerator generator;
    late String generatedCode;

    setUpAll(() async {
      generator = BridgeGenerator(
        workspacePath: testFixturesDir,
        skipPrivate: true,
        helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
        sourceImport: 'operator_test_source.dart',
        packageName: 'test_package',
        verbose: false,
      );

      final sourceFile = p.join(testFixturesDir, 'operator_test_source.dart');
      final outputFile = p.join(tempOutputDir, 'operator_bridge_test.dart');

      final result = await generator.generateBridges(
        sourceFiles: [sourceFile],
        outputPath: outputFile,
        moduleName: 'test',
      );

      expect(result.errors, isEmpty, reason: 'Should generate without errors');
      expect(result.outputFiles, isNotEmpty);

      generatedCode = await File(result.outputFiles.first).readAsString();
    });

    test('generates bridges for arithmetic operators', () {
      // Check that Vector2 operators are present
      expect(generatedCode, contains("'+': (visitor, target, positional, named)"));
      expect(generatedCode, contains("'-': (visitor, target, positional, named)"));
      expect(generatedCode, contains("'*': (visitor, target, positional, named)"));
      expect(generatedCode, contains("'/': (visitor, target, positional, named)"));
      // New format uses D4.getRequiredArg to extract typed operands
      expect(generatedCode, contains('return t + other;'));
      expect(generatedCode, contains('return t * other;'));
      expect(generatedCode, contains('return t / other;'));
      expect(generatedCode, contains('return -t;')); // Unary negation
    });

    test('generates bridges for index operators', () {
      expect(generatedCode, contains("'[]': (visitor, target, positional, named)"));
      expect(generatedCode, contains("'[]=': (visitor, target, positional, named)"));
      // New format uses D4.getRequiredArg to extract typed index and value
      expect(generatedCode, contains('return t[index];'));
      expect(generatedCode, contains('t[index] = value;'));
    });

    test('generates bridges for bitwise operators', () {
      expect(generatedCode, contains("'&': (visitor, target, positional, named)"));
      expect(generatedCode, contains("'|': (visitor, target, positional, named)"));
      expect(generatedCode, contains("'^': (visitor, target, positional, named)"));
      expect(generatedCode, contains("'~': (visitor, target, positional, named)"));
      expect(generatedCode, contains("'<<': (visitor, target, positional, named)"));
      expect(generatedCode, contains("'>>': (visitor, target, positional, named)"));
      // New format uses D4.getRequiredArg to extract typed operands
      expect(generatedCode, contains('return t & other;'));
      expect(generatedCode, contains('return t | other;'));
      expect(generatedCode, contains('return t ^ other;'));
      expect(generatedCode, contains('return ~t;')); // Unary operator
      expect(generatedCode, contains('return t << other;'));
      expect(generatedCode, contains('return t >> other;'));
    });

    test('generates bridges for comparison operators', () {
      expect(generatedCode, contains("'<': (visitor, target, positional, named)"));
      expect(generatedCode, contains("'>': (visitor, target, positional, named)"));
      expect(generatedCode, contains("'<=': (visitor, target, positional, named)"));
      expect(generatedCode, contains("'>=': (visitor, target, positional, named)"));
      expect(generatedCode, contains("'==': (visitor, target, positional, named)"));
      // New format uses D4.getRequiredArg to extract typed operands
      expect(generatedCode, contains('return t < other;'));
      expect(generatedCode, contains('return t > other;'));
      expect(generatedCode, contains('return t <= other;'));
      expect(generatedCode, contains('return t >= other;'));
      expect(generatedCode, contains('return t == other;'));
    });

    test('operators are placed in methods map', () {
      // Both methods and operators should be in the same methods: block
      expect(generatedCode, contains('methods: {'));
      // MixedClass has both add method and + operator
      expect(generatedCode, contains("'add': (visitor, target, positional, named)"));
    });
  });
}

