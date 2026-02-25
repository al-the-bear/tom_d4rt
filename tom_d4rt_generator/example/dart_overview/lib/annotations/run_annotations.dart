/// Runs all annotations feature demonstrations
///
/// This script executes all examples in the annotations area:
/// - basics

import 'basics/run_basics.dart' as basics;

void main() {
  final separator = '=' * 70;

  print('');
  print(separator);
  print('                        DART ANNOTATIONS');
  print(separator);
  print('');

  print('');
  print(separator);
  print('  1. ANNOTATION BASICS');
  print(separator);
  print('');
  basics.main();

  print('');
  print(separator);
  print('  All annotations demos completed!');
  print(separator);
}
