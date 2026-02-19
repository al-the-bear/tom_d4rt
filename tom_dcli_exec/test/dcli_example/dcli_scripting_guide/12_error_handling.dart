#!/usr/bin/env dcli
// DCli Scripting Guide - Error Handling Example

import 'package:dcli/dcli.dart';

void main() {
  print('DCli Error Handling Examples');
  print('============================\n');
  
  // Handle copy errors
  print('1. Copy error handling:');
  try {
    copy('nonexistent_source.txt', 'dest.txt');
  } on CopyException catch (e) {
    print('  Copy failed: ${e.message}');
  }
  
  // Handle command errors
  print('\n2. Command error handling:');
  try {
    'nonexistent-command-xyz'.run;
  } on RunException catch (e) {
    print('  Run failed: Exit code ${e.exitCode}');
  }
  
  // Check before delete
  print('\n3. Check before delete:');
  var testFile = '/tmp/test_delete_me.txt';
  if (exists(testFile)) {
    delete(testFile);
    print('  File deleted');
  } else {
    print('  File does not exist, skipping delete');
  }
  
  // Use nothrow for commands (false exists but returns non-zero exit)
  print('\n4. Using nothrow:');
  var result = 'false'.toList(nothrow: true);
  print('  Result lines: ${result.length} (no exception thrown)');
  
  // Catch and continue
  print('\n5. Catch and continue:');
  try {
    'optional-step'.run;
  } catch (_) {
    print('  Optional step skipped');
  }
  
  print(green('\nAll error handling examples completed!'));
}
