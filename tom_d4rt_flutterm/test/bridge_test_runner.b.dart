// D4rt Bridge - Generated file, do not edit
// Test runner for flutter_material_bridges
// Generated: 2026-02-28T15:17:33.911578

// ignore_for_file: avoid_print

//
// Usage:
//   dart run test/bridge_test_runner.b.dart <script.dart|.d4rt>  Run a D4rt script file
//   dart run test/bridge_test_runner.b.dart "<expression>"      Evaluate an expression
//   dart run test/bridge_test_runner.b.dart --eval-file <file>  Evaluate file content with eval()
//   dart run test/bridge_test_runner.b.dart --init-eval         Validate bridge registrations
//   dart run test/bridge_test_runner.b.dart --test <file>       Test script (structured JSON output)
//   dart run test/bridge_test_runner.b.dart --test-eval <init> <expr>  Test eval (structured JSON output)

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:tom_d4rt_exec/d4rt.dart';
import 'package:tom_d4rt_flutterm/src/bridges/dart_ui_bridges.b.dart' as dart_ui_bridges;
import 'package:tom_d4rt_flutterm/src/bridges/painting_bridges.b.dart' as flutter_painting_bridges;
import 'package:tom_d4rt_flutterm/src/bridges/foundation_bridges.b.dart' as flutter_foundation_bridges;
import 'package:tom_d4rt_flutterm/src/bridges/animation_bridges.b.dart' as flutter_animation_bridges;
import 'package:tom_d4rt_flutterm/src/bridges/physics_bridges.b.dart' as flutter_physics_bridges;
import 'package:tom_d4rt_flutterm/src/bridges/scheduler_bridges.b.dart' as flutter_scheduler_bridges;
import 'package:tom_d4rt_flutterm/src/bridges/semantics_bridges.b.dart' as flutter_semantics_bridges;
import 'package:tom_d4rt_flutterm/src/bridges/services_bridges.b.dart' as flutter_services_bridges;
import 'package:tom_d4rt_flutterm/src/bridges/gestures_bridges.b.dart' as flutter_gestures_bridges;
import 'package:tom_d4rt_flutterm/src/bridges/rendering_bridges.b.dart' as flutter_rendering_bridges;
import 'package:tom_d4rt_flutterm/src/bridges/widgets_bridges.b.dart' as flutter_widgets_bridges;
import 'package:tom_d4rt_flutterm/src/bridges/material_widgets_bridges.b.dart' as flutter_material_bridges;
import 'package:tom_d4rt_flutterm/src/bridges/cupertino_bridges.b.dart' as flutter_cupertino_bridges;

/// Init script source that imports all bridged modules.
const String _initSource = '''
import 'package:flutter/painting.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {}
''';

/// Registers all bridges with the given D4rt interpreter.
void _registerBridges(D4rt d4rt) {
  dart_ui_bridges.DartUiBridge.registerBridges(
    d4rt,
    'dart:ui',
  );
  flutter_painting_bridges.FlutterPaintingBridge.registerBridges(
    d4rt,
    'package:flutter/painting.dart',
  );
  flutter_foundation_bridges.FlutterFoundationBridge.registerBridges(
    d4rt,
    'package:flutter/foundation.dart',
  );
  flutter_animation_bridges.FlutterAnimationBridge.registerBridges(
    d4rt,
    'package:flutter/animation.dart',
  );
  flutter_physics_bridges.FlutterPhysicsBridge.registerBridges(
    d4rt,
    'package:flutter/physics.dart',
  );
  flutter_scheduler_bridges.FlutterSchedulerBridge.registerBridges(
    d4rt,
    'package:flutter/scheduler.dart',
  );
  flutter_semantics_bridges.FlutterSemanticsBridge.registerBridges(
    d4rt,
    'package:flutter/semantics.dart',
  );
  flutter_services_bridges.FlutterServicesBridge.registerBridges(
    d4rt,
    'package:flutter/services.dart',
  );
  flutter_gestures_bridges.FlutterGesturesBridge.registerBridges(
    d4rt,
    'package:flutter/gestures.dart',
  );
  flutter_rendering_bridges.FlutterRenderingBridge.registerBridges(
    d4rt,
    'package:flutter/rendering.dart',
  );
  flutter_widgets_bridges.FlutterWidgetsBridge.registerBridges(
    d4rt,
    'package:flutter/widgets.dart',
  );
  flutter_material_bridges.FlutterMaterialBridge.registerBridges(
    d4rt,
    'package:flutter/material.dart',
  );
  flutter_cupertino_bridges.FlutterCupertinoBridge.registerBridges(
    d4rt,
    'package:flutter/cupertino.dart',
  );
}

/// Logs D4 invocations to a debug file.
const String _d4InvocationsLogPath = '/Users/alexiskyaw/Desktop/Code/tom2/d4_invocations.log';

void _logD4Invocation(String mode, String input) {
  final timestamp = DateTime.now().toIso8601String();
  final logLine = '$timestamp | $mode | $input\n';
  try {
    File(_d4InvocationsLogPath).writeAsStringSync(logLine, mode: FileMode.append);
  } catch (_) {
    // Ignore logging failures
  }
}

