#!/usr/bin/env dart
/// Script to run D4rt example scripts.
///
/// Run with:
/// ```bash
/// dart run bin/example_executor.dart [script_name]
/// ```
///
/// Examples:
/// - dart run bin/example_executor.dart basic      # Run basic_example.d4rt
/// - dart run bin/example_executor.dart all        # Run all examples
/// - dart run bin/example_executor.dart            # Run all examples (default)
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:tom_d4rt/d4rt.dart';

import 'package:d4rt_generator_example/d4rt_bridges/basic_bridge.dart';
import 'package:d4rt_generator_example/d4rt_bridges/generic_bridge.dart';
import 'package:d4rt_generator_example/d4rt_bridges/inheritance_bridge.dart';
import 'package:d4rt_generator_example/d4rt_bridges/callback_bridge.dart';
import 'package:d4rt_generator_example/d4rt_bridges/operator_bridge.dart';

const importPath = 'package:d4rt_generator_example/test_classes.dart';

void main(List<String> args) async {
  final scriptName = args.isEmpty ? 'all' : args.first;
  
  // Find the project root (go up from bin/ to project root)
  var exampleDir = Directory.current.path;
  final scriptDir = p.dirname(Platform.script.toFilePath());
  if (p.basename(scriptDir) == 'bin') {
    exampleDir = p.dirname(scriptDir);
  }
  
  final scriptsDir = p.join(exampleDir, 'scripts');

  print('D4rt Example Executor');
  print('=====================');
  print('Scripts directory: $scriptsDir');
  print('');

  // Available scripts
  final availableScripts = [
    'basic_example.d4rt',
    'generic_example.d4rt',
    'inheritance_example.d4rt',
    'callbacks_example.d4rt',
    'operators_example.d4rt',
  ];

  // Determine which scripts to run
  List<String> scriptsToRun;
  if (scriptName == 'all') {
    scriptsToRun = availableScripts;
  } else {
    // Find matching script
    final matching = availableScripts.where(
      (s) => s.startsWith(scriptName) || s == scriptName || s == '$scriptName.d4rt'
    ).toList();
    
    if (matching.isEmpty) {
      stderr.writeln('Unknown script: $scriptName');
      stderr.writeln('Available scripts:');
      for (final s in availableScripts) {
        stderr.writeln('  - ${p.basenameWithoutExtension(s)}');
      }
      exit(1);
    }
    scriptsToRun = matching;
  }

  var passed = 0;
  var failed = 0;
  final failures = <String, String>{};

  for (final scriptFile in scriptsToRun) {
    final scriptPath = p.join(scriptsDir, scriptFile);
    
    if (!File(scriptPath).existsSync()) {
      print('⚠ Script not found: $scriptFile');
      failures[scriptFile] = 'Script file not found';
      failed++;
      continue;
    }

    print('Running: $scriptFile');
    print('-' * 60);

    try {
      final result = await runScript(scriptPath);
      print('');
      print('Result: $result');
      print('✓ $scriptFile passed');
      passed++;
    } catch (e, stack) {
      print('');
      print('❌ $scriptFile failed:');
      final errorMessage = _formatError(e, stack);
      print(errorMessage);
      failures[scriptFile] = errorMessage;
      failed++;
    }

    print('');
    print('=' * 60);
    print('');
  }

  // Print summary
  print('');
  print('Summary');
  print('=======');
  print('Passed: $passed');
  print('Failed: $failed');
  
  if (failures.isNotEmpty) {
    print('');
    print('Failures:');
    for (final entry in failures.entries) {
      print('');
      print('  ${entry.key}:');
      for (final line in entry.value.split('\n')) {
        print('    $line');
      }
    }
  }
  
  exit(failed > 0 ? 1 : 0);
}

/// Formats an error with optional stack trace for clean reporting.
String _formatError(Object error, StackTrace stack) {
  final buffer = StringBuffer();
  buffer.writeln('Error: $error');
  
  // For D4rt errors, the message is usually sufficient
  // For other errors, include a trimmed stack trace
  if (error is! String && error.runtimeType.toString() != 'D4rtError') {
    final stackLines = stack.toString().split('\n');
    // Only include the first few relevant lines
    final relevantLines = stackLines
        .where((line) => !line.contains('dart:async'))
        .take(5)
        .toList();
    if (relevantLines.isNotEmpty) {
      buffer.writeln('Stack trace:');
      for (final line in relevantLines) {
        buffer.writeln('  $line');
      }
    }
  }
  
  return buffer.toString().trimRight();
}

/// Creates and configures a D4rt interpreter with all bridges registered.
D4rt createInterpreter() {
  final interpreter = D4rt();

  // Register all bridges
  BasicBridge.registerBridges(interpreter, importPath);
  GenericBridge.registerBridges(interpreter, importPath);
  InheritanceBridge.registerBridges(interpreter, importPath);
  CallbackBridge.registerBridges(interpreter, importPath);
  OperatorBridge.registerBridges(interpreter, importPath);

  return interpreter;
}

/// Runs a D4rt script file and returns the result.
Future<dynamic> runScript(String scriptPath) async {
  final source = await File(scriptPath).readAsString();
  final interpreter = createInterpreter();
  
  return await interpreter.execute(source: source);
}
