#!/usr/bin/env dcli
// DCli Scripting Guide - Shell Execution Example

import 'package:dcli/dcli.dart';

void main() {
  print('DCli Shell Execution Examples');
  print('=============================\n');

  // 1. Direct run without shell - $HOME is literal
  print('1. Without shell (literal \$HOME):');
  'echo \$HOME'.run;

  // 2. Using startFromArgs with sh -c for variable expansion
  print('\n2. With shell via sh -c (expanded \$HOME):');
  startFromArgs('sh', ['-c', 'echo \$HOME']);

  // 3. Shell needed for pipes - use sh -c
  print('\n3. Pipe through shell (sh -c):');
  startFromArgs('sh', ['-c', 'echo "line1\nline2\nline3" | head -2']);

  // 4. Shell needed for redirects - use sh -c
  print('\n4. Redirect through shell:');
  var tempFile = '/tmp/dcli_shell_test.txt';
  startFromArgs('sh', ['-c', 'echo "test content" > $tempFile']);
  cat(tempFile);
  delete(tempFile);

  print(green('\nShell execution examples completed!'));
}
