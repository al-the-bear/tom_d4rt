#!/usr/bin/env dcli
// DCli Scripting Guide - Basic File Operations Example

import 'package:dcli/dcli.dart';
import 'package:path/path.dart';

void main() {
  // Navigate and list
  print('Current directory: $pwd');
  print('Home: $HOME');
  
  // Create directory structure
  var workDir = createDir(join(HOME, 'dcli_demo'), recursive: true);
  
  // Create and write file
  var filePath = join(workDir, 'hello.txt');
  filePath.write('Hello, DCli!');
  filePath.append('This is line 2');
  
  // Read and display
  print('\nFile contents:');
  cat(filePath);
  
  // Copy file
  var copyPath = join(workDir, 'hello_copy.txt');
  copy(filePath, copyPath);
  
  // Find files
  print('\nText files in demo:');
  find('*.txt', workingDirectory: workDir).forEach(print);
  
  // Cleanup
  deleteDir(workDir);
  print(green('\nDemo completed and cleaned up!'));
}
