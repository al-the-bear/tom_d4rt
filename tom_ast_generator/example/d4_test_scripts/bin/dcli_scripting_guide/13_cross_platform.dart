#!/usr/bin/env dcli
// DCli Scripting Guide - Cross-Platform Example

import 'dart:io';
import 'package:dcli/dcli.dart';
import 'package:path/path.dart';

void main() {
  print('DCli Cross-Platform Examples');
  print('============================\n');
  
  // Path handling with truepath and join
  print('1. Path handling:');
  var configPath = truepath(HOME, '.config', 'myapp');
  var logFile = join(configPath, 'app.log');
  print('  Config path: $configPath');
  print('  Log file: $logFile');
  
  // Platform detection
  print('\n2. Platform detection:');
  print('  isWindows: ${Platform.isWindows}');
  print('  isMacOS: ${Platform.isMacOS}');
  print('  isLinux: ${Platform.isLinux}');
  print('  operatingSystem: ${Platform.operatingSystem}');
  
  // Line endings
  print('\n3. Line endings:');
  print('  Platform eol: ${eol.codeUnits}');
  print('  (Unix: [10], Windows: [13, 10])');
  
  // Executable search
  print('\n4. Executable search:');
  var dart = which('dart').path;
  if (dart != null) {
    print('  Dart found at: $dart');
  }
  var git = which('git').path;
  if (git != null) {
    print('  Git found at: $git');
  }
  
  print(green('\nCross-platform examples completed!'));
}
