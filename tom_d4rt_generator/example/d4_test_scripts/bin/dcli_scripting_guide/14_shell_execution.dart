#!/usr/bin/env dcli
// DCli Scripting Guide - Shell Execution Example

import 'package:dcli/dcli.dart';

void main() {
  print('DCli Shell Execution Examples');
  print('=============================\n');

  // Direct run using String extension
  print('1. String extension .run:');
  'echo hello-from-run'.run;

  // Using run() function with named parameters
  print('\n2. run() function with nothrow:');
  run('echo success-message', nothrow: true);

  // Using start() for more control
  print('\n3. start() function:');
  var progress = start('echo started-process', progress: Progress.capture());
  print('  Captured: ${progress.lines.join(", ")}');

  // Demonstrating workingDirectory parameter
  print('\n4. run() with workingDirectory:');
  run('ls', workingDirectory: '/tmp');

  print(green('\nShell execution examples completed!'));
}
