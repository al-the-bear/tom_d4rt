#!/usr/bin/env dcli
// DCli Scripting Guide - File Write Extensions Example

import 'package:dcli/dcli.dart';

void main() {
  var filePath = '/tmp/dcli_write_test.txt';
  
  // Write (overwrite) to file
  filePath.write('First line');
  
  // Append to file
  filePath.append('Second line');
  filePath.append('Third line');
  
  // Show contents
  print('File contents:');
  cat(filePath);
  
  // Cleanup
  delete(filePath);
  print(green('\nFile operations completed!'));
}
