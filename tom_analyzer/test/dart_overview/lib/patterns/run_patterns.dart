/// Runs all patterns feature demonstrations
///
/// This script executes all examples in the patterns area:
/// - pattern_types
/// - switch_patterns
/// - destructuring
library;

import 'pattern_types/run_pattern_types.dart' as pattern_types;
import 'switch_patterns/run_switch_patterns.dart' as switch_patterns;
import 'destructuring/run_destructuring.dart' as destructuring;

void main() {
  final separator = '=' * 70;

  print('');
  print(separator);
  print('                          DART PATTERNS');
  print(separator);
  print('');

  print('');
  print(separator);
  print('  1. PATTERN TYPES');
  print(separator);
  print('');
  pattern_types.main();

  print('');
  print(separator);
  print('  2. SWITCH PATTERNS');
  print(separator);
  print('');
  switch_patterns.main();

  print('');
  print(separator);
  print('  3. DESTRUCTURING');
  print(separator);
  print('');
  destructuring.main();

  print('');
  print(separator);
  print('  All patterns demos completed!');
  print(separator);
}
