#!/usr/bin/env dcli
// DCli Scripting Guide - Find Function Details Example

import 'dart:io';
import 'package:dcli/dcli.dart';

void main() {
  print('Find Function Examples');
  print('======================\n');
  
  // Non-recursive find
  print('Dart files in current dir (non-recursive):');
  find('*.dart', recursive: false).forEach(print);
  
  // Include hidden files
  print('\nHidden files (starting with .):');
  find('.*', includeHidden: true, recursive: false).forEach((item) {
    print('  $item');
  });
  
  // Find with type filters - files only
  print('\nFiles only in current dir:');
  find('*', recursive: false, types: [FileSystemEntityType.file])
    .forEach((f) => print('  File: $f'));
  
  // Find with type filters - directories only
  print('\nDirectories only:');
  find('*', recursive: false, types: [FileSystemEntityType.directory])
    .forEach((d) => print('  Dir: $d'));
  
  print(green('\nFind examples completed!'));
}
