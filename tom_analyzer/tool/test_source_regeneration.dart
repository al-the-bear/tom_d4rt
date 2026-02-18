/// Regeneration test - extracts source and regenerates to verify completeness.
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:tom_analyzer/tom_analyzer.dart';

void main() async {
  print('=== Source Regeneration Test ===');
  print('');

  final basePath = Directory.current.path;
  final testFile = p.join(
    basePath,
    'test/dart_overview/lib/comments/basics/run_basics.dart',
  );

  print('Test file: $testFile');
  print('');

  // Read original source
  final originalSource = File(testFile).readAsStringSync();
  print('Original file size: ${originalSource.length} chars');

  // Analyze with full source extraction
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

  final analyzer = EntryPointAnalyzer(config);
  final result = await analyzer.analyze();
  final sourceInfo = result.sourceInfo!;

  print('Elements with source info: ${sourceInfo.count}');
  print('');

  // Test 1: Verify stored file contents match exactly
  print('=== Test 1: Stored File Contents ===');
  final fileUri = File(testFile).uri.toString();
  final storedSource = sourceInfo.getSource(fileUri);
  if (storedSource != null) {
    print('Stored source size: ${storedSource.length} chars');
    print('Exact match: ${originalSource == storedSource}');
    if (originalSource != storedSource) {
      print('MISMATCH at char: ${_findFirstDifference(originalSource, storedSource)}');
    }
  } else {
    print('No stored source found for URI: $fileUri');
  }

  // Test 2: Serialize and deserialize, then compare
  print('');
  print('=== Test 2: Serialization Roundtrip ===');
  final json = sourceInfo.toJsonString();
  print('JSON size: ${json.length} chars');
  
  final restored = SourceInfoCollection.fromJsonString(json);
  print('Restored elements: ${restored.count}');
  
  final restoredSource = restored.getSource(fileUri);
  if (restoredSource != null) {
    print('Restored source size: ${restoredSource.length} chars');
    print('Matches original: ${originalSource == restoredSource}');
  }

  // Test 3: Check individual element sources can be recovered
  print('');
  print('=== Test 3: Element Source Recovery ===');
  
  // Find classes in our file
  final fileClasses = result.classes.where((cls) {
    return cls.library.firstFragment.source.uri.toString() == fileUri;
  }).toList();
  
  print('Classes in test file: ${fileClasses.length}');
  
  for (final cls in fileClasses) {
    final qualifiedName = '$fileUri#${cls.name}';
    final info = sourceInfo.get(qualifiedName);
    
    if (info != null && info.sourceCode != null) {
      // Verify source code can be found in original
      final found = originalSource.contains(info.sourceCode!);
      final status = found ? '✓' : '✗';
      print('  $status ${cls.name}: ${info.sourceCode!.length} chars at line ${info.line}');
      
      if (!found) {
        print('    Source not found in original!');
        print('    First 100 chars: ${info.sourceCode!.substring(0, 100.clamp(0, info.sourceCode!.length))}');
      }
    } else {
      print('  - ${cls.name}: no source info');
    }
  }

  // Test 4: Check function source
  print('');
  print('=== Test 4: Function Source Recovery ===');
  final fileFunctions = result.globalFunctions.where((fn) {
    return fn.library.firstFragment.source.uri.toString() == fileUri;
  }).toList();
  
  print('Functions in test file: ${fileFunctions.length}');
  
  for (final fn in fileFunctions) {
    final qualifiedName = '$fileUri#${fn.name}';
    final info = sourceInfo.get(qualifiedName);
    
    if (info != null && info.sourceCode != null) {
      final found = originalSource.contains(info.sourceCode!);
      final status = found ? '✓' : '✗';
      print('  $status ${fn.name}: ${info.sourceCode!.length} chars at line ${info.line}');
    } else {
      print('  - ${fn.name}: no source info');
    }
  }

  print('');
  print('=== Summary ===');
  print('File source recovery: ${storedSource != null && originalSource == storedSource ? "PASS" : "FAIL"}');
  print('Serialization roundtrip: ${restoredSource != null && originalSource == restoredSource ? "PASS" : "FAIL"}');
  print('');
  print('Test complete.');
}

int _findFirstDifference(String a, String b) {
  final minLen = a.length < b.length ? a.length : b.length;
  for (var i = 0; i < minLen; i++) {
    if (a[i] != b[i]) return i;
  }
  return minLen;
}
