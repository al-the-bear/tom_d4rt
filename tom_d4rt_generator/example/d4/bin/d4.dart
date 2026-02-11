#!/usr/bin/env dart
/// D4 - A minimal D4rt executor for testing extension bridges.
///
/// Run with:
/// ```bash
/// dart run bin/d4.dart [options] [script_file]
/// dart run bin/d4.dart scripts/test.d4rt
/// dart run bin/d4.dart --version
/// dart run bin/d4.dart --help
/// echo 'print("Hello from stdin");' | dart run bin/d4.dart -
/// ```
library;

import 'dart:io';

import 'package:tom_d4rt/d4rt.dart';

import 'package:d4_example/src/d4rt_bridges/core_extensions.b.dart';
import 'package:d4_example/src/d4rt_bridges/dcli_bridges.b.dart';
import 'package:d4_example/src/d4rt_bridges/path_bridges.b.dart';

/// Version of the d4 tool.
const String version = '1.0.0';

/// Import path for test extensions.
const String coreExtensionsImport = 'package:d4_example/test_extensions.dart';

/// Import path for DCli.
const String dcliImport = 'package:dcli/dcli.dart';

/// Import path for path package.
const String pathImport = 'package:path/path.dart';

void main(List<String> args) async {
  if (args.isEmpty) {
    _printUsage();
    exit(1);
  }

  final arg = args.first;

  // Handle options
  if (arg == '--version' || arg == '-v') {
    print('d4 version $version');
    exit(0);
  }

  if (arg == '--help' || arg == '-h') {
    _printHelp();
    exit(0);
  }

  // Handle stdin input
  if (arg == '-') {
    final code = stdin.readLineSync() ?? '';
    if (code.isEmpty) {
      stderr.writeln('Error: No input received from stdin');
      exit(1);
    }
    await _executeCode(code, '<stdin>');
    return;
  }

  // Handle file input
  final scriptPath = arg;
  final file = File(scriptPath);
  if (!file.existsSync()) {
    stderr.writeln('Error: File not found: $scriptPath');
    exit(1);
  }

  final code = file.readAsStringSync();
  await _executeCode(code, scriptPath);
}

Future<void> _executeCode(String code, String sourceName) async {
  try {
    // Create the D4rt interpreter with our bridges
    final interpreter = D4rt();
    
    // Grant all permissions for full access (d4 is a development tool)
    interpreter.grant(FilesystemPermission.any);
    interpreter.grant(NetworkPermission.any);
    interpreter.grant(ProcessRunPermission.any);
    interpreter.grant(IsolatePermission.any);
    interpreter.grant(DangerousPermission.any);
    
    // Register bridges
    CoreExtensionsBridge.registerBridges(interpreter, coreExtensionsImport);
    PathBridge.registerBridges(interpreter, pathImport);
    DcliBridge.registerBridges(interpreter, dcliImport);

    // Parse and execute
    final result = await interpreter.execute(source: code);
    
    // Print result if not null/void
    if (result != null) {
      print(result);
    }
  } catch (e, st) {
    stderr.writeln('Error executing $sourceName:');
    stderr.writeln(e);
    if (Platform.environment['D4_DEBUG'] == '1') {
      stderr.writeln(st);
    }
    exit(1);
  }
}

void _printUsage() {
  print('Usage: d4 [options] <script_file>');
  print('       d4 - (read from stdin)');
  print('');
  print('Run "d4 --help" for more information.');
}

void _printHelp() {
  print('D4 - A minimal D4rt script executor');
  print('');
  print('Usage: d4 [options] <script_file>');
  print('       d4 - (read from stdin)');
  print('');
  print('Options:');
  print('  -h, --help     Show this help message');
  print('  -v, --version  Show version information');
  print('');
  print('Environment:');
  print('  D4_DEBUG=1     Enable debug output including stack traces');
  print('');
  print('Examples:');
  print('  d4 script.d4rt              Run a D4rt script file');
  print('  d4 -                        Read and execute from stdin');
  print('  echo "print(1+1)" | d4 -    Execute code from pipe');
  print('');
  print('This example project tests:');
  print('  - Extensions on dart:core types (String, int, List)');
  print('  - Extensions on dart:io types (Platform)');
  print('  - Callback parameters with function types');
}
