#!/usr/bin/env dcli
// DCli Scripting Guide - Command Execution Example

import 'package:dcli/dcli.dart';

void main() {
  // Simple run
  'echo "Hello from shell"'.run;
  
  // Capture output
  var dartVersion = 'dart --version'.firstLine;
  print('Dart: $dartVersion');
  
  // Process lines
  'git log --oneline -5'.forEach((line) {
    print('  Commit: $line');
  });
  
  // Handle errors
  try {
    'false'.run;  // Will throw
  } on RunException catch (e) {
    print('Command failed with exit code: ${e.exitCode}');
  }
  
  // Ignore errors with nothrow
  // Note: nothrow only suppresses non-zero exit codes, not command-not-found errors
  var lines = 'echo hello'.toList(nothrow: true);
  print('Captured ${lines.length} line(s)');
  
  // Handle command-not-found gracefully
  try {
    'might-not-exist'.run;
  } on RunException catch (e) {
    print('Expected error: ${e.reason}');
  }
  
  print(green('\nCommand execution examples completed!'));
}
