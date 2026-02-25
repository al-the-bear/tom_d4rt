#!/usr/bin/env dart
/// Master script to generate bridges and run examples.
///
/// This script:
/// 1. Runs `bin/generate_bridges.dart` to generate D4rt bridges
/// 2. Runs `bin/example_executor.dart` to execute all example scripts
///
/// Run with:
/// ```bash
/// dart run run_examples.dart
/// ```
library;

import 'dart:io';

import 'package:path/path.dart' as p;

Future<void> main(List<String> args) async {
  final projectDir = p.dirname(Platform.script.toFilePath());

  print('╔════════════════════════════════════════════════════════════╗');
  print('║            D4rt Generator Example Runner                   ║');
  print('╚════════════════════════════════════════════════════════════╝');
  print('');
  print('Project directory: $projectDir');
  print('');

  // Step 1: Generate bridges
  print('┌────────────────────────────────────────────────────────────┐');
  print('│ Step 1: Generating bridges                                 │');
  print('└────────────────────────────────────────────────────────────┘');
  print('');

  final generateResult = await _runDartScript(
    projectDir,
    p.join(projectDir, 'bin', 'generate_bridges.dart'),
  );

  if (generateResult != 0) {
    stderr.writeln('');
    stderr.writeln('❌ Bridge generation failed with exit code $generateResult');
    exit(generateResult);
  }

  print('');
  print('✓ Bridge generation completed');
  print('');

  // Step 2: Run examples
  print('┌────────────────────────────────────────────────────────────┐');
  print('│ Step 2: Running examples                                   │');
  print('└────────────────────────────────────────────────────────────┘');
  print('');

  final exampleArgs = args.isNotEmpty ? args : <String>[];
  final exampleResult = await _runDartScript(
    projectDir,
    p.join(projectDir, 'bin', 'example_executor.dart'),
    arguments: exampleArgs,
  );

  print('');
  if (exampleResult == 0) {
    print('╔════════════════════════════════════════════════════════════╗');
    print('║                    ✓ All steps completed                   ║');
    print('╚════════════════════════════════════════════════════════════╝');
  } else {
    stderr.writeln('╔════════════════════════════════════════════════════════════╗');
    stderr.writeln('║               ❌ Some examples failed                       ║');
    stderr.writeln('╚════════════════════════════════════════════════════════════╝');
  }

  exit(exampleResult);
}

/// Runs a Dart script and streams output to stdout/stderr.
Future<int> _runDartScript(
  String workingDirectory,
  String scriptPath, {
  List<String> arguments = const [],
}) async {
  final process = await Process.start(
    'dart',
    ['run', scriptPath, ...arguments],
    workingDirectory: workingDirectory,
    mode: ProcessStartMode.inheritStdio,
  );

  return await process.exitCode;
}
