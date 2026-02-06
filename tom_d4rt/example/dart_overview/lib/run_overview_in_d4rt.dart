#!/usr/bin/env dart
/// Run Dart Overview Examples using D4rt Interpreter
///
/// This script executes all area demonstration files (run_<area>.dart)
/// using the D4rt interpreter with full permissions and relative import support.
///
/// Usage:
///   dart run run_overview_in_d4rt.dart              # Run compatible areas
///   dart run run_overview_in_d4rt.dart --all        # Run all areas (including known failures)
///   dart run run_overview_in_d4rt.dart --list       # List available areas with status
///   dart run run_overview_in_d4rt.dart <area>       # Run specific area(s)
///   dart run run_overview_in_d4rt.dart variables    # Run only variables
///   dart run run_overview_in_d4rt.dart control func # Run control_flow and functions
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';

/// All 20 overview areas in order
const areas = [
  'variables',
  'operators',
  'control_flow',
  'functions',
  'classes',
  'class_modifiers',
  'generics',
  'collections',
  'records',
  'patterns',
  'enums',
  'mixins',
  'extensions',
  'async',
  'error_handling',
  'libraries',
  'comments',
  'typedefs',
  'annotations',
  'globals',
];

/// Areas excluded due to documented D4rt limitations (see doc/limitations.md)
/// These require features that D4rt intentionally does not support.
const excludedDocumentedLimitations = <String, String>{
  // All previously excluded areas have been fixed
};

/// Get compatible areas (not excluded due to documented limitations)
List<String> get compatibleAreas => 
    areas.where((a) => !excludedDocumentedLimitations.containsKey(a)).toList();

