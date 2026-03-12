#!/usr/bin/env dcli
// DCli Scripting Guide - Environment Variables Example

import 'package:dcli/dcli.dart';

void main() {
  // Access environment variables
  print('HOME: ${env['HOME']}');
  print('PATH entries: ${env['PATH']?.split(':').length}');
  
  // Set environment variable
  env['MY_DCLI_VAR'] = 'test_value';
  print('MY_DCLI_VAR: ${env['MY_DCLI_VAR']}');
  
  // Global properties
  print('\nGlobal properties:');
  print('  pwd: $pwd');
  print('  HOME: $HOME');
  print('  rootPath: $rootPath');
  print('  PATH entries: ${PATH.length}');
}