Future<void> main(List<String> args) async {
  if (args.isEmpty) {
    stderr.writeln('Usage:');
    stderr.writeln('  dart run test/bridge_test_runner.b.dart <script.dart|.d4rt>  Run a D4rt script file');
    stderr.writeln('  dart run test/bridge_test_runner.b.dart "<expression>"      Evaluate an expression');
    stderr.writeln('  dart run test/bridge_test_runner.b.dart --eval-file <file>  Evaluate file content with eval()');
    stderr.writeln('  dart run test/bridge_test_runner.b.dart --init-eval         Validate bridge registrations');
    stderr.writeln('  dart run test/bridge_test_runner.b.dart --test <file>       Test script (structured JSON output)');
    stderr.writeln('  dart run test/bridge_test_runner.b.dart --test-eval <init> <expr>  Test eval (structured JSON)');
    exit(1);
  }

  if (args.first == '--test') {
    if (args.length < 2) {
      stderr.writeln('Error: --test requires a script file path argument.');
      exit(1);
    }
    await _runTestScript(args[1]);
    return;
  }

  if (args.first == '--test-eval') {
    if (args.length < 3) {
      stderr.writeln('Error: --test-eval requires <init-file> and <expression-file> arguments.');
      exit(1);
    }
    await _runTestEval(args[1], args[2]);
    return;
  }

  if (args.first == '--init-eval') {
    _runInitEval();
    return;
  }

  if (args.first == '--eval-file') {
    if (args.length < 2) {
      stderr.writeln('Error: --eval-file requires a file path argument.');
      exit(1);
    }
    _runEvalFile(args[1]);
    return;
  }

  final input = args.first;
  if (input.endsWith('.dart') || input.endsWith('.d4rt') || File(input).existsSync()) {
    _runFile(input);
  } else {
    _runExpression(input);
  }
}

/// Run a D4rt script file using execute().
void _runFile(String filePath) {
  _logD4Invocation('FILE', filePath);
  final file = File(filePath);
  if (!file.existsSync()) {
    stderr.writeln('Error: File not found: $filePath');
    exit(1);
  }

  final source = file.readAsStringSync();
  final d4rt = D4rt();
  _registerBridges(d4rt);
  // Grant all permissions for full access
  d4rt.grant(FilesystemPermission.any);
  d4rt.grant(NetworkPermission.any);
  d4rt.grant(ProcessRunPermission.any);
  d4rt.grant(IsolatePermission.any);
  d4rt.grant(DangerousPermission.any);

  try {
    final result = d4rt.execute(
      source: source,
      basePath: File(filePath).parent.path,
      allowFileSystemImports: true,
    );
    if (result != null) {
      print('Result: $result');
    }
  } catch (e, st) {
    stderr.writeln('Error executing $filePath:');
    stderr.writeln('  $e');
    stderr.writeln(st);
    exit(2);
  }
}

/// Evaluate an expression using eval().
void _runExpression(String expression) {
  _logD4Invocation('EXPR', expression);
  final d4rt = D4rt();
  _registerBridges(d4rt);
  // Grant all permissions for full access
  d4rt.grant(FilesystemPermission.any);
  d4rt.grant(NetworkPermission.any);
  d4rt.grant(ProcessRunPermission.any);
  d4rt.grant(IsolatePermission.any);
  d4rt.grant(DangerousPermission.any);

  // Initialize the interpreter with the import script
  d4rt.execute(source: _initSource);

  try {
    final result = d4rt.eval(expression);
    if (result != null) {
      print('Result: $result');
    }
  } catch (e, st) {
    stderr.writeln('Error evaluating expression:');
    stderr.writeln('  $e');
    stderr.writeln(st);
    exit(2);
  }
}

/// Evaluate file content using eval().
void _runEvalFile(String filePath) {
  _logD4Invocation('EVAL-FILE', filePath);
  final file = File(filePath);
  if (!file.existsSync()) {
    stderr.writeln('Error: File not found: $filePath');
    exit(1);
  }

  final source = file.readAsStringSync();
  final d4rt = D4rt();
  _registerBridges(d4rt);
  // Grant all permissions for full access
  d4rt.grant(FilesystemPermission.any);
  d4rt.grant(NetworkPermission.any);
  d4rt.grant(ProcessRunPermission.any);
  d4rt.grant(IsolatePermission.any);
  d4rt.grant(DangerousPermission.any);

  // Initialize the interpreter with the import script
  d4rt.execute(source: _initSource);

  try {
    final result = d4rt.eval(source);
    if (result != null) {
      print('Result: $result');
    }
  } catch (e, st) {
    stderr.writeln('Error evaluating $filePath:');
    stderr.writeln('  $e');
    stderr.writeln(st);
    exit(2);
  }
}

