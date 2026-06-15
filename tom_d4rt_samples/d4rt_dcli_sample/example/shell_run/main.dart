// shell_run — running external processes and reading the environment with dcli.
//
// The `'command'.run` / `'command'.toList()` extensions execute real processes;
// `env` exposes environment variables. All of it is bridged native code.

import 'package:dcli/dcli.dart';

void main(List<String> args) {
  // Capture a command's output instead of streaming it to the console.
  print('Asking the Dart SDK for its version:');
  final version = 'dart --version'.toList(nothrow: true);
  for (final line in version) {
    print('  $line');
  }

  // Stream a command straight to stdout (no capture) with `.run`.
  print('\nStreaming the same command with .run (output goes direct to stdout):');
  'dart --version'.run;

  // Read an environment variable. PATH is separated by ';' on Windows and ':'
  // elsewhere — pick the separator that actually appears.
  final path = env['PATH'] ?? '';
  final separator = path.contains(';') ? ';' : ':';
  final segments = path.split(separator);
  print('\nPATH has ${segments.length} entr(y/ies); first one:');
  print('  ${segments.isEmpty ? '(empty)' : segments.first}');
}
