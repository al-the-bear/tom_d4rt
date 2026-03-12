#!/usr/bin/env dcli
// DCli Scripting Guide - Color Functions Example

import 'package:dcli/dcli.dart';

void main() {
  print(red('Error: ') + 'Something went wrong');
  print(green('Success!', bold: true));
  print(yellow('Warning', background: AnsiColor.black));
  print(blue('Info: ') + 'This is informational');
  print(cyan('Debug: ') + 'Debugging output');
  print(magenta('Special: ') + 'Highlighted text');
}
