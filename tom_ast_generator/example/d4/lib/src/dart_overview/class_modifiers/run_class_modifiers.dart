/// Runs all class_modifiers feature demonstrations
///
/// This script executes all examples in the class_modifiers area:
/// - modifiers (abstract, base, interface, final, sealed, mixin class)
/// - sealed (exhaustive pattern matching)

import 'modifiers/run_modifiers.dart' as modifiers;
import 'sealed/run_sealed.dart' as sealed;

void main() {
  final separator = '=' * 70;

  print('');
  print(separator);
  print('                       DART CLASS MODIFIERS');
  print(separator);
  print('');

  print('');
  print(separator);
  print('  1. CLASS MODIFIERS');
  print(separator);
  print('');
  modifiers.main();

  print('');
  print(separator);
  print('  2. SEALED CLASSES');
  print(separator);
  print('');
  sealed.main();

  print('');
  print(separator);
  print('  All class_modifiers demos completed!');
  print(separator);
}
