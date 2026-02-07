// D4rt Bridge - Generated file, do not edit
// Test runner for userbridge_override_example
// Generated: 2026-02-07T11:51:37.292651
//
// Usage:
//   dart run bin/d4rtrun.b.dart <script.dart|.d4rt>  Run a D4rt script file
//   dart run bin/d4rtrun.b.dart "<expression>"      Evaluate an expression
//   dart run bin/d4rtrun.b.dart --eval-file <file>  Evaluate file content with eval()
//   dart run bin/d4rtrun.b.dart --init-eval         Validate bridge registrations

import 'dart:io';

import 'package:tom_d4rt/d4rt.dart';
import '../lib/src/d4rt_bridges/userbridge_bridges.dart' as all_bridges;

/// Init script source that imports all bridged modules.
const String _initSource = '''
import 'package:userbridge_override_example/userbridge_override_example.dart';

void main() {}
''';

/// Registers all bridges with the given D4rt interpreter.
void _registerBridges(D4rt d4rt) {
  all_bridges.AllBridge.registerBridges(
    d4rt,
    'package:userbridge_override_example/userbridge_override_example.dart',
  );
}

void main(List<String> args) {
  if (args.isEmpty) {
    stderr.writeln('Usage:');
    stderr.writeln('  dart run bin/d4rtrun.b.dart <script.dart|.d4rt>  Run a D4rt script file');
    stderr.writeln('  dart run bin/d4rtrun.b.dart "<expression>"      Evaluate an expression');
    stderr.writeln('  dart run bin/d4rtrun.b.dart --eval-file <file>  Evaluate file content with eval()');
    stderr.writeln('  dart run bin/d4rtrun.b.dart --init-eval         Validate bridge registrations');
    exit(1);
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
  print('Validating bridge registrations for userbridge_override_example...');
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
