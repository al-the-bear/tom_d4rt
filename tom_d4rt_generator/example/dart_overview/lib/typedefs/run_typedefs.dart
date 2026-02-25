/// Runs all typedefs feature demonstrations
///
/// This script executes all examples in the typedefs area:
/// - basics

import 'basics/run_basics.dart' as basics;

void main() {
  final separator = '=' * 70;

  print('');
  print(separator);
  print('                          DART TYPEDEFS');
  print(separator);
  print('');

  print('');
  print(separator);
  print('  1. TYPEDEF BASICS');
  print(separator);
  print('');
  basics.main();

  print('');
  print(separator);
  print('  All typedefs demos completed!');
  print(separator);
}
