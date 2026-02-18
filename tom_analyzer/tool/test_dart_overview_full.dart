/// Full dart_overview source extraction and regeneration test.
///
/// Analyzes the complete dart_overview test folder and saves:
/// - Source info JSON
/// - Regenerated source files
/// - Comparison report
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:tom_analyzer/tom_analyzer.dart';

void main() async {
  print('=== Full dart_overview Source Extraction Test ===');
  print('');

  final basePath = Directory.current.path;
  final dartOverviewPath = p.join(basePath, 'test/dart_overview/lib');
  final outputPath = p.join(basePath, 'doc/generated/dart_overview');

  // Create output directory
  final outputDir = Directory(outputPath);
  if (!outputDir.existsSync()) {
    outputDir.createSync(recursive: true);
  }

  // Find all Dart files in dart_overview
  final dartFiles = <String>[];
  await _collectDartFiles(Directory(dartOverviewPath), dartFiles);
  
  print('Found ${dartFiles.length} Dart files in dart_overview');
  print('Output directory: $outputPath');
  print('');

  // Use all dart files as entry points (run_dart_overview has broken imports)
  final entryPoints = dartFiles.where((f) => 
    !f.contains('run_dart_overview.dart') && 
    !f.contains('run_overview_in_d4rt.dart')
  ).toList();
  print('Using ${entryPoints.length} individual entry points');
  print('');

  // Analyze with full source extraction
  final config = ReflectionConfig(
    entryPoints: entryPoints,
    sourceExtractionConfig: const SourceExtractionConfig(
      enabled: true,
      includeSourceCode: true,
      includeDocComments: true,
      includeAllComments: true,
      includeLineInfo: true,
      storeFileContents: true,
    ),
  );

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
  print('Mixins: ${result.mixins.length}');
  print('Functions: ${result.globalFunctions.length}');
  print('Variables: ${result.globalVariables.length}');
  print('');

  final sourceInfo = result.sourceInfo;
  if (sourceInfo == null) {
    print('ERROR: No source info collected!');
    return;
  }

  print('=== Source Info ===');
  print('Elements with source info: ${sourceInfo.count}');
  print('Estimated memory: ${sourceInfo.estimatedMemorySize}');
  print('');

  // Save source info JSON
  print('=== Saving Generated Files ===');
  
  final jsonPath = p.join(outputPath, 'source_info.json');
  final jsonContent = sourceInfo.toJsonString(pretty: true);
  File(jsonPath).writeAsStringSync(jsonContent);
  print('Saved: source_info.json (${_formatSize(jsonContent.length)})');

  // Save compact JSON
  final jsonCompactPath = p.join(outputPath, 'source_info.compact.json');
  final jsonCompact = sourceInfo.toJsonString(pretty: false);
  File(jsonCompactPath).writeAsStringSync(jsonCompact);
  print('Saved: source_info.compact.json (${_formatSize(jsonCompact.length)})');

  // Regenerate source files from stored content
  final regeneratedDir = Directory(p.join(outputPath, 'regenerated'));
  if (!regeneratedDir.existsSync()) {
    regeneratedDir.createSync(recursive: true);
  }

  int regeneratedCount = 0;
  int totalChars = 0;
  final regeneratedFiles = <String, String>{};

  // Get all stored sources
  final sources = sourceInfo.toJson()['sources'] as Map<String, dynamic>?;
  if (sources != null) {
    for (final entry in sources.entries) {
      final uri = entry.key;
      final content = entry.value as String;
      
      // Convert file URI to relative path
      if (uri.startsWith('file://')) {
        final fullPath = Uri.parse(uri).toFilePath();
        if (fullPath.contains('dart_overview/lib/')) {
          final relativePath = fullPath.split('dart_overview/lib/').last;
          final outputFile = p.join(regeneratedDir.path, relativePath);
          
          // Create directory structure
          final dir = Directory(p.dirname(outputFile));
          if (!dir.existsSync()) {
            dir.createSync(recursive: true);
          }
          
          File(outputFile).writeAsStringSync(content);
          regeneratedFiles[relativePath] = outputFile;
          regeneratedCount++;
          totalChars += content.length;
        }
      }
    }
  }

  print('Regenerated: $regeneratedCount files (${_formatSize(totalChars)})');
  print('');

  // Compare regenerated files with originals
  print('=== Verification ===');
  int matches = 0;
  int mismatches = 0;
  final report = StringBuffer();
  report.writeln('# dart_overview Source Regeneration Report');
  report.writeln('');
  report.writeln('Generated: ${DateTime.now().toIso8601String()}');
  report.writeln('');
  report.writeln('## Summary');
  report.writeln('');
  report.writeln('- Analysis time: ${stopwatch.elapsedMilliseconds}ms');
  report.writeln('- Classes: ${result.classes.length}');
  report.writeln('- Enums: ${result.enums.length}');
  report.writeln('- Functions: ${result.globalFunctions.length}');
  report.writeln('- Elements with source info: ${sourceInfo.count}');
  report.writeln('- JSON size: ${_formatSize(jsonContent.length)}');
  report.writeln('');
  report.writeln('## File Comparison');
  report.writeln('');
  report.writeln('| File | Original | Regenerated | Match |');
  report.writeln('|------|----------|-------------|-------|');

  for (final entry in regeneratedFiles.entries) {
    final relativePath = entry.key;
    final regeneratedPath = entry.value;
    final originalPath = p.join(dartOverviewPath, relativePath);
    
    if (File(originalPath).existsSync()) {
      final original = File(originalPath).readAsStringSync();
      final regenerated = File(regeneratedPath).readAsStringSync();
      
      if (original == regenerated) {
        matches++;
        report.writeln('| $relativePath | ${original.length} | ${regenerated.length} | ✓ |');
      } else {
        mismatches++;
        final diffPos = _findFirstDifference(original, regenerated);
        report.writeln('| $relativePath | ${original.length} | ${regenerated.length} | ✗ (diff@$diffPos) |');
      }
    } else {
      report.writeln('| $relativePath | N/A | ${File(regeneratedPath).lengthSync()} | - |');
    }
  }

  report.writeln('');
  report.writeln('## Results');
  report.writeln('');
  report.writeln('- **Matches**: $matches');
  report.writeln('- **Mismatches**: $mismatches');
  report.writeln('- **Success rate**: ${(matches / (matches + mismatches) * 100).toStringAsFixed(1)}%');

  // Save report
  final reportPath = p.join(outputPath, 'regeneration_report.md');
  File(reportPath).writeAsStringSync(report.toString());
  print('Saved: regeneration_report.md');

  print('');
  print('Matches: $matches');
  print('Mismatches: $mismatches');
  print('Success rate: ${(matches / (matches + mismatches) * 100).toStringAsFixed(1)}%');
  
  // Save element source info
  final elementsReport = StringBuffer();
  elementsReport.writeln('# Element Source Info');
  elementsReport.writeln('');
  elementsReport.writeln('## Classes (${result.classes.length})');
  elementsReport.writeln('');
  
  for (final cls in result.classes) {
    final uri = cls.library.firstFragment.source.uri.toString();
    if (!uri.contains('dart_overview')) continue;
    
    final qualifiedName = '$uri#${cls.name}';
    final info = sourceInfo.get(qualifiedName);
    
    if (info != null) {
      elementsReport.writeln('### ${cls.name}');
      elementsReport.writeln('');
      elementsReport.writeln('- File: ${info.fileUri.split('/').last}');
      elementsReport.writeln('- Line: ${info.line}');
      elementsReport.writeln('- Source length: ${info.sourceCode?.length ?? 0} chars');
      if (info.docComment != null) {
        final firstLine = info.docComment!.split('\n').first;
        elementsReport.writeln('- Doc: `$firstLine`');
      }
      elementsReport.writeln('');
    }
  }

  final elementsPath = p.join(outputPath, 'elements_report.md');
  File(elementsPath).writeAsStringSync(elementsReport.toString());
  print('Saved: elements_report.md');

  print('');
  print('=== Test Complete ===');
  print('All files saved to: $outputPath');
}

Future<void> _collectDartFiles(Directory dir, List<String> files) async {
  await for (final entity in dir.list()) {
    if (entity is File && entity.path.endsWith('.dart')) {
      files.add(entity.path);
    } else if (entity is Directory) {
      await _collectDartFiles(entity, files);
    }
  }
}

String _formatSize(int chars) {
  if (chars < 1024) return '$chars chars';
  if (chars < 1024 * 1024) return '${(chars / 1024).toStringAsFixed(1)} KB';
  return '${(chars / 1024 / 1024).toStringAsFixed(1)} MB';
}

int _findFirstDifference(String a, String b) {
  final minLen = a.length < b.length ? a.length : b.length;
  for (var i = 0; i < minLen; i++) {
    if (a[i] != b[i]) return i;
  }
  return minLen;
}
