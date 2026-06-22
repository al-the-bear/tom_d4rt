/// Runs all globals (top-level declarations) feature demonstrations
///
/// This script executes all examples in the globals area:
/// - basics

import 'basics/run_basics.dart' as basics;

void main() {
  final separator = '=' * 70;

  print('');
  print(separator);
  print('                  DART TOP-LEVEL DECLARATIONS');
  print(separator);
  print('');

  print('');
  print(separator);
  print('  1. TOP-LEVEL BASICS');
  print(separator);
  print('');
  basics.main();

  print('');
  print(separator);
  print('  All globals demos completed!');
  print(separator);
}
