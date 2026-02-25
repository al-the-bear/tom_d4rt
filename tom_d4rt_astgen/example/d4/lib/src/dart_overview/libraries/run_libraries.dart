/// Runs all libraries feature demonstrations
///
/// This script executes all examples in the libraries area:
/// - basics

import 'basics/run_basics.dart' as basics;

void main() {
  final separator = '=' * 70;

  print('');
  print(separator);
  print('                          DART LIBRARIES');
  print(separator);
  print('');

  print('');
  print(separator);
  print('  1. LIBRARY BASICS');
  print(separator);
  print('');
  basics.main();

  print('');
  print(separator);
  print('  All libraries demos completed!');
  print(separator);
}
