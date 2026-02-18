/// Runs all enums feature demonstrations
///
/// This script executes all examples in the enums area:
/// - basics
library;

import 'basics/run_basics.dart' as basics;

void main() {
  final separator = '=' * 70;

  print('');
  print(separator);
  print('                            DART ENUMS');
  print(separator);
  print('');

  print('');
  print(separator);
  print('  1. ENUM BASICS');
  print(separator);
  print('');
  basics.main();

  print('');
  print(separator);
  print('  All enums demos completed!');
  print(separator);
}