/// Validate bridge registrations by running the init script
/// and collecting all duplicate element errors.
void _runInitEval() {
  print('Validating bridge registrations for flutter_material_bridges...');
  print('');

  final d4rt = D4rt();
  _registerBridges(d4rt);

  final errors = d4rt.validateRegistrations(source: _initSource);

  if (errors.isEmpty) {
    print('✓ All bridge registrations are valid.');
    print('  No duplicate elements found.');
  } else {
    stderr.writeln('✗ Found ${errors.length} registration error(s):');
    stderr.writeln('');
    for (var i = 0; i < errors.length; i++) {
      stderr.writeln('  ${i + 1}. ${errors[i]}');
    }
    stderr.writeln('');
    stderr.writeln('Fix these issues by using import show/hide clauses in your');
    stderr.writeln('module configuration or by removing duplicate exports.');
    exit(2);
  }
}

/// Run a D4rt script in test mode with structured output capture.
/// Uses runZonedGuarded with ZoneSpecification to capture all print()
/// output and unhandled exceptions. Results are output as JSON.
/// Properly awaits async main() functions.
Future<void> _runTestScript(String filePath) async {
  _logD4Invocation('TEST', filePath);
  final file = File(filePath);
  if (!file.existsSync()) {
    _emitTestResult('', ['File not found: $filePath']);
    exit(2);
  }

  final source = file.readAsStringSync();
  final capturedOutput = StringBuffer();
  final capturedExceptions = <String>[];
  final completer = Completer<void>();

  runZonedGuarded(
    () async {
      try {
        final d4rt = D4rt();
        _registerBridges(d4rt);
        // Grant all permissions for full access
        d4rt.grant(FilesystemPermission.any);
        d4rt.grant(NetworkPermission.any);
        d4rt.grant(ProcessRunPermission.any);
        d4rt.grant(IsolatePermission.any);
        d4rt.grant(DangerousPermission.any);
        final result = d4rt.execute(
          source: source,
          basePath: File(filePath).parent.path,
          allowFileSystemImports: true,
        );
        // Await if result is a Future (async main)
        if (result is Future) {
          await result;
        }
        completer.complete();
      } catch (e, st) {
        capturedExceptions.add('$e\n$st');
        completer.complete();
      }
    },
    (error, stackTrace) {
      capturedExceptions.add('$error\n$stackTrace');
      if (!completer.isCompleted) completer.complete();
    },
    zoneSpecification: ZoneSpecification(
      print: (self, parent, zone, line) {
        capturedOutput.writeln(line);
      },
    ),
  );

  await completer.future;
  _emitTestResult(capturedOutput.toString(), capturedExceptions);
  if (capturedExceptions.isNotEmpty) exit(2);
}

/// Evaluate file content in test mode with structured output capture.
/// Initializes with [initFilePath], then evaluates [evalFilePath].
/// Properly awaits async init scripts.
Future<void> _runTestEval(String initFilePath, String evalFilePath) async {
  _logD4Invocation('TEST-EVAL', '$initFilePath | $evalFilePath');
  final initFile = File(initFilePath);
  final evalFile = File(evalFilePath);
  if (!initFile.existsSync()) {
    _emitTestResult('', ['Init file not found: $initFilePath']);
    exit(2);
  }
  if (!evalFile.existsSync()) {
    _emitTestResult('', ['Eval file not found: $evalFilePath']);
    exit(2);
  }

  final initSource = initFile.readAsStringSync();
  final evalSource = evalFile.readAsStringSync();
  final capturedOutput = StringBuffer();
  final capturedExceptions = <String>[];
  final completer = Completer<void>();

  runZonedGuarded(
    () async {
      try {
        final d4rt = D4rt();
        _registerBridges(d4rt);
        // Grant all permissions for full access
        d4rt.grant(FilesystemPermission.any);
        d4rt.grant(NetworkPermission.any);
        d4rt.grant(ProcessRunPermission.any);
        d4rt.grant(IsolatePermission.any);
        d4rt.grant(DangerousPermission.any);
        // Initialize with the init script
        final initResult = d4rt.execute(
          source: initSource,
          basePath: File(initFilePath).parent.path,
          allowFileSystemImports: true,
        );
        // Await if init result is a Future (async main)
        if (initResult is Future) {
          await initResult;
        }
        // Evaluate the expression file
        d4rt.eval(evalSource);
        completer.complete();
      } catch (e, st) {
        capturedExceptions.add('$e\n$st');
        completer.complete();
      }
    },
    (error, stackTrace) {
      capturedExceptions.add('$error\n$stackTrace');
      if (!completer.isCompleted) completer.complete();
    },
    zoneSpecification: ZoneSpecification(
      print: (self, parent, zone, line) {
        capturedOutput.writeln(line);
      },
    ),
  );

  await completer.future;
  _emitTestResult(capturedOutput.toString(), capturedExceptions);
  if (capturedExceptions.isNotEmpty) exit(2);
}

/// Emit structured test result as JSON for D4rtTester to parse.
/// Uses stdout.writeln directly to bypass any zone print overrides.
void _emitTestResult(String output, List<String> exceptions) {
  final result = jsonEncode({
    'output': output,
    'exceptions': exceptions,
  });
  stdout.writeln('###D4RT_TEST_RESULT###$result');
}
