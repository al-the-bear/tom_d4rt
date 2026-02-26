/// Runs all generics feature demonstrations
///
/// This script executes all examples in the generics area:
/// - generic_classes
/// - generic_functions
/// - type_bounds
/// - variance

import 'generic_classes/run_generic_classes.dart' as generic_classes;
import 'generic_functions/run_generic_functions.dart' as generic_functions;
import 'type_bounds/run_type_bounds.dart' as type_bounds;
import 'variance/run_variance.dart' as variance;

void main() {
  final separator = '=' * 70;

  print('');
  print(separator);
  print('                           DART GENERICS');
  print(separator);
  print('');

  print('');
  print(separator);
  print('  1. GENERIC CLASSES');
  print(separator);
  print('');
  generic_classes.main();

  print('');
  print(separator);
  print('  2. GENERIC FUNCTIONS');
  print(separator);
  print('');
  generic_functions.main();

  print('');
  print(separator);
  print('  3. TYPE BOUNDS');
  print(separator);
  print('');
  type_bounds.main();

  print('');
  print(separator);
  print('  4. VARIANCE');
  print(separator);
  print('');
  variance.main();

  print('');
  print(separator);
  print('  All generics demos completed!');
  print(separator);
}
