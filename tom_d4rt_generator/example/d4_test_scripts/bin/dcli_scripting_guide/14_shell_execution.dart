#!/usr/bin/env dcli
// DCli Scripting Guide - Shell Execution Example

import 'package:dcli/dcli.dart';

void main() {
  print('DCli Shell Execution Examples');
  print('=============================\n');

  // Direct run without shell - $HOME is literal
  print('1. Without shell (literal \$HOME):');
  'echo \$HOME'.run;
  
  // Use shell for variable expansion
  print('\n2. With shell (expanded \$HOME):');
  run('echo \$HOME', runInShell: true);
  
  // Shell needed for pipes
  print('\n3. Pipe through shell:');
  run('ls -la | head -5', runInShell: true);
  
  // Shell needed for redirects
  print('\n4. Redirect through shell:');
  var tempFile = '/tmp/dcli_shell_test.txt';
  run('echo "test content" > $tempFile', runInShell: true);
  cat(tempFile);
  delete(tempFile);
  
  print(green('\nShell execution examples completed!'));
}
