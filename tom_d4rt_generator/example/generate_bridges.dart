#!/usr/bin/env dart
/// Script to generate D4rt bridges for the example test classes.
///
/// Run with:
/// ```bash
/// dart run generate_bridges.dart
/// ```
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

Future<void> main() async {
  final exampleDir = Directory.current.path;
  final testClassesDir = p.join(exampleDir, 'lib', 'test_classes');
  final outputDir = p.join(exampleDir, 'lib', 'd4rt_bridges');

  // Ensure output directory exists
  Directory(outputDir).createSync(recursive: true);

  print('D4rt Bridge Generator - Example Classes');
  print('========================================');
  print('Source: $testClassesDir');
  print('Output: $outputDir');
  print('');

  // Collect all source files
  final sourceFiles = <String>[];
  final testClassesDirObj = Directory(testClassesDir);
  if (!testClassesDirObj.existsSync()) {
    stderr.writeln('Error: test_classes directory not found at $testClassesDir');
    exit(1);
  }

  for (final entity in testClassesDirObj.listSync()) {
    if (entity is File && entity.path.endsWith('.dart')) {
      sourceFiles.add(entity.path);
    }
  }

  sourceFiles.sort();

  print('Found ${sourceFiles.length} source files:');
  for (final file in sourceFiles) {
    print('  - ${p.basename(file)}');
  }
  print('');

  // Generate bridges for each category
  final categories = [
    ('basic_classes.dart', 'basic_bridge.dart', 'Basic'),
    ('generic_classes.dart', 'generic_bridge.dart', 'Generic'),
    ('inheritance_classes.dart', 'inheritance_bridge.dart', 'Inheritance'),
    ('callback_classes.dart', 'callback_bridge.dart', 'Callback'),
    ('operator_classes.dart', 'operator_bridge.dart', 'Operator'),
    ('global_members.dart', 'global_bridge.dart', 'Global'),
    ('enum_classes.dart', 'enum_bridge.dart', 'Enum'),
  ];

  var totalErrors = 0;
  var totalWarnings = 0;

  for (final (sourceFile, outputFile, moduleName) in categories) {
    final sourcePath = p.join(testClassesDir, sourceFile);
    final outputPath = p.join(outputDir, outputFile);

    if (!File(sourcePath).existsSync()) {
      print('⚠ Skipping $sourceFile (not found)');
      continue;
    }

    print('Generating $outputFile...');

    final generator = BridgeGenerator(
      workspacePath: exampleDir,
      skipPrivate: true,
      helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
      sourceImport: 'test_classes.dart',
      packageName: 'd4rt_generator_example',
      verbose: false,
    );

    try {
      final result = await generator.generateBridges(
        sourceFiles: [sourcePath],
        outputPath: outputPath,
        moduleName: moduleName,
      );

      if (result.errors.isNotEmpty) {
        print('  ❌ Errors:');
        for (final error in result.errors) {
          print('    - $error');
        }
        totalErrors += result.errors.length;
      }

      if (result.warnings.isNotEmpty) {
        print('  ⚠ Warnings:');
        for (final warning in result.warnings) {
          print('    - $warning');
        }
        totalWarnings += result.warnings.length;
      }

      if (result.errors.isEmpty && result.warnings.isEmpty) {
        print('  ✓ Generated successfully');
      }
    } catch (e) {
      print('  ❌ Failed: $e');
      totalErrors++;
    }
  }

  print('');
  print('========================================');
  if (totalErrors == 0) {
    print('✓ Bridge generation complete!');
  } else {
    print('Completed with $totalErrors error(s) and $totalWarnings warning(s)');
  }

  // Note: Combined bridge generation is disabled due to stack overflow
  // when processing many source files together. Use individual bridges instead.

  exit(totalErrors > 0 ? 1 : 0);
}
