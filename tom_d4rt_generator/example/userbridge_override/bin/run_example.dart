#!/usr/bin/env dart
/// UserBridge Override Example - D4rt Script Runner
///
/// This script demonstrates how generated bridges work with
/// UserBridge overrides for operators and globals.
///
/// From: userbridge_override_design.md
///
/// Run with:
/// ```bash
/// dart run bin/run_example.dart
/// ```
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:tom_d4rt/d4rt.dart';

import 'package:userbridge_override_example/dartscript.dart';

void main() async {
  print('=== UserBridge Override D4rt Example Runner ===');
  print('');

  // Create D4rt interpreter
  final d4rt = D4rt();

  // Register all generated bridges (including UserBridge overrides)
  UserbridgeOverrideExampleBridges.register(d4rt);

  // Find the scripts directory
  final scriptDir = _findScriptsDir();
  if (scriptDir == null) {
    print('Error: scripts/ directory not found');
    exit(1);
  }

  // Run the example script
  final scriptPath = p.join(scriptDir, 'userbridge_override_example.d4rt');
  final scriptFile = File(scriptPath);

  if (!scriptFile.existsSync()) {
    print('Error: Script not found: $scriptPath');
    exit(1);
  }

  print('Running: userbridge_override_example.d4rt');
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
