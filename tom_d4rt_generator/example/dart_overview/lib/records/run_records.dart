/// Runs all records feature demonstrations
///
/// This script executes all examples in the records area:
/// - basics

import 'basics/run_basics.dart' as basics;

void main() {
  final separator = '=' * 70;

  print('');
  print(separator);
  print('                           DART RECORDS');
  print(separator);
  print('');

  print('');
  print(separator);
  print('  1. RECORD BASICS');
  print(separator);
  print('');
  basics.main();

  print('');
  print(separator);
  print('  All records demos completed!');
  print(separator);
}
