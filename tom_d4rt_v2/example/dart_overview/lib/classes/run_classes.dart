/// Runs all classes feature demonstrations
///
/// This script executes all examples in the classes area:
/// - declarations
/// - constructors
/// - inheritance
/// - static_object_methods

import 'declarations/run_declarations.dart' as declarations;
import 'constructors/run_constructors.dart' as constructors;
import 'inheritance/run_inheritance.dart' as inheritance;
import 'static_object_methods/run_static_object_methods.dart'
    as static_object_methods;

void main() {
  final separator = '=' * 70;

  print('');
  print(separator);
  print('                          DART CLASSES');
  print(separator);
  print('');

  print('');
  print(separator);
  print('  1. CLASS DECLARATIONS');
  print(separator);
  print('');
  declarations.main();

  print('');
  print(separator);
  print('  2. CONSTRUCTORS');
  print(separator);
  print('');
  constructors.main();

  print('');
  print(separator);
  print('  3. INHERITANCE AND INTERFACES');
  print(separator);
  print('');
  inheritance.main();

  print('');
  print(separator);
  print('  4. STATIC MEMBERS AND OBJECT METHODS');
  print(separator);
  print('');
  static_object_methods.main();

  print('');
  print(separator);
  print('  All classes demos completed!');
  print(separator);
}
