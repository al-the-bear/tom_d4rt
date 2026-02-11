#!/usr/bin/env dcli
// DCli Scripting Guide - Progress Class Example

import 'package:dcli/dcli.dart';

void main() {
  // Start with Progress.print() - prints to stdout
  print('Running ls with Progress.print():');
  start('ls -la', progress: Progress.print());
  
  // Capture to list
  print('\nCapturing git log:');
  var progress = start('git log --oneline -5');
  for (var line in progress.lines) {
    print('  Commit: $line');
  }
  
  // Discard output with Progress.devNull()
  print('\nRunning silently (output discarded):');
  start('echo "This is discarded"', progress: Progress.devNull());
  print('  (no output shown)');
}
