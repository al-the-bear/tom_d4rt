/// Runs all comments feature demonstrations
///
/// This script executes all examples in the comments area:
/// - basics
library;

import 'basics/run_basics.dart' as basics;

void main() {
  final separator = '=' * 70;

  print('');
  print(separator);
  print('                          DART COMMENTS');
  print(separator);
  print('');

  print('');
  print(separator);
  print('  1. COMMENT BASICS');
  print(separator);
  print('');
  basics.main();

  print('');
  print(separator);
  print('  All comments demos completed!');
  print(separator);
}
