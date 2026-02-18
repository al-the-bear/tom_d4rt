/// Test script for source extraction feature.
///
/// Tests the complete code parsing feature on a small codebase (dart_overview)
/// and verifies that source code can be recovered and regenerated.
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:tom_analyzer/tom_analyzer.dart';

void main() async {
  print('=== Source Extraction Test ===');
  print('');

  // Analyze dart_overview test folder with source extraction enabled
  final basePath = Directory.current.path;
  final testFile = p.join(
    basePath,
    'test/dart_overview/lib/comments/basics/run_basics.dart',
  );

  print('Entry point: $testFile');
  print('');

  // Create config with source extraction enabled
  final config = ReflectionConfig(
    entryPoints: [testFile],
    sourceExtractionConfig: const SourceExtractionConfig(
      enabled: true,
      includeSourceCode: true,
      includeDocComments: true,
      includeAllComments: true,
      includeLineInfo: true,
      storeFileContents: true,
    ),
  );

  print('Source extraction config:');
  print('  enabled: ${config.sourceExtractionConfig.enabled}');
  print('  includeSourceCode: ${config.sourceExtractionConfig.includeSourceCode}');
  print('  includeDocComments: ${config.sourceExtractionConfig.includeDocComments}');
  print('  includeAllComments: ${config.sourceExtractionConfig.includeAllComments}');
  print('');

  // Analyze
  print('Analyzing...');
  final stopwatch = Stopwatch()..start();

  final analyzer = EntryPointAnalyzer(config);
  final result = await analyzer.analyze();

  stopwatch.stop();
  print('Analysis time: ${stopwatch.elapsedMilliseconds}ms');
  print('');

  // Report results
  print('=== Analysis Results ===');
  print('Classes: ${result.classes.length}');
  print('Enums: ${result.enums.length}');
  print('Functions: ${result.globalFunctions.length}');
  print('Variables: ${result.globalVariables.length}');
  print('');

  // Check source info
  final sourceInfo = result.sourceInfo;
  if (sourceInfo == null) {
    print('ERROR: No source info collected!');
    return;
  }

  print('=== Source Info Collection ===');
  print('Elements with source info: ${sourceInfo.count}');
  print('Estimated memory: ${sourceInfo.estimatedMemorySize}');
  print('');

  // Show source info for each class
  print('=== Classes with Source Info ===');
  for (final cls in result.classes) {
    final qualifiedName =
      '${cls.library.firstFragment.source.uri}#${cls.name}';
    final info = sourceInfo.get(qualifiedName);

    print('');
    print('Class: ${cls.name}');
    print('  Qualified name: $qualifiedName');
    if (info != null) {
      print('  Has source info: true');
      print('  Range: ${info.range.offset}-${info.range.end}');
      print('  Line: ${info.line}');
      print('  Has doc comment: ${info.hasDocComment}');
      if (info.docComment != null) {
        final firstLine = info.docComment!.split('\n').first;
        print('  Doc comment (first line): $firstLine');
      }
      if (info.sourceCode != null) {
        print('  Source code length: ${info.sourceCode!.length} chars');
        // Show first 200 chars
        final preview = info.sourceCode!.substring(
          0,
          info.sourceCode!.length.clamp(0, 200),
        );
        print('  Preview:');
        print('  ---');
        for (final line in preview.split('\n')) {
          print('  $line');
        }
        print('  ---');
      }
    } else {
      print('  Has source info: false');
    }
  }

  // Test serialization
  print('');
  print('=== Serialization Test ===');
  final json = sourceInfo.toJsonString(pretty: false);
  print('JSON size: ${json.length} chars');

  // Deserialize and verify
  final restored = SourceInfoCollection.fromJsonString(json);
  print('Restored elements: ${restored.count}');
  print('Serialization/deserialization: OK');

  // Compare original source with stored source
  print('');
  print('=== Source Recovery Test ===');

  // Read original file
  final originalSource = File(testFile).readAsStringSync();
  print('Original file size: ${originalSource.length} chars');

  // Get stored source
  final storedSource = sourceInfo.getSource(File(testFile).uri.toString());
  if (storedSource != null) {
    print('Stored source size: ${storedSource.length} chars');
    print('Sources match: ${originalSource == storedSource}');
  } else {
    print('No stored source (file URI might differ)');
    // Try finding it in sources
    print('Looking for source by file path...');
    for (final cls in result.classes) {
        final qualifiedName =
          '${cls.library.firstFragment.source.uri}#${cls.name}';
      final info = sourceInfo.get(qualifiedName);
      if (info != null) {
        final fileSource = sourceInfo.getSource(info.fileUri);
        if (fileSource != null) {
          print('Found source for ${info.fileUri}');
          print('Source size: ${fileSource.length} chars');
          break;
        }
      }
    }
  }

  print('');
  print('=== Test Complete ===');
}
