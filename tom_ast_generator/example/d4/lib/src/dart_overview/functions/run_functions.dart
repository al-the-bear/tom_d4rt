/// Runs all functions feature demonstrations
///
/// This script executes all examples in the functions area:
/// - declarations
/// - parameters
/// - anonymous_closures
/// - higher_order
/// - generators

import 'declarations/run_declarations.dart' as declarations;
import 'parameters/run_parameters.dart' as parameters;
import 'anonymous_closures/run_anonymous_closures.dart' as anonymous_closures;
import 'higher_order/run_higher_order.dart' as higher_order;
import 'generators/run_generators.dart' as generators;

void main() async {
  final separator = '=' * 70;

  print('');
  print(separator);
  print('                         DART FUNCTIONS');
  print(separator);
  print('');

  print('');
  print(separator);
  print('  1. FUNCTION DECLARATIONS');
  print(separator);
  print('');
  declarations.main();

  print('');
  print(separator);
  print('  2. FUNCTION PARAMETERS');
  print(separator);
  print('');
  parameters.main();

  print('');
  print(separator);
  print('  3. ANONYMOUS FUNCTIONS AND CLOSURES');
  print(separator);
  print('');
  anonymous_closures.main();

  print('');
  print(separator);
  print('  4. HIGHER-ORDER FUNCTIONS');
  print(separator);
  print('');
  higher_order.main();

  print('');
  print(separator);
  print('  5. GENERATORS');
  print(separator);
  print('');
  generators.main();

  print('');
  print(separator);
  print('  All functions demos completed!');
  print(separator);
}
