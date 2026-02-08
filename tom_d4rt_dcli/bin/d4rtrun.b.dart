// D4rt Bridge - Generated file, do not edit
// Test runner for tom_d4rt_dcli
// Generated: 2026-02-08T11:56:54.211048
//
// Usage:
//   dart run bin/d4rtrun.b.dart <script.dart|.d4rt>  Run a D4rt script file
//   dart run bin/d4rtrun.b.dart "<expression>"      Evaluate an expression
//   dart run bin/d4rtrun.b.dart --eval-file <file>  Evaluate file content with eval()
//   dart run bin/d4rtrun.b.dart --init-eval         Validate bridge registrations
//   dart run bin/d4rtrun.b.dart --test <file>       Test script (structured JSON output)
//   dart run bin/d4rtrun.b.dart --test-eval <init> <expr>  Test eval (structured JSON output)

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt_dcli/src/bridges/cli_api_bridges.b.dart' as cli_api_bridges;
import 'package:tom_d4rt_dcli/src/bridges/tom_vscode_scripting_api_bridges.b.dart' as tom_vscode_scripting_api_bridges;
import 'package:tom_d4rt_dcli/src/bridges/dcli_bridges.b.dart' as dcli_bridges;
import 'package:tom_d4rt_dcli/src/bridges/tom_chattools_bridges.b.dart' as tom_chattools_bridges;

/// Init script source that imports all bridged modules.
const String _initSource = '''
import 'package:tom_d4rt_dcli/tom_d4rt_cli_api.dart';
import 'package:tom_vscode_scripting_api/script_globals.dart';
import 'package:dcli/dcli.dart';
import 'package:dcli_core/dcli_core.dart';
import 'package:tom_chattools/tom_chattools.dart';

void main() {}
''';

/// Registers all bridges with the given D4rt interpreter.
void _registerBridges(D4rt d4rt) {
  cli_api_bridges.CliApiBridge.registerBridges(
    d4rt,
    'package:tom_d4rt_dcli/tom_d4rt_cli_api.dart',
  );
  tom_vscode_scripting_api_bridges.TomVscodeScriptingApiBridge.registerBridges(
    d4rt,
    'package:tom_vscode_scripting_api/script_globals.dart',
  );
  dcli_bridges.DcliBridge.registerBridges(
    d4rt,
    'package:dcli/dcli.dart',
  );
  dcli_bridges.DcliBridge.registerBridges(
    d4rt,
    'package:dcli_core/dcli_core.dart',
  );
  tom_chattools_bridges.TomChattoolsBridge.registerBridges(
    d4rt,
    'package:tom_chattools/tom_chattools.dart',
  );
}

void main(List<String> args) {
  if (args.isEmpty) {
    stderr.writeln('Usage:');
    stderr.writeln('  dart run bin/d4rtrun.b.dart <script.dart|.d4rt>  Run a D4rt script file');
    stderr.writeln('  dart run bin/d4rtrun.b.dart "<expression>"      Evaluate an expression');
    stderr.writeln('  dart run bin/d4rtrun.b.dart --eval-file <file>  Evaluate file content with eval()');
    stderr.writeln('  dart run bin/d4rtrun.b.dart --init-eval         Validate bridge registrations');
    stderr.writeln('  dart run bin/d4rtrun.b.dart --test <file>       Test script (structured JSON output)');
    stderr.writeln('  dart run bin/d4rtrun.b.dart --test-eval <init> <expr>  Test eval (structured JSON)');
    exit(1);
  }

  if (args.first == '--test') {
    if (args.length < 2) {
      stderr.writeln('Error: --test requires a script file path argument.');
      exit(1);
    }
    _runTestScript(args[1]);
    return;
  }

  if (args.first == '--test-eval') {
    if (args.length < 3) {
      stderr.writeln('Error: --test-eval requires <init-file> and <expression-file> arguments.');
      exit(1);
    }
    _runTestEval(args[1], args[2]);
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
  final file = File(filePath);
  if (!file.existsSync()) {
    stderr.writeln('Error: File not found: $filePath');
    exit(1);
  }

  final source = file.readAsStringSync();
  final d4rt = D4rt();
  _registerBridges(d4rt);
  d4rt.grant(FilesystemPermission.any);

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
  final d4rt = D4rt();
  _registerBridges(d4rt);
  d4rt.grant(FilesystemPermission.any);

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
  final file = File(filePath);
  if (!file.existsSync()) {
    stderr.writeln('Error: File not found: $filePath');
    exit(1);
  }

  final source = file.readAsStringSync();
  final d4rt = D4rt();
  _registerBridges(d4rt);
  d4rt.grant(FilesystemPermission.any);

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
  print('Validating bridge registrations for tom_d4rt_dcli...');
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
void _runTestScript(String filePath) {
  final file = File(filePath);
  if (!file.existsSync()) {
    _emitTestResult('', ['File not found: $filePath']);
    exit(2);
  }

  final source = file.readAsStringSync();
  final capturedOutput = StringBuffer();
  final capturedExceptions = <String>[];

  runZonedGuarded(
    () {
      final d4rt = D4rt();
      _registerBridges(d4rt);
      d4rt.grant(FilesystemPermission.any);
      d4rt.execute(
        source: source,
        basePath: File(filePath).parent.path,
        allowFileSystemImports: true,
      );
    },
    (error, stackTrace) {
      capturedExceptions.add('$error\n$stackTrace');
    },
    zoneSpecification: ZoneSpecification(
      print: (self, parent, zone, line) {
        capturedOutput.writeln(line);
      },
    ),
  );

  _emitTestResult(capturedOutput.toString(), capturedExceptions);
  if (capturedExceptions.isNotEmpty) exit(2);
}

/// Evaluate file content in test mode with structured output capture.
/// Initializes with [initFilePath], then evaluates [evalFilePath].
void _runTestEval(String initFilePath, String evalFilePath) {
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

  runZonedGuarded(
    () {
      final d4rt = D4rt();
      _registerBridges(d4rt);
      d4rt.grant(FilesystemPermission.any);
      // Initialize with the init script
      d4rt.execute(
        source: initSource,
        basePath: File(initFilePath).parent.path,
        allowFileSystemImports: true,
      );
      // Evaluate the expression file
      d4rt.eval(evalSource);
    },
    (error, stackTrace) {
      capturedExceptions.add('$error\n$stackTrace');
    },
    zoneSpecification: ZoneSpecification(
      print: (self, parent, zone, line) {
        capturedOutput.writeln(line);
      },
    ),
  );

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
