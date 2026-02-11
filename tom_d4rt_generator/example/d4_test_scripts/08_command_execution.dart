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
  
  // Ignore errors
  'might-not-exist'.toList(nothrow: true);
  
  print(green('\nCommand execution examples completed!'));
}
