/// Runs all extensions feature demonstrations
///
/// This script executes all examples in the extensions area:
/// - basics
library;

import 'basics/run_basics.dart' as basics;

void main() {
  final separator = '=' * 70;

  print('');
  print(separator);
  print('                         DART EXTENSIONS');
  print(separator);
  print('');

  print('');
  print(separator);
  print('  1. EXTENSION BASICS');
  print(separator);
  print('');
  basics.main();

  print('');
  print(separator);
  print('  All extensions demos completed!');
  print(separator);
}
