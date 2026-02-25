/// DCli Environment Operations Example
///
/// Demonstrates env, envs, HOME, PATH, isOnPATH, withEnvironment functions.
///
/// Run with: dart run tomexample/environment.dart
library;

import 'dart:io';
import 'package:dcli/dcli.dart';
import 'package:path/path.dart' as p;

void main() {
  print('=== DCli Environment Operations Examples ===\n');

  // 1. Accessing common environment variables
  print('--- 1. Common Environment Variables ---');
  print('HOME: ${env['HOME']}');
  print('USER: ${env['USER']}');
  print('SHELL: ${env['SHELL']}');
  print('LANG: ${env['LANG']}');
  print('TERM: ${env['TERM']}');

  // 2. Using HOME constant
  print('\n--- 2. HOME Constant ---');
  print('HOME constant: $HOME');
  print('Same as env["HOME"]: ${HOME == env['HOME']}');

  // Common home subdirectories
  print('Config dir: ${p.join(HOME, '.config')}');
  print('Local dir: ${p.join(HOME, '.local')}');

  // 3. PATH operations
  print('\n--- 3. PATH Operations ---');
  print('PATH directories (first 5):');
  for (var i = 0; i < PATH.length && i < 5; i++) {
    print('  ${PATH[i]}');
  }
  print('  ... (${PATH.length} total directories)');

  // 4. Check if command is on PATH
  print('\n--- 4. Check Commands on PATH ---');
  final commands = [
    'bash',
    'sh',
    'dart',
    'git',
    'python',
    'node',
    'nonexistent'
  ];
  for (final cmd in commands) {
    final found = isOnPATH(cmd);
    print('  $cmd: ${found ? "✓ found" : "✗ not found"}');
  }

  // 5. Find command path with which
  print('\n--- 5. Find Command Location ---');
  final whichDart = which('dart');
  if (whichDart.found) {
    print('dart location: ${whichDart.path}');
  }

  final whichBash = which('bash');
  if (whichBash.found) {
    print('bash location: ${whichBash.path}');
  }

  // 6. Setting environment variables
  print('\n--- 6. Setting Environment Variables ---');
  env['MY_APP_MODE'] = 'development';
  env['MY_APP_DEBUG'] = 'true';
  env['MY_APP_PORT'] = '8080';

  print('MY_APP_MODE: ${env['MY_APP_MODE']}');
  print('MY_APP_DEBUG: ${env['MY_APP_DEBUG']}');
  print('MY_APP_PORT: ${env['MY_APP_PORT']}');

  // Cleanup
  env['MY_APP_MODE'] = null;
  env['MY_APP_DEBUG'] = null;
  env['MY_APP_PORT'] = null;

  // 7. All environment variables
  print('\n--- 7. All Environment Variables ---');
  print('Total environment variables: ${envs.length}');
  print('First 10 variable names:');
  envs.keys.take(10).forEach((key) => print('  $key'));

  // 8. Temporary environment with withEnvironment
  print('\n--- 8. Temporary Environment ---');
  print('Before: TEST_VAR = ${env['TEST_VAR']}');

  withEnvironmentAsync(() async {
    print('Inside block: TEST_VAR = ${env['TEST_VAR']}');
  }, environment: {'TEST_VAR': 'temporary_value'});

  print('After: TEST_VAR = ${env['TEST_VAR']}');

  // 9. Environment in subprocesses
  print('\n--- 9. Environment in Subprocesses ---');
  env['GREETING'] = 'Hello from DCli';
  final greeting = 'echo \$GREETING'.firstLine;
  print('Subprocess sees: $greeting');
  env['GREETING'] = null;

  // 10. Custom environment for subprocess
  print('\n--- 10. Custom Environment for Subprocess ---');
  final output = <String>[];
  // Set env var, run command, then clean up
  env['CUSTOM_VAR'] = 'custom_value';
  startFromArgs('sh', ['-c', 'echo \$CUSTOM_VAR'],
      progress: Progress((line) => output.add(line)));
  env['CUSTOM_VAR'] = null;
  print('Subprocess with custom env: ${output.join()}');

  // 11. Check for required environment
  print('\n--- 11. Environment Validation ---');
  final required = ['HOME', 'PATH', 'USER'];
  final missing = required.where((v) => env[v] == null).toList();
  if (missing.isEmpty) {
    print('All required variables present ✓');
  } else {
    print('Missing variables: $missing');
  }

  // 12. Path expansion with ~
  print('\n--- 12. Tilde Expansion ---');
  print('~/Documents expands to: ${truepath('~/Documents')}');
  print('~/.config expands to: ${truepath('~/.config')}');

  // 13. Working with special values
  print('\n--- 13. Special Environment Values ---');
  env['EMPTY_VAR'] = '';
  env['SPACES_VAR'] = '  spaced  ';
  env['EQUALS_VAR'] = 'key=value';
  env['MULTILINE_VAR'] = 'line1\nline2';

  print('Empty var: "${env['EMPTY_VAR']}"');
  print('Spaces var: "${env['SPACES_VAR']}"');
  print('Equals var: "${env['EQUALS_VAR']}"');
  print('Multiline var: "${env['MULTILINE_VAR']}"');

  // Cleanup
  env['EMPTY_VAR'] = null;
  env['SPACES_VAR'] = null;
  env['EQUALS_VAR'] = null;
  env['MULTILINE_VAR'] = null;

  // 14. Platform detection
  print('\n--- 14. Platform Information ---');
  print('Is Linux: ${Platform.isLinux}');
  print('Is macOS: ${Platform.isMacOS}');
  print('Is Windows: ${Platform.isWindows}');
  print('Path separator: "${Platform.pathSeparator}"');
  print('Number of processors: ${Platform.numberOfProcessors}');

  // 15. Real-world configuration pattern
  print('\n--- 15. Configuration Pattern ---');

  // Set defaults, override from environment
  String getConfig(String key, String defaultValue) {
    return env['MYAPP_$key'] ?? defaultValue;
  }

  final config = {
    'host': getConfig('HOST', 'localhost'),
    'port': getConfig('PORT', '3000'),
    'debug': getConfig('DEBUG', 'false'),
    'logLevel': getConfig('LOG_LEVEL', 'info'),
  };

  print('Application config:');
  config.forEach((key, value) => print('  $key: $value'));

  print('\n=== Environment Operations Example Complete ===');
}