Future<void> main(List<String> args) async {
  final bigSeparator = '=' * 80;
  final sectionSeparator = '*' * 80;

  print('');
  print(bigSeparator);
  print('');
  print('     ██████╗ ██╗  ██╗██████╗ ████████╗');
  print('     ██╔══██╗██║  ██║██╔══██╗╚══██╔══╝');
  print('     ██║  ██║███████║██████╔╝   ██║   ');
  print('     ██║  ██║╚════██║██╔══██╗   ██║   ');
  print('     ██████╔╝     ██║██║  ██║   ██║   ');
  print('     ╚═════╝      ╚═╝╚═╝  ╚═╝   ╚═╝   ');
  print('');
  print('           D4RT INTERPRETER RUNNER');
  print('        Executing Dart Overview Examples');
  print('');
  print(bigSeparator);
  print('');

  // Find the dart_overview directory
  final overviewDir = _findOverviewDirectory();
  if (overviewDir == null) {
    print('Error: Could not find dart_overview directory');
    exit(1);
  }

  print('Overview directory: $overviewDir');
  print('');

  final runAll = args.contains('--all');

  // Handle --list flag
  if (args.contains('--list')) {
    print('Available areas:');
    print('');
    for (var i = 0; i < areas.length; i++) {
      final area = areas[i];
      final num = '${i + 1}.'.padLeft(4);
      if (excludedDocumentedLimitations.containsKey(area)) {
        print('  $num ${_capitalize(area)} ⚠️  [LIMITATION: ${excludedDocumentedLimitations[area]}]');
      } else {
        print('  $num ${_capitalize(area)} ✓');
      }
    }
    print('');
    print('Legend:');
    print('  ✓  = Will be executed');
    print('  ⚠️  = Excluded (documented limitation)');
    print('');
    print('Compatible areas: ${compatibleAreas.length}/${areas.length}');
    print('Use --all to include areas with documented limitations.');
    return;
  }

  // Determine which areas to run
  List<String> areasToRun;
  final filterArgs = args.where((a) => !a.startsWith('--')).toList();
  
  if (filterArgs.isEmpty) {
    // Default: run only compatible areas (unless --all)
    areasToRun = runAll ? areas : compatibleAreas;
  } else {
    // Filter areas matching any argument (partial match)
    final baseAreas = runAll ? areas : compatibleAreas;
    areasToRun = baseAreas.where((area) {
      return filterArgs.any((arg) => area.contains(arg) || arg.contains(area));
    }).toList();

    if (areasToRun.isEmpty) {
      print('No areas matching: ${filterArgs.join(", ")}');
      print('Use --list to see available areas.');
      exit(1);
    }
  }

  final excludedCount = areas.length - compatibleAreas.length;
  if (!runAll && excludedCount > 0) {
    print('Excluding $excludedCount areas with known issues.');
    print('Use --all to run all areas, or --list to see details.');
    print('');
  }

  print('Running ${areasToRun.length} of ${areas.length} areas...');
  print('');

  // Track timing and results
  final stopwatch = Stopwatch()..start();
  var passed = 0;
  var failed = 0;

  // Create D4rt interpreter
  final d4rt = D4rt();

  // Grant all permissions for full access
  d4rt.grant(FilesystemPermission.any);
  d4rt.grant(IsolatePermission.any);  // For async/isolates examples

  for (var i = 0; i < areasToRun.length; i++) {
    final area = areasToRun[i];
    final areaIndex = areas.indexOf(area) + 1;
    final runnerFile = p.join(overviewDir, area, 'run_$area.dart');

    print('');
    print(sectionSeparator);
    print('  AREA $areaIndex/${areas.length}: ${area.toUpperCase()}');
    print(sectionSeparator);
    print('');

    if (!File(runnerFile).existsSync()) {
      print('⚠ Runner file not found: run_$area.dart');
      failed++;
      continue;
    }

    try {
      // Execute the area file using D4rt with relative import support
      final result = executeFile(
        d4rt,
        runnerFile,
        log: null, // Set to print for debug logging
      );

      if (result.success) {
        // Handle async results
        var finalResult = result.result;
        if (finalResult is Future) {
          finalResult = await finalResult;
        }
        
        print('');
        if (result.sourcesLoaded > 1) {
          print('(loaded ${result.sourcesLoaded} source files)');
        }
        print('✓ $area completed');
        passed++;
      } else {
        print('');
        print('❌ $area failed: ${result.error}');
        if (result.stackTrace != null) {
          print('Stack: ${result.stackTrace}');
        }
        failed++;
      }
    } catch (e, stack) {
      print('');
      print('❌ $area failed with exception:');
      print('Error: $e');
      print('Stack: $stack');
      failed++;
    }
  }

  stopwatch.stop();

  // Final summary
  print('');
  print(bigSeparator);
  print('');
  print('                    D4RT EXECUTION COMPLETE');
  print('');
  if (failed == 0) {
    print('  All ${areasToRun.length} areas executed successfully!');
  } else {
    print('  Passed: $passed, Failed: $failed');
  }
  print('');
  print('  Areas executed:');
  for (final area in areasToRun) {
    final i = areas.indexOf(area);
    final num = '${i + 1}.'.padLeft(4);
    print('    $num ${_capitalize(area)}');
  }
  if (!runAll && excludedDocumentedLimitations.isNotEmpty) {
    print('');
    print('  Excluded (${excludedDocumentedLimitations.length} areas with documented limitations):');
    for (final area in excludedDocumentedLimitations.keys) {
      final i = areas.indexOf(area);
      final num = '${i + 1}.'.padLeft(4);
      print('    $num ${_capitalize(area)} ⚠️');
    }
  }
  print('');
  print('  Total execution time: ${stopwatch.elapsedMilliseconds}ms');
  print('');
  print(bigSeparator);

  if (failed > 0) {
    exit(1);
  }
}

/// Find the dart_overview directory from the current script location.
String? _findOverviewDirectory() {
  // First, try relative to current directory
  if (Directory('variables').existsSync() && 
      Directory('operators').existsSync()) {
    return Directory.current.path;
  }

  // Try relative to script location
  final scriptDir = File(Platform.script.toFilePath()).parent;
  if (Directory(p.join(scriptDir.path, 'variables')).existsSync()) {
    return scriptDir.path;
  }

  // Try common locations
  final candidates = [
    'example/dart_overview',
    '../dart_overview',
    'dart_overview',
  ];

  for (final candidate in candidates) {
    if (Directory(p.join(candidate, 'variables')).existsSync()) {
      return p.canonicalize(candidate);
    }
  }

  return null;
}

/// Capitalize area name for display.
String _capitalize(String s) {
  if (s.isEmpty) return s;
  return s.split('_').map((word) {
    return word.isEmpty ? word : word[0].toUpperCase() + word.substring(1);
  }).join(' ');
}
