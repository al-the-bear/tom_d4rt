/// Runs all error_handling feature demonstrations
///
/// This script executes all examples in the error_handling area:
/// - basics
library;

import 'basics/run_basics.dart' as basics;

void main() {
  final separator = '=' * 70;

  print('');
  print(separator);
  print('                       DART ERROR HANDLING');
  print(separator);
  print('');

  print('');
  print(separator);
  print('  1. ERROR HANDLING BASICS');
  print(separator);
  print('');
  basics.main();

  print('');
  print(separator);
  print('  All error_handling demos completed!');
  print(separator);
}
