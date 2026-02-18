/// Runs all control flow feature demonstrations
///
/// This script executes all examples in the control_flow area:
/// - conditionals
/// - switch_statement
/// - switch_expression
/// - loops
/// - loop_control
/// - assertions_collections
library;

import 'conditionals/run_conditionals.dart' as conditionals;
import 'switch_statement/run_switch_statement.dart' as switch_statement;
import 'switch_expression/run_switch_expression.dart' as switch_expression;
import 'loops/run_loops.dart' as loops;
import 'loop_control/run_loop_control.dart' as loop_control;
import 'assertions_collections/run_assertions_collections.dart'
    as assertions_collections;

void main() {
  final separator = '=' * 70;

  print('');
  print(separator);
  print('                       DART CONTROL FLOW');
  print(separator);
  print('');

  print('');
  print(separator);
  print('  1. CONDITIONAL STATEMENTS');
  print(separator);
  print('');
  conditionals.main();

  print('');
  print(separator);
  print('  2. SWITCH STATEMENT');
  print(separator);
  print('');
  switch_statement.main();

  print('');
  print(separator);
  print('  3. SWITCH EXPRESSION');
  print(separator);
  print('');
  switch_expression.main();

  print('');
  print(separator);
  print('  4. LOOPS');
  print(separator);
  print('');
  loops.main();

  print('');
  print(separator);
  print('  5. LOOP CONTROL (break, continue, labels)');
  print(separator);
  print('');
  loop_control.main();

  print('');
  print(separator);
  print('  6. ASSERTIONS AND COLLECTION CONTROL FLOW');
  print(separator);
  print('');
  assertions_collections.main();

  print('');
  print(separator);
  print('  All control flow demos completed!');
  print(separator);
}
