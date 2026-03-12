#!/usr/bin/env dcli
// DCli Scripting Guide - StringAsProcess Extension Example

import 'package:dcli/dcli.dart';

void main() {
  // Run and print
  'ls -la'.run;
  
  // Capture as list
  var files = 'ls'.toList();
  print('\nFound ${files.length} items');
  
  // Get first line
  var version = 'dart --version'.firstLine;
  print('Dart version: $version');
  
  // Process each line
  'git status'.forEach((line) => print('> $line'));
}
