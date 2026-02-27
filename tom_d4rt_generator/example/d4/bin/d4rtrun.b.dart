// D4rt Bridge - Generated file, do not edit
// Test runner for d4_example
// Generated: 2026-02-27T12:12:32.937951
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
import 'package:d4_example/src/d4rt_bridges/core_extensions.b.dart' as core_extensions_bridges;
import 'package:d4_example/src/d4rt_bridges/example_project.b.dart' as example_project_bridges;
import 'package:d4_example/src/d4rt_bridges/user_guide.b.dart' as user_guide_bridges;
import 'package:d4_example/src/d4rt_bridges/user_reference.b.dart' as user_reference_bridges;
import 'package:d4_example/src/d4rt_bridges/userbridge_override.b.dart' as userbridge_override_bridges;
import 'package:d4_example/src/d4rt_bridges/userbridge_user_guide.b.dart' as userbridge_user_guide_bridges;
import 'package:d4_example/src/d4rt_bridges/dart_overview.b.dart' as dart_overview_bridges;
import 'package:d4_example/src/d4rt_bridges/path_bridges.b.dart' as path_bridges;
import 'package:d4_example/src/d4rt_bridges/dcli_bridges.b.dart' as dcli_bridges;
import 'package:d4_example/src/d4rt_bridges/test_part_of_files.b.dart' as test_part_of_files_bridges;
import 'package:d4_example/src/d4rt_bridges/test_callback_types.b.dart' as test_callback_types_bridges;

/// Init script source that imports all bridged modules.
const String _initSource = '''
import 'package:d4_example/test_extensions.dart';
import 'package:d4_example/example_project.dart';
import 'package:d4_example/user_guide.dart';
import 'package:d4_example/user_reference.dart';
import 'package:d4_example/userbridge_override.dart';
import 'package:d4_example/userbridge_user_guide.dart';
import 'package:d4_example/dart_overview.dart';
import 'package:path/path.dart';
import 'package:dcli/dcli.dart';
import 'package:d4_example/test_part_of_files.dart';
import 'package:d4_example/test_callback_types.dart';

void main() {}
''';

/// Registers all bridges with the given D4rt interpreter.
void _registerBridges(D4rt d4rt) {
  core_extensions_bridges.CoreExtensionsBridge.registerBridges(
    d4rt,
    'package:d4_example/test_extensions.dart',
  );
  example_project_bridges.ExampleProjectBridge.registerBridges(
    d4rt,
    'package:d4_example/example_project.dart',
  );
  user_guide_bridges.UserGuideBridge.registerBridges(
    d4rt,
    'package:d4_example/user_guide.dart',
  );
  user_reference_bridges.UserReferenceBridge.registerBridges(
    d4rt,
    'package:d4_example/user_reference.dart',
  );
  userbridge_override_bridges.UserbridgeOverrideBridge.registerBridges(
    d4rt,
    'package:d4_example/userbridge_override.dart',
  );
  userbridge_user_guide_bridges.UserbridgeUserGuideBridge.registerBridges(
    d4rt,
    'package:d4_example/userbridge_user_guide.dart',
  );
  dart_overview_bridges.DartOverviewBridge.registerBridges(
    d4rt,
    'package:d4_example/dart_overview.dart',
  );
  path_bridges.PathBridge.registerBridges(
    d4rt,
    'package:path/path.dart',
  );
  dcli_bridges.DcliBridge.registerBridges(
    d4rt,
    'package:dcli/dcli.dart',
  );
  test_part_of_files_bridges.TestPartOfFilesBridge.registerBridges(
    d4rt,
    'package:d4_example/test_part_of_files.dart',
  );
  test_callback_types_bridges.TestCallbackTypesBridge.registerBridges(
    d4rt,
    'package:d4_example/test_callback_types.dart',
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
  print('Validating bridge registrations for d4_example...');
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
