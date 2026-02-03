#!/usr/bin/env dart
/// User Guide Example - D4rt Script Runner
///
/// This script demonstrates how to use generated bridges to run D4rt scripts.
///
/// From: bridgegenerator_user_guide.md - Quick Start section
///
/// Run with:
/// ```bash
/// dart run bin/run_example.dart
/// ```
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:tom_d4rt/d4rt.dart';

import 'package:user_guide_example/dartscript.dart';

void main() async {
  print('=== User Guide D4rt Example Runner ===');
  print('');

  // Create D4rt interpreter
  final d4rt = D4rt();

  // Register all generated bridges
  UserGuideExampleBridges.register(d4rt);

  // Find the scripts directory
  final scriptDir = _findScriptsDir();
  if (scriptDir == null) {
    print('Error: scripts/ directory not found');
    exit(1);
  }

  // Run the example script
  final scriptPath = p.join(scriptDir, 'user_guide_example.d4rt');
  final scriptFile = File(scriptPath);

  if (!scriptFile.existsSync()) {
    print('Error: Script not found: $scriptPath');
    exit(1);
  }

  print('Running: user_guide_example.d4rt');
  print('-' * 60);
  print('');

  try {
    final source = scriptFile.readAsStringSync();
    final result = await d4rt.execute(source: source);

    print('');
    print('-' * 60);
    print('Result: $result');
    print('');
    print('✓ Example completed successfully');
  } catch (e, stack) {
    print('');
    print('❌ Example failed:');
    print('Error: $e');
    print('Stack: $stack');
    exit(1);
  }
}

/// Find the scripts directory relative to the current working directory.
String? _findScriptsDir() {
  // Try common locations
  final candidates = [
    'scripts',
    '../scripts',
    p.join(Directory.current.path, 'scripts'),
  ];

  for (final path in candidates) {
    if (Directory(path).existsSync()) {
      return path;
    }
  }

  return null;
}
