/// Runs all operators feature demonstrations
///
/// This script executes all examples in the operators area:
/// - arithmetic
/// - comparison
/// - logical
/// - bitwise
/// - assignment
/// - conditional
/// - cascade
/// - type_operators
/// - spread
/// - member_access
library;

import 'arithmetic/run_arithmetic.dart' as arithmetic;
import 'comparison/run_comparison.dart' as comparison;
import 'logical/run_logical.dart' as logical;
import 'bitwise/run_bitwise.dart' as bitwise;
import 'assignment/run_assignment.dart' as assignment;
import 'conditional/run_conditional.dart' as conditional;
import 'cascade/run_cascade.dart' as cascade;
import 'type_operators/run_type_operators.dart' as type_operators;
import 'spread/run_spread.dart' as spread;
import 'member_access/run_member_access.dart' as member_access;

void main() {
  final separator = '=' * 70;

  print('');
  print(separator);
  print('                         DART OPERATORS');
  print(separator);
  print('');

  print('');
  print(separator);
  print('  1. ARITHMETIC OPERATORS');
  print(separator);
  print('');
  arithmetic.main();

  print('');
  print(separator);
  print('  2. COMPARISON OPERATORS');
  print(separator);
  print('');
  comparison.main();

  print('');
  print(separator);
  print('  3. LOGICAL OPERATORS');
  print(separator);
  print('');
  logical.main();

  print('');
  print(separator);
  print('  4. BITWISE OPERATORS');
  print(separator);
  print('');
  bitwise.main();

  print('');
  print(separator);
  print('  5. ASSIGNMENT OPERATORS');
  print(separator);
  print('');
  assignment.main();

  print('');
  print(separator);
  print('  6. CONDITIONAL OPERATORS');
  print(separator);
  print('');
  conditional.main();

  print('');
  print(separator);
  print('  7. CASCADE OPERATORS');
  print(separator);
  print('');
  cascade.main();

  print('');
  print(separator);
  print('  8. TYPE OPERATORS');
  print(separator);
  print('');
  type_operators.main();

  print('');
  print(separator);
  print('  9. SPREAD OPERATORS');
  print(separator);
  print('');
  spread.main();

  print('');
  print(separator);
  print('  10. MEMBER ACCESS AND OPERATOR OVERLOADING');
  print(separator);
  print('');
  member_access.main();

  print('');
  print(separator);
  print('  All operators demos completed!');
  print(separator);
}
