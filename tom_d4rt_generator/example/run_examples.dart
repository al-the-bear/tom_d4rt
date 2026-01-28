#!/usr/bin/env dart
/// Script to run D4rt example scripts.
///
/// Run with:
/// ```bash
/// dart run run_examples.dart [script_name]
/// ```
///
/// Examples:
/// - dart run run_examples.dart basic      # Run basic_example.d4rt
/// - dart run run_examples.dart all        # Run all examples
/// - dart run run_examples.dart            # Run all examples (default)
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
  final exampleDir = Directory.current.path;
  final scriptsDir = p.join(exampleDir, 'scripts');

  print('D4rt Example Runner');
  print('===================');
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

  for (final scriptFile in scriptsToRun) {
    final scriptPath = p.join(scriptsDir, scriptFile);
    
    if (!File(scriptPath).existsSync()) {
      print('⚠ Script not found: $scriptFile');
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
      print('Error: $e');
      if (e is! String) {
        print('Stack: $stack');
      }
      failed++;
    }

    print('');
    print('=' * 60);
    print('');
  }

  print('Summary: $passed passed, $failed failed');
  exit(failed > 0 ? 1 : 0);
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
