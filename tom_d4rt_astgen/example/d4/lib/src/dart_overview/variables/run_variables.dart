/// Runs all variables feature demonstrations
///
/// This script executes all examples in the variables area:
/// - declarations
/// - builtin_types
/// - null_safety
/// - type_system
/// - constants

import 'declarations/run_declarations.dart' as declarations;
import 'builtin_types/run_builtin_types.dart' as builtin_types;
import 'null_safety/run_null_safety.dart' as null_safety;
import 'type_system/run_type_system.dart' as type_system;
import 'constants/run_constants.dart' as constants;

void main() {
  print('╔════════════════════════════════════════════════════════════════╗');
  print('║                    DART VARIABLES & TYPES                      ║');
  print('╚════════════════════════════════════════════════════════════════╝');
  print('');

  print('\n' + '═' * 70);
  print('  1. DECLARATIONS');
  print('═' * 70 + '\n');
  declarations.main();

  print('\n' + '═' * 70);
  print('  2. BUILT-IN TYPES');
  print('═' * 70 + '\n');
  builtin_types.main();

  print('\n' + '═' * 70);
  print('  3. NULL SAFETY');
  print('═' * 70 + '\n');
  null_safety.main();

  print('\n' + '═' * 70);
  print('  4. TYPE SYSTEM');
  print('═' * 70 + '\n');
  type_system.main();

  print('\n' + '═' * 70);
  print('  5. CONSTANTS');
  print('═' * 70 + '\n');
  constants.main();

  print('\n' + '═' * 70);
  print('  All variables demos completed!');
  print('═' * 70);
}
